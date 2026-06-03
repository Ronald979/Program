# Project 8：Large Log File Parser

## Scope

實作 streaming log parser，不一次載入整個檔案，能處理 malformed line、統計欄位、輸出 report。

## Expected Modules

```text
src/log_reader.c
src/record.c
src/report.c
include/log_reader.h
include/record.h
include/report.h
test/test_log_parser.c
```

## Validation

large file、empty file、malformed line、long line cases pass；記錄 throughput 與 peak memory usage。
