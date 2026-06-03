# Project Progress Tracker

Last updated: 2026-06-03

## Status Legend

| Status | Meaning |
|---|---|
| Not Started | 還沒有開始實作 |
| In Progress | 正在做，但未完成驗收 |
| Implemented | 有 code，但測試/筆記/gate review 還不完整 |
| Gate Passed | 完成驗收，可放入 CV 摘要 |
| CV Updated | 已加入 `CV/02_02_PERSONAL_PROJECTS_INDEX.md` |
| PPT Notes Done | 已完成 `CV/REF_00_REF_00_PROJECT_PRESENTATION_NOTES.md` 展開內容 |
| PPT Created | 已製作實際 PPT 檔 |

## Main Project Tracker

| Project | Learning Material | Status | CV Updated | PPT Notes Done | PPT Created | Current Blocker |
|---|---|---|---|---|---|---|
| C Build System and Memory Debug Foundation | `Learning_Material/C_Algorithm` | Not Started | Draft only | Draft only | No | 尚未完成實作與驗收 |
| C Data Structure Library | `Learning_Material/C_Algorithm` | Not Started | Draft only | Draft only | No | 需要先完成 C build/test 底盤 |
| UART-like Ring Buffer and State Machine Protocol Parser | `Learning_Material/C_Algorithm` | Not Started | Draft only | Draft only | No | 需要先完成 pointer、buffer、FSM |
| Streaming Log Parser in C | `Learning_Material/C_Algorithm` | Not Started | Draft only | Draft only | No | 需要先完成 file I/O 與 data structure |
| TCP Client/Server with Custom Protocol in C | `Learning_Material/C_Algorithm` | Not Started | Draft only | Draft only | No | 需要先完成 parser 與 Linux socket |
| Zynq INT8 Dot Product Accelerator | `Learning_Material/FPGA` | In Progress / Needs Gate Review | Draft only | Draft only | No | 需要確認 simulation/hardware/golden model 完成度 |
| C-based Communication and Data Processing Engine | `Learning_Material/C_Algorithm` | Not Started | Draft only | Draft only | No | 需要前面 project 作為組件 |

## Professional Experience Tracker

| Experience | Resume Location | Status | PPT / Case Study Notes | Current Blocker |
|---|---|---|---|---|
| ERP / Simray Internal System | `CV/01_01_MASTER_RESUME.md` Professional Experience | Recorded as resume material | Case study outline exists in `REF_00_PROJECT_PRESENTATION_NOTES.md` | 需要從原始 PDF 抽取個人資料與公司/職稱細節 |

## CV Readiness

| Resume Version | Status | Missing |
|---|---|---|
| Full-stack / ERP resume | Draft material ready | 需要把原始 PDF 的姓名、職稱、公司、日期整合進 Markdown |
| Firmware resume | Not ready | 需要至少完成 ring buffer/parser 或 C communication engine |
| C Linux resume | Not ready | 需要至少完成 TCP client/server 或 streaming parser |
| FPGA / SoC resume | Not ready | 需要完成 Zynq project gate review |

## PPT Readiness

| PPT | Status | Notes |
|---|---|---|
| ERP Professional Case Study | Outline only | ERP 是工作經歷，不是 personal project |
| C Build System PPT | Outline only | 完成 project 後再補實際截圖與結果 |
| C Data Structure Library PPT | Outline only | 需要 ownership table 與 test result |
| UART Ring Buffer Parser PPT | Outline only | 需要 FSM diagram、packet format、test cases |
| TCP Custom Protocol PPT | Outline only | 需要 network flow、partial read/write examples |
| Zynq INT8 Accelerator PPT | Outline only | 需要 RTL block diagram、register map、latency/resource |
| Final C Communication Engine PPT | Outline only | 需要完整 demo flow、benchmark、test evidence |

