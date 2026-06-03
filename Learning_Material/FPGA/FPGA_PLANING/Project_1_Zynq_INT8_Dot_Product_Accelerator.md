# Project 1：Zynq INT8 Dot Product Accelerator

實作路徑：`C:\Users\ronald\Program\FPGA\Project\Zynq_INT8_Dot_Product_Accelerator`

## 1. Project 目標

建立第一個可驗證、可上板的 Zynq PS-PL INT8 accelerator。PL 用 Verilog RTL 計算 16-element dot product，PS 用 bare-metal C 透過 AXI-Lite register map 控制。

```text
result = sum(A[i] * B[i]), i = 0..15
A[i], B[i] : signed int8
result     : signed int32
```

## 2. 本 Project 對 AI Accelerator 的意義

Dot product 是 matrix multiplication、convolution、fully-connected layer 的共同底層運算。本 project 不追求高效能，重點是建立以下工程閉環：

* RTL module 切分。
* signed INT8 MAC 正確性。
* AXI-Lite control/status/data register。
* PS software golden model 比對。
* simulation 與 hardware bring-up。

## 3. 前置知識

| 類別 | 必須理解 |
| --- | --- |
| RTL | clock/reset、FSM、signed multiply、register |
| AXI-Lite | address/data/response channel、memory-mapped register |
| Zynq | PS `M_AXI_GP0` 連到 PL peripheral |
| C | volatile/MMIO access、int8_t packing、polling timeout |
| Verification | testbench、golden model、waveform、corner case |

## 4. 系統架構

PS 負責準備資料、寫 register、啟動 accelerator、poll done、讀 result、和 software result 比對。PL 負責 latch vector、執行 16 次 signed MAC、輸出 int32 result。

## 5. Block Diagram

```text
ARM Cortex-A9 bare-metal C
        |
        | AXI-Lite M_AXI_GP0
        v
AXI Interconnect / SmartConnect
        |
        v
axi_lite_dot_product
  ├── register file
  └── int8_dot_product_core
        └── int8_mac
```

## 6. RTL Module 切分

| Module | 責任 |
| --- | --- |
| `int8_mac` | signed int8 multiply + signed int32 accumulate |
| `int8_dot_product_core` | latch A/B，跑 16-cycle sequential dot product |
| `axi_lite_dot_product` | AXI-Lite slave、register map、start/done/result |

## 7. Interface 設計

第一版使用 AXI-Lite registers。A/B input 直接打包在 8 個 32-bit register 中，result 由 1 個 32-bit register 讀回。不使用 DMA、不使用 BRAM data buffer。

## 8. Register Map / Memory Map

建議 base address：`0x43C0_0000`，range：`64K`。

| Offset | Name | 說明 |
| --- | --- | --- |
| `0x00` | CONTROL | bit0 start、bit1 clear_done |
| `0x04` | STATUS | bit0 busy、bit1 done |
| `0x08` | VECTOR_LENGTH | 固定 16 |
| `0x0C` | LATENCY_CYCLES | 上次 core latency |
| `0x10..0x1C` | A0..A3 | A[0..15] |
| `0x20..0x2C` | B0..B3 | B[0..15] |
| `0x30` | RESULT | signed int32 result |

## 9. Data Flow

```text
C arrays -> pack int8 into 32-bit words -> AXI-Lite writes -> PL registers
PL registers -> core latch -> sequential MAC -> result register
result register -> AXI-Lite read -> C compare with software golden
```

## 10. Control Flow

1. PS read `VECTOR_LENGTH`。
2. PS write `A0..A3`、`B0..B3`。
3. PS write `CONTROL.clear_done`。
4. PS write `CONTROL.start`。
5. PL sets busy。
6. PL runs 16 MAC cycles。
7. PL pulses done，wrapper sets done sticky。
8. PS poll done，read `RESULT`。

## 11. Testbench 設計

* core testbench：直接驅動 `start/a_vector/b_vector`。
* AXI wrapper testbench：透過 AXI-Lite task 寫 A/B、start、poll status、讀 result。
* case 必須包含 zero、all one、mixed sign、最大幅度負數、交錯正負。

## 12. Golden Model

* Python golden model：產生 expected result 與 packed register words。
* PS C golden model：hardware run 當下用同一筆資料計算 expected result。

## 13. 驗收標準

| 項目 | 標準 |
| --- | --- |
| Simulation | core 與 AXI wrapper testbench pass |
| Correctness | RTL result 等於 Python/C golden |
| Hardware | UART 顯示 SW result、PL result、latency、PASS |
| Timing | `LATENCY_CYCLES = 16` |
| Resource | 記錄 LUT/FF/DSP/BRAM |
| Debug | 若失敗，有 waveform 或 UART log |

## 14. 常見錯誤

* Verilog 沒宣告 signed，負數乘法錯。
* C packing 用 signed left shift，造成 undefined 或錯誤值。
* byte order 和 register map 對不起來。
* reset polarity 接錯。
* C base address 和 Vivado address editor 不一致。
* 忘記重新 package IP 或重新 generate bitstream。

## 15. Debug Checklist

1. 讀 `VECTOR_LENGTH` 是否為 16。
2. 寫 A/B 後讀回是否一致。
3. 寫 start 後 `busy` 是否變 1。
4. `LATENCY_CYCLES` 是否為 16。
5. `RESULT` 是否等於 Python golden。
6. Waveform 檢查 `a_current/b_current/product/acc_next`。

## 16. Performance Measurement

* Core latency：`LATENCY_CYCLES`。
* PS wall-clock：可用 ARM global timer 或 XTime 量測 `start` 到 `done` polling。
* Throughput：單次 dot product / total cycles。
* 第一版不宣稱 speedup，先建立 measurement baseline。

## 17. Resource Usage 觀察

Vivado report 中記錄：

* LUT
* FF
* DSP
* BRAM
* Fmax / WNS

本版使用 1 個 MAC，DSP 使用量應低，BRAM 應為 0。

## 18. Project 問答區域 Q&A Zone

詳見實作路徑：`docs/qa_learning.md`

## 19. Project 筆記區域 Learning Notes Zone

詳見實作路徑：`docs/qa_learning.md`

## 20. 是否可以進入下一個 Project？

目前判斷：可以開始本 project 實作與 simulation；不建議直接進入 4x4 matrix multiplication。

進入下一個 Project 的條件：

* simulation pass。
* hardware run pass。
* PS result 和 PL result 一致。
* 能說明 AXI-Lite register map。
* 能解釋 signed int8 multiply 與 int32 accumulation。
* 能說明 dot product 如何擴展成 4x4 matrix multiplication。
