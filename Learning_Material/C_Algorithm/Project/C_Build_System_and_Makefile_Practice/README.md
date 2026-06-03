# Project 1：C Build System and Makefile Practice

詳細規格：`../../C_Algorithm_PLANING/Project_1_C_Build_System_and_Makefile_Practice.md`

## Scope

建立第一個標準 C project 骨架：`src/`、`include/`、`test/`、`docs/`、`Makefile`、unit test、sanitizer target。

## Expected Files

```text
src/main.c
src/math_ops.c
src/string_tools.c
include/math_ops.h
include/string_tools.h
test/test_runner.c
Makefile
```

## Validation

最低驗收：`make all`、`make test`、`make sanitize` 全部通過，且無 compiler warning。
