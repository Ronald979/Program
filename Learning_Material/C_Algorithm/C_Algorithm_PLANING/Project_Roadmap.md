# C Algorithm Project Roadmap

本文件對應 FPGA planning 中的 project roadmap。每個 Project 都是獨立可驗證的工程單元，不是單純練習題。

| Project | Goal | C Concept | Algorithm Concept | Modules | Test Method | Debug Tool | Completion Criteria |
| --- | --- | --- | --- | --- | --- | --- | --- |
| P1 C Build System and Makefile Practice | 建立可重複編譯、測試、清理的 C project | compiler flags、header/source、Makefile | 無，重點在工程流程 | `main`, `math_ops`, `string_tools`, `test_runner` | build/test targets | compiler warning、gdb | 無 warning、unit test pass、README 完整 |
| P2 Pointer and Memory Visualizer | 用程式與圖表理解 stack/heap/pointer | pointer、array、malloc/free | memory tracing | `memory_trace`, `pointer_demo`, `diagram_export` | sanitizer + manual diagram | ASan、gdb | 能說明 ownership、無 leak |
| P3 Dynamic Array Library | 實作可重用 dynamic array | struct、capacity、realloc、ownership | amortized complexity | `cvec`, `allocator`, `test_cvec` | unit + repeated operation | valgrind、ASan | push/pop/get/set 全部通過 |
| P4 Linked List / Stack / Queue Library | 實作基本 container library | pointer-to-pointer、node ownership | list/stack/queue operations | `list`, `stack`, `queue` | boundary + invalid input | gdb、valgrind | empty/single/multi node case pass |
| P5 Ring Buffer for UART-like Data Stream | 處理 fixed-size stream buffer | circular index、overflow policy | producer-consumer buffer | `ringbuf`, `stream_sim` | wraparound + overflow | log、ASan | fragment read/write 正確 |
| P6 String and Binary Protocol Parser | 解析 text 或 binary packet | buffer、endian、checksum、FSM | parsing/state machine | `parser`, `packet`, `checksum` | fragmented input + invalid packet | gdb、log | checksum/error handling 正確 |
| P7 Sorting and Searching Algorithm Library | 建立演算法 library 與 benchmark | function pointer、array API | sort/search/complexity | `sort`, `search`, `benchmark` | golden compare | profiler、assert | result correct、complexity 可說明 |
| P8 Large Log File Parser | streaming 處理大檔案 | file I/O、line buffer、error handling | aggregation/statistics | `log_reader`, `record`, `report` | large file + malformed lines | gdb、perf counter | 不一次載入整檔 |
| P9 Dynamic Programming Practice Set | 建立 DP 問題分析與實作模板 | array allocation、table ownership | brute force、memo、tabulation | `dp_cases`, `golden`, `bench` | brute vs optimized | ASan、benchmark | 能說明 state/transition |
| P10 TCP Client / Server with Custom Protocol | socket 通訊與 protocol round-trip | socket、select/poll、partial read | stream framing | `server`, `client`, `protocol` | integration test | log、Wireshark optional | client/server round-trip pass |
| P11 Embedded-style State Machine Parser | 模擬嵌入式 parser 與狀態機 | enum state、bit mask、static buffer | FSM robustness | `fsm_parser`, `uart_sim` | invalid sequence + fragment | waveform-like log | state transition 可追蹤 |
| P12 C-based Communication and Data Processing Engine | 整合接收、解析、儲存、查詢、輸出 | modular design、memory ownership、testing | data processing pipeline | `source`, `ringbuf`, `parser`, `store`, `query`, `report` | system test + benchmark | sanitizer、valgrind、gdb | final demo/report pass |

## Dependency Chain

```text
P1 -> P2 -> P3 -> P4 -> P5 -> P6
                         ├── P7 -> P9
                         ├── P8
                         └── P10 -> P11 -> P12
```

## Skill Dependency Table

| Skill | Required Before | Used In | Practice | Common Failure | Validation |
| --- | --- | --- | --- | --- | --- |
| Pointer | malloc/free、linked list、parser | P2-P6、P11-P12 | pointer trace、memory diagram | dangling pointer、wrong arithmetic | gdb + ASan |
| Memory Ownership | dynamic container、parser buffer | P3-P6、P12 | owner/free policy table | leak、double free | valgrind |
| Header/API Design | reusable library | P1-P7、P12 | `.h` 只暴露必要 API | circular include、global state | code review |
| Error Handling | parser、file/socket | P3-P12 | enum error + return code | ignored error、ambiguous status | invalid input test |
| Buffer Boundary | string/binary stream | P5-P6、P8、P11-P12 | boundary test | overflow、off-by-one | ASan + tests |
| Complexity Analysis | algorithm library | P7-P9、P12 | brute vs optimized | 只背 Big-O | benchmark + explanation |
| State Machine | protocol parser | P6、P11-P12 | transition table | hidden states、bad reset | invalid sequence test |
| Performance Measurement | parser/algorithm/final | P7-P12 | benchmark harness | benchmark 不穩定 | repeated measurement |

## Gate Policy

每個 Project 結束時只能有三種判定：

1. 可以進入下一個 Project。
2. 可以進入下一個 Project，但需要補強指定項目。
3. 不建議進入下一個 Project，必須先修正指定問題。

放行條件至少包含：

| 類別 | 條件 |
| --- | --- |
| Build | compile success、無 compiler warning |
| Test | normal、boundary、invalid、empty、large/repeated cases pass |
| Memory | sanitizer pass、valgrind pass 或可接受的替代 memory check |
| Debug | 知道如何重現 failure，並有 debug note |
| Notes | Learning Notes Zone 已更新且通過 AI review |
| Explanation | 能說明 data flow、memory ownership、failure cases、complexity |
