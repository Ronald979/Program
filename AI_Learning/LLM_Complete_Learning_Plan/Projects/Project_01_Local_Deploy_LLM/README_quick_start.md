# Project 01 Quick Start (Windows PowerShell)

## 1) 啟動 Local API

```powershell
cd C:\Users\ronald\Program\AI_Learning\LLM_Complete_Learning_Plan\Projects\Project_01_Local_Deploy_LLM

# 安裝相依套件
.\scripts\install.ps1

# 啟動 Ollama server
cd infra
copy .env.example .env
docker compose up -d

# 確認服務
docker compose ps
Invoke-WebRequest -Uri http://localhost:11434 -UseBasicParsing
```

## 2) 下載模型（第一次）

```powershell
ollama pull phi3:mini
# 或者你可改成 tinyllama:1.1b
```

## 3) 快速對話測試

```powershell
cd C:\Users\ronald\Program\AI_Learning\LLM_Complete_Learning_Plan\Projects\Project_01_Local_Deploy_LLM
python .\apps\local_chat_cli.py --model phi3:mini --prompt "請用一句話解釋什麼是 Inference"
```

## 4) 壓力/基準測試

```powershell
cd C:\Users\ronald\Program\AI_Learning\LLM_Complete_Learning_Plan\Projects\Project_01_Local_Deploy_LLM
python .\apps\run_bench.py --model phi3:mini --rounds 2
python .\test\smoke_test.py
```

## 5) 檢查報告

```powershell
python .\scripts\check_env.ps1
```

> 重要：若你看到 OOM，優先降 `num_ctx`，改用更小模型，先穩定再優化。
