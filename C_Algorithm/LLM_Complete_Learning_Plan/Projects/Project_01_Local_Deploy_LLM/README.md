# Project 01: Local LLM Deployment

## 1. Project 目標

在本機建立一套可重現的 LLM 推理服務：
- 快速安裝
- 穩定啟動
- 可監控
- 可回歸測試
- 以 GTX 1050 的可承受範圍為第一優先

## 2. 前置技能

- Docker 或 venv 使用
- Python 3.10+
- curl / HTTP API
- 基本 Linux 指令（或 PowerShell）

## 3. 最小可交付範圍

- `local_chat_cli.py`
- `scripts/check_env.ps1`
- `scripts/install.ps1`
- `infra/docker-compose.yml`
- `infra/.env.example`
- `test/smoke_test.py`
- `docs/{qa_learning.md,learning_notes.md,learning_log.md,gate_review.md}`

## 4. 硬體限制設定（GTX 1050）

- 建議模型：`phi3:mini`、`llama3.2:1b`、`tinyllama:1.1b`
- `context` 先壓到 1024 以內
- `max_tokens` 先 128~256
- 推理框架優先：`Ollama`
- 如出現 OOM，先降模型、再降並行數、最後降 tokens，不要一開始調太大

## 5. 步驟

1. 建立模型服務容器：先用 Ollama
2. 載入 1B ~ 3B 小模型，確認可推理
3. 用 REST API 進行聊天測試
4. 加入簡易資源監控腳本（VRAM/RAM/CPU）
5. 產出第一版 README runbook（含啟停、重現、除錯）

## 6. 功能拆解

- API 測試模組：健康檢查、模型列表、生成測試
- CLI 模組：輸入 prompt 並列印回覆時間（TTFT/TPS）
- 指標模組：記錄顯存、記憶體、response 長度

## 7. 錯誤處理

- 啟動失敗：輸出 container log + 環境檢查結果
- 超時：輸出 retry 次數與請求參數
- 回覆格式錯誤：記錄原始 body 並驗證 JSON schema
- OOM：關掉其他 GPU 負載、縮短 prompt、切換更小模型

## 8. 測試

- smoke test：5～10 題固定 prompt，確保每題皆成功回覆
- 回歸測試：下週再跑一次，對比前後延遲

## 9. Debug Checklist

- 先 `docker compose up -d` 再 `curl /v1/models`
- 若 OOM -> 降 `num_ctx`、`num_predict`，改用更小模型
- 若回覆空白 -> 檢查 context、模板、stream 設定

## 10. 常見問題

- 模型下載卡住：先切換到最小模型驗證 pipeline
- API 回傳 404：核對 endpoint 與 Ollama 版本一致
- 字元亂碼：確認 encoding + prompt 模板
- 回覆慢：先固定 max tokens，並監控 VRAM 峰值

## 11. Gate Review（入場條件）

- 本地模型可反覆啟停
- CLI/HTTP 都能穩定回傳
- 測試日誌可定位失敗原因
- `docs/*` 有至少 1 份可重複步驟
- 成功在 GTX 1050 上完成最低配推理流量（連續 20 次 1~2 段對話）