# 面試可懂架構學習手冊：C 韌體 / LLM / FPGA

你現在要做的是把「知識點」變成「可解釋架構」。  
面試不是考你一次背多少東西，而是你能不能把問題拆開並講清楚。

## 共用原則（先看這份）

每一題都用一樣 4 行路線回答：
1. 架構：這個系統分幾層？（Input/Processing/Output/Recovery）
2. 資源：哪裡是瓶頸？（CPU、記憶體、時序、I/O、功耗）
3. 安全與穩定：失敗時怎麼回復？（timeout、retry、watchdog、fallback）
4. 指標：怎麼知道做得好？（延遲、吞吐、失敗率、記憶體、功耗）

你不需要一次把所有題目都會，只要每天至少 10 分鐘「畫圖 + 口頭說 30 秒」。

## 一、韌體（C）面試架構模板

### 一句話架構說明
「我把韌體系統分成啟動、驅動、任務、通訊、監控五層；用中斷與任務佇列維持時序可預測，再用看門狗與恢復機制確保穩定。」

### 應該會背的最小模型
- 層級：Boot -> Init -> HAL/Driver -> App -> Error Recovery
- 時間軸：中斷優先度、主迴圈、任務切換
- 記憶體策略：堆疊、靜態配置、buffer 大小、DMA
- 故障處理：watchdog、重啟策略、降階模式

### 你每天 2~4 小時怎麼安排（可加到日常計畫）
- 2 小時：看一個 C 主題（指標、指標、`volatile`） + 寫一個簡短驅動式小函式模擬
- 4 小時：補一個可在桌面環境重現的「韌體邏輯題」（例如事件佇列、重試機制） + 用文字畫出流程

## 二、LLM 工程師架構模板

### 一句話架構說明
「LLM 服務關鍵不是模型大小，而是輸入清洗、檢索增強、推論控制、回應治理與監控閉環這五層是否穩。」

### 應該會背的最小模型
- 層級：Ingress -> Router -> Context Builder -> Retrieval/LLM -> Guard -> Postprocess -> Observability
- 服務能力：cache、queue、fallback、cost control
- 效能治理：P95/P99、token 成本、超時、冷啟動
- 品質治理：prompt 邊界、輸出 schema、拒答策略

### 你每天 2~4 小時怎麼安排
- 2 小時：把一題 LLM 題（RAG / quant / LoRA）畫成資料流
- 4 小時：做一段 10 句以內口頭版本，並補上 1 個 fallback 設計

## 三、FPGA 面試架構模板

### 一句話架構說明
「FPGA 的面試要先證明你有時序意識：規格->RTL->模擬->綜合->P&R->上板->驗證，才能談加速成效。」

### 應該會背的最小模型
- 流程：Spec -> RTL design -> Simulation -> Synthesis -> Timing closure -> Bitstream -> Board bring-up
- 重點指標：LUT/FF/BRAM、Fmax、latency、throughput、功耗
- 驗證節點：module testbench、波形驗證、邊界測試
- 應用場景：pipeline、并行處理、硬體濾波、加速推論前處理

### 你每天 2~4 小時怎麼安排
- 2 小時：畫出一個小型處理流（input -> buffer -> pipeline -> output）並標出瓶頸
- 4 小時：加上 timing 風險點與 fallback 方案（例如頻率調降、資源縮減）

## 每日 10 分鐘口頭模板（直接背）
1. 「這題是做哪一層？」  
2. 「哪裡會超？」（瓶頸）  
3. 「如果超了怎麼救？」（fallback）  
4. 「怎麼驗證？」（指標）

## 你這次新增要的內容放在哪
- 架構主軸：本檔
- 方向對應題庫：`ai_ml_backend_question_bank.md`（已經新增 C 韌體與 FPGA 題區）
- 你原本的進度規劃：`30_day_plan.md`（保留）

## 你最少要做的 30 分鐘複習（隔日）
- 先複述一次韌體架構流程（2 分鐘）
- 再複述一次 LLM 流程（2 分鐘）
- 再複述一次 FPGA 流程（2 分鐘）
- 接著用 1 題題庫，按 4 行回答模板回覆
