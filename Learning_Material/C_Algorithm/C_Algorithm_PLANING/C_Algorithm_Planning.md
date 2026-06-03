# C Algorithm Planning

本文件是 `C_Algorithm` 的總規劃，對應 FPGA 目錄中的 `FPGA_PLANING/FPGA_Planing`。目標是把原本分散在 `0_Prompt.txt` 到 `15_Final_Enhanse.txt` 的需求，整理成可執行、可驗證、可累積的 C 語言與演算法學習架構。

實作根目錄：

```text
C:\Users\ronald\Program\C_Algorithm
```

## 1. 目錄架構

```text
C_Algorithm
├── C_Algorithm_PLANING
│   ├── C_Algorithm_Planning.md
│   ├── Project_Roadmap.md
│   ├── extra.md
│   └── Project_1_C_Build_System_and_Makefile_Practice.md
└── Project
    ├── C_Build_System_and_Makefile_Practice
    ├── Pointer_and_Memory_Visualizer
    ├── Dynamic_Array_Library
    ├── Linked_List_Stack_Queue_Library
    ├── Ring_Buffer_for_UART_like_Data_Stream
    ├── String_and_Binary_Protocol_Parser
    ├── Sorting_and_Searching_Algorithm_Library
    ├── Large_Log_File_Parser
    ├── Dynamic_Programming_Practice_Set
    ├── TCP_Client_Server_with_Custom_Protocol
    ├── Embedded_style_State_Machine_Parser
    └── C_based_Communication_and_Data_Processing_Engine
```

每個 Project 固定使用以下實作結構：

```text
Project_Name
├── README.md
├── src
├── include
├── test
├── docs
├── build
├── tools
└── benchmark
```

| 路徑 | 用途 |
| --- | --- |
| `src/` | C source implementation |
| `include/` | public header 與 module API |
| `test/` | unit test、integration test、test data |
| `docs/` | Q&A Zone、Learning Notes Zone、Learning Log、Gate Review |
| `build/` | 編譯輸出，原則上不放入版本化成果 |
| `tools/` | 測試資料產生器、debug helper、script |
| `benchmark/` | performance case、量測資料與報告 |

## 2. 總目標

建立一套 project-based 的 C 語言、資料結構、演算法、記憶體管理、測試、debug、效能分析與系統程式訓練路線，最後完成：

```text
C-based Communication and Data Processing Engine
```

最終專案必須能處理 file 或 socket stream，透過 ring buffer 與 state machine parser 解析資料，驗證 checksum，儲存成資料結構，支援查詢、排序、統計、CSV/report 輸出，並通過 unit test、sanitizer、memory leak check 與 benchmark。

## 3. 學習階段

| Stage | 主題 | 實作重點 | 驗收方式 |
| --- | --- | --- | --- |
| 1 | C 語法與編譯流程 | gcc/clang、warning、Makefile、header/source separation | `make test` pass、無 warning |
| 2 | 記憶體模型與指標 | stack/heap、pointer arithmetic、malloc/free | sanitizer pass、能畫 memory diagram |
| 3 | struct/enum/typedef 與封裝 | struct layout、alignment、module API | header/source API 清楚、unit test pass |
| 4 | 字串、buffer、二進位處理 | `memcpy`、endian、checksum、overflow 防護 | invalid input 不 crash |
| 5 | 資料結構 | dynamic array、linked list、stack、queue、ring buffer | normal/boundary/repeated cases pass |
| 6 | 演算法基礎 | search、sort、recursion、Big-O | golden result 比對、複雜度說明 |
| 7 | 進階演算法 | greedy、DP、graph、bit manipulation | brute force vs optimized 比對 |
| 8 | 檔案與 stream 處理 | large file streaming、CSV/log parser | 大檔不一次載入記憶體 |
| 9 | 系統程式與通訊 | TCP client/server、select/poll、thread/mutex | protocol round-trip pass |
| 10 | 工程化與測試 | unit test、gdb、valgrind、sanitizer、benchmark | 測試與 debug 報告完整 |
| 11 | 嵌入式 C 思維 | bit mask、state machine、UART-like parser | parser 可處理 fragment input |
| 12 | 整合專案 | communication/data processing engine | final demo、report、portfolio description |

