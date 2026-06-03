# Project 02: Complete LLM Training Architecture

## 1. Project 目標

建立一條「可重播」的 LLM 訓練流程：
- 資料處理與品質管控放在本機
- 微調主流程（LoRA）放到雲端 GPU
- 回收 adapter/merged 模型後回灌到本機部署
- 持續做評估與回歸

## 2. 前置技能

- Python / Git
- PyTorch 基本訓練觀念
- JSON/JSONL 操作
- Hugging Face Transformers 基礎
- 遠端訓練環境基本操作（如 Colab、A10+、A100）

## 3. 架構說明

### 全流程（本機 + 遠端）

```text
Raw Data
  -> Validation
  -> Normalization
  -> Dedup
  -> Filter
  -> Train/Valid Split
  -> Tokenize
  -> Cloud Trainer(LoRA)
      -> Adapter Checkpoint
  -> Eval
  -> Merge + Quantize
  -> Local Deploy Smoke Test
```

### 組件

- `data pipeline`：本機可重放的資料清洗/切分/版本化
- `train engine`：只放參數與腳本，實際跑在雲端 GPU
- `experiment registry`：每次實驗保留 config + 指標（含雲端 run id）
- `quality gate`：每輪都有可追蹤的回歸檢查

## 4. 任務

1. 建立 `configs/`：model / train / eval
2. `build_dataset.py` 生成 token 與長度統計
3. 將 `train_lora.py` 改為「雲端啟動模板」，含可切換的 batch、lr、lora rank
4. 寫 `eval.py` 產生質量報表，放在本機 `outputs/reports`
5. `merge_and_export.py` 合併 adapter，輸出可量化模型
6. 回到 Project 01 用本機硬體做 smoke test（推理與回歸題）

## 5. 里程碑

- M1：smoke train 檔案可在本機跑完 100-500 筆資料格式驗證
- M2：雲端全量 LoRA 收斂，loss 曲線可觀測
- M3：建立 3 類自動化測試（指令服從、事實回覆、一致性）
- M4：匯出 adapter/merged 後本地量化並成功載入
- M5：形成第一版「訓練報告」與下輪調參清單

## 6. 風險與對策（1050 版）

- 資料污染：在本機先做 dedup / quality filter 再上雲
- 訓練漂移：每次變更都固定 seed + config + dataset hash
- 雲端成本/時間：先做小樣本 smoke train 驗證，再啟動完整訓練
- 回灌衝突：明確記錄 base model hash 與 adapter 版本

## 7. Gate Review（完成條件）

- 有可重播 config + scripts
- 有 dataset profile 與 evaluation report
- 有至少一個可導出的 adapter / merged 模型
- 部署測試可成功並回傳合理結果
- Learning Notes 有明確的問題與修正紀錄
- 形成「本機預處理 + 雲端訓練」的 SOP