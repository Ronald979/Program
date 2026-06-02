# Project 1：Zynq INT8 Dot Product Accelerator Q&A / Learning Notes

## Learning Log

| Date | Project | Topic | Question / Note | AI Feedback | Status |
| ---- | ------- | ----- | --------------- | ----------- | ------ |
| 2026-06-02 | Zynq INT8 Dot Product Accelerator | Architecture Decision | 第一版是否使用 AXI-Lite、AXI BRAM 或 DMA？ | 本版使用 AXI-Lite register file，因資料量只有 32 bytes input 與 4 bytes output，最適合先驗證 PS-PL 控制與 RTL 正確性。DMA 延後到資料量變大時再導入。 | Answered |

## Project 問答區域 Q&A Zone

### Q1. 第一版為什麼不使用 AXI DMA？

**問題分類：** AXI Interface / Architecture Decision

**我的問題：**  
本 project 要先用 AXI-Lite 或 AXI BRAM，不使用 DMA。應該怎麼選？

**AI 解答摘要：**  
Vector length 只有 16，A/B 各 16 bytes，輸出 1 個 int32。AXI DMA 的設定成本與 debug 成本遠高於資料搬運本身，因此第一版用 AXI-Lite registers 最務實。等升級到 16x16 tiled matrix multiplication 或 convolution，資料量變大後再導入 AXI DMA。

**關鍵觀念：**

* 小資料量先用 register map，能把控制流程、done polling、golden comparison 做穩。
* DMA 是資料搬運優化，不是第一個 accelerator 成功的必要條件。
* 不懂 AXI-Lite register map 就直接接 DMA，debug 範圍會太大。

**實作影響：**

* RTL 需要 `axi_lite_dot_product` wrapper。
* Testbench 需要測 AXI write/read。
* Register map 是硬體與 C 程式的共同契約。
* 下一個 4x4 matrix multiplication 仍可沿用 AXI-Lite。

**待驗證項目：**

* simulation：AXI wrapper write/start/poll/read。
* hardware：PS 讀 `VECTOR_LENGTH`、寫 A/B、讀 `RESULT`。
* waveform：`AW/W/B/AR/R` handshake 和 `core_start` pulse。
* golden model：PS software result 等於 PL result。

**目前理解狀態：** 已實作但需 hardware 驗證

### Q2. INT8 乘法需要注意什麼？

**問題分類：** Fixed-point / INT8 / Overflow / RTL

**我的問題：**  
INT8 input 和 weight 相乘，再做 INT32 accumulation，RTL 要怎麼避免 signed 錯誤？

**AI 解答摘要：**  
`a` 和 `b` 必須宣告為 `signed [7:0]`，乘積是 signed 16-bit，再 sign-extend 到 32-bit 後累加。C 端 packing 時要先轉成 `uint8_t`，只搬 bit pattern，不在 packing 階段做 signed arithmetic。

**關鍵觀念：**

* `8'h80` 在 int8 是 `-128`，不是 `+128`。
* Verilog signedness 會影響 multiply 結果。
* 本 project 最大累加值約 `262144`，INT32 足夠。

**實作影響：**

* `int8_mac.v` 使用 signed ports。
* Testbench 必須包含負數與最大幅度 case。
* Golden model 必須以 int8 signed 解讀 byte。

**待驗證項目：**

* `127 * -128` case。
* mixed sign case。
* waveform 檢查 `product` 與 `acc_next`。

**目前理解狀態：** 已實作但需 waveform 複查

## Project 筆記區域 Learning Notes Zone

### 我的筆記

請你在 simulation pass 與 hardware run pass 後，用自己的話補上：

1. 這個 Project 在做什麼。
2. 為什麼 dot product 是 AI accelerator 的基礎。
3. A/B 資料從 PS 到 PL 的路徑。
4. CONTROL / STATUS / RESULT registers 的作用。
5. `start`、`busy`、`done` 的 timing。
6. RTL module 如何分工。
7. testbench 測了哪些 case。
8. golden model 如何比對。
9. 你遇到的錯誤與 debug 方法。
10. 下一次升級到 4x4 matrix multiplication 時，你會保留與修改哪些部分。

### AI 審核

等待你填寫筆記後再審核。審核時會檢查：

* 是否能說清楚資料流，而不是只背 module 名稱。
* 是否能指出 register map 與 C 程式 packing 的關係。
* 是否能解釋 signed INT8 multiply 的風險。
* 是否能根據 waveform 說明 latency 為什麼是 16 cycles。
* 是否能列出至少 3 個 hardware bring-up 可能錯誤。

## Project Gate Review

目前判斷：可以開始實作與 simulation，但尚不可結案。

結案需要：

* core simulation pass。
* AXI wrapper simulation pass。
* Vivado synthesis/implementation pass。
* hardware terminal 顯示 `PASS`。
* 你完成 Learning Notes，並通過 AI review。
