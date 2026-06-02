import argparse
import hashlib
import json
from pathlib import Path


def read_jsonl(path):
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line:
                yield json.loads(line)


def normalize_row(row):
    text = json.dumps(row, ensure_ascii=False, sort_keys=True)
    return text


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True)
    parser.add_argument("--out-dir", default="outputs/datasets")
    parser.add_argument("--train-ratio", type=float, default=0.9)
    parser.add_argument("--seed", type=int, default=42)
    args = parser.parse_args()

    rows = list(read_jsonl(args.input))
    seen = {}
    dedup = []
    for r in rows:
        key = hashlib.md5(normalize_row(r).encode()).hexdigest()
        if key not in seen:
            seen[key] = True
            dedup.append(r)

    n_train = int(len(dedup) * args.train_ratio)
    train_rows = dedup[:n_train]
    val_rows = dedup[n_train:]

    out = Path(args.out_dir)
    out.mkdir(parents=True, exist_ok=True)

    def write(path, data):
        with open(out / path, "w", encoding="utf-8") as f:
            for r in data:
                f.write(json.dumps(r, ensure_ascii=False) + "\n")

    write("train.jsonl", train_rows)
    write("valid.jsonl", val_rows)

    profile = {
        "raw_rows": len(rows),
        "dedup_rows": len(dedup),
        "train_rows": len(train_rows),
        "valid_rows": len(val_rows),
        "train_ratio": args.train_ratio,
        "seed": args.seed,
    }
    with open(out / "dataset_profile.json", "w", encoding="utf-8") as f:
        json.dump(profile, f, ensure_ascii=False, indent=2)

    print(json.dumps(profile, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
