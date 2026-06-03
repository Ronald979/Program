# Project 1：Zynq INT8 Dot Product Accelerator

本專案是第一個可在 Zynq PS-PL 上跑通的 INT8 AI accelerator prototype。目標不是追求大模型，而是把「PS 控制、PL 計算、AXI-Lite register map、RTL 驗證、golden model 比對、硬體驗收」完整走一遍。

## Project Scope

| 項目 | 設計選擇 |
| --- | --- |
| FPGA | Xilinx Zynq-7000 / Zynq-7015 類板子 |
| PS | ARM Cortex-A9 bare-metal C |
| PL | Verilog RTL accelerator |
| Interface | AXI-Lite memory-mapped registers |
| Data type | input int8、weight int8、accumulation int32 |
| Vector length | 16 |
| Function | `result = sum(A[i] * B[i])`, `i = 0..15` |
| 不使用 | Vitis AI、DPU、Linux driver、AXI DMA |

## 目錄

| 路徑 | 用途 |
| --- | --- |
| `rtl/` | synthesizable Verilog RTL |
| `tb/` | RTL simulation testbench 與 Icarus runner |
| `golden/` | Python golden model |
| `sw/baremetal/` | Zynq PS bare-metal C 控制程式 |
| `vivado/` | Vivado block design 連接方式 |
| `docs/` | Q&A、learning notes、debug checklist |

## 1. 系統 Block Diagram

```text
        Zynq Processing System (PS)
        ARM Cortex-A9 bare-metal C
                  |
                  | AXI-Lite GP0
                  v
        +--------------------------+
        | AXI Interconnect/Smart   |
        +--------------------------+
                  |
                  | AXI-Lite slave
                  v
+------------------------------------------------+
| PL: axi_lite_dot_product                       |
|                                                |
|  Control/Status Registers                      |
|  A[0..15] regs, B[0..15] regs, result reg      |
|        |                                       |
|        v                                       |
|  int8_dot_product_core                         |
|        |                                       |
|        v                                       |
|  int8_mac: int8 * int8 + int32 accumulator     |
+------------------------------------------------+
```

本版資料量很小，A/B vector 直接由 PS 寫入 AXI-Lite registers，不經 DDR、BRAM 或 DMA。這能先把控制面和驗證方法做穩。

## 2. RTL Module Hierarchy

```text
axi_lite_dot_product
├── AXI-Lite write/read handshake
├── register file
│   ├── CONTROL
│   ├── STATUS
│   ├── A0..A3
│   ├── B0..B3
│   ├── RESULT
│   └── LATENCY_CYCLES
└── int8_dot_product_core
    └── int8_mac
```

設計重點：

* `axi_lite_dot_product`：PS 可見的 memory-mapped peripheral。
* `int8_dot_product_core`：在 `start` 時 latch A/B vector，使用 1 個 MAC sequential 跑 16 cycles。
* `int8_mac`：signed INT8 multiply，signed INT32 accumulate。

## 3. Register Map

假設 Vivado address editor 指派 base address 為 `0x43C0_0000`，offset 如下。

| Offset | Name | R/W | Bits | 說明 |
| --- | --- | --- | --- | --- |
| `0x00` | CONTROL | W | bit0 | `start`，write-1 pulse。busy 時忽略 |
| `0x00` | CONTROL | W | bit1 | `clear_done`，write-1 pulse |
| `0x04` | STATUS | R | bit0 | `busy`，core 正在運算 |
| `0x04` | STATUS | R | bit1 | `done`，sticky，直到 clear 或下一次 start |
| `0x08` | VECTOR_LENGTH | R | `[31:0]` | 固定回傳 `16` |
| `0x0C` | LATENCY_CYCLES | R | `[31:0]` | 上次 core 計算 latency，本版應為 `16` |
| `0x10` | A0 | R/W | bytes | `{A3,A2,A1,A0}` |
| `0x14` | A1 | R/W | bytes | `{A7,A6,A5,A4}` |
| `0x18` | A2 | R/W | bytes | `{A11,A10,A9,A8}` |
| `0x1C` | A3 | R/W | bytes | `{A15,A14,A13,A12}` |
| `0x20` | B0 | R/W | bytes | `{B3,B2,B1,B0}` |
| `0x24` | B1 | R/W | bytes | `{B7,B6,B5,B4}` |
| `0x28` | B2 | R/W | bytes | `{B11,B10,B9,B8}` |
| `0x2C` | B3 | R/W | bytes | `{B15,B14,B13,B12}` |
| `0x30` | RESULT | R | signed `[31:0]` | dot product result |

