import argparse
import json
from difflib import SequenceMatcher


def load_jsonl(path):
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            if line.strip():
                yield json.loads(line)


def normalized_exact_match(a, b):
    a = (a or "").strip().lower()
    b = (b or "").strip().lower()
    return 1 if a == b else 0


def rouge_like_sim(a, b):
    ratio = SequenceMatcher(None, a or "", b or "").ratio()
    return ratio


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--predictions", required=True)
    parser.add_argument("--ground-truth", required=True)
    parser.add_argument("--out", default="outputs/reports/eval_report.json")
    args = parser.parse_args()

    preds = list(load_jsonl(args.predictions))
    truths = list(load_jsonl(args.ground_truth))

    n = min(len(preds), len(truths))
    if n == 0:
        raise RuntimeError("empty eval set")

    rows = []
    exact = 0
    sims = []
    for p, gt in zip(preds[:n], truths[:n]):
        pred = p.get("answer", "")
        ref = gt.get("answer", "")
        em = normalized_exact_match(pred, ref)
        sim = rouge_like_sim(pred, ref)
        exact += em
        sims.append(sim)
        rows.append({"pred": pred, "gt": ref, "exact_match": em, "sim": sim})

    report = {
        "n": n,
        "exact_match": exact / n,
        "avg_sim": sum(sims) / n,
        "rows": rows,
    }

    from pathlib import Path
    out = Path(args.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    with open(out, "w", encoding="utf-8") as f:
        json.dump(report, f, ensure_ascii=False, indent=2)

    print(json.dumps(report, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
