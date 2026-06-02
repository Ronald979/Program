# Project 10：TCP Client / Server with Custom Protocol

## Scope

建立 TCP client/server，使用自訂 protocol，處理 partial read/write、framing、timeout 與 server/client round-trip。

## Expected Modules

```text
src/server.c
src/client.c
src/protocol.c
include/protocol.h
test/test_protocol.c
```

## Validation

protocol unit test pass；client/server integration round-trip pass；能說明 socket stream 和 packet boundary 的差異。
