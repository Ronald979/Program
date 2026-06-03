# Ronald - Master Resume

> This is the main resume baseline. Update this file first, then derive focused versions for Firmware, C/Linux, FPGA, or Full-stack ERP roles.

Primary resume source:

- Original current resume: `C:\Users\ronald\Program\CV\REF_01_Ronald_Tan_CV.pdf`
- Editable master resume: `C:\Users\ronald\Program\CV\01_01_MASTER_RESUME.md`
- Project evidence source: `C:\Users\ronald\Program\Tree\ERP_SYSTEM_FILETREE.txt.txt`

Resume facts to keep consistent:

- Employment end date / resignation date: May 2026.

Canonical resume structure:

- ERP / Simray internal system is past professional experience, not a personal project.
- The resume should describe ERP under "Professional Experience" with responsibilities, modules, architecture, and business impact.
- Personal projects should appear in the resume only as concise entries: project name, one-line purpose, and key technologies.
- Detailed explanation for each personal project should be kept outside the resume as a project presentation/PPT.
- Until PPT files are created, keep project presentation content in Markdown notes under this CV folder.

Current Markdown records:

- Personal project resume index: `C:\Users\ronald\Program\CV\02_02_PERSONAL_PROJECTS_INDEX.md`
- Project presentation notes: `C:\Users\ronald\Program\CV\REF_00_REF_00_PROJECT_PRESENTATION_NOTES.md`

Editing rule:

- Keep the PDF as the current historical resume snapshot.
- Use this Markdown file as the new editable source of truth.
- When a new learning/project stage is completed, add the new project here first, then export or rewrite a focused resume version.

## 0. How to Use This Resume

Use this file as the source of truth for staged resume updates.

Update order:

1. Add new project evidence under "Project Portfolio".
2. Move the strongest 2 to 3 projects into "Selected Projects".
3. Adjust the "Professional Summary" to match the target role.
4. Keep facts measurable. If a number is not confirmed yet, leave it as `[TBD]`.
5. Do not delete older project content immediately. Move weaker items to "Project Bank".

Recommended derived versions:

| Resume Version | Target Role | Main Projects |
|---|---|---|
| `resume_fullstack_erp.md` | Full-stack / ERP / internal system developer | Simray ERP/MES platform, drawing workflow, permission system |
| `resume_firmware.md` | Firmware / embedded software engineer | ERP system + future C ring buffer/parser + communication engine |
| `resume_c_linux.md` | C Linux / embedded Linux engineer | ERP backend + future TCP protocol project + Linux tooling |
| `resume_fpga_soc.md` | FPGA / SoC software / validation engineer | ERP system + future Zynq INT8 accelerator + C validation tools |

---

# Resume - Full-stack ERP / Industrial Software Version

## Ronald

Location: Taiwan  
Email: `[your_email]`  
Phone: `[your_phone]`  
GitHub: `[your_github]`  
LinkedIn: `[your_linkedin]`

## Professional Summary

Full-stack software developer with hands-on experience building a modular ERP/MES-style internal operation platform for manufacturing workflows. Experienced in React/TypeScript frontend development, Python/Flask backend APIs, PostgreSQL data modeling, Alembic database migrations, real-time socket services, permission management, file/document workflows, and deployment with Gunicorn/Nginx. Strong at turning fragmented business processes into maintainable modules, dashboards, data workflows, and internal tools.

Current career direction: embedded C, C/Linux system programming, FPGA/SoC-oriented software, and semiconductor manufacturing software systems.

## Core Skills

| Category | Skills |
|---|---|
| Frontend | React, TypeScript, TSX, Vite, modular UI architecture, dashboard UI, modal workflows, canvas-based interaction |
| Backend | Python, Flask-style routing, service layer design, API modules, schema/model separation |
| Database | PostgreSQL, Alembic migrations, relational schema design, ERP data modeling |
| Realtime / Integration | Socket.IO-style event service, Redis client integration, internal workflow automation |
| DevOps | Gunicorn, Nginx, shell deployment scripts, Cloudflare DDNS, environment configuration |
| Business Domains | ERP, MES-style workflow, purchase order, sales order, accounting, maintenance, tool store, drawing/document control |
| Engineering Habits | Modular architecture, API documentation, migration tracking, permission matrix, workflow verification |

## Selected Projects

### Simray ERP/MES Internal Operation Platform

Role: Full-stack developer / system builder  
Tech stack: React, TypeScript, Python, Flask-style backend, PostgreSQL, Alembic, Socket service, Redis, Gunicorn, Nginx

