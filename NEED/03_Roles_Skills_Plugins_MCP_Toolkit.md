## The governing rule: lazy-load everything

Every skill, MCP server, plugin, or subagent you add costs context and/or tokens just by existing in your tool list — even unused. So:

1. **Never pre-install "just in case."** Install a tool the first time a task actually requires it, not in anticipation of a future phase.
2. **Prefer a subagent over loading a heavy tool into the main thread.** If a task needs specialist tools (database introspection, image processing, etc.), delegate it to a subagent that loads those tools in its own isolated context and reports back a summary — don't pull them into the main conversation where they'll sit in context for the rest of the session.
3. **Before installing anything, ask: is there a lighter way?** A short Bash script often beats an MCP server. A one-off Read/Grep often beats a whole skill. Reach for the heavier tool only when the lighter one genuinely can't do it.
4. **Record what you installed and why**, in `NEED/TOOLKIT.md` — tool name, what task triggered it, date. If you're ever about to reinstall something already on that list, you probably already have it; check first.
5. **Uninstall or stop using what a finished phase no longer needs.** Research-phase tools (document/web research) and build-phase tools (database, deployment) are mostly different sets — don't carry dead weight from one phase into the next.
6. **No AI slop, extended to tooling:** don't wire up a plugin or MCP server you haven't actually verified works and fits this project, just because it sounded relevant. Confirm it does the specific job before relying on it.

---

## Part 1 — Roles (subagents)

Each role below should be a Claude Code subagent (its own file under `.claude/agents/`), not a persona you simply "act as" in the main thread. The point of a subagent is that it only loads when invoked for a matching task, works in its own context window, and hands back a result — so you (the orchestrator) stay lightweight across a long project. Give each one a tight tool list (only what that role needs), a model tier, and an explicit quality bar. You stay the orchestrator: read the task, decide which role fits, delegate, review what comes back before accepting it — don't let a subagent's confidence substitute for your own check.

