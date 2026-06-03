# 60-Day Learning Roadmap

Last updated: 2026-06-03

## Goal

60 天後的目標不是只完成學習，而是形成三種可投履歷方向：

1. Firmware / Embedded C
2. C Linux / Embedded Linux
3. FPGA / SoC-oriented software

ERP / Simray 系統作為過去工作經歷，提供大型系統、製造流程、資料庫、權限、部署與跨部門工具經驗。

個人 project 則用來證明低階 C、Linux、韌體與 FPGA 能力。

## Phase 0 - Workspace and Resume System

Status: Completed

Deliverables:

- `Learning_Material`
- `CV`
- `Learning_Roadmap`
- `CV/01_01_MASTER_RESUME.md`
- `CV/02_02_PERSONAL_PROJECTS_INDEX.md`
- `CV/REF_00_REF_00_PROJECT_PRESENTATION_NOTES.md`

## Phase 1 - C Engineering Foundation

Target days: Day 1-7

Project:

```text
C Build System and Memory Debug Foundation
```

Tasks:

- Create `src/`, `include/`, `test/`, `docs/`.
- Create Makefile.
- Add warning flags.
- Add unit test runner.
- Add sanitizer target.
- Write README.
- Write gate review notes.

Gate:

- Build succeeds.
- No warning.
- Unit tests pass.
- ASan/UBSan pass.
- README explains build/test/debug flow.
- Can explain compile vs link, `.h` vs `.c`, and sanitizer limits.

CV action:

- Add project to `CV/02_02_PERSONAL_PROJECTS_INDEX.md` as completed.
- Add PPT notes to `CV/REF_00_REF_00_PROJECT_PRESENTATION_NOTES.md`.

## Phase 2 - C Memory and Data Structures

Target days: Day 8-15

Project:

```text
C Data Structure Library
```

Tasks:

- Implement dynamic array.
- Implement linked list.
- Implement stack.
- Implement queue.
- Define ownership rules.
- Write boundary/invalid/repeated tests.
- Run memory validation.

Gate:

- All container APIs tested.
- Ownership rules documented.
- Empty/single/multiple cases covered.
- NULL pointer cases handled.
- Can explain time/space complexity.

CV action:

- Add concise project entry.
- PPT notes include ownership table and failure cases.

## Phase 3 - Firmware Stream and Parser

Target days: Day 16-23

Project:

```text
UART-like Ring Buffer and State Machine Protocol Parser
```

Tasks:

- Implement ring buffer.
- Define packet format.
- Implement checksum.
- Implement FSM parser.
- Test fragmented input.
- Test invalid packet and parser recovery.

Gate:

- Wraparound works.
- Full/empty handling works.
- Fragmented input parsed correctly.
- Corrupted checksum rejected.
- Can explain FSM transitions and failure recovery.

CV action:

- Firmware resume can start using this as a core personal project.
- PPT notes need packet format, FSM, and test cases.

## Phase 4 - C Linux File and Data Processing

Target days: Day 24-32

Project:

```text
Streaming Log Parser in C
```

Tasks:

- Implement streaming file reader.
- Parse records.
- Handle malformed lines.
- Add sorting/searching/statistics.
- Output CSV/report.
- Add benchmark.

Gate:

- Does not load whole file into memory.
- Handles malformed lines.
- Produces report.
- Has benchmark notes.

CV action:

- Add to C Linux resume.
- PPT notes include data flow and benchmark result.

## Phase 5 - C Linux Socket and Custom Protocol

Target days: Day 33-42

Project:

```text
TCP Client/Server with Custom Protocol in C
```

Tasks:

- Implement TCP server.
- Implement TCP client.
- Define custom packet format.
- Handle partial read/write.
- Add timeout/disconnect handling.
- Add integration tests.

Gate:

- Client/server round trip works.
- Malformed packet handled.
- Partial read/write handled.
- Timeout behavior documented.

CV action:

- C Linux resume becomes stronger after this phase.
- PPT notes need stream framing explanation.

## Phase 6 - FPGA / Zynq Accelerator

Target days: Day 43-52

Project:

```text
Zynq INT8 Dot Product Accelerator
```

Tasks:

- Confirm RTL modules.
- Confirm testbench cases.
- Confirm golden model.
- Confirm AXI-Lite register map.
- Confirm PS bare-metal C control flow.
- Record latency/resource.
- Complete gate review.

Gate:

- RTL simulation pass.
- AXI wrapper simulation pass.
- Golden model matches.
- Register map documented.
- Can explain PS/PL data flow.
- Can explain signed INT8 risk.

CV action:

- Add to FPGA/SoC resume.
- PPT notes include block diagram, register map, timing, debug risks.

## Phase 7 - Final C Communication Engine

Target days: Day 53-60

Project:

```text
C-based Communication and Data Processing Engine
```

Tasks:

- Input from file or socket.
- Ring buffer.
- FSM parser.
- Checksum validation.
- Record storage.
- Query/sort/statistics.
- CSV/report output.
- Unit/integration tests.
- Benchmark and sanitizer validation.

Gate:

- End-to-end demo works.
- Tests cover normal, boundary, invalid, fragmented, and large input.
- Memory validation clean.
- Benchmark recorded.
- README explains architecture and demo flow.

CV action:

- Add as strongest personal project for firmware/C Linux/semiconductor software.
- Complete PPT notes.