Project summary:

Built a modular internal ERP/MES-style platform covering production operations, purchase orders, accounting workflows, customer service, drawing management, maintenance, file management, tool store, dashboard reporting, permissions, and user/group control.

Key contributions:

- Designed a multi-module frontend architecture under React/TypeScript with separate workspaces for accounting, calendar, checklist, customer service, dashboard, drawing, employee, file system, group control, maintenance, and tool store functions.
- Implemented backend API modules with separated routers, services, schemas, and database models to support ERP-style workflows and future module expansion.
- Built relational data models for accounting, customer data, drawing records, file management, HSE data, ISO data, machine data, maintenance, OAuth, production flow, purchase orders, sales orders, tool store, and user data.
- Managed database evolution with Alembic migration scripts for permissions, maintenance modules, tool store tables, checklist ownership rules, HBR intake tables, sales order fields, user OTP reset fields, and other production schema changes.
- Added deployment and runtime configuration through Gunicorn, Nginx, shell scripts, Cloudflare DDNS utilities, and environment-based startup files.
- Structured API documentation and module-level README files to make a large internal system easier to maintain and extend.

Resume bullets:

- Built a modular ERP/MES-style internal platform with React/TypeScript frontend, Python backend APIs, PostgreSQL models, and Alembic database migrations.
- Developed business modules for accounting, purchase orders, sales orders, maintenance, drawing workflows, file management, user/group permissions, and dashboard reporting.
- Organized backend architecture into routers, services, schemas, and models to keep large business workflows maintainable and extensible.
- Maintained deployment configuration using Gunicorn, Nginx, shell scripts, and environment-based startup workflows.

Interview talking points:

- How the system is split into frontend modules, backend routers/services, database models, and migrations.
- How permission and group control prevents uncontrolled access in an internal ERP system.
- How drawing, checklist, maintenance, and purchase order workflows map real manufacturing processes into software.
- How to maintain a large monolithic-but-modular internal platform without losing structure.

---

### Digital Drawing and Checklist Workflow System

Role: Frontend/backend workflow developer  
Tech stack: React, TypeScript, Canvas-style UI, Python API services, database-backed drawing/checklist records

Project summary:

Built digital drawing and checklist workflow modules for manufacturing documentation, including drawing boards, detail modals, canvas viewers, checklist panels, import/export tools, OCR-related selection, undo/redo, context menus, and data synchronization.

Key contributions:

- Developed drawing workflow modules including drawing home page, drawing program board, drawing preview/detail modal, process drawing engine, and checklist display modules.
- Built interactive UI components for canvas rendering, hit testing, OCR selection, context menu actions, pen palette, coordinate display, attachment handling, edit box modal, and export/import checklist workflows.
- Organized drawing logic into actions, API modules, core state, drawing renderers, event handlers, menus, UI components, constants, DOM helpers, and shared types.
- Added workflow features such as undo/redo, box actions, note API, attach API, checklist panels, and export functions.

Resume bullets:

- Developed a digital drawing workflow system with interactive canvas rendering, checklist panels, import/export functions, context menus, and undo/redo operations.
- Modularized drawing logic into state management, event handling, API access, rendering, and UI layers for maintainability.
- Built manufacturing-document workflows that connect drawing review, checklist data, attachments, notes, and exportable reports.

Interview talking points:

- How canvas interaction is split into rendering, event handling, hit testing, state, and API layers.
- How checklist data moves from UI editing to backend storage and export.
- How undo/redo and context menu actions reduce operator mistakes in document-heavy workflows.

---

### Permission, User Group, and Internal Access Control System

Role: Full-stack developer  
Tech stack: React, TypeScript, Python backend, PostgreSQL, Alembic migrations

Project summary:

Built user, group, permission, firewall, OAuth, and access-control-related modules for an internal ERP platform.

Key contributions:

- Implemented frontend group control modules for group membership, permission assignment, and access control management.
- Supported backend permission-related schema evolution through migration files for maintenance permissions, supervisor group permissions, default group permissions, and user active status.
- Integrated user data, OAuth-related models, firewall routes, and internal access management modules.
- Created permission planning documentation including permission matrix and workflow verification assets.

Resume bullets:

- Built internal user/group permission management features for ERP modules, including group membership, permission assignment, and access-controlled workflows.
- Maintained database migrations for permission seeding, default group setup, supervisor access, and user status changes.
- Documented permission matrices and workflow verification plans to support safer module rollout.

