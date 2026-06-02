# Project 02: Complete LLM Training Architecture

## 1. Project 目標

建立一條「可重播」的 LLM 訓練流程：
- Dataset 建立
- LoRA 微調
- 評估與報告
- 匯出並可回灌到本地部署

## 2. 前置技能

- Python / Git
- PyTorch 基本訓練觀念
- JSON/JSONL 操作
- Hugging Face Transformers 基礎

## 3. 架構說明

### 全流程

```text
Raw Data
  -> Validation
  -> Normalization
  -> Dedup
  -> Filter
  -> Train/Valid Split
  -> Tokenize
  -> Trainer(SFT/LoRA)
  -> Checkpoint
  -> Eval
  -> Export
  -> Deploy Smoke Test
```

### 組件

- `data pipeline`：可重放的資料處理
- `train engine`：可配置的訓練啟動腳本
- `experiment registry`：每次實驗保留 config + 指標
- `quality gate`：每輪都有可追蹤的回歸檢查

## 4. 任務

1. 建立 `configs/`：model / train / eval
2. `build_dataset.py` 生成 token 與長度統計
3. 寫 `train_lora.py`，先跑 smoke + full run
4. 寫 `eval.py` 生成質量報表
5. `merge_and_export.py` 產生部署用模型
6. 回到 Project 01 完整走一次端到端

## 5. 里程碑

- M1：smoke train 可跑完 100-500 條資料
- M2：全量 LoRA 收斂，loss 曲線可觀測
- M3：建立 3 類自動化測試（指令服從、事實回覆、一致性）
- M4：匯出模型後本地成功載入
- M5：形成第一版「訓練報告」與下一輪優化清單

## 6. 風險

- 資料污染：在預處理時做重複資料排除
- 訓練漂移：每次變更都要固定 seed + config
- 硬體不足：優先 LoRA + QLoRA，不求模型尺寸先求流程可用

## 7. Gate Review（完成條件）

- 有可重播 config + scripts
- 有 dataset profile 與 evaluation report
- 有至少一個可導出的 adapter / merged 模型
- 部署測試可成功並回傳合理結果
- Learning Notes 有明確的問題與修正紀錄