import argparse
import json
from pathlib import Path
import yaml


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--model-config", default="configs/model.yaml")
    parser.add_argument("--train-config", default="configs/train.yaml")
    parser.add_argument("--dataset-dir", default="outputs/datasets")
    parser.add_argument("--out-dir", default="outputs/adapters")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    with open(args.model_config, "r", encoding="utf-8") as f:
        model_cfg = yaml.safe_load(f)
    with open(args.train_config, "r", encoding="utf-8") as f:
        train_cfg = yaml.safe_load(f)

    base = model_cfg["model"]["base_model"]
    train = train_cfg["train"]
    exp = train_cfg["logging"]["exp_name"]

    command = (
        "python -m torchrun train.py "
        f"--base-model {base} "
        f"--train-data {Path(args.dataset_dir) / 'train.jsonl'} "
        f"--val-data {Path(args.dataset_dir) / 'valid.jsonl'} "
        f"--lora-r {train['adapter_rank']} --lora-alpha {train['alpha']} --lr {train['lr']} "
        f"--batch-size {train['batch_size']} --epochs {train['epochs']} "
        f"--output-dir {args.out_dir}"
    )

    manifest = {
        "base_model": base,
        "train_command": command,
        "dataset_dir": args.dataset_dir,
        "output_dir": args.out_dir,
        "exp_name": exp,
    }
    Path("outputs").mkdir(exist_ok=True)
    with open("outputs/train_plan.json", "w", encoding="utf-8") as f:
        json.dump(manifest, f, ensure_ascii=False, indent=2)

    if args.dry_run:
        print(json.dumps(manifest, ensure_ascii=False, indent=2))
    else:
        print("已產生 train_plan.json，請到雲端主機執行以下命令：")
        print(command)


if __name__ == "__main__":
    main()
