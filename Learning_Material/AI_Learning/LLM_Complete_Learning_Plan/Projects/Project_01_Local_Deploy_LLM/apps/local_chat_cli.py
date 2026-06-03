import argparse
import json
import requests
import time


def call_chat(base_url, model, prompt, temperature=0.3, max_tokens=256, timeout=120):
    payload = {
        "model": model,
        "messages": [
            {"role": "user", "content": prompt}
        ],
        "temperature": temperature,
        "max_tokens": max_tokens,
        "stream": False,
    }

    start = time.time()
    r = requests.post(f"{base_url.rstrip('/')}/v1/chat/completions", json=payload, timeout=timeout)
    latency = time.time() - start
    r.raise_for_status()

    data = r.json()
    content = (data.get("choices") or [{}])[0].get("message", {}).get("content", "")
    return content.strip(), latency, r.status_code, data


def main():
    parser = argparse.ArgumentParser(description="Call local Ollama-compatible chat endpoint")
    parser.add_argument("--base-url", default="http://localhost:11434")
    parser.add_argument("--model", default="phi3:mini")
    parser.add_argument("--temp", type=float, default=0.3)
    parser.add_argument("--max-tokens", type=int, default=256)
    parser.add_argument("--prompt", default="請用一句話介紹你自己")
    args = parser.parse_args()

    try:
        text, latency, status, raw = call_chat(
            args.base_url,
            args.model,
            args.prompt,
            temperature=args.temp,
            max_tokens=args.max_tokens,
        )
        print(f"status={status}")
        print(f"latency={latency:.3f}s")
        print("response:")
        print(text)
    except requests.RequestException as e:
        print("request failed")
        print(e)
        if hasattr(e, "response") and e.response is not None:
            print(e.response.text)
        raise SystemExit(1)


if __name__ == "__main__":
    main()
