# C Algorithm Extra Requirements

本文件對應 FPGA planning 中的 `extra`。用途是固定每個 Project 的 Q&A、Learning Notes、Learning Log、AI Review 與 Gate Review 格式。

## A. Q&A Zone

每個 Project 必須在 `docs/qa_learning.md` 維護問答紀錄。回答不能只保留聊天紀錄，必須整理成可複習的工程知識。

```markdown
## Project X：Q&A Zone

### Q1. 問題標題

**問題分類：**
C Syntax / Pointer / Memory Management / Struct / Enum / File I/O / Algorithm / Data Structure / Complexity / Debug / Test / Build System / Makefile / GDB / Valgrind / Sanitizer / Socket / Thread / Embedded C / Architecture Decision

**我的問題：**
記錄原始問題。

**AI 解答摘要：**
整理成工程結論，不只複製聊天內容。

**關鍵觀念：**
- 涉及哪些概念？
- 為什麼重要？
- 不理解會卡在哪裡？

**對實作的影響：**
- 影響哪些 `.c/.h`？
- 影響哪個 function？
- 是否影響 memory ownership？
- 是否影響 error handling？
- 是否影響 test case？
- 是否影響 performance？

**需要驗證的項目：**
- unit test
- sanitizer
- valgrind
- gdb
- benchmark

**目前理解狀態：**
未理解 / 部分理解 / 已理解但未實作 / 已實作但未測試 / 已測試 / 已整理成筆記 / 已關閉
```

## B. Learning Notes Zone

每個 Project 必須在 `docs/learning_notes.md` 維護筆記。若筆記只有名詞，沒有 data flow、memory ownership、failure case、test method，視為理解不足。

```markdown
## Project X：Learning Notes Zone

### 我的理解筆記

1. 這個 Project 的核心目標是什麼？
2. 解決的是 C 語言或演算法中的哪個問題？
3. 主要 data flow 是什麼？
4. 主要 module 有哪些？
5. 每個 module 的責任是什麼？
6. 每個主要 function 的 input/output 是什麼？
7. 哪些資料在 stack？
8. 哪些資料在 heap？
9. 哪些資料是 global/static？
10. pointer 在本 Project 中如何使用？
11. memory ownership 怎麼分配？
12. 誰負責 malloc？
13. 誰負責 free？
14. 是否可能 memory leak？
15. 是否可能 dangling pointer？
16. 是否可能 buffer overflow？
17. 是否可能 off-by-one error？
18. error handling 怎麼設計？
19. test case 覆蓋哪些情境？
20. 哪些 case 還沒測？
21. time complexity 是多少？
22. space complexity 是多少？
23. performance bottleneck 可能在哪裡？
24. 遇到什麼 bug？
25. 怎麼 debug？
26. 下一次會怎麼改？
27. 如何銜接下一個 Project？
```

## C. AI Review Checklist

```markdown
## 筆記審核結果

### 理解正確的地方

### 理解錯誤的地方

- 錯誤點：
- 為什麼錯：
- 正確觀念：
- 如何驗證：

### 理解模糊的地方

- 模糊點：
- 缺少的細節：
- 建議補充：

### 遺漏的關鍵點

### 需要重寫的筆記段落

重寫時必須補上：
- data flow
- function responsibility
- memory ownership
- error handling
- test case
- failure case
- debug method
- complexity
```

## D. Learning Log

每個 Project 必須在 `docs/learning_log.md` 維護表格：

| Date | Project | Topic | Question / Note | AI Feedback | Status |
| --- | --- | --- | --- | --- | --- |

Status 可使用：

```text
Open
Answered
Need Review
Need Re-test
Verified
Misunderstood
Rewritten
Closed
```

## E. Project Gate Review

每個 Project 結束前必須在 `docs/gate_review.md` 執行 gate review。

| 項目 | Pass 條件 |
| --- | --- |
| Build | code 可成功編譯 |
| Warning | 無 compiler warning |
| Unit Test | unit test pass |
| Sanitizer | AddressSanitizer/UBSan pass |
| Valgrind | 無 leak、invalid read/write、double free |
| Normal Case | 正常輸入通過 |
| Boundary Case | 邊界條件通過 |
| Invalid Input | 不 crash，error handling 明確 |
| Ownership | malloc/free 責任清楚 |
| Undefined Behavior | 無明顯 UB |
| Explanation | 能說明 data flow、function responsibility、time/space complexity |
| Failure Cases | 能指出至少 3 個 failure cases |
| Notes | Learning Notes 已更新 |
| AI Review | AI 已審核筆記 |

判定結果只能是：

1. 可以進入下一個 Project。
2. 可以進入下一個 Project，但需要補強指定項目。
3. 不建議進入下一個 Project，必須先修正指定問題。

## F. C Engineering Rules

| 規則 | 原因 | 違反後果 |
| --- | --- | --- |
| public API 放在 `include/`，實作放在 `src/` | 分離 interface 和 implementation | module 互相依賴混亂 |
| 每個 function 明確定義 ownership | C 沒有自動記憶體管理 | leak、double free、dangling pointer |
| 所有 pointer input 先檢查 NULL | C 不會自動保護 | segmentation fault |
| 所有 buffer function 必須帶 length | 避免只靠 `\0` 或假設長度 | overflow、out-of-bounds |
| signed/unsigned conversion 必須明確 | C promotion 規則容易出錯 | underflow、比較結果錯誤 |
| error code 使用 enum 或明確 return convention | 呼叫端可判斷失敗原因 | error 被忽略或誤判 |
| `malloc` 後必須檢查結果 | allocation 可能失敗 | NULL dereference |
| 不在 library function 直接 `exit` | 呼叫端應控制流程 | module 不可重用 |
| test 必須覆蓋 invalid input | 真實資料不保證正確 | parser 或 data structure 崩潰 |
| README 必須包含 build/run/test/debug | 保證成果可重現 | 專案不可驗證 |