Interview talking points:

- How permission data should be modeled across users, groups, modules, and actions.
- Why migrations are important when permission logic evolves.
- How to avoid hard-coded access rules in a growing internal system.

---

### Accounting, Purchase Order, and Autocount Integration Modules

Role: Full-stack workflow developer  
Tech stack: React, TypeScript, Python services, PostgreSQL, business-data integration

Project summary:

Developed ERP accounting and purchasing modules including AP invoice dashboard, cash book dashboard, expenses dashboard, purchase order dashboard, pending orders, outsourcing delivery notes, Autocount-related search modals, creditor search, PO detail search, and shared accounting components.

Key contributions:

- Built accounting dashboard components for AP invoice, cash book, expenses, and purchase order views.
- Implemented purchase order rendering and detail display modules with shared rendering logic.
- Added Autocount-related frontend search flows for creditors, PO details, result modals, and selection workflows.
- Integrated backend services and testing utilities for purchase order preview, sales order search, and Autocount bridge behavior.

Resume bullets:

- Developed ERP accounting and purchasing modules including AP invoice, cash book, expenses, purchase order dashboards, pending orders, and outsourcing delivery-note workflows.
- Built Autocount-related search and selection interfaces to connect ERP purchase/accounting workflows with external accounting data.
- Created reusable shared rendering logic for purchase order display and detail views.

Interview talking points:

- How purchase order, sales order, accounting, and external ERP data should be connected.
- How dashboard views differ from transactional forms.
- How to design search modals and detail views without duplicating business logic.

---

### Maintenance, Machine, Tool Store, and Production Support Modules

Role: Full-stack developer  
Tech stack: React, TypeScript, Python services, PostgreSQL, Alembic migrations

Project summary:

Built manufacturing support modules for maintenance, machine data, tool store inventory, production flow, problem reports, and operational dashboards.

Key contributions:

- Implemented backend models and services for machine data, maintenance, production flow, tool store, issue tracking, and inventory-related workflows.
- Added Alembic migrations for maintenance service modules, machine specification fields, tool store modules, transaction issue tracking, and problem report timing fields.
- Created planning documents for maintenance backend blueprint, data model schema, permission matrix, QA workflow verification, task dashboard, and workspace planning.
- Built frontend modules for maintenance-related workflows, tool store management, task/calendar coordination, and dashboard reporting.

Resume bullets:

- Developed maintenance, machine-data, production-flow, and tool-store modules for manufacturing operations.
- Added database migrations for maintenance services, machine specifications, tool inventory, transaction issue tracking, and problem report timing fields.
- Created planning documents for backend blueprint, data schema, permissions, QA workflow verification, and task dashboards.

Interview talking points:

- How production, maintenance, tool inventory, and machine data connect in a manufacturing platform.
- Why issue tracking and timing fields matter for operational accountability.
- How planning docs reduce risk before implementing large workflow modules.

---

### HBR PDF Extraction and Auto-ingestion Agent Modules

Role: Automation / data ingestion developer  
Tech stack: Python, extraction service modules, router services, static document workflows

Project summary:

Built document extraction and auto-ingestion service modules for HBR-related PDF/document workflows, including extract services, auto-ingest services, agent index documentation, and router service integration.

Key contributions:

- Implemented Python service modules for PDF extraction, HBR v2 extraction, auto-ingest workflows, and routing.
- Added documentation for extraction agents, auto-ingest agents, and agent indexing.
- Connected document workflow outputs to ERP/static form modules and database intake tables through migrations.

Resume bullets:

- Built Python-based document extraction and auto-ingestion modules for ERP document workflows.
- Designed extraction service routing and documentation to support repeatable document-processing pipelines.
- Added database migration support for HBR v2 intake and submission timestamp tracking.

Interview talking points:

- How document ingestion moves from raw files to structured database records.
- How extraction services should be routed, logged, and verified.
- How automation reduces manual document handling in manufacturing workflows.

---

## Project Portfolio Matrix

| Project Area | Evidence in Tree Project | Resume Value | Target Role |
|---|---|---|---|
| ERP/MES platform | frontend modules, backend routers, models, migrations | Large system architecture | Full-stack, manufacturing software |
| Drawing workflow | dwg modules, process drawing engine, checklist UI | Complex UI and workflow design | Industrial software, frontend-heavy roles |
| Permission system | group control, OAuth, permission migrations, planning docs | Security/access control | Backend, enterprise software |
| Accounting/PO integration | Autocount, AP invoice, cash book, PO modules | Business-system integration | ERP/backend roles |
| Maintenance/tool store | maintenance, machine, tool store, production models | Manufacturing domain knowledge | Semiconductor manufacturing software |
| Socket/Redis service | socket routes, events, redis client | Realtime system experience | Backend/system roles |
| Deployment | Gunicorn, Nginx, run scripts, DDNS | Production deployment awareness | Backend/DevOps-adjacent roles |
| Document ingestion | HBR extraction, auto-ingest services | Automation/data pipeline | Backend/data tooling roles |

