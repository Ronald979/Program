# LLM Project Roadmap

## Project 01：Local Deployment First（先把 LLM 跑起來）

### Project 目標
- 在本機建立可重現的 LLM 推理服務。
- 會使用 REST API + CLI 呼叫模型並做錯誤回報。

### 前置知識
- Linux/PowerShell 基礎
- 容器化概念（docker-compose）
- 基本 Python 環境與套件安裝
- CUDA/PyTorch 版本基本判斷

### 核心概念
- 推理框架：Ollama / vLLM / llama.cpp
- Quantization（4bit/8bit）
- Context window、sampling（temperature, top_p, top_k）
- Token 速度、TPS、P99 延遲

### 任務清單
1. 建立本機推理腳本：`generate.py`
2. 對接 API 測試：`/v1/chat/completions`
3. 用最小資料做回歸測試：3 組提示詞 + 預期回覆
4. 實作簡易資源監控：顯卡/CPU 記憶體
5. 紀錄模型載入失敗、OOM、回覆格式錯誤的除錯流程

### Module / 文件結構

```text
Project_01_Local_Deploy_LLM
├── README.md
├── infra/
│   ├── docker-compose.yml
│   └── .env.example
├── apps/
│   ├── local_chat_cli.py
│   └── run_bench.py
├── scripts/
│   ├── install.sh / install.ps1
│   └── check_env.sh / check_env.ps1
├── docs/
│   ├── qa_learning.md
│   ├── learning_notes.md
│   ├── learning_log.md
│   └── gate_review.md
└── test/
    └── smoke_test.py
```

### Data Flow

```text
User Prompt
  -> API Client
    -> Inference Server (Ollama/vLLM)
      -> Model Engine
        -> Response
          -> Client Validation -> 回覆紀錄
```

### Error Handling

- `model not found`：確認模型名稱與 registry 對齊。
- `out of memory`：降到較小模型或加 `offload`
- `invalid response`：檢查訊息格式與 stop sequence。

### 常見問題
- 模型下載過慢：先用小模型確認 pipeline。
- 版本衝突：固定 docker image tag。
- 回覆亂碼：確認 prompt template 與 token 編碼。

### 測試方式
- `python apps/local_chat_cli.py` 是否能正常回覆
- `python test/smoke_test.py` 是否通過
- 連續 10 次請求可否保持成功率

### Project Gate Review
- 本地 server 可穩定啟停
- CLI/HTTP 都能回傳
- 回覆格式可解析
- 有 baseline latency / memory 日誌
- 文件完整、可重現

## Project 02：Self-Train LLM Architecture（自己 train 的完整架構）

### Project 目標
- 建立一條「可重播」的 LLM 訓練流程。
- 從資料準備到模型匯出做一條可重播流水線。
- 先做 LoRA SFT，再逐步擴充 DPO（可選）。

### 前置知識
- PyTorch / Hugging Face Transformers
- JSONL、token、序列長度（context）
- 梯度累積、學習率排程、PEFT
- 實驗紀錄（W&B / MLflow）

### 架構說明（最小可行）

```text
[Raw Data]
    |
    +--> [Cleaning]
    +--> [Dedup / Filtering]
    +--> [Formatting]
    |
[Dataset Builder]
    |
[Tokenizer]
    |
[Trainer(LoRA SFT)] --> [Checkpoint]
    |
[Evaluator] --> [Report]
    |
[Optional DPO]
    |
[Export + Quantize] --> [Local Deploy]
```

### 任務

1. 建立 `configs/`：model / train / eval
2. `build_dataset.py` 生成 token 與長度統計
3. 寫 `train_lora.py`，先跑 smoke + full run
4. 寫 `eval.py` 生成質量報表
5. `merge_and_export.py` 產生部署用模型
6. 回到 Project 01 完整走一次端到端