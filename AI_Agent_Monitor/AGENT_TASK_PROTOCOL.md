# Agent Task Protocol

Last updated: 2026-06-03

這份文件定義 AI Agent 在每次任務開始與結束時應該如何同步狀態。

## 1. Task Start Protocol

任務開始時，AI Agent 應先判斷任務類型。

| User Intent | Primary Folder | Secondary Folder |
|---|---|---|
| 學習內容、筆記、project 實作 | `Learning_Material` | `Learning_Roadmap` |
| 履歷、CV、Project 摘要 | `CV` | `Learning_Roadmap` |
| 進度、roadmap、復盤、下一步 | `Learning_Roadmap` | `AI_Agent_Monitor` |
| 路徑整理、狀態同步、監視架構 | `AI_Agent_Monitor` | `Learning_Roadmap` |

Start checklist:

| Step | Action |
|---|---|
| 1 | Read or infer from `WORKSPACE_STATE.md` what the current global state is |
| 2 | Check `PATH_REGISTRY.md` to avoid editing the wrong folder |
| 3 | Check whether the task affects CV, Roadmap, Learning Material, or Agent Monitor |
| 4 | If project status changes, prepare to update `PROJECT_PROGRESS_TRACKER.md` |
| 5 | If resume wording changes, prepare to update `CV/PERSONAL_PROJECTS_INDEX.md` or `CV/MASTER_RESUME.md` |
| 6 | If PPT/project presentation content changes, prepare to update `CV/PROJECT_PRESENTATION_NOTES.md` |

## 2. Task End Protocol

任務結束時，AI Agent 應更新狀態，不要只完成檔案修改。

End checklist:

| Step | Action |
|---|---|
| 1 | Summarize what changed |
| 2 | Update `WORKSPACE_STATE.md` if folder structure, project status, or resume status changed |
| 3 | Add an entry to `TASK_SYNC_LOG.md` |
| 4 | Update `Learning_Roadmap/CURRENT_STATUS.md` if current status changed |
| 5 | Update `Learning_Roadmap/PROJECT_PROGRESS_TRACKER.md` if project status changed |
| 6 | Update `CV/PERSONAL_PROJECTS_INDEX.md` if a project became resume-ready |
| 7 | Update `CV/PROJECT_PRESENTATION_NOTES.md` if project presentation notes changed |
| 8 | Confirm `Tree/` remains ignored unless user explicitly requests otherwise |

## 3. Project Status Update Rule

Project status should move in this order:

```text
Not Started -> In Progress -> Implemented -> Gate Passed -> CV Updated -> PPT Notes Done -> PPT Created
```

Do not mark a project as `Gate Passed` unless it has:

| Requirement | Meaning |
|---|---|
| Code or implementation | 有實作證據 |
| README or notes | 能解釋架構與使用方式 |
| Validation | 有測試、debug、benchmark 或 golden model |
| Failure cases | 能說明至少 3 個可能失敗點 |
| Interview story | 能用 2 分鐘說明問題、方案、驗證、結果 |

## 4. CV Update Rule

ERP / Simray:

- Always treat as professional experience.
- Do not move it into personal projects.

Personal projects:

- Resume only contains project name, one-line purpose, and key technologies.
- Details go to project PPT notes.

## 5. PPT Update Rule

When a project becomes resume-ready, create or update the Markdown presentation section first.

Actual PPT files can be created later.

The minimum PPT notes should include:

| Section | Required |
|---|---|
| Problem | What engineering problem is solved |
| Architecture | Modules, data flow, control flow |
| Implementation | APIs, data structures, FSM, register map, or algorithms |
| Validation | Tests, golden model, benchmark, sanitizer, or waveform |
| Failure cases | At least 3 risks or bugs |
| Result | What can be shown in interview |

## 6. Tree Folder Rule

`Tree/` is an ignored reference folder.

Rules:

- Do not push `Tree/`.
- Do not move `Tree/` into CV.
- Do not treat ERP/Simray as a personal project.
- Use `Tree/ERP_SYSTEM_FILETREE.txt.txt` only as evidence for past professional experience unless user says otherwise.