Byte order：`A0[7:0] = A[0]`，`A0[15:8] = A[1]`。C 端用 `(uint8_t)` packing，避免 signed shift 出錯。

## 4. Memory Map

| Region | 建議位址 | Size | Owner | 用途 |
| --- | --- | --- | --- | --- |
| Dot Product AXI-Lite | `0x43C0_0000` | `64K` | PS/PL | 控制、A/B input、result、latency |
| DDR | Vivado PS 預設 | board dependent | PS | 本版不需要用來搬 accelerator data |
| BRAM | 無 | 無 | 無 | 本版不使用 AXI BRAM |
| DMA | 無 | 無 | 無 | 本版不使用 AXI DMA |

## 5. Control Flow

```text
PS software:
1. Read VECTOR_LENGTH，確認等於 16。
2. 用 software golden model 算出 expected int32 result。
3. 將 A[0..15] pack 成 A0..A3，寫入 AXI-Lite。
4. 將 B[0..15] pack 成 B0..B3，寫入 AXI-Lite。
5. Write CONTROL.clear_done = 1。
6. Write CONTROL.start = 1。
7. Poll STATUS.done，或檢查 timeout。
8. Read RESULT 與 LATENCY_CYCLES。
9. 比對 PL result 和 software result。
```

PL behavior：

```text
IDLE:
  wait start
  latch A/B vector
  acc = 0
  busy = 1

RUN:
  for index 0..15:
    acc = acc + signed(A[index]) * signed(B[index])

DONE:
  result = acc
  done pulse -> wrapper done sticky
  busy = 0
```

## 6. Timing Flow

假設 `s_axi_aclk = 100 MHz`：

```text
T0       AXI write CONTROL.start accepted
T1       core latches start, busy=1
T1..T16  16 個 MAC cycle，index 0..15
T16      result registered，core_done pulse
T17+     STATUS.done sticky=1，PS 可讀 RESULT
```

RTL 的 `LATENCY_CYCLES` 量測的是 core MAC cycles，固定為 `16`。實際 PS 端 wall-clock latency 還包含 AXI write、poll、read 的時間，硬體驗收時要分開記錄。

## 7. Testbench 設計

檔案：

| Testbench | 驗證重點 |
| --- | --- |
| `tb/tb_int8_dot_product_core.v` | core signed multiply、accumulate、done、latency |
| `tb/tb_axi_lite_dot_product.v` | AXI-Lite write/read、register packing、start/done/result |

測試 case：

| Case | 目的 |
| --- | --- |
| zero | reset 後與零輸入 |
| all_one | 基本正數累加 |
| mixed_sign | signed int8 正負號 |
| max_magnitude_negative | `127 * -128` 的符號延伸與累加 |
| alternating | 交錯正負值 |

建議 waveform 檢查訊號：`start`、`busy`、`done`、`index`、`acc`、`result`、`latency_cycles`、AXI `AW/W/B/AR/R` channel handshake。

## 8. Golden Model 設計

Golden model 有兩層：

1. Python：`golden/dot_product_golden.py`
   * 產生 test cases 的 expected result。
   * 顯示 A/B register packed words。
2. C software：`sw/baremetal/main.c`
   * PS 端直接算同一筆資料的 software result。
   * hardware run 時比對 PL result。

核心公式：

```c
int32_t acc = 0;
for (i = 0; i < 16; ++i) {
    acc += (int32_t)a[i] * (int32_t)b[i];
}
```

