# Engineering Plan (Phase 0)

**Status:** APPROVED by Narendra, 5 Nov 2026. We are in Phase 1 and Phase 2. Durations are my judgement, not measured, and they depend mostly on how much time people can give you.

**The problem we are solving** is defined in `PROBLEM_DEFINITION.md`. This plan is the order of work.

**Current mode:** research only, as Prateek instructed. No production code until you say in so many words that we've moved to Max.

## The order I recommend

| # | Phase | What we do | Output | We can move on when | Estimate |
| --- | --- | --- | --- | --- | --- |
| 0 | Plan | This document and the question sheets | Plan, sheets, register | You approve the order | Today |
| 1 | People and ownership | Find out who really exists and who owns what | One-page org map | Every department has a named head and who leads on site is known. **Two questions must be `CONFIRMED` by the people doing the work, not just answered:** (1) Is Logistics a real team of its own, or is its work split across Production and Procurement? (2) Are Project Management and Project Coordination two roles or one? | Under 1 week, alongside 2 |
| 2 | Ground truth | Workflow and data flow **together**. Round 1: one short profile per department (team and heads, who they talk to, what they use, make, pass on and keep). Then draw the connection map. Round 2: real files and fields, only after the map. Also: trace 2–3 finished stands, watch the floor, one site visit | Eight department profiles; one connection map and flow | All eight profiles done and each department has walked through one real stand | 3–4 weeks |
| 3 | Play it back | Show each person what we wrote down; bring disagreements to one table | Workflow marked `CONFIRMED — [who, when]` | Every core step is confirmed or listed as open | 1 week |
| 4 | Stand Studio boundary | Agree with Prateek what Build receives, what it owns, the shared job number, and **the date Stand Studio will actually be live** | Short agreed handoff document, including a manual intake fallback | Prateek signs off, with a real live date or a decision to start on manual intake | About 1 week, overlaps 2–3 |
| 5 | Questions, ideas, scope | Decide what the business needs to be able to answer; propose new capabilities from what we found; check any tool idea against NDA Annex A; pick the first slice | Business questions list, capability proposals, first-slice decision | You and Prateek choose the slice | 1–2 weeks |
| 6 | Data model and roles | On paper: the things we track, one owner per fact, who can see and change what | Plain-English data model, ownership table, access rules | Every row in "Who owns what" in `OPEN_QUESTIONS.md` has a decision | 2 weeks |
| 7 | Capture design | Who enters what, when, on which device; paper sketches tried with real users; what each role sees at a glance | Tested paper flows; fixes back into Phase 6 | Real users say they'd actually do it | 1–2 weeks |
| — | **Readiness review** | I tell you plainly whether we're ready | Go or no-go list | **You say we've switched to Max** | — |
| 8 | Technical design | Database design, tech choice (only tools Annex A allows), hosting, backups, login, mock data scenarios | Technical design note | You approve | About 1 week |
| 9 | Build the first slice | Working end to end, with tests, version control and enforced access. Must run on manual intake if Stand Studio isn't live | Working prototype on labelled mock data | Tests pass and the mock scenarios work | 3–6 weeks |
| 10 | Pilot | One live job, running beside the current process | Fix list, adoption evidence | A real job finishes in it | At least one full job cycle |
| 11 | Rollout and handover | Move real data, add departments, write admin guide, test a backup restore | A system you can run yourself | You can run it without me | Depends on the pilot |

**Honest total:** roughly 9–12 weeks of calendar time to reach the readiness review, because several phases overlap. Add about 1–2 months for the first slice and pilot. The build isn't the slow part. Access to busy people and adoption on the floor are.

## What I changed from your starting shape, and why

