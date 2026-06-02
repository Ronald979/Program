# Project 5：Ring Buffer for UART-like Data Stream

## Scope

實作 fixed-size circular buffer，模擬 UART-like byte stream。重點是 wraparound、overflow policy、producer/consumer、partial read/write。

## Expected Modules

```text
src/ringbuf.c
src/stream_sim.c
include/ringbuf.h
test/test_ringbuf.c
```

## Validation

buffer full/empty/wraparound/fragment input cases pass，且能說明 head/tail/count 的不變式。