---

# Staged Resume Update Plan

Use this section when adding future C, Linux, Firmware, and FPGA projects.

## Stage A - Current Baseline

Resume focus:

- Full-stack ERP/MES internal platform.
- Manufacturing workflow software.
- Python/React/PostgreSQL deployment experience.

Best project order:

1. Simray ERP/MES Internal Operation Platform
2. Digital Drawing and Checklist Workflow System
3. Permission, User Group, and Internal Access Control System
4. Accounting, Purchase Order, and Autocount Integration Modules

## Stage B - After C Build System and Memory Debug Project

Add project:

### C Build System and Memory Debug Foundation

Resume bullets:

- Built a reproducible C project structure with Makefile, header/source separation, warning-as-error compilation, and unit test workflow.
- Added AddressSanitizer-based debug flow to detect invalid memory access and undefined behavior.
- Designed minimal test cases covering normal, boundary, invalid, and repeated-operation scenarios.

Skill additions:

`C`, `Makefile`, `gcc`, `clang`, `AddressSanitizer`, `unit testing`, `debugging`

Resume positioning:

- Keep Simray ERP/MES as the main production-scale project.
- Add this C project as proof of low-level engineering discipline.

## Stage C - After Data Structure Library

Add project:

### C Data Structure Library with Memory Ownership Validation

Resume bullets:

- Implemented reusable C data structures including dynamic array, linked list, stack, and queue with explicit memory ownership rules.
- Designed boundary and invalid-input tests to verify empty container behavior, NULL pointer handling, and repeated operations.
- Documented API contracts, time complexity, and failure cases for each data structure module.

Skill additions:

`pointer`, `malloc/free`, `data structures`, `memory ownership`, `Valgrind`, `API design`

Resume positioning:

- For firmware roles, move this project above accounting modules.
- For full-stack roles, keep it under Selected Low-level Projects.

## Stage D - After Ring Buffer and Protocol Parser

Add project:

### UART-like Ring Buffer and State Machine Protocol Parser

Resume bullets:

- Developed a firmware-style ring buffer for UART-like streaming data with wraparound handling and configurable overflow policy.
- Implemented a state machine parser supporting fragmented packet input, checksum validation, and invalid-frame recovery.
- Created test cases for partial read/write, buffer full/empty states, corrupted packets, and parser reset behavior.

Skill additions:

`embedded C`, `ring buffer`, `UART-style stream`, `state machine`, `protocol parser`, `checksum`

Resume positioning:

- Firmware resume top projects: Ring Buffer Parser, Simray ERP/MES, C Data Structure Library.
- C/Linux resume top projects: Simray ERP/MES, Ring Buffer Parser, future TCP project.

## Stage E - After Streaming Log Parser

Add project:

### Streaming Log Parser in C with Search and Aggregation

Resume bullets:

- Built a streaming log parser in C to process large text files without loading the entire file into memory.
- Implemented filtering, aggregation, sorting, and binary-search-based lookup for parsed records.
- Added benchmark reports to measure throughput, memory usage, and malformed-line handling.

Skill additions:

`Linux file I/O`, `stream processing`, `sorting`, `binary search`, `benchmarking`, `CSV report`

Resume positioning:

- C/Linux resume should now emphasize backend system thinking plus low-level C data processing.

## Stage F - After TCP Client/Server Project

Add project:

### TCP Client/Server with Custom Protocol in C

Resume bullets:

- Implemented a TCP client/server system in C using a custom packet protocol and stream-framing logic.
- Handled partial reads, partial writes, timeout, malformed packets, and client disconnect scenarios.
- Integrated protocol parser, ring buffer, and logging modules into a reusable Linux networking project.

Skill additions:

`Linux socket`, `TCP/IP`, `select/poll`, `pthread`, `custom protocol`, `network debugging`

Resume positioning:

- C/Linux resume top projects: TCP Client/Server, Simray ERP/MES, Streaming Log Parser.
- Firmware resume top projects: Ring Buffer Parser, TCP Protocol, Simray ERP/MES.

