# The Engineering Problem

Written 6 Nov 2026 after Ali's account. Everything is `ASSUMED` unless marked `CONFIRMED`. It will change as departments answer. Facts about how Build works live in `WORKING_UNDERSTANDING.md`; this file says what we're trying to solve and what we still need to learn.

## The problem in one paragraph

Ravashing's Build side runs eight departments across two places (the Build area and the event site), on many stands at once, using people's memory, one Excel file per PM, paper printouts and WhatsApp. Nobody has one current picture of a stand: which design is the latest, how far each department has got, who is working on it, and what's missing. So changes reach some departments and not others, Aman can't see the whole load, and labour (our own and outsourced) isn't recorded. The problem to solve is **one shared, current picture of every stand, from handoff to dismantle, that busy people on the floor and on site will actually keep up to date.**

## What we know goes wrong

- **A real mistake (`ASSUMED`, Narendra's account of Ali):** the carpentry foreman got a design doubt cleared directly with Design and changed the work. The PM wasn't told, so Graphics kept using the old design. A mistake followed.
- **No one owns labour records (`ASSUMED`, Ali):** each department is meant to track its own and outside people, but they're too busy. Only Carpentry and Paint have someone hired for it.
- **No whole-load view (`ASSUMED`):** each PM keeps their own Excel. Aman allocates stands, but how he sees all stands together is unknown.
- **Site status is in WhatsApp (`CONFIRMED — Ali (PM), 5 Nov 2026`):** it can't be searched, summed or learned from.

## The problem, broken into parts

| # | Part | Evidence so far | What we still need to learn |
| --- | --- | --- | --- |
| 1 | **One current design per stand.** Who has the latest, and how does everyone find out when it changes? | The mistake above | Where designs are kept; file types; who at Design answers doubts; how changes are announced |
| 2 | **Stand progress.** At the Build area and on site, per department | PM Excel; WhatsApp; Ali's site steps | What each department tracks today and who sees it |
| 3 | **Load and capacity.** Stands × PMs × departments × machines × show dates | Aman allocates; outsourcing when busy; one PM on 10–20 stands on site | Team sizes, peak months, machine limits (CNC, spray area), who decides priority |
| 4 | **Labour, own and outsourced,** including outside PMs | Not recorded | Who counts, who pays, which companies, hours per stand |
| 5 | **Materials and equipment.** BOQ, stock check, ordering, furniture, scrap | Procurement checks stock; Furniture keeps its own data | How stock is kept; what's reused; money handling |
| 6 | **Site operations.** Many stands per show, trucks, status steps, handover, dismantle | Ali's step list; Logistics moves stands and people | Who guides workers at each stand; how truck status reaches PMs; overseas jobs |
| 7 | **The edge with Agency.** Technicals, BOQ, job number, show dates, changes after handoff | Design releases; PM collects | Formats; what's a "job"; whether Stand Studio will exist in time |
| 8 | **Memory.** Photos, lessons learned, history of how long things take | Board says PM files jobs; WhatsApp is the real archive | Whether any of it happens in practice |

## Added after thinking it through

Things earlier notes missed or only touched:

1. **Furniture is a department with its own data.** Is it part of Build, or a separate unit that serves everyone (and maybe hires out)?
2. **Outsourcing is core, not an exception.** Work, labour and PMs go outside whenever it's busy. Outside people may need briefs, drawings and some access. That has security consequences.
3. **Many stands, one show.** The unit is the stand, but PMs and site work run by show. One PM walks 10–20 stands.
4. **Two places and sometimes abroad.** Build area, site, and overseas. Overseas jobs are an unknown: who builds them?
5. **Machines and spaces are capacity too,** not only people: CNC, panel saw, spray area, drying time.
6. **Equipment and fixtures are probably reused more than stand parts.** "Reuse is rare" came from a talk about stands. Lights, AV, furniture and tools are likely reused or hired. We haven't asked.
7. **Procurement must handle prices,** unlike the trades and PMs. Access rules can't be "nobody in Build sees money".
8. **Part of this is a people rule, not software.** "All talk between departments goes through the PM" is a management decision. Software can make the right path easy; it can't force it. And if the PM is on site, a rule that sends every doubt through the PM may create a new delay.
9. **WhatsApp is the real system.** A tool that asks people to stop using it will fail. One that works with it may win.
10. **Phones, not desks.** PMs walk, foremen are on the floor, and venues often have weak signal. Capture must be quick and may need to work offline.
11. **Team sizes are unknown.** They decide how many users, how many roles and how much training.
12. **Show dates are hard deadlines.** The organiser sets build-up windows, passed on by Project Coordinators (Agency).

## Who uses it, and what each needs at a glance (`ASSUMED`)

| Person | Needs to see |
| --- | --- |
| Foreman | My stands, the latest design for each, what's blocked, who's on my team today |
| PM | All my stands: status by department, last change, what's late. Works on a phone |
| Aman | All stands, all PMs' load, next two weeks, where outside people are needed |
| Procurement | Which stands need what, what's missing, what's on order |
| Logistics | Which stands will be ready when, load lists, venue windows |
| Top Managers | Unknown (ask Prateek) |

## Questions the system should eventually answer

Decided properly in Phase 5. Candidates: which stands are late, and in which department; how many people (own and outside) worked on a stand; how often designs change after handoff; which outsourcers are reliable; how long each site step takes; which departments are the bottleneck in busy months; what a PM's load looks like.

## Constraints

- Research only until Narendra says we're on Max.
- One technical person (Narendra). Keep it small, simple and maintainable.
- Tools and platforms must be on NDA Annex A. Claude is confirmed; the rest we haven't seen.
- Build's first slice must not wait for Stand Studio. It runs on stands typed in by hand.
- People are busy. Whatever we build must take less time than it saves, or it won't be used.

## Patterns borrowed from other businesses

These are questions to test, not designs to copy.

| From | Pattern | Fits Ravashing? |
| --- | --- | --- |
| Construction | **Document control:** a drawing register with revision numbers, and doubts logged as requests for information, with the answer sent to every trade affected | **Strong fit** for part 1. It's exactly the Carpentry/Graphics mistake. The heavy paperwork wouldn't fit, so only the idea: one latest drawing, and one place where doubts and answers are visible |
| Restaurant kitchen | **The pass:** one person sees every table's order across all stations. Each station sees only its tickets | Good for PMs and foremen. A stand is a ticket, each trade is a station. Differs: tickets repeat; stands are one-offs |
| Film production | **Stripboard schedule:** one strip per scene, moved around a board | Possible for Aman's load view: one strip per stand across weeks |
| Aircraft turnaround | **Timed checklist:** a fixed list of steps with times | Ali's site steps are almost this. A tap per step gives timings for free |
| Field service and event staffing | **Dispatch board and roster:** who's working where today, own and agency staff | Good for part 4. Differs: the work is not repeated |
| Equipment hire | **Check-out and check-in** with condition and owner | Good for lights, AV, furniture and tools, if reuse is as common as we now suspect |
| Job-shop manufacturing | **Finite capacity loading** and visible work-in-progress | Fits machines and paint area. Doesn't fit repeat-product planning ("MRP") |
| Warehouse | **Pick list** from an order | The BOQ stock check is close to this |

## Ideas to hold for Phase 5

A fuller version, with each department's view, the hand-over flow and the list of lags and wasted effort, is in `IMPROVEMENT_IDEAS.md` (6 Nov 2026).

Not designed, not promised. Each must tie to a real problem we've confirmed.

1. A "latest design" mark per stand, with a note to everyone on that stand when it changes.
2. A **stand board:** a row per stand, a column per department, with simple states such as not started, working, done, blocked.
3. A **site walk checklist** on the phone: one tap per step, with a time. Replaces most status messages.
4. A **labour count per stand per day,** own and outside, in the fewest taps possible.
5. A **load view for Aman:** stands per PM, crowding by week, show dates.
6. A **change log:** each design change, who asked, who was told. Counting changes also shows which stands are risky.
7. A **photo log** per stand: mock-up, site, dismantle. It replaces WhatsApp as the archive.
8. An **equipment register,** only if reuse turns out to be common.

Any tool idea gets checked against Annex A before it goes further.

## What success might look like (`ASSUMED`; ask Prateek)

- No more mistakes from out-of-date designs.
- A PM can see all their stands' status in one place, in under a minute.
- Aman can see load across PMs and the next two weeks.
- Own and outside labour per stand is recorded.
- A foreman or PM spends only a few minutes a day entering anything.

## Out of scope

Agency (Sales, Design, Estimation, Accounts, HR work), Project Coordinators and organiser submissions, pricing, and any tool choice before Phase 8. We name them when they come up, and set them aside.

## Decisions that belong to people, not to us

1. The communication rule: who may talk to Design, and who must be told afterwards (Prateek, Aman).
2. Who owns labour records and outside-company lists (Aman, heads).
3. How much overload the PM can take before the rule becomes a problem.
4. Whether outside people may use our system.

## What we need to learn first (round 1)

Before any detail about fields, one profile per department:
1. Who heads it, and how big the team is (own, outside, normal, busiest).
2. Which departments they talk to, and what for.
3. What information they use, make, pass on and keep, and where (paper, Excel, WhatsApp, phone).
4. Where it goes wrong, and when they're busiest.

Then we draw the connection map and flow, and only then ask for the real files and fields. Questions are in `interview_sheets/`, one file per department.

**Suggested order:** Graphics (you're going there now), then Carpentry (largest, and where the mistake began), Procurement, Logistics, Paint, Electric, Furniture, then Aman and other PMs. Prateek's questions can go in any gap.