## 4. 技術主線

| 主線 | 必須建立的能力 | 對應 Project |
| --- | --- | --- |
| C Syntax and Compilation | gcc/clang、warning flags、Makefile、`.h/.c` 分離 | P1 |
| Memory Model | stack、heap、pointer、malloc/free、ownership | P2, P3, P4 |
| Data Representation | signed/unsigned、endian、struct layout、alignment | P2, P6, P11 |
| Modular C Design | API、opaque struct、error code、library reuse | P3, P4, P6, P12 |
| Data Structures | dynamic array、linked list、queue、ring buffer | P3, P4, P5, P12 |
| Algorithms | sort/search、DP、graph、bit operation | P7, P9, P12 |
| File and Stream Processing | CSV/log/binary、large file streaming | P6, P8, P12 |
| Debug and Verification | gdb、valgrind、sanitizer、unit test、assert | All |
| Performance Engineering | Big-O、benchmark、allocation cost、profiling | P7, P8, P9, P12 |
| Embedded C Thinking | bit mask、state machine、protocol parser | P5, P6, P11, P12 |

## 5. 學習閉環

每個 Project 都必須依照以下流程完成：

```text
Project 啟動
  -> 前置知識確認
  -> module/API 設計
  -> 實作 src/include
  -> 建立 unit test
  -> sanitizer/valgrind/gdb 驗證
  -> 更新 Q&A Zone
  -> 更新 Learning Notes Zone
  -> AI Review
  -> Project Gate Review
  -> 結案摘要寫入 README
```

不能只靠「看懂」放行。若無法說明 data flow、memory ownership、failure cases、test method、debug method，就視為未完成。

## 6. 12 週計畫

| Week | Topic | Practice | Deliverable | Validation |
| --- | --- | --- | --- | --- |
| 1 | Build system | P1 Makefile、warnings、test runner | P1 README + Makefile | compile/test pass |
| 2 | Pointer/memory | P2 pointer trace、stack/heap diagram | visualizer demo | ASan pass |
| 3 | Dynamic array | P3 reusable vector library | `cvec` API | unit/valgrind pass |
| 4 | Linked list/stack/queue | P4 container library | API + tests | boundary cases pass |
| 5 | Ring buffer | P5 UART-like stream buffer | ring buffer module | wrap/overflow cases pass |
| 6 | Protocol parser | P6 text or binary parser | parser + checksum | fragmented input pass |
| 7 | Sort/search | P7 algorithm library | sort/search benchmark | golden comparison |
| 8 | Large log parser | P8 streaming parser | report generator | large file test pass |
| 9 | Dynamic programming | P9 practice set | brute/optimized comparison | cases + complexity |
| 10 | Socket protocol | P10 TCP client/server | round-trip demo | integration test pass |
| 11 | Embedded state machine | P11 FSM parser | state diagram + tests | invalid sequence pass |
| 12 | Final integration | P12 engine | final demo/report | gate review pass |

## 7. 最終成果

最終輸出應包含：

| 成果 | 最低標準 |
| --- | --- |
| Demo flow | file/socket input -> parser -> data store -> query/stat/report |
| System architecture | module diagram 與 data flow |
| Code | 可編譯、可測試、module 分工清楚 |
| Test report | normal/boundary/invalid/large/repeated cases |
| Debug report | sanitizer、valgrind、gdb 或 failure analysis |
| Performance report | latency、throughput、memory usage、Big-O |
| README | build/run/test/debug/benchmark/demo |
| Portfolio description | 說明工程問題、架構決策、驗證方式與結果 |
