import argparse
import statistics
from local_chat_cli import call_chat


def main():
    parser = argparse.ArgumentParser(description="Simple local benchmark for chat endpoint")
    parser.add_argument("--base-url", default="http://localhost:11434")
    parser.add_argument("--model", default="phi3:mini")
    parser.add_argument("--rounds", type=int, default=5)
    args = parser.parse_args()

    prompts = [
        "請用 20 字以內說明 Transformer。",
        "請用繁體中文回答：今天適合學習哪個主題？",
        "請列出 3 個部署 LLM 的風險控管要點。",
        "你是誰？",
        "請比較本機推論與雲端訓練。",
    ]

    latencies = []
    failures = 0

    for i in range(args.rounds):
        for p in prompts:
            try:
                _, latency, status, _ = call_chat(args.base_url, args.model, p)
                if status != 200:
                    failures += 1
                latencies.append(latency)
                print(f"[{i + 1}/{args.rounds}] {status} {latency:.3f}s")
            except Exception as e:
                failures += 1
                print(f"[{i + 1}/{args.rounds}] fail: {e}")

    ok = len(latencies)
    if ok:
        print(f"success={ok}")
        print(f"fail={failures}")
        print(f"avg_latency={statistics.mean(latencies):.3f}s")
        print(f"p95_latency={sorted(latencies)[max(0, int(len(latencies)*0.95)-1)]:.3f}s")
    else:
        print(f"fail={failures}")


if __name__ == "__main__":
    main()