最大絕對值估算：`16 * 128 * 128 = 262144`，遠小於 INT32 範圍，所以本 project 不會發生 INT32 overflow。

## 9. PS 端 C 程式流程

PS bare-metal 程式位於 `sw/baremetal/main.c`。

```text
main()
├── 準備 int8_t a[16], b[16]
├── sw_result = dot_product_sw(a, b)
├── dotp_load_vectors(a, b)
├── dotp_run()
│   ├── clear_done
│   ├── start
│   ├── poll STATUS.done with timeout
│   ├── read RESULT
│   └── read LATENCY_CYCLES
└── print PASS/FAIL
```

硬體上若 timeout，先檢查：

* base address 是否和 Vivado address editor 一致。
* `FCLK_CLK0` 是否接到 `s_axi_aclk`。
* reset polarity 是否接成 active-low `s_axi_aresetn`。
* AXI GP0 是否 enabled。

## 10. Vivado Block Design 連接方式

完整步驟放在 `vivado/block_design.md`。摘要：

```text
ZYNQ7 Processing System
├── M_AXI_GP0  -> AXI Interconnect/SmartConnect -> axi_lite_dot_product/S_AXI
├── FCLK_CLK0  -> s_axi_aclk
└── FCLK_RESET0_N -> Processor System Reset -> peripheral_aresetn -> s_axi_aresetn
```

Address Editor：

* assign `axi_lite_dot_product` base address：建議 `0x43C0_0000`
* range：`64K`

不加入 AXI DMA、不加入 Linux driver、不加入 Vitis AI/DPU。

## 11. 驗收標準

| 類別 | Pass 條件 |
| --- | --- |
| RTL simulation | core testbench 全部 case PASS |
| AXI simulation | AXI wrapper testbench 可完成 write/start/poll/read |
| Golden model | Python/C expected result 與 RTL result 一致 |
| Vivado synthesis | 無 latch、無 critical warning、可 generate bitstream |
| Hardware run | PS terminal 印出 `PASS` |
| Register access | `VECTOR_LENGTH == 16`，`LATENCY_CYCLES == 16` |
| Correctness | 至少 5 組 input，PS software result 等於 PL result |
| Debug record | 若失敗，記錄 waveform 或 UART log |
| Resource record | 記錄 LUT/FF/DSP/BRAM 使用量 |

Project gate：simulation 與 hardware 都通過後，才建議進入 4x4 matrix multiplication。

## 12. 下一步如何升級成 4x4 Matrix Multiplication

4x4 matrix multiplication 可視為 16 次 dot product：

```text
C[row][col] = sum(A[row][k] * B[k][col]), k = 0..3
```

升級路線：

| 階段 | 做法 | 目的 |
| --- | --- | --- |
| 1 | 先把 vector length 參數改成 4 | 重用 dot product core |
| 2 | 加 matrix register map：A 16 bytes、B 16 bytes、C 16 int32 | 建立矩陣資料格式 |
| 3 | FSM 產生 row/col/k index | 從單一 dot product 擴展成 nested loops |
| 4 | 先用 1 個 MAC sequential 計算 64 cycles | 最容易驗證 |
| 5 | 再升級成 4 個 MAC parallel 算一個 dot product | 觀察 latency/resource tradeoff |
| 6 | 最後做 4x4 output buffer 與 PS 讀回 | 完成 matrix accelerator prototype |

下一版新增 module：

```text
axi_lite_matmul4x4
└── matmul4x4_core
    ├── matrix_a_buffer
    ├── matrix_b_buffer
    ├── output_c_buffer
    └── int8_mac / dot_product_lane
```

驗證要從單一 result 擴展成 16 個 `C[row][col]` 與 golden model 全矩陣比對。

## Quick Simulation

如果已安裝 Icarus Verilog：

```powershell
cd C:\Users\ronald\Program\FPGA\Project\Zynq_INT8_Dot_Product_Accelerator
powershell -ExecutionPolicy Bypass -File .\tb\run_iverilog.ps1
python .\golden\dot_product_golden.py
```

Vivado xsim 也可使用同一組 RTL/testbench 檔案。
