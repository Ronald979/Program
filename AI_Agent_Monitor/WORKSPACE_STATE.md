# Workspace State

Last updated: 2026-06-03

## Global Structure

The workspace is organized into four active main folders:

| Folder | Current State |
|---|---|
| `Learning_Material` | Created and populated with `AI_Learning`, `C_Algorithm`, and `FPGA` |
| `CV` | Active resume workspace with master resume, personal project index, and project presentation notes |
| `Learning_Roadmap` | Active progress tracker with current status, 60-day roadmap, project tracker, and retrospective |
| `AI_Agent_Monitor` | Active monitoring architecture for AI Agent task start/end synchronization |

Ignored reference folder:

| Folder | Current State |
|---|---|
| `Tree` | ERP project evidence folder, ignored by `.gitignore`, should not be pushed |

## Current Resume Facts

| Fact | Value |
|---|---|
| Employment end date / resignation date | May 2026 |
| ERP / Simray positioning | Past professional experience |
| Personal projects positioning | Resume short entries only |
| Project details positioning | Separate PPT, currently recorded as Markdown notes |

## Current Learning Status

| Area | Status |
|---|---|
| Workspace organization | Completed |
| CV master structure | Completed |
| Learning roadmap structure | Completed |
| AI Agent monitor structure | Created |
| C Build System project | Not Started |
| C Data Structure Library | Not Started |
| UART-like Ring Buffer Parser | Not Started |
| Streaming Log Parser | Not Started |
| TCP Client/Server | Not Started |
| Zynq INT8 Dot Product Accelerator | In Progress / Needs Gate Review |
| Final C Communication Engine | Not Started |

## Current Priority

Next recommended project:

```text
C Build System and Memory Debug Foundation
```

Reason:

This project creates the C engineering workflow required by all later C, firmware, and C Linux projects.

## Current Risks

| Risk | Impact | Mitigation |
|---|---|---|
| Project folders become scattered | AI Agent may lose current state | Keep this monitor updated at task start/end |
| Resume and learning notes get mixed | CV becomes too long or unfocused | Keep personal project details in PPT notes, not resume |
| ERP gets treated as personal project | Professional experience becomes confusing | Keep ERP under Professional Experience |
| Tree accidentally pushed | Private/large reference data may leak | Keep `Tree/` in `.gitignore` |
| Projects marked complete too early | Resume claims become weak in interview | Require gate review before CV-ready status |

## Files That Should Be Updated Often

| File | When to Update |
|---|---|
| `AI_Agent_Monitor/WORKSPACE_STATE.md` | At start/end of major task |
| `AI_Agent_Monitor/TASK_SYNC_LOG.md` | After any structural or status change |
| `Learning_Roadmap/CURRENT_STATUS.md` | When learning state changes |
| `Learning_Roadmap/PROJECT_PROGRESS_TRACKER.md` | When project status changes |
| `CV/PERSONAL_PROJECTS_INDEX.md` | When project becomes CV-ready |
| `CV/PROJECT_PRESENTATION_NOTES.md` | When project presentation notes change |

