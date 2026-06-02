# Vivado Block Design 連接方式

## 目標

把 `rtl/axi_lite_dot_product.v` 包成 AXI-Lite slave peripheral，接到 Zynq PS 的 `M_AXI_GP0`。本 project 不使用 DMA、不使用 Linux driver、不使用 Vitis AI/DPU。

## 建議流程

1. 建立 Vivado RTL project，選擇你的 Zynq-7000 / Zynq-7015 board 或 part。
2. 加入 RTL：
   * `rtl/int8_mac.v`
   * `rtl/int8_dot_product_core.v`
   * `rtl/axi_lite_dot_product.v`
3. 使用 IP Packager：
   * `Tools -> Create and Package New IP`
   * 選 `Package your current project` 或以這三個 RTL 建立新 IP。
   * 確認 `axi_lite_dot_product` 被辨識為 AXI4-Lite slave interface。
4. 建立 Block Design。
5. 加入 `ZYNQ7 Processing System`。
6. Run Block Automation：
   * enable `M_AXI_GP0`
   * enable `FCLK_CLK0`，建議 100 MHz。
7. 加入包好的 `axi_lite_dot_product` IP。
8. Run Connection Automation，或手動連接：

```text
processing_system7_0/M_AXI_GP0
  -> axi_interconnect_0/S00_AXI
  -> axi_interconnect_0/M00_AXI
  -> axi_lite_dot_product_0/S_AXI

processing_system7_0/FCLK_CLK0
  -> axi_interconnect_0/ACLK
  -> axi_interconnect_0/S00_ACLK
  -> axi_interconnect_0/M00_ACLK
  -> axi_lite_dot_product_0/s_axi_aclk

processing_system7_0/FCLK_RESET0_N
  -> proc_sys_reset_0/ext_reset_in
proc_sys_reset_0/peripheral_aresetn
  -> axi_interconnect_0/ARESETN
  -> axi_interconnect_0/S00_ARESETN
  -> axi_interconnect_0/M00_ARESETN
  -> axi_lite_dot_product_0/s_axi_aresetn
```

9. Address Editor：
   * base address：建議 `0x43C0_0000`
   * range：`64K`
10. Validate Design。
11. Generate HDL Wrapper。
12. Run Synthesis / Implementation / Generate Bitstream。
13. Export Hardware / XSA。
14. 在 Vitis 建立 bare-metal application，加入 `sw/baremetal/main.c`。

## Hardware Bring-up Checklist

| 檢查項目 | 正常現象 |
| --- | --- |
| AXI GP0 enabled | PS 可讀 `VECTOR_LENGTH = 16` |
| Base address 一致 | 不會 timeout 或讀到全 `0xFFFFFFFF` |
| Clock connected | `busy/done` 可變化 |
| Reset polarity 正確 | reset 後 STATUS busy=0 done=0 |
| UART printf | terminal 印出 SW/PL result |
| Latency register | `LATENCY_CYCLES = 16` |

## 常見錯誤

| 錯誤 | 現象 | 修正 |
| --- | --- | --- |
| base address 和 C macro 不一致 | 讀不到 register 或 timeout | 對照 Address Editor 與 `DOTP_BASEADDR` |
| reset 接反 | STATUS 卡住或 result 不變 | 使用 active-low `s_axi_aresetn` |
| 沒有接 FCLK | AXI transaction hang | `FCLK_CLK0` 接所有 AXI clock |
| IP 沒重新 package | RTL 修改沒有進 bitstream | re-package IP 並 upgrade BD |
| 忘記 clear done | 第二次測試誤判 done | start 前寫 CONTROL bit1 |
