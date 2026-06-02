# LLM學習規劃（對齊既有學習架構）

這份規劃沿用你現有的 `C_Algorithm_Planning.md` 節奏：
- 每個階段都要有明確目標
- 每個 Project 都有可執行任務、錯誤處理、除錯方式
- 每個階段需有 Q&A / Learning Notes / Project Gate Review

### 硬體前提（已鎖定）
- GPU：NVIDIA GTX 1050（約 4GB）
- 本機定位：可做 **LLM 本地部署 + 量化推理 + 基礎監控**
- 本機限制：不建議做全量訓練/大規模 SFT
- 解法：
  - Project 01 做「穩定部署」
  - Project 02 做「資料處理 + 評估 + 遠端訓練」並回灌到本地

## 1. 學習目標

- 先把 LLM 在本地跑起來（可用 API、可對話、可排查）。
- 再做「可跑通」的 LLM 訓練流程：本機前處理、雲端 LoRA 微調、回灌本地。
- 最後建立你可持續擴充的完整架構：
  - 本地推理平台
  - 資料整理與評估
  - 訓練/微調 pipeline
  - 版本控管與實驗追蹤

## 2. 學習階段（共 2 大段）

### Phase A：Local Deployment LLM（先上手）
1. 基礎環境與 GPU/CPU 檢核
2. 本地載入/啟動量化模型（建議 1B~3B）
3. API/CLI 驗證與簡單應用
4. 性能與資源監控（TTFT/TPS、VRAM/RAM）
5. 錯誤日誌與除錯機制

### Phase B：Self-Train LLM Architecture（架構能力）
1. 資料來源、清洗、格式化
2. Tokenizer / 上下文長度設計
3. 指令微調（SFT）腳手架（以本機可重現腳本為主）
4. LoRA/Adapter 微調（訓練主力改到雲端）
5. 對齊流程（可選：DPO/RLHF）
6. 評估框架與回歸測試
7. 模型導出與部署版本化（只回灌 adapter/merged 量化模型到本機）

## 3. 章節目標表

| 階段 | 核心目標 | 可交付 | 驗收條件 |
| --- | --- | --- | --- |
| P1 本地部署 | 一個可重現的低資源 LLM 推理環境 | `docker-compose` + 推理腳本 + API 測試 | 以 `phi-3-mini`/`llama3.2:1b`/`tinyllama` 成功啟動，回覆可解析 |
| P2 訓練預備 | 資料 pipeline 可重放 | ETL 腳本 + dataset profile + checksums | 清洗、切分、重複檢查、版本快照完成 |
| P3 雲端微調 | 完成最小可行微調實驗 | remote train config + 結果回傳 | 指標文件可追溯，並可回收 adapter |
| P4 對齊與評估 | 做出質量可比對的成品 | 評估報表 + 風險測試集 | 在 3 類指標上有可讀 baseline |
| P5 成果整合 | 微調成果回灌並可本地驗證 | exported/quantized 模型 + local smoke test | 本機可載入並完成回歸提問 |

## 4. 檔案結構

```text
C_Algorithm/LLM_Complete_Learning_Plan
├── LLM_Learning_Plan.md
├── LLM_Project_Roadmap.md
└── Projects
    ├── Project_01_Local_Deploy_LLM
    │   └── README.md
    └── Project_02_Self_Train_LLM_Architecture
        └── README.md
```

## 5. 12 週建議節奏（可壓縮為 6~10 週）

- 1-2 週：P1（本地基礎部署）
- 3-4 週：P2（資料工具鏈）
- 5-6 週：P3（雲端 LoRA 實驗）
- 7 週：P4（評估與回歸）
- 8-9 週：P5（導出與量化部署）
- 10-12 週：Project Gate Review + 作品總整理

## 6. 每個 Project 都要保留的輸出

- `docs/qa_learning.md`
- `docs/learning_notes.md`
- `docs/gate_review.md`
- `runbooks/`：啟動與除錯手冊
- `checkpoints/`：訓練實驗快照與指標
- `scripts/`：資料與訓練自動化腳本

## 7. 你可以先執行的下一步

1. 先直接照 [Project_01_Local_Deploy_LLM/README.md] 走一輪基礎佈署，先確認本機可運行。
2. 成功後再把 `local` 進程固定為「推理」，`training` 進程固定為「雲端」，做兩條路徑並行。
3. 下一步我可以再幫你直接補一版 `C_Algorithm\LLM_Complete_Learning_Plan\Projects\Project_01_Local_Deploy_LLM\infra` 和 `apps` 的實作腳本。