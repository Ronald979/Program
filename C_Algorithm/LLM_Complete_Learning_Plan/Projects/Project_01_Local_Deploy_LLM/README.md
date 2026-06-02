# Project 01: Local LLM Deployment

## 1. Project 目標

在本機建立一套可重現的 LLM 推理服務：
- 快速安裝
- 穩定啟動
- 可監控
- 可回歸測試

## 2. 前置技能

- Docker 或 venv 使用
- Python 3.10+
- curl / HTTP API
- 基本 Linux 指令（或 PowerShell）

## 3. 最小可交付範圍

- `local_chat_cli.py`
- `scripts/check_env.ps1`
- `infra/docker-compose.yml`
- `test/smoke_test.py`
- `docs/{qa_learning.md,learning_notes.md,gate_review.md}`

## 4. 步驟

1. 建立模型服務容器：Ollama 或 vLLM
2. 載入一個 7B 小模型
3. 用 REST API 進行聊天測試
4. 加入簡易資源監控腳本
5. 產出第一版 README runbook

## 5. 功能拆解

- API 測試模組：健康檢查、模型列表、生成測試
- CLI 模組：輸入 prompt 並列印回覆時間
- 指標模組：記錄 TTFT、TPS、顯存/記憶體

## 6. 錯誤處理

- 啟動失敗：輸出 container log + 環境檢查結果
- 超時：輸出 retry 次數與請求參數
- 回覆格式錯誤：記錄原始 body 並驗證 JSON schema

## 7. 測試

- smoke test：5 題固定 prompt，確保 5 題皆成功回覆
- 回歸測試：下週再跑一次，對比前後延遲

## 8. Debug Checklist

- 先 `docker compose up -d` 再 `curl /v1/models`
- 若 OOM -> 降 token 或開 quantized mode
- 若回覆空白 -> 檢查 context、模板、stream 設定

## 9. 常見問題

- 模型下載卡住：先切換到較小模型
- API 回傳 404：核對 endpoint 路由
- 字元亂碼：確認 encoding + prompt 模板

## 10. Gate Review（入場條件）

- 本地模型可反覆啟停
- CLI/HTTP 都能回傳
- 測試日誌可定位失敗原因
- `docs/*` 有至少 1 份可重複步驟