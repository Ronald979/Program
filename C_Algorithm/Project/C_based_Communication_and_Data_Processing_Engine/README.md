# Project 12：C-based Communication and Data Processing Engine

## Scope

整合 file/socket input、ring buffer、state machine parser、checksum、data store、query/sort/statistics、CSV/report output、test、benchmark 與 memory check。

## Expected Modules

```text
src/source_file.c
src/source_socket.c
src/ringbuf.c
src/parser.c
src/store.c
src/query.c
src/report.c
include/*.h
test/test_engine.c
benchmark/bench_engine.c
```

## Validation

final demo 必須展示 input -> parse -> validate -> store -> query/stat -> report 的完整 data flow，且 sanitizer、valgrind、unit/integration test、benchmark report 都完成。
