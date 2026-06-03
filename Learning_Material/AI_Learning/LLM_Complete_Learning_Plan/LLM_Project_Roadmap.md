# LLM Project Roadmap

本版本已以 **GTX 1050（約4GB）** 鎖定，重點是本地推理穩定，微調放雲端。

## Project 01：Local Deployment First（先把 LLM 跑起來）

### Project 目標
- 在本機建立可重現的 LLM 推理服務。
- 會使用 REST API + CLI 呼叫模型並能做錯誤回報。
- 不求速度極限，先求穩定可用。

### 前置知識
- Linux/PowerShell 基礎
- 容器化概念（docker-compose）
- 基本 Python 環境與套件安裝
- 顯卡資源與 CUDA 版本判斷

### 硬體條件（GTX 1050）
- 建議模型：`phi3:mini`、`tinyllama:1.1b`、`llama3.2:1b`
- context 建議：1024 以內
- 先用 `Ollama`，避免 1050 上 vLLM/llama.cpp 的資源壓力
- 4-bit/8-bit 量化為預設，`max_tokens` 先 128~256

### 核心概念
- 推理框架優先：`Ollama`
- Quantization（4bit/8bit）
- Context window、sampling（temperature, top_p, top_k）
- Token 速度、TPS、P99 延遲

### 任務清單
1. 建立本機推理腳本：`generate.py`（或 `local_chat_cli.py`）
2. 對接 API 測試：`/v1/chat/completions`
3. 用最小資料做回歸測試：5 組提示詞 + 預期回覆
4. 實作簡易資源監控：NVIDIA-SMI / 任務記憶體
5. 記錄模型載入失敗、OOM、回覆格式錯誤的除錯流程

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
│   ├── install.ps1
│   ├── check_env.ps1
│   └── preload.ps1 (可選：模型預載流程)
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
  -> API/CLI Client
    -> Inference Server (Ollama)
      -> Quantized Model Engine
        -> Response
          -> Client Validation -> 記錄回報
```

### Error Handling

- `model not found`：確認模型名稱與 registry 對齊。
- `out of memory`：降低 batch、降模型、縮短 prompt/context。
- `invalid response`：檢查訊息格式與 stop sequence。
- `server not start`：固定 Docker image tag，先看 `docker compose logs`。

### 常見問題
- 模型下載過慢：先用最小模型（tinyllama/phi3-mini）驗證流水線。
- 回覆變慢：把 `num_ctx`、`num_predict` 從 2048 降到 1024/256。
- 版本衝突：固定 image tag + 本機 Python 套件版本。

### 測試方式
- `python apps/local_chat_cli.py` 是否能正常回覆
- `python test/smoke_test.py` 是否通過
- 連續 20 次請求可否維持成功率

### Project Gate Review
- 本地 server 可穩定啟停
- CLI/HTTP 都能回傳
- 回覆格式可解析
- 有 baseline latency / memory 日誌
- 文件完整、可重現

## Project 02：Self-Train LLM Architecture（自己 train 的完整架構）

### Project 目標
- 建立一條「可重播」的 LLM 訓練流程，但將**本機訓練重任外包到雲端 GPU**。
- 從資料準備到模型導出做可回溯流水線。
- 先做 LoRA SFT，再逐步擴充 DPO（可選）。

### 前置知識
- Python / Git
- JSONL、token、序列長度（context）
- PyTorch 訓練概念、PEFT
- 實驗紀錄（W&B / MLflow）

### 架構說明（本機 + 雲端）

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
[Cloud Train (LoRA)] --> [Adapter Checkpoint]
    |
[Evaluator] --> [Report]
    |
[Merge + Quantize] --> [Local Deploy Smoke Test]
```

### 任務

1. 建立 `configs/`：model / train / eval
2. `build_dataset.py` 生成 token 與長度統計、品質報告
3. 設計 `train_lora.py` 的雲端參數模板（batch、lr、lora rank）
4. `eval.py` 生成質量報表（本機可比對）
5. `merge_and_export.py` 合併 adapter，輸出可量化模型
6. 回到 Project 01 以 smoke test 完整走一次端到端