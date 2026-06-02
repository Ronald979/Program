# LLM學習規劃（對齊既有學習架構）

這份規劃沿用你現有的 `C_Algorithm_Planning.md` 節奏：
- 每個階段都要有明確目標
- 每個 Project 都有可執行任務、錯誤處理、除錯方式
- 每個階段需有 Q&A / Learning Notes / Project Gate Review

## 1. 學習目標

- 先把 LLM 在本地跑起來（可用 API、可對話、可排查）。
- 再做「能跑通」的 LLM 訓練全流程（至少到微調可交付）。
- 最後建立你自己可延伸的完整架構：
  - 本地推理平台
  - 資料整理與評估
  - 訓練/微調 pipeline
  - 版本控管與實驗追蹤

## 2. 學習階段（共 2 大段）

### Phase A：Local Deployment LLM（先上手）
1. 基礎環境與 GPU/CPU 檢核
2. 本地載入/啟動開源模型（7B/8B）
3. API/CLI 驗證與簡單應用
4. 性能與資源監控
5. 錯誤日誌與排查機制

### Phase B：Self-Train LLM Architecture（架構能力）
1. 資料來源、清洗、格式化
2. Tokenizer / 上下文長度設計
3. 指令微調（SFT）
4. LoRA/Adapter 微調
5. 對齊流程（可選：DPO/RLHF）
6. 評估框架與回歸測試
7. 模型導出與部署版本化

## 3. 章節目標表

| 階段 | 核心目標 | 可交付 | 驗收條件 |
| --- | --- | --- | --- |
| P1 本地部署 | 一個穩定可重現的 LLM 推理環境 | `docker-compose` + 讀取腳本 + API 測試 | 啟動成功、能回覆、CPU/GPU 用量可觀測 |
| P2 訓練預備 | 資料管線可重放 | ETL 腳本 + dataset profile | 清洗、切分、checksum、版本快照 |
| P3 微調基礎 | 完成第一版可重複訓練流程 | `train.py` + `config` + `accelerate` 配置 | 在驗證集有穩定指標改善 |
| P4 對齊與評估 | 做出質量可比對的成品 | 評估報表 + 風險測試集 | 在 3 類指標上有可讀 baseline |
| P5 成果整合 | 訓練到部署收斂 | Exported 模型 + 簡易部署腳本 | 模型可再次在本地啟動並驗證 |

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
- 5-7 週：P3（SFT + LoRA）
- 8 週：P4（評估與對齊）
- 9-10 週：P5（部署整合）
- 11-12 週：Project Gate Review + 作品總整理

## 6. 每個 Project 都要保留的輸出

- `docs/qa_learning.md`
- `docs/learning_notes.md`
- `docs/gate_review.md`
- `runbooks/`：啟動與除錯手冊
- `checkpoints/`：訓練實驗快照與指標
- `scripts/`：資料與訓練自動化腳本

## 7. 你可以先執行的下一步

1. 我已建好 Folder 和核心文件（待你確認）後，第二步可以直接依 `Project_01_Local_Deploy_LLM/README.md` 開始佈署。
2. 當你告訴我 GPU 規格後，我可以立即幫你把每一個指令鎖成對應硬體版本（例如：RTX 3060、A100、Mac M2）。