For every role: ground rules from the kickoff prompt apply (CONFIRMED vs. ASSUMED, ask-don't-assume, Ravashing-specific only, plain-English explanations back to Narendra). What's below is what's specific to each.

### Orchestrator (you, the main thread)
- Stays thin. Holds the overall plan, the open-questions register, and the decision log. Delegates anything specialist-shaped instead of doing it inline.
- Default model: Sonnet for routine delegation and synthesis; escalate to Opus yourself for the hardest cross-role judgment calls (reconciling conflicting subagent outputs, final architecture calls).

### Business Analyst / Requirements Analyst
- **Mission:** turn messy real-world answers from Narendra into structured, precise requirements. Spot contradictions, gaps, and unstated assumptions.
- **Invoked when:** after any discovery conversation Narendra reports back; before anything gets written into a workflow doc or data model as settled.
- **Tools:** Read/Write/Edit on the discovery and requirements docs; no code execution needed.
- **Quality bar:** every requirement traceable to a specific confirmed answer or explicitly marked assumed; no invented precision.

### CRM/ERP Domain Specialist
- **Mission:** the person in the room who's actually seen how CRM/ERP systems are modeled well and badly — job/project-centric data models, status-vs-computed-status, BOQ/estimate-vs-actual patterns, vendor/inventory patterns, multi-department access patterns. Sanity-checks the business analyst's output against what's structurally sound.
- **Invoked when:** reviewing the workflow model before it becomes a data model; whenever a new entity or relationship is proposed.
- **Tools:** Read/Write on specs; WebSearch for checking how a specific pattern is handled elsewhere, used sparingly and only to borrow the *question*, not copy a design (per the kickoff prompt's analogical-thinking rule).
- **Quality bar:** single source of truth per fact; no entity that secretly means two different things to two departments.

### Database Designer
- **Mission:** best-in-class relational schema design for exactly Ravashing's Build workflow. Normalization where it matters, deliberate denormalization where it's faster and documented as a choice, proper indexing, constraints that actually enforce the business rules (not just comments saying what the rule is), column-level access control where departments share a table.
- **Invoked when:** Phase 6 (data model) and Phase 8 (technical design) in the engineering plan, and any later schema change.
- **Tools:** Read/Write/Edit on schema files and migrations; Bash to run migration tooling; a database-introspection MCP server (see Part 3) once there's a real database to point it at — not before.
- **Quality bar:** every table and column traceable to a confirmed real need; every foreign key and constraint enforced at the database level, not just assumed in application code; no column that silently serves two purposes.

### Backend Engineer
- **Mission:** fast, secure, boring-in-a-good-way backend. Specifically: handles file upload/download (documents, images, and Design's 3D/2D technical files) efficiently — streaming/chunked transfer rather than loading whole files into memory, sensible size limits, background processing for anything slow (large file conversion, thumbnailing) instead of blocking a request.
- **Invoked when:** Phase 9 onward (the actual build), and any time an API or file-handling path is designed or touched.
- **Tools:** Read/Write/Edit/Bash on the backend codebase; a test runner; a database MCP server for query-level work.
- **Quality bar:** every endpoint has server-side auth and role checks (never just a hidden frontend button); input validation on everything; no endpoint that reads an entire large file into memory when streaming is available; meaningful error messages, never a raw stack trace to the user; a documented, tested path for every file type Design/Production/Procurement actually use.

### Frontend Engineer
- **Mission:** a clean, fast, lag-free UI that actually matches how Ravashing's Build departments think, not a generic admin-panel template. No AI slop: no filler copy, no decorative animation that costs performance, no screen that looks done but doesn't work end to end.
- **Invoked when:** Phase 7 (capture design, paper first) and Phase 9 onward (real build).
- **Tools:** Read/Write/Edit on the frontend codebase; a browser-automation MCP (Playwright or similar) for checking real rendered behavior, not just reading code.
- **Quality bar:** every screen reachable in the fewest clicks that make sense; large file previews (3D/2D technical drawings) load progressively, never freeze the UI; every interactive element has a real loading/error/empty state, not a silent blank; accessible (keyboard, color-blind-safe status indicators) by default.

### AI Engineer
- **Mission:** anything that's actually AI/automation inside the product itself (if and when the project calls for it — e.g., smart scheduling suggestions, anomaly flags) as distinct from you (Claude Code) building the product. Keeps a hard line between "AI helping us build this" and "AI features inside what we ship" so the two don't get confused.
- **Invoked when:** Phase 5 (capability proposals) for feasibility input; later only if a genuine AI feature is approved and scoped.
- **Tools:** Read/Write on specs; WebSearch for feasibility checks.
- **Quality bar:** no AI feature proposed just because it's possible — each one ties to a real problem surfaced in discovery, with a plain explanation of what it actually does and where it could be wrong.

### Data Analyst
- **Mission:** makes sure the data model can actually answer the business questions decided in Phase 5 (which vendor is reliable, which job types run over budget, where jobs stall) — not just store records that look complete.
- **Invoked when:** Phase 5 and Phase 6, and later whenever a new report or dashboard is requested.
- **Tools:** Read/Write on specs; a database MCP server for query testing once real/mock data exists.
- **Quality bar:** every business question from Phase 5 has a concrete, nameable query path through the schema before the schema is considered final.

### Data Visualization Specialist
- **Mission:** decides what a Production supervisor or Project Manager actually needs to see at a glance, versus what's decoration. Charts/dashboards only where they answer a real question faster than a table would.
- **Invoked when:** Phase 7 (what each role sees at a glance) and any dashboard/reporting build.
- **Tools:** Read/Write/Edit on frontend dashboard code.
- **Quality bar:** every chart answers a specific named question; no chart that exists because dashboards "should have charts."

### Security Reviewer
- **Mission:** a second pass, specifically adversarial, on auth, access control, secrets, and data handling — someone whose only job is to find what the builder-roles missed, since the same role building a thing is bad at spotting its own blind spots.
- **Invoked when:** before anything touching real data goes live; before the pilot (Phase 10); periodically during the build.
- **Tools:** Read-only on the codebase; Bash for running security linters/scanners.
- **Quality bar:** every finding is concrete (a specific exploitable path), not generic advice; nothing shipped with a known, unaddressed finding without Narendra explicitly accepting the risk.

### QA / Test Engineer
- **Mission:** real tests, not just manual spot-checks — unit tests for business logic, integration tests for the gates that matter (e.g., "no PO without a finalized BOQ"-type rules, once confirmed), and a repeatable way to verify the mock scenarios from Phase 9 actually work.
- **Invoked when:** Phase 9 onward, every time new logic ships.
- **Tools:** Read/Write/Edit/Bash, test runner.
- **Quality bar:** every confirmed business rule has at least one test that would fail if the rule were broken.

### Documentation / Knowledge-Base Keeper
- **Mission:** keeps `NEED/PROGRESS_LOG.md`, `NEED/MEETING_NOTES.md`, `NEED/OPEN_QUESTIONS.md`, and `NEED/TOOLKIT.md` current, compressed, and genuinely useful — not a dumping ground.
- **Invoked when:** end of every working session, without being asked.
- **Tools:** Read/Write/Edit on the `NEED` folder only.
- **Quality bar:** short, timestamped, plain English; someone who lost the whole chat history could reconstruct where things stand from these files alone.

---

## Part 2 — Skills

**Reuse, don't rebuild, what already exists.** Claude Code ships with skills for common file formats (PDF, DOCX, XLSX, PPTX) — use those when Ravashing hands you a real document rather than writing your own parser. Only build a custom skill for something genuinely specific to this project that will recur.

Project-specific skills worth building once a need is real (not before):
- **`ravashing-vocabulary`** — a living glossary of Ravashing's own terms for things (once learned from real people), so every role uses the business's language, not generic CRM/ERP terms. Update it as discovery progresses; load it at the start of any task that touches naming.
- **`discovery-synthesis`** — the method for turning a raw interview/notes dump into the CONFIRMED/ASSUMED structure used across this project. Load when Narendra reports back from a real conversation.
- **`scenario-mock-data`** — the method (not a static dataset) for generating minimal, scenario-complete mock data matching confirmed real structure, per the kickoff prompt's data rules. Load only when building or refreshing mock data, never left loaded by default.

Don't build a skill for something that'll only happen once — just do it inline.

---

## Part 3 — MCP servers / connectors

Don't install any of these until the specific phase needs them. Before installing, search for and verify the current, maintained option — exact packages change over time, so treat the categories below as what to look for, not a fixed install list to copy blindly.

| Category | Needed from phase | What to look for |
| --- | --- | --- |
| Version control | 9 (build) | A GitHub (or whichever host Ravashing/Prateek standardizes on) MCP server, for repo/PR operations beyond what the Bash git CLI already covers. |
| Database | 6 (schema review), 8–9 (build) | A Postgres (or whatever's chosen in Phase 8) MCP server for schema introspection and query testing — install only once a real or mock database exists to point it at. |
| File/document handling | Whenever real documents are shared | Reuse the built-in document skills first; an MCP server here is only needed if Ravashing hands over a file type those don't cover. |
| Design files (3D/2D technical drawings) | Whenever Design's actual file formats are confirmed | Find out the real file format first (ask, don't assume) — then check whether a connector exists for that specific tool (e.g., a CAD or 3D-design platform's MCP/API), rather than guessing generically. |
| Browser automation | 7 (testing paper/real screen flows), 9–10 (QA) | Playwright or an equivalent, for the Frontend Engineer and QA roles to verify real rendered behavior, not just read code. |
| Deployment/hosting | 8 (technical design) onward | Whatever platform gets chosen in Phase 8 — don't pre-install a hosting MCP before that decision is made. |

**Before adding any MCP server:** check it against Ravashing's NDA Annex A approved-tools list (Narendra has this) — don't wire up a connector that isn't on it without flagging that to Narendra first.

---

## Part 4 — Plugins

A plugin is worth installing only when it bundles several things you've already confirmed you need (a skill + an MCP server + a subagent, say) and saves real setup effort — not because it looks comprehensive. Before installing a plugin:
1. Check whether what you actually need is already covered by a built-in skill or a smaller, targeted MCP server.
2. If a plugin does cover a real need, check it's actively maintained and from a trustworthy source before relying on it.
3. Record it in `NEED/TOOLKIT.md` either way, with the reasoning.

Don't install a general-purpose "CRM builder" or "ERP template" plugin at any point — the kickoff prompt's rule stands: this is built for Ravashing specifically, not assembled from a generic template.

---

## How to use this document

Read it now, but don't act on most of it yet — we're still in the research phase (Pro plan, no coding). Right now, the only roles that should actually be doing anything are the **Business Analyst** and **CRM/ERP Domain Specialist** (reviewing discovery output), and the **Documentation Keeper** (maintaining the NEED folder). Everything else activates when its listed phase arrives. Confirm you've understood this document, note it in `NEED/TOOLKIT.md`, and don't install anything else today.