## Stage G - After Zynq INT8 Dot Product Accelerator

Add project:

### Zynq-based INT8 Dot Product Accelerator with AXI-Lite Control

Resume bullets:

- Designed an INT8 dot product accelerator in Verilog using signed INT8 multiplication and INT32 accumulation.
- Built testbenches and golden-model comparison to verify signed arithmetic, mixed-sign input, and latency behavior.
- Designed an AXI-Lite register map and bare-metal C control flow for PS-to-PL accelerator interaction.

Skill additions:

`Verilog`, `RTL`, `testbench`, `AXI-Lite`, `Zynq`, `PS/PL`, `INT8`, `golden model`

Resume positioning:

- FPGA/SoC resume top projects: Zynq INT8 Accelerator, Simray ERP/MES, C Communication Engine.
- Emphasize that ERP/MES project proves large-system software maturity, while FPGA project proves hardware-facing capability.

## Stage H - After Final C Communication Engine

Add project:

### C-based Communication and Data Processing Engine

Resume bullets:

- Built an end-to-end C data processing engine that receives stream data from file or socket, buffers it, parses packets, validates checksum, stores records, and exports reports.
- Integrated ring buffer, state machine parser, dynamic data storage, sorting/searching, and CSV reporting into a modular C architecture.
- Added tests for normal, boundary, invalid, fragmented, and large-input cases with sanitizer-based memory validation.

Skill additions:

`modular C`, `stream processing`, `protocol parser`, `Linux socket`, `data structure`, `benchmark`, `system design`

Resume positioning:

- Semiconductor software resume top projects: C Communication Engine, Zynq INT8 Accelerator, Simray ERP/MES.

---

# Targeted Resume Summaries

Use one of these summaries depending on the job.

## Full-stack ERP / Manufacturing Software

Full-stack developer experienced in building modular ERP/MES-style internal systems for manufacturing workflows. Skilled in React/TypeScript, Python backend APIs, PostgreSQL schema design, Alembic migrations, permission management, dashboards, document workflows, and deployment with Gunicorn/Nginx.

## Firmware / Embedded Software

Software developer transitioning into embedded C and firmware engineering, with experience building manufacturing ERP/MES systems and current focus on C memory ownership, ring buffers, protocol parsers, state machines, Linux tooling, and hardware-facing workflows.

## C Linux / Embedded Linux

Software developer with production-scale backend and ERP system experience, now focused on C/Linux system programming, socket communication, stream processing, memory debugging, protocol design, and maintainable system-level tooling.

## FPGA / SoC Software

Software developer with large-system ERP/MES experience and growing FPGA/SoC skill set, focused on Verilog RTL, testbench verification, AXI-Lite register maps, PS/PL interaction, C-based hardware control, and semiconductor-oriented validation workflows.

---

# Resume Editing Checklist

Before exporting a resume version, check:

- The top 3 projects match the target job.
- Each project has problem, implementation, validation, and result.
- No unverified metric is presented as fact.
- Skills listed are supported by project evidence.
- ERP project is framed as manufacturing workflow software, not generic web development.
- Low-level C/FPGA projects are placed higher for semiconductor roles.
- Every bullet starts with an action verb.
- Every major claim can be explained in a 2-minute interview story.

---

# Project Bank

Keep these projects here until they are strong enough to move into Selected Projects.

## Future Project - C Build System and Memory Debug Foundation

Status: Planned  
Target resume version: Firmware, C/Linux  
Evidence needed: code, Makefile, tests, ASan output, README

## Future Project - C Data Structure Library

Status: Planned  
Target resume version: Firmware, C/Linux  
Evidence needed: API docs, ownership table, tests, Valgrind/ASan notes

## Future Project - UART-like Ring Buffer and Protocol Parser

Status: Planned  
Target resume version: Firmware  
Evidence needed: parser state table, checksum test, fragmented input test

## Future Project - TCP Client/Server with Custom Protocol

Status: Planned  
Target resume version: C/Linux  
Evidence needed: integration test, partial read/write handling, timeout behavior

## Future Project - Zynq INT8 Dot Product Accelerator

Status: Planned  
Target resume version: FPGA/SoC  
Evidence needed: RTL, testbench, golden model, AXI-Lite register map, latency/resource report

## Future Project - C-based Communication and Data Processing Engine

Status: Planned  
Target resume version: Semiconductor software / firmware / C Linux  
Evidence needed: final demo, tests, benchmark, memory validation, README
