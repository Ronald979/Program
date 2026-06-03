# Project 02 Quick Start（Local preprocessing + Cloud LoRA workflow）

## 0) 準備

```powershell
cd C:\Users\ronald\Program\AI_Learning\LLM_Complete_Learning_Plan\Projects\Project_02_Self_Train_LLM_Architecture
python -m pip install -r requirements.txt  # 若你有維護到 requirements
```

> 若尚未有 requirements，可先安裝 `pyyaml`、`requests`。

## 1) 建資料集（本機）

```powershell
python .\scripts\build_dataset.py --input .\data\raw.jsonl --out-dir outputs\datasets --train-ratio 0.9
```

會輸出：
- `outputs\datasets\dataset_profile.json`
- `outputs\datasets\train.jsonl`
- `outputs\datasets\valid.jsonl`

## 2) 建訓練指令（上雲）

```powershell
python .\scripts\train_lora.py --dry-run
```

> 執行結果會產生 `outputs\train_plan.json`，把 `train_command` 貼到雲端 GPU 環境跑。

## 3) 回灌與匯出

```powershell
python .\scripts\merge_and_export.py --adapter-dir outputs\adapters --base-model meta-llama/Llama-3.2-1B-Instruct --out-dir outputs\merged
```

## 4) 本機回歸驗證（接回 Project 01）

```powershell
python .\scripts\eval.py --predictions outputs\predictions.jsonl --ground-truth outputs\ground_truth.jsonl --out outputs\reports\eval_report.json
```

## 5) 上限測試 / 上線門檻

- 至少有 1 次可重現的 train_plan 與 eval_report
- `outputs/reports/eval_report.json` 已更新
- 量化後模型可被 Project 01 的 smoke_test 通過