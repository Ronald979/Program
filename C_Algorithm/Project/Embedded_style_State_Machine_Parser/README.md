# Project 11：Embedded-style State Machine Parser

## Scope

用 embedded C 思維實作 state machine parser，模擬 UART/SPI-like fragmented data。重點是 enum state、bit mask、static buffer、reset/error transition。

## Expected Modules

```text
src/fsm_parser.c
src/uart_sim.c
include/fsm_parser.h
test/test_fsm_parser.c
```

## Validation

valid sequence、invalid sequence、fragmented data、timeout/reset cases pass；能畫出 state transition table。
