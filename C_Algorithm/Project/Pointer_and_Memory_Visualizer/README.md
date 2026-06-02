# Project 2：Pointer and Memory Visualizer

## Scope

用 C 程式與手寫 memory diagram 理解 stack、heap、global/static、array vs pointer、malloc/free、dangling pointer 與 segmentation fault。

## Expected Modules

```text
src/memory_trace.c
src/pointer_demo.c
src/main.c
include/memory_trace.h
test/test_memory_trace.c
```

## Validation

AddressSanitizer pass，能用自己的話說明每個 pointer 指向哪裡、誰擁有 heap memory、誰負責 free。
