# Project 1：C Build System and Makefile Practice

實作路徑：`C:\Users\ronald\Program\C_Algorithm\Project\C_Build_System_and_Makefile_Practice`

## 1. Project 目標

建立第一個可重複編譯、可測試、可 debug 的 C project。重點不是寫複雜演算法，而是建立工程閉環：

```text
source/header separation -> Makefile -> warning flags -> unit test -> sanitizer -> README
```

## 2. 本 Project 對 C 語言 / 演算法能力的意義

C 的工程能力不是只會寫單一 `main.c`。後續 dynamic array、parser、socket、final engine 都需要穩定的 build/test/debug workflow。本 Project 先建立最低限度的專案骨架，避免後面每個 Project 都被編譯方式、header include、warning、測試流程卡住。

## 3. Project Scope

| 項目 | 設計選擇 |
| --- | --- |
| Language | ISO C11 |
| Compiler | gcc 或 clang |
| Build | Makefile |
| Test | 自製最小 test runner |
| Debug | compiler warning、gdb、sanitizer |
| 不使用 | 複雜第三方測試框架、CMake、外部套件 |

## 4. 前置知識

| 類別 | 必須理解 |
| --- | --- |
| C syntax | function、header include、基本型別 |
| Compiler | compile、link、object file |
| Makefile | target、dependency、variable |
| Test | expected/actual、return code |
| Debug | warning、assert、最小重現案例 |

## 5. 系統架構

```text
command line
    |
    v
src/main.c
    |
    +--> src/math_ops.c
    |
    +--> src/string_tools.c

test/test_runner.c
    |
    +--> test_math_ops()
    |
    +--> test_string_tools()
```

## 6. Module 切分

```text
src/
  main.c
  math_ops.c
  string_tools.c

include/
  math_ops.h
  string_tools.h

test/
  test_runner.c

docs/
  qa_learning.md
  learning_notes.md
  learning_log.md
  gate_review.md

Makefile
README.md
```

| Module | 責任 |
| --- | --- |
| `main.c` | 展示 library API 使用方式，不放太多邏輯 |
| `math_ops.c/.h` | 基本整數運算與 checked API |
| `string_tools.c/.h` | 基本字串掃描，不配置 heap |
| `test_runner.c` | 執行 unit test，失敗時回傳非零 exit code |
| `Makefile` | 提供 `all/test/sanitize/clean` targets |

## 7. Data Flow

```text
developer command
    |
    v
Makefile target
    |
    +--> compile src/*.c into objects
    |
    +--> link app or test binary
    |
    +--> run unit tests
    |
    +--> report pass/fail
```

## 8. Function 設計

建議 API：

```c
int math_add_checked(int a, int b, int *out);
int math_sub_checked(int a, int b, int *out);
size_t cstr_count_char(const char *s, char target);
int cstr_is_ascii(const char *s);
```

設計要求：

| Function | 要求 |
| --- | --- |
| `math_add_checked` | `out == NULL` 時回傳 error，不 dereference |
| `math_sub_checked` | 檢查 signed integer overflow 風險 |
| `cstr_count_char` | `s == NULL` 時安全回傳或回報 error，規則需寫入 README |
| `cstr_is_ascii` | 明確處理 empty string |

## 9. Memory Ownership

本 Project 第一版不使用 heap allocation。

| 資料 | Owner | 說明 |
| --- | --- | --- |
| command line args | OS/runtime | `main` 只讀，不保存 pointer |
| string literal | program image | 不可修改 |
| output parameter | caller | caller 分配，callee 只寫入 |
| test data | test runner | test function 不取得 ownership |

若後續加入 heap，必須在 README 說明誰 `malloc`、誰 `free`。

## 10. Error Handling

建議使用 enum：

```c
typedef enum {
    CAPP_OK = 0,
    CAPP_ERR_NULL = -1,
    CAPP_ERR_OVERFLOW = -2,
    CAPP_ERR_INVALID_ARG = -3
} CappError;
```

規則：

