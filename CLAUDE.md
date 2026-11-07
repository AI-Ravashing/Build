### Auto-loaded every session. Keep this file short — detail belongs in NEED/*.md, not here. If this file and a NEED file ever disagree, NEED/OPEN_QUESTIONS.md and the latest PROGRESS_LOG.md entry win; update this file to match, don't silently follow the stale version.

## Identity & scope
- Digitizing Ravashing's **Build** side only: Project Management, Carpentry, Water Paint, Spray Paint, Electric, Branding (Graphics, CNC, Logo inside it), Logistics (told by Narendra from Prateek, 6 Nov; not confirmed by a department head; Procurement and Furniture are Agency; there is no single Production department) — with Project Management as the main bridge to Agency (Marketing, Sales, Design, Estimation, Finance, HR, Project Coordinators), which Prateek is building separately. Not your scope unless Narendra explicitly extends it.
- Narendra is non-technical and is the *only* channel to real Ravashing people. Everything he reports is secondhand until marked CONFIRMED.
- Built exclusively for Ravashing. No generic CRM/ERP template thinking.

## Current phase — check before doing anything
- Read the latest entries at the bottom of `NEED/PROGRESS_LOG.md` for the live phase and status.
- **Pro plan = research and design only. No production code** unless Narendra has said, in so many words, that we're on Max.

## Hard rules
1. Ask, don't assume. Tag everything `CONFIRMED — [who, when]` or `ASSUMED`. Never let repetition turn an assumption into a treated-as-fact.
2. Single source of truth per fact — flag, don't silently resolve, any case where two departments/tables could each own the same thing.
3. Nothing destructive (delete/overwrite real data, mock data, or prior decisions) without asking first.
4. No scope creep — name anything Agency-side or outside current Build focus, and set it aside.
5. Mock data: structure matches confirmed real research; minimal rows, scenario-complete, unambiguously labeled fictional.
6. No AI slop: nothing static dressed up as functional; server-side enforced auth/RBAC; real tests; no hardcoded secrets; concise code over padded code (prefer ~20 lines that do the job over 100 that don't need to).
7. Explain technical decisions to Narendra in plain English — what it means for him, not just the justification.
8. Honest estimates, not reassuring ones.
9. Use Ravashing's own vocabulary once learned (see "Ravashing's words" in `NEED/WORKING_UNDERSTANDING.md`) instead of generic industry terms.
10. Lazy-load everything — skills, MCP servers, plugins, subagents. Install only when a real task needs it right now; log it in `NEED/TOOLKIT.md` with why.

## NEED folder — the project's non-code memory
- `00_Build_Part_Working_Reference.md` — Narendra's secondhand notes from the COO. Question it, don't follow it blindly. Where it differs, `WORKING_UNDERSTANDING.md` wins.
- `WORKING_UNDERSTANDING.md` — what we currently believe about Build, with sources and status.
- `Build_Map.html` — the visual map (work flow, people, data flows) and the short question set per department (63 questions, tab "All department questions"; `interview_sheets/` is generated from them), plus a "Whole company map" tab: Agency + PM bridge + Build, Agency side guessed or from Prateek's notes. Its data is hand-written inside the file; update it when WORKING_UNDERSTANDING.md changes. Contains real first names: keep it local. The A4 PDFs in `NEED/PDF/` are rebuilt with `bash NEED/PDF/make_pdfs.sh` after any change.
- `ORG_CHART.md` — HR's organisation chart (heads, counts; confidential). `DATA_FLOW.md` — what each department should update and use (proposal); its visual is `PDF/7_Portal_Concept.pdf`, built from `Portal_Concept.html`. `IMPROVEMENT_IDEAS.md` — where Build loses time. `Department_Board.html` — every department (Agency + Build): makes, manages, gets, sends, tied to both schemas; `UI_Board.html` — the portal screens per role.
- `PROBLEM_DEFINITION.md` — what we're solving, sub-problems, constraints, ideas held for Phase 5.
- `ENGINEERING_PLAN.md` — the approved phase order.
- `interview_sheets/` — short talks and question lists for real people.
- `PROGRESS_LOG.md` — timestamped, compressed, append-only. Read the latest entries first thing every session; append before ending one.
- `MEETING_NOTES.md` — short, plain English, for Narendra alone, to brief himself before meetings.
- `OPEN_QUESTIONS.md` — every unresolved item, contradiction, and pending decision. Nothing should quietly disappear from here without being resolved.
- `TOOLKIT.md` — every skill/MCP server/plugin/subagent installed, what triggered it, when.

## Roles
Specialist work goes to subagents, not the main thread — Business Analyst, CRM/ERP Specialist, Database Designer, Backend, Frontend, AI Engineer, Data Analyst, Data Visualization Specialist, Security Reviewer, QA, Documentation Keeper. Full definitions in the roles/toolkit document in NEED. The orchestrator (this main thread) stays thin and delegates; it reviews what comes back rather than trusting it blindly.

## Models
- Research phase (now): Sonnet by default; Opus only for hard synthesis (reconciling conflicting information, the engineering plan, the data model).
- Build phase (later, Max plan): Opus for architecture/schema/security-sensitive logic; Sonnet for routine implementation.

## Every session
1. Read `NEED/PROGRESS_LOG.md` (latest entries) and `NEED/OPEN_QUESTIONS.md` before doing new work.
2. State the current phase and what's still open before starting.
3. Log everything Narendra does or decides in `PROGRESS_LOG.md`, each entry headed with the real time from `date` (never guessed), so no progress is lost. Before ending, append a short entry to `PROGRESS_LOG.md` (and `MEETING_NOTES.md` if the session gave Narendra something worth saying in a meeting).
