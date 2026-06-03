# Path Registry

Last updated: 2026-06-03

## Main Paths

| Path | Role | Can Edit | Push to Git | Notes |
|---|---|---|---|---|
| `Learning_Material` | 學習、筆記、實作、Q&A、debug、gate review | Yes | Yes | 未完成學習與 project 都先放這裡 |
| `CV` | 履歷、個人 project 摘要、Project PPT notes | Yes | Yes | ERP 寫成過去工作經歷，personal projects 只放摘要 |
| `Learning_Roadmap` | 進度、待辦、已完成、未攻克問題、復盤 | Yes | Yes | 每次任務開始與結束都應參照 |
| `AI_Agent_Monitor` | AI Agent 狀態同步、路徑監視、任務紀錄 | Yes | Yes | 每次任務開始/結束更新 |
| `Tree` | ERP 專案資料來源與過去經歷參考 | No, unless explicitly requested | No | 已被 `.gitignore` 忽略，不推送 |

## Learning Material Subpaths

| Path | Role | Update Trigger |
|---|---|---|
| `Learning_Material/AI_Learning` | 面試框架、學習方法、筆記模板 | 面試策略或學習方法調整 |
| `Learning_Material/C_Algorithm` | C、演算法、C Linux、韌體前置 project | C project 實作或筆記更新 |
| `Learning_Material/FPGA` | FPGA、Verilog、Zynq、AXI、accelerator | FPGA project 實作或筆記更新 |

## CV Subpaths

| Path | Role | Update Trigger |
|---|---|---|
| `CV/01_01_MASTER_RESUME.md` | 履歷主檔與履歷事實來源 | 工作經歷、離職日期、履歷主策略變更 |
| `CV/02_02_PERSONAL_PROJECTS_INDEX.md` | 個人 project 履歷摘要 | project 完成或關鍵技術變更 |
| `CV/REF_00_REF_00_PROJECT_PRESENTATION_NOTES.md` | Project PPT Markdown 素材 | project 完成、簡報架構新增、面試講稿更新 |
| `CV/REF_01_Ronald_Tan_CV.pdf` | 原始 PDF 履歷快照 | 不直接修改 |

## Learning Roadmap Subpaths

| Path | Role | Update Trigger |
|---|---|---|
| `Learning_Roadmap/01_01_CURRENT_STATUS.md` | 目前整體狀態 | 每次重大任務結束 |
| `Learning_Roadmap/02_02_PROJECT_PROGRESS_TRACKER.md` | project 進度、CV/PPT 狀態 | project 狀態有變 |
| `Learning_Roadmap/03_03_ROADMAP_60_DAYS.md` | 60 天學習路線 | 學習策略或順序改變 |
| `Learning_Roadmap/04_04_LEARNING_RETROSPECTIVE.md` | 階段復盤 | 每個 phase 結束 |

## AI Agent Monitor Subpaths

| Path | Role | Update Trigger |
|---|---|---|
| `AI_Agent_Monitor/01_01_WORKSPACE_STATE.md` | 最新狀態快照 | 每次任務開始/結束需要同步 |
| `AI_Agent_Monitor/REF_00_REF_00_PATH_REGISTRY.md` | 路徑角色與規則 | 新增、移動、刪除主要路徑 |
| `AI_Agent_Monitor/02_02_AGENT_TASK_PROTOCOL.md` | 任務同步流程 | 工作流程規則改變 |
| `AI_Agent_Monitor/REF_01_REF_01_TASK_SYNC_LOG.md` | 任務同步紀錄 | 每次整理或狀態更新 |

