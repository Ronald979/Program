# Project Presentation Notes

> Future PPT rule: each personal project should have its own short presentation. This Markdown file records the slide structure before PPT files are created.

Recommended PPT length:

- Small project: 5 to 7 slides.
- Medium project: 8 to 10 slides.
- Final project: 10 to 12 slides.

Each project presentation should answer:

1. What problem does this project solve?
2. What did I build?
3. What is the architecture/data flow?
4. What are the key implementation details?
5. How did I test or validate it?
6. What bugs or risks did I handle?
7. What did I learn, and how does it connect to the target role?

---

# Presentation Template

## Slide 1 - Project Title

Content:

- Project name
- Target role relevance
- One-line project goal
- Key technologies

## Slide 2 - Problem and Motivation

Content:

- What real engineering problem this project represents
- Why this problem matters in firmware, C/Linux, FPGA, or semiconductor software
- What failure would look like in a real system

## Slide 3 - System Architecture

Content:

- Module list
- Data flow
- Control flow
- External inputs/outputs

## Slide 4 - Core Implementation

Content:

- Important data structures
- APIs or module boundaries
- Memory ownership or register map if applicable
- Key algorithm or state machine

## Slide 5 - Validation

Content:

- Unit tests
- Integration tests
- Golden model
- Boundary cases
- Invalid input cases
- Debug tools

## Slide 6 - Failure Cases and Debug

Content:

- At least 3 failure cases
- How each failure is detected
- How each failure is recovered or prevented

## Slide 7 - Result and Interview Story

Content:

- Final outcome
- Measurable result if available
- 2-minute interview explanation
- What I would improve next

---

# Personal Project PPT Outlines

## 1. C Build System and Memory Debug Foundation

Target PPT length: 5 slides

Slide outline:

1. Project goal: reproducible C engineering workflow.
2. Project structure: `src/`, `include/`, `test/`, `Makefile`.
3. Build and warning strategy: `-Wall`, `-Wextra`, `-Werror`, C standard.
4. Test and sanitizer workflow: unit tests, ASan, UBSan.
5. Result: why this foundation matters before data structures, firmware parser, and Linux projects.

Key story:

This project proves I can create a repeatable C development workflow instead of writing isolated C files.

## 2. C Data Structure Library

Target PPT length: 6 slides

Slide outline:

1. Project goal: reusable C containers.
2. API design: dynamic array, linked list, stack, queue.
3. Memory ownership: who allocates, who frees, NULL handling.
4. Test strategy: empty, single, multiple, invalid, repeated cases.
5. Debug strategy: ASan/Valgrind and failure cases.
6. Result: how this supports parser, communication engine, and embedded-style data handling.

Key story:

This project proves I understand pointer-heavy C code, memory ownership, and container failure cases.

## 3. UART-like Ring Buffer and State Machine Protocol Parser

Target PPT length: 8 slides

Slide outline:

1. Project goal: firmware-style stream handling.
2. Problem: fragmented UART-like input and packet boundary recovery.
3. Ring buffer design: read/write index, full/empty, wraparound, overflow policy.
4. Packet format: header, length, payload, checksum.
5. Parser FSM: states, transitions, reset/recovery.
6. Validation: fragmented input, corrupted checksum, overflow, empty/full buffer.
7. Debug cases: off-by-one, stale state, invalid reset, checksum mismatch.
8. Result: relevance to firmware and embedded communication.

Key story:

This project proves I can handle streaming data where packets do not arrive perfectly aligned.

## 4. Streaming Log Parser in C

Target PPT length: 6 slides

Slide outline:

1. Project goal: process large logs without loading entire files.
2. Input/output: log format, parsed records, CSV/report output.
3. Streaming architecture: file reader, parser, aggregator, reporter.
4. Algorithms: filtering, sorting, binary search, aggregation.
5. Benchmark: throughput, memory usage, malformed-line handling.
6. Result: relevance to Linux tooling, semiconductor logs, and validation data analysis.

Key story:

This project proves I can build practical C tools for large operational data and test logs.

## 5. TCP Client/Server with Custom Protocol in C

Target PPT length: 8 slides

Slide outline:

1. Project goal: Linux socket communication with custom protocol.
2. Problem: TCP is a byte stream, not message-based.
3. Protocol format: header, length, payload, checksum/status.
4. Server architecture: socket, accept, read loop, parser, response.
5. Robustness: partial read/write, timeout, disconnect, malformed packet.
6. Concurrency option: select/poll or pthread.
7. Validation: integration test and invalid network behavior.
8. Result: relevance to C Linux and embedded Linux engineering.

Key story:

This project proves I understand Linux networking beyond simple send/recv examples.

## 6. Zynq INT8 Dot Product Accelerator

Target PPT length: 10 slides

Slide outline:

1. Project goal: small AI accelerator prototype on Zynq.
2. Why dot product: foundation of matrix multiplication and neural network inference.
3. System architecture: PS, PL, AXI-Lite, RTL core.
4. RTL modules: INT8 MAC, dot product core, AXI-Lite wrapper.
5. Register map: CONTROL, STATUS, A/B vectors, RESULT, LATENCY.
6. Data flow: PS packs vector, writes registers, starts core, polls done, reads result.
7. Verification: testbench, signed INT8 cases, Python/C golden model.
8. Timing and latency: start, busy, done, accumulation cycles.
9. Debug risks: signed extension, reset polarity, base address mismatch, AXI handshake.
10. Result: relevance to FPGA, SoC validation, and hardware-facing software.

Key story:

This project proves I can connect C software control with RTL hardware through a register map.

## 7. C-based Communication and Data Processing Engine

Target PPT length: 12 slides

Slide outline:

1. Project goal: end-to-end stream data processing in C.
2. Problem: embedded/industrial data arrives as fragmented stream data.
3. System architecture: input source, ring buffer, parser, validator, store, query, report.
4. Input sources: file and socket.
5. Buffer design: ring buffer and overflow policy.
6. Parser design: FSM, packet format, checksum.
7. Storage design: dynamic array or linked list and ownership.
8. Query/report design: sorting, searching, statistics, CSV output.
9. Error handling: enum return codes, invalid packet, timeout, memory failure.
10. Validation: unit, integration, large input, fragmented input, sanitizer.
11. Performance: throughput, memory usage, benchmark.
12. Result: relevance to firmware, C Linux, and semiconductor software roles.

Key story:

This final project connects the C learning path into one system that looks like a real firmware/Linux data pipeline.

---

# ERP Experience Presentation Note

ERP/Simray is not a personal project. It should be presented as work experience or a professional case study if needed.

Possible presentation title:

```text
Professional Experience Case Study: Simray ERP/MES Internal Operation Platform
```

Recommended slide outline:

1. Company/process context and problem.
2. Overall ERP/MES architecture.
3. Frontend module system.
4. Backend routers/services/models/schemas.
5. Database and migration strategy.
6. Permission and group control.
7. Drawing/checklist workflow.
8. Maintenance/tool store/accounting modules.
9. Deployment/runtime setup.
10. Lessons learned and future improvements.

