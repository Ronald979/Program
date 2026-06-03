# Personal Projects Index

> Resume rule: personal projects should be short in the resume. Use this file to maintain the project name, role, one-line purpose, and key technologies only. Put detailed explanations in `REF_00_PROJECT_PRESENTATION_NOTES.md`.

## Resume Placement

Recommended resume section title:

```text
Personal Projects
```

Recommended format:

```text
Project Name - one-line purpose
Key Technologies: A, B, C, D
```

Do not expand full architecture, implementation history, or slide-level details in the resume. Those belong in the project presentation/PPT.

---

# Current / Future Personal Projects

## 1. C Build System and Memory Debug Foundation

Status: Planned  
Resume category: Low-level C foundation  
One-line purpose: A reproducible C project skeleton with Makefile, unit tests, compiler warnings, and sanitizer-based debugging.  
Key Technologies: C, Makefile, GCC/Clang, AddressSanitizer, UndefinedBehaviorSanitizer, unit testing, header/source separation

Resume entry:

```text
C Build System and Memory Debug Foundation - Built a reproducible C project skeleton with Makefile, unit tests, warning-as-error compilation, and sanitizer-based debugging.
Key Technologies: C, Makefile, GCC/Clang, AddressSanitizer, unit testing
```

## 2. C Data Structure Library

Status: Planned  
Resume category: C / memory ownership  
One-line purpose: A reusable C data structure library covering dynamic array, linked list, stack, and queue with explicit ownership rules.  
Key Technologies: C, pointers, malloc/free, dynamic array, linked list, stack, queue, Valgrind, API design

Resume entry:

```text
C Data Structure Library - Implemented reusable C containers with explicit memory ownership, boundary tests, and API documentation.
Key Technologies: C, pointers, malloc/free, data structures, Valgrind
```

## 3. UART-like Ring Buffer and State Machine Protocol Parser

Status: Planned  
Resume category: Firmware / embedded C  
One-line purpose: A firmware-style streaming data parser using ring buffer, checksum validation, and finite state machine recovery.  
Key Technologies: embedded C, ring buffer, UART-style stream, finite state machine, checksum, protocol parser, buffer boundary handling

Resume entry:

```text
UART-like Ring Buffer and State Machine Protocol Parser - Built a firmware-style stream parser with ring buffer, checksum validation, fragmented input handling, and parser recovery.
Key Technologies: embedded C, ring buffer, FSM, checksum, protocol parser
```

## 4. Streaming Log Parser in C

Status: Planned  
Resume category: C Linux / data processing  
One-line purpose: A streaming C log parser that processes large files without loading the entire file into memory.  
Key Technologies: C, Linux file I/O, stream processing, sorting, binary search, aggregation, CSV report, benchmarking

Resume entry:

```text
Streaming Log Parser in C - Processed large log files with streaming file I/O, filtering, aggregation, sorting, and benchmark reporting.
Key Technologies: C, Linux file I/O, stream processing, sorting, binary search, benchmarking
```

## 5. TCP Client/Server with Custom Protocol in C

Status: Planned  
Resume category: C Linux / embedded Linux  
One-line purpose: A TCP client/server project using custom packet framing, partial read/write handling, and protocol validation.  
Key Technologies: C, Linux socket, TCP/IP, select/poll, pthread, custom binary protocol, timeout handling, network debugging

Resume entry:

```text
TCP Client/Server with Custom Protocol in C - Implemented TCP client/server communication with custom packet framing, partial read/write handling, timeout control, and malformed packet recovery.
Key Technologies: C, Linux sockets, TCP/IP, select/poll, pthread, custom protocol
```

## 6. Zynq INT8 Dot Product Accelerator

Status: Planned / in learning roadmap  
Resume category: FPGA / SoC  
One-line purpose: A Zynq-based INT8 dot product accelerator with Verilog RTL, AXI-Lite register map, and bare-metal C control flow.  
Key Technologies: Verilog, RTL, testbench, AXI-Lite, Zynq, PS/PL, bare-metal C, INT8, INT32 accumulation, golden model

Resume entry:

```text
Zynq INT8 Dot Product Accelerator - Designed an INT8 dot product accelerator with Verilog RTL, AXI-Lite register control, golden-model verification, and bare-metal C PS/PL interaction.
Key Technologies: Verilog, RTL, AXI-Lite, Zynq, bare-metal C, INT8, golden model
```

## 7. C-based Communication and Data Processing Engine

Status: Planned final project  
Resume category: Firmware / C Linux / semiconductor software  
One-line purpose: An end-to-end C communication engine that receives stream data, buffers packets, parses protocol frames, validates checksum, stores records, and exports reports.  
Key Technologies: modular C, ring buffer, state machine parser, Linux socket, file input, dynamic array, sorting/searching, CSV report, sanitizer, benchmark

Resume entry:

```text
C-based Communication and Data Processing Engine - Built an end-to-end C engine for stream input, packet buffering, protocol parsing, checksum validation, record storage, query, and CSV reporting.
Key Technologies: modular C, ring buffer, FSM parser, Linux socket, data structures, benchmark
```

---

# Resume Version Priority

## Firmware Resume

Recommended personal project order:

1. C-based Communication and Data Processing Engine
2. UART-like Ring Buffer and State Machine Protocol Parser
3. C Data Structure Library
4. Zynq INT8 Dot Product Accelerator

## C Linux Resume

Recommended personal project order:

1. TCP Client/Server with Custom Protocol in C
2. C-based Communication and Data Processing Engine
3. Streaming Log Parser in C
4. C Data Structure Library

## FPGA / SoC Resume

Recommended personal project order:

1. Zynq INT8 Dot Product Accelerator
2. C-based Communication and Data Processing Engine
3. UART-like Ring Buffer and State Machine Protocol Parser
4. C Build System and Memory Debug Foundation

## Full-stack / ERP Resume

Recommended personal project order:

1. C-based Communication and Data Processing Engine
2. TCP Client/Server with Custom Protocol in C
3. Zynq INT8 Dot Product Accelerator

Note: ERP/Simray should stay under Professional Experience, not Personal Projects.