1. **Added people and ownership first.** Your workflow questions depend on knowing who does what, and right now we can't say how many departments there are.
2. **Merged workflow and data flow into one phase.** They're the same conversation. Asking a busy supervisor twice wastes goodwill, and you learn the data flow best by following a real job.
3. **Added playback.** Without it, your notes never become confirmed. This is the only step that moves things from `ASSUMED` to `CONFIRMED`.
4. **Added the Stand Studio boundary before modelling.** We can't model data until we know which facts Build owns and which it only receives.
5. **Added business questions, new capabilities and scope before modelling.** The data model must be able to answer the questions asked of it later. It can't cover the entire Build side in the first version either, so a first slice has to be picked.
6. **Put screen design before database design.** You had database first. I'd switch them, in paper form only. A field nobody on the floor will fill in is useless, however neat it looks in the database. Testing capture first keeps the database honest.
7. **Added pilot and rollout.** Your shape ended at "build". Most of these projects fail after that point, when people quietly go back to WhatsApp.

## Discovery method

- **Talk, don't hand out forms.** People are busy. Narendra talks to each department using its own file in `interview_sheets/`, then tells me what he heard in his own words, with who said what. The files are questions for Narendra, not forms for staff.
- **Trace real jobs, not general descriptions.** People describe the process as it should be; a past job shows what really happened.
- **Round 1 asks four things of every department, in its own words:** team and heads, who they talk to and about what, what information they use, make, pass on and keep (and where), and where it goes wrong. Exact data fields wait until the map is drawn. Disagreements between departments show us the ownership conflicts.
- **Collect the real things:** files, photos of whiteboards, WhatsApp group names. Store anything with real names or figures carefully; don't paste client or vendor details into this folder unless you've decided that's fine.
- **Watch, if allowed.** One morning on the floor and one site build-up would likely teach us more than several interviews.
- **New capability ideas** get logged as we hear real problems, and proposed in Phase 5. None of them gets designed before that.

## Analogies

Borrowed patterns (document control, restaurant pass, stripboard, turnaround checklist, dispatch roster, equipment hire) and where they fit or don't are in `PROBLEM_DEFINITION.md`.

## Main risks

| Risk | What we do about it |
| --- | --- |
| Interviews clash with busy show periods. Dubai's season usually runs through the cooler months (`ASSUMED`). | Keep sessions short, use ★ questions, and treat live jobs as a chance to observe. |
| Everything reaches me secondhand from you | Status markers, and every answer tagged with who said it. |
| Generic research gets mistaken for Ravashing fact | The pack can't confirm anything. Its terms get used only if Ravashing uses them too. |
| Heads see this as monitoring | Prateek introduces it. First version should save them time, not only report on them. |
| WhatsApp is the real system today. A tool that asks people to stop using it will fail | Design to work with WhatsApp, not against it. Test in Phase 7. |
| "Everything goes through the PM" is a people rule, and may overload PMs on site | Treat it as a decision for Prateek and Aman. Software only makes the right path easier. |
| Floor staff don't adopt it | Capture testing in Phase 7 and a pilot in Phase 10. Language, device and connectivity get checked first. |
| Stand Studio may not be ready when Build needs it. Reported as still in research and planning (`ASSUMED`; I haven't seen the research pack). If Build waits for it, Build's schedule depends on Agency's | Get a live date in Phase 4. Build's first slice must never depend on Stand Studio: it starts on **manual intake**, meaning someone types in a new job's number, client, show and dates. A direct link can replace that later. |
| Stand Studio's design changes while we design around it | Keep the boundary written down and agreed in Phase 4. |
| We plan around a tool you aren't allowed to use | Check every tool against NDA Annex A before proposing it (see Limits below). |
| Key decisions depend on Prateek's availability | Clear the ★ list in his sheet early. |
| You're the only technical person | Simple tools, plain documentation, tested backups, and a named backup (PT-23). |

## Limits on how we work

- **Match the business, not Prateek's process.** His research pack reportedly uses a heavy multi-agent "judges and panels" process. That's his call for his team. This project is one person working with Claude, so documents stay short and the real check is a Ravashing person confirming something.
- **NDA Annex A.** No tool or platform gets adopted, and no design relies on one, until it's checked against the approved list in Annex A. I haven't seen that list yet.

## Not in this plan

- Any Agency-side design. If something comes up, I'll name it and set it aside.
- Any choice of tools, database or hosting. Those wait for Phase 8.
- Any screen or data design before the phases above.
