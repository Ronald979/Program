# Program Workspace

這個工作區分成四個主要區域。

| Folder | Purpose |
|---|---|
| `Learning_Material` | 我和 Codex 深度合作的學習、筆記、知識實踐、Q&A、debug、gate review |
| `CV` | 完成後的知識實踐整理成履歷敘述、個人 Project 摘要、Project PPT 素材 |
| `Learning_Roadmap` | 學習進度、階段任務、未攻克問題、完成狀態、PPT/CV 同步狀態、復盤 |
| `AI_Agent_Monitor` | AI Agent 專用監視架構，用來在任務開始與結束時同步整個工作區狀態 |

## Important Rule

`Tree/` 是 ERP 專案資料來源與過去經歷參考，不是目前要推送的主要工作區。

`Tree/` 已被 `.gitignore` 忽略，不應推上 GitHub。

## How Future Work Should Start

每次開始任務前，先看：

1. `AI_Agent_Monitor/WORKSPACE_STATE.md`
2. `AI_Agent_Monitor/PATH_REGISTRY.md`
3. `Learning_Roadmap/CURRENT_STATUS.md`
4. 和任務相關的 project tracker 或 CV 檔案

## How Future Work Should End

每次任務結束後，更新：

1. `AI_Agent_Monitor/WORKSPACE_STATE.md`
2. `AI_Agent_Monitor/TASK_SYNC_LOG.md`
3. `Learning_Roadmap/PROJECT_PROGRESS_TRACKER.md`
4. 如果和履歷有關，更新 `CV/PERSONAL_PROJECTS_INDEX.md`
5. 如果和簡報有關，更新 `CV/PROJECT_PRESENTATION_NOTES.md`

