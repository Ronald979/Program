import argparse
import json
from pathlib import Path


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--adapter-dir", required=True)
    parser.add_argument("--base-model", required=True)
    parser.add_argument("--out-dir", default="outputs/merged")
    args = parser.parse_args()

    out = Path(args.out_dir)
    out.mkdir(parents=True, exist_ok=True)
    manifest = {
        "adapter_dir": args.adapter_dir,
        "base_model": args.base_model,
        "status": "ready_for_local_quantize",
    }
    with open(out / "manifest.json", "w", encoding="utf-8") as f:
        json.dump(manifest, f, ensure_ascii=False, indent=2)
    readme = out / "README.md"
    readme.write_text(
        "已產生 merged 清單，請使用你的量化流程將模型導出為本機可部署格式\n"
        "步驟：\n"
        "1. 導入 adapter\n"
        "2. 合併 base model + adapter\n"
        "3. 量化匯出\n",
        encoding="utf-8",
    )
    print(f"manifest: {out / 'manifest.json'}")


if __name__ == "__main__":
    main()
