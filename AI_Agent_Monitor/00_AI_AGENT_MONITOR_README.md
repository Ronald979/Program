# AI Agent Monitor

這個資料夾是 AI Agent 專用的監視架構。

目的不是存放學習內容，而是讓 AI Agent 能在每次任務開始與結束時，知道：

- 現在整個工作區有哪些主要路徑。
- 每個路徑負責什麼。
- 哪些內容已完成。
- 哪些內容還沒完成。
- 哪些 project 已經更新到 CV。
- 哪些 project 已經有 PPT notes。
- 哪些資料不能推送，例如 `Tree/`。

## Core Files

| File | Purpose |
|---|---|
| `01_WORKSPACE_STATE.md` | 整個工作區目前狀態快照 |
| `02_AGENT_TASK_PROTOCOL.md` | AI Agent 任務開始與結束時要做的同步流程 |
| `REF_00_PATH_REGISTRY.md` | 每個主要路徑的用途、更新規則、注意事項 |
| `REF_01_TASK_SYNC_LOG.md` | 每次整理、移動、更新後的紀錄 |

## Agent Rule

AI Agent 每次接到任務時，應該先判斷任務屬於哪一區：

| Task Type | Main Folder |
|---|---|
| 學習、筆記、實作、debug | `Learning_Material` |
| 履歷、個人 project 摘要、PPT 素材 | `CV` |
| 進度、下一步、復盤、未攻克問題 | `Learning_Roadmap` |
| 狀態同步、路徑監視、任務紀錄 | `AI_Agent_Monitor` |

## Start and End Sync

任務開始時：

- 讀取目前 workspace state。
- 確認要操作的資料夾。
- 避免修改錯誤區域。
- 確認 `Tree/` 不被推送。

任務結束時：

- 更新狀態快照。
- 更新任務同步紀錄。
- 若 project 狀態有變，更新 roadmap tracker。
- 若 project 已完成，更新 CV project index。
- 若 project 可做簡報，更新 presentation notes。
