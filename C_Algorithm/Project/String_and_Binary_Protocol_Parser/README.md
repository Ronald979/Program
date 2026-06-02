# Project 6：String and Binary Protocol Parser

## Scope

實作 text 或 binary protocol parser，支援 packet framing、length、checksum、endian、invalid packet handling 與 fragmented input。

## Expected Modules

```text
src/parser.c
src/packet.c
src/checksum.c
include/parser.h
include/packet.h
test/test_parser.c
```

## Validation

normal packet、fragmented packet、bad checksum、invalid length、empty input 全部通過；parser 不得 out-of-bounds。