| 情境 | 行為 |
| --- | --- |
| NULL pointer | 回傳 `CAPP_ERR_NULL` |
| invalid input | 回傳 `CAPP_ERR_INVALID_ARG` |
| overflow risk | 回傳 `CAPP_ERR_OVERFLOW` |
| test failure | test runner 回傳非零 exit code |

## 11. Makefile Targets

最低要求：

| Target | 用途 |
| --- | --- |
| `make all` | build app |
| `make test` | build and run unit test |
| `make sanitize` | 使用 AddressSanitizer/UBSan build and test |
| `make clean` | 清理 build output |

建議 flags：

```text
-std=c11 -Wall -Wextra -Wpedantic -Werror
```

Sanitizer flags：

```text
-fsanitize=address,undefined -fno-omit-frame-pointer
```

## 12. Test Case 設計

| Case | 測試內容 |
| --- | --- |
| normal | `1 + 2 = 3`、字串計數正常 |
| boundary | `INT_MAX`、`INT_MIN`、empty string |
| invalid input | NULL pointer |
| repeated operation | 多次呼叫 API 結果一致 |
| build failure | 故意加入 warning 時 `-Werror` 應阻止通過 |

## 13. Debug Checklist

1. `make clean` 後重新 `make all`。
2. 若 include 找不到，檢查 `-Iinclude`。
3. 若 link error，檢查 `.c` 是否加入 Makefile。
4. 若 test binary 沒更新，檢查 dependency rule。
5. 若 sanitizer fail，先建立最小重現 case。
6. 用 gdb 對 test binary 下 breakpoint，確認 expected/actual。

## 14. Performance Measurement

本 Project 不追求效能，但要建立量測習慣：

| 項目 | 方法 |
| --- | --- |
| build time | 可用 shell time 或手動記錄 |
| test count | test runner 印出 pass/fail count |
| binary size | optional：記錄 executable size |

## 15. Code Review Checklist

| 項目 | 檢查問題 |
| --- | --- |
| Header | 是否有 include guard？是否只放 public API？ |
| Source | 是否包含對應 header？ |
| Naming | function/module 命名是否清楚？ |
| Error | NULL/invalid/overflow 是否處理？ |
| Warning | 是否能用 `-Werror` 編譯？ |
| Test | 是否覆蓋 normal/boundary/invalid？ |
| README | build/test/debug 步驟是否可重現？ |

## 16. 驗收標準

| 類別 | Pass 條件 |
| --- | --- |
| Build | `make all` 成功 |
| Warning | `-Wall -Wextra -Wpedantic -Werror` 無 warning |
| Test | `make test` pass |
| Sanitizer | `make sanitize` pass |
| Structure | `src/include/test/docs` 結構完整 |
| Error handling | NULL pointer、overflow risk 有測 |
| README | 說明 build/run/test/debug |
| Notes | Learning Notes Zone 已更新 |
| Gate | Gate Review 有明確判定 |

## 17. 常見錯誤

| 錯誤 | 後果 | 修正 |
| --- | --- | --- |
| header 裡定義 non-static global variable | multiple definition link error | header 只宣告，source 定義 |
| `.c` 沒加入 Makefile | undefined reference | 更新 object list |
| function prototype 和實作不一致 | compile/link error 或 UB | source include 自己的 header |
| 忽略 compiler warning | 後續變 runtime bug | 使用 `-Werror` |
| test 只測 normal case | bug 藏在 boundary/invalid | 補 NULL、empty、limit case |

## 18. Project 問答區域 Q&A Zone

詳見：`docs/qa_learning.md`

## 19. Project 筆記區域 Learning Notes Zone

詳見：`docs/learning_notes.md`

## 20. Project Gate Review

進入 Project 2 前必須能說明：

1. compile 和 link 的差異。
2. `.h` 和 `.c` 的責任差異。
3. Makefile dependency 如何影響 rebuild。
4. 為什麼 warning 不能忽略。
5. test runner 如何判斷 pass/fail。
6. sanitizer 能抓到哪些問題，不能抓到哪些問題。

目前建議判定：可以開始 Project 1 實作；完成 gate 前不建議進入 pointer/memory visualizer。
