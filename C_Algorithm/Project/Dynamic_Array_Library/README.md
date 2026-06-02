# Project 3：Dynamic Array Library

## Scope

實作可重用 dynamic array library，建立 capacity、size、realloc、push/pop/get/set、ownership 與 amortized complexity 的概念。

## Expected Modules

```text
src/cvec.c
include/cvec.h
test/test_cvec.c
benchmark/bench_cvec.c
```

## Validation

normal、boundary、invalid、repeated operation cases pass；sanitizer 與 valgrind 不得有 leak 或 invalid access。
