# Current Learning Status

Last updated: 2026-06-03

## 目前總狀態

目前已完成的是「學習系統與履歷系統的整理」，還不是低階 C / FPGA project 的完成。

已完成：

- 建立 `CV` 作為履歷主工作區。
- 保留原始 PDF 履歷作為歷史快照。
- 建立 `CV/01_01_MASTER_RESUME.md` 作為新履歷主檔。
- 將 ERP / Simray 系統定位為過去工作經歷，不作為個人 project。
- 建立個人 project 履歷索引。
- 建立 project PPT 的 Markdown 展開大綱。
- 將學習素材移到 `Learning_Material`。
- 建立 `Learning_Roadmap` 作為未來進度入口。
- 建立 `AI_Agent_Monitor` 作為 AI Agent 任務開始/結束時的監視與同步架構。

尚未完成：

- C Build System project 尚未完成驗收。
- C Data Structure Library 尚未完成驗收。
- UART-like Ring Buffer / Protocol Parser 尚未完成驗收。
- TCP Client/Server 尚未完成驗收。
- Zynq INT8 Dot Product Accelerator 尚未完成完整 gate review。
- C-based Communication and Data Processing Engine 尚未完成。
- 個人 project 尚未真正轉成 PPT 檔，目前只有 Markdown 展開大綱。

AI Agent monitor 狀態：

- 已建立路徑登記表。
- 已建立任務開始/結束同步流程。
- 已建立 workspace state 快照。
- 已建立 task sync log。

## 目前最重要的方向

目前主線是：

```text
C foundation -> C memory/data structure -> firmware parser -> C Linux socket -> FPGA/Zynq -> final communication engine -> CV/PPT
```

不要同時全面展開。

第一個應該完成的 project 是：

```text
C Build System and Memory Debug Foundation
```

## 目前還沒被攻克的問題

| Area | Unresolved Problem | Why It Matters | Next Action |
|---|---|---|---|
| C engineering | 還沒有完成可重現的 C build/test/debug project | 後面所有 C project 都會依賴這個工程底盤 | 完成 Makefile、unit test、ASan/UBSan |
| Memory ownership | 還沒有用 project 證明 malloc/free ownership | 韌體、C Linux、parser 都會卡在 pointer/memory | 完成 dynamic array 與 ownership table |
| Firmware stream | 還沒有完成 ring buffer + FSM parser | 韌體面試常問 buffer、UART、state machine | 完成 UART-like parser project |
| Linux socket | 還沒有完成 TCP custom protocol | C Linux 面試需要 system programming 證據 | 完成 TCP client/server |
| FPGA/SoC | Zynq INT8 accelerator 還需要明確完成狀態 | FPGA 履歷需要 RTL、testbench、golden model、AXI 敘述 | 完成 gate review 與 PPT notes |
| CV/PPT | Project 尚未有實際 PPT | 履歷只放摘要，面試要靠 PPT 展開 | 每完成一個 project 就補 `REF_00_PROJECT_PRESENTATION_NOTES.md` |

## 下次開始時的任務

建議下次直接做：

1. 開始 `C Build System and Memory Debug Foundation`。
2. 建立 project README、Makefile、src/include/test 結構。
3. 寫最小 C function 與 test runner。
4. 加上 warning flags 與 sanitizer target。
5. 完成後更新 `02_PROJECT_PROGRESS_TRACKER.md`。
