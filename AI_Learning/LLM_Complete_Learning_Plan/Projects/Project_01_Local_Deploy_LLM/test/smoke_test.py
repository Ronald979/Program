import requests

BASE_URL = "http://localhost:11434"
MODEL = "phi3:mini"


def test_models_endpoint():
    r = requests.get(f"{BASE_URL}/api/tags", timeout=30)
    r.raise_for_status()
    payload = r.json()
    if "models" not in payload:
        raise AssertionError("/api/tags should contain models")


def test_chat():
    payload = {
        "model": MODEL,
        "messages": [{"role": "user", "content": "請用 10 字回覆：你好嗎"}],
        "stream": False,
    }
    r = requests.post(f"{BASE_URL}/v1/chat/completions", json=payload, timeout=60)
    r.raise_for_status()
    data = r.json()
    msg = data.get("choices", [{}])[0].get("message", {}).get("content", "")
    assert isinstance(msg, str) and len(msg.strip()) > 0


if __name__ == "__main__":
    test_models_endpoint()
    test_chat()
    print("smoke test pass")
