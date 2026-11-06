# Data flow: what each department updates, and who uses it

Written 6 Nov 2026. **A proposal, not a design; nothing is built.** Everything below is `ASSUMED` unless a line says otherwise: it is our proposal for who should update what, built from what Ali, Prateek, Bashini and Adhiraj told Narendra. Each row ends in a question for the people who do the work. Agency work (Design, the rep, Procurement, Coordination) is named where Build depends on it and left to Prateek.

## 1. Rules

1. **One owner per fact.** Each piece of data has one department that creates it and may change it. Others read it. If two could own it, it is a decision (see the end).

2. **Enter once, at the source.** The person who knows the fact enters it. Nobody retypes it for someone else.

3. **Tap, don't type.** Status is a tap with a time and a name. A photo or a voice note replaces a sentence.

4. **Everything else is built from taps.** The PM's board, Aman's load, the top managers' view and the report to Sales are never typed by hand.

5. **Changes announce themselves.** When data that others rely on changes, everyone who relies on it is told and must tap Seen.

## 2. The stand file: 15 pieces of data

O = owns and updates · U = updates part of it · R = reads · A = must tap Seen when it changes. Columns: Design, Sales & Finance, Procurement & Estimation, Project Coord., PM, Aman, Production Coord., Carpentry, Water Paint, Spray Paint, Electric, Branding (Print, Acrylic, CNC), Transport, Top managers.

| # | Data | What is in it | Owner | How and when it is updated | Today and evidence |
| --- | --- | --- | --- | --- | --- |
| 1 | Stand and job record | stand ID, show, client, space size, build-up, show and dismantle dates, rep, PM, overall status | Sales (rep) creates; Aman adds the PM | Once when the job is won; PM added at allocation | Told. Job number may come from Stand Studio (Decision A) |
| 2 | Design set | 3D, 2D plan, item and AV list (what Build calls the BOQ), special elements, version number, current or replaced | Design | On every upload; each new version replaces the old one | Told (Ali, Prateek). Version control is new |
| 3 | Colour and finish spec | one line per coloured element: Pantone or 'match to render', finish type | Design (Prateek's Build Spec) | Before release; any change is a change record | Prateek. Does not exist today: colours are chased from the client |
| 4 | Artwork, sizes and print proof | artwork files, panel sizes, proof status, client approval, printed or not | Design (artwork and design mock-up); Branding (printed status) | Design uploads; rep records client approval; Branding taps printed, packed, fitted | Told: Branding gets a zip from Design; proof approval by message |
| 5 | Item list and stock status | each item: in stock, reusable or to buy; ordered; arrived; quantity | Design (item list); Procurement (stock status) | Design uploads list; Procurement updates status as it checks, orders and receives | Told: PM sends the BOQ to Procurement; Prateek: Procurement reads the 3D render |
| 6 | Handover pack and release | checklist (technicals, colours, proofs, finish spec, approvals, purchasing list), rep's go-ahead, PM release time | PM | Pieces added by their owners; rep presses go-ahead; PM checks and releases | Prateek's chart and rules |
| 7 | Doubts | stand, drawing, spot on the drawing, photo or voice note, who asked, answer, who answered, time | Raised by the trade; answered by Design | When a trade is unsure; Design answers on the same card | Told: doubts go by phone; one went direct to Design and caused the mistake |
| 8 | Change records | what changed, old and new version, why, who asked (Design, or the rep for a client change), who must see it, who has seen it | Design (design changes); the rep (client change orders) | Created at the moment of change; each department taps Seen | Told: changes reach some departments only. Prateek: no change-order step exists |
| 9 | Task status | per stand and department: not started, working, done, blocked, with time and person; site steps (truck reached, offloaded, platform, electric, structure, putty, paint, fitting, logo) | Each department for its own tasks | One tap per task or step, at the Build area and on site | CONFIRMED (Ali): site steps tracked by PMs in WhatsApp |
| 10 | Photos | mock-up, finish, test, packed, site, snags; each tied to a stand and a step | Whoever does the step | A photo button on the task | Told: photos go to WhatsApp |
| 11 | Show dates, passes and approvals | build-up windows, loading-bay slots, gate and vehicle passes, organiser and venue approvals | Project Coordination | Entered once by Coordination; PM passes on to Transport | Told: arrive by WhatsApp; Prateek: all coordination goes to the PM |
| 12 | Load list, crates and truck status | items per crate, crate labels, scans at loading and offloading, truck booked, left, reached, offloaded | Transport at loading; trades list what they pack | Trades build the list; Transport scans; the PM sees the result | Told: paper load list; truck status by WhatsApp |
| 13 | Furniture and stock allocation | which furniture and stock each stand uses; ready or short; returns | Procurement (Furniture is part of its inventory) | Procurement updates; the PM arranges with Transport (Narendra) | Told; Prateek's note; Furniture division appears in Production (Question 95) |
| 14 | People and equipment (later) | head count per stand per day, own and outside; lights, cables and AV: where they are | Each foreman; Electric for equipment | One count a day per stand; equipment scanned out and in | ASSUMED: labour is recorded almost nowhere (told) |
| 15 | Site steps, snags, sign-off and lessons | walk checklist, snag list, client sign-off, site changes for the invoice, three-tap lessons at close | PM | PM and trades tap on site; rep records the client's sign-off; PM taps lessons at close | Told: handover sheet and lessons are on paper or not done |

## 3. Who updates and who uses it

| Data | Design | Sales | Procure | Coord | PM | Aman | Prod Co | Carp | Water | Spray | Elec | Brand | Transp | Top |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 Stand and job record |  | O |  | R | R | U | R | R | R | R | R | R | R | R |
| 2 Design set | O | R | R | R | R | R | R | RA | RA | RA | RA | RA |  |  |
| 3 Colour and finish spec | O | R |  |  | R |  |  | R | RA | RA |  | RA |  |  |
| 4 Artwork, sizes and print proof | O | U |  |  | R |  |  | R |  |  | R | U |  |  |
| 5 Item list and stock status | O |  | U |  | R |  | R | R | R | R | R | R | R |  |
| 6 Handover pack and release | U | U | U | U | O | R | R | R | R | R | R | R |  | R |
| 7 Doubts | U |  |  |  | R | R |  | U | U | U | U | U |  |  |
| 8 Change records | O | U | R |  | R | R | R | RA | RA | RA | RA | RA | R |  |
| 9 Task status | R | R | R |  | R | R | U | O | O | O | O | O | O | R |
| 10 Photos | R | R |  |  | U | R | U | U | U | U | U | U | U | R |
| 11 Show dates, passes and approvals |  | R |  | O | R | R | R |  |  |  |  |  | R |  |
| 12 Load list, crates and truck status |  |  | R |  | R | R | R | U | U | U | U | U | O |  |
| 13 Furniture and stock allocation |  |  | O |  | R |  |  |  |  |  |  |  | R |  |
| 14 People and equipment (later) |  |  |  |  | R | R | U | U | U | U | U | U | U |  |
| 15 Site steps, snags, sign-off and lessons | R | U |  |  | O | R |  | U | U | U | U | U |  | R |

Short names: Procure = Procurement and Estimation (Agency), Coord = Project Coordination (Agency), Prod Co = Production Coordination, Brand = Printing, Acrylic and CNC (called Branding). Column order as in section 2.

## 4. Stage by stage

| Stage | What happens | Data made, and by whom | Data needed, and from whom | Who is told |
| --- | --- | --- | --- | --- |
| 0 Sell (Agency) | Lead, brief, design loop, estimate, quote, WON | Rep: stand and job record (1). Design: design set (2), colour spec (3), artwork (4), item list (5). Estimation: quote | Aman could see the likely stands by week now (idea: a pipeline view), so load is not a surprise | Nothing reaches Build yet |
| 1 Release | Handover pack checked; rep says go; PM releases | PM: pack and release (6). Coordination: dates and approvals (11). Procurement: purchasing list. Design: final set | Every department sees only its part with NEW and taps Seen; PM sees who has not | Alert to each department with a link |
| 2 Build area: start | Carpentry and Branding start; parts ready, Paint and Electric join | Each trade: task status (9), photos (10). Procurement: stock status (5). Trades: doubts (7) | Procurement answers 'is it in stock' to the PM and trades from the same record | Alert when a part is ready for the next trade |
| 3 Build area: mock-up | Stand mock-up; graphic and logo mock-up; print proof | Carpentry, Paint, Electric: done taps and photos. Branding: printed. Rep: client approval (4). Design: changes (8) | Any change reaches every department on the stand with a Seen tap | Alert on change; red on the PM board until seen |
| 4 Pack and move | Dismantle, label, load list; trucks booked | Trades: load list (12). Procurement: furniture and stock allocation (13). PM: ready to load. Transport: truck booking and scans | Transport reads the list and the dates; the PM reads truck status | Alert to Transport when a stand is ready to load |
| 5 On site: build-up | Truck reached, offload, platform, electric, structure, putty, paint, fitting, logo | PM and trades: site steps (9, 15), photos, doubts (7), head count (14). Rep: client changes (8) | Foremen can see the current drawing without the PM; the PM sees steps from phones | Alert when a step is late against the usual time |
| 6 Show and handover | Walk-through, snags, sign-off, daily checks | PM: snags and sign-off (15). Trades: snag fixes. Rep: client's sign-off | Sales and the top managers read status instead of receiving messages | Alert to the rep when snags are closed |
| 7 Dismantle and return | Dismantle, scrap and keep, return to stock | Transport: crate scans back (12). Procurement: stock updated (5, 13). Electric: equipment back (14) | Procurement sees what came back without a call | Alert to Procurement when items return |
| 8 Close | Handover sheet, final invoice, lessons | PM: closing sheet, lessons (15). Rep and Finance: change records feed the final invoice (8) | Design reads the lessons through the PM | Alert to Design with the lessons |

## 5. Department by department

### Carpentry

*Who: Foreman, 3 senior carpenters, 21 carpenters (HR chart)*

- **Updates:** Task status per part (done, blocked) · photos of mock-up, structure and packed stand · doubts with a mark on the drawing · pack list for the load
- **Uses (from others):** Design set and changes (from Design) · item list and what has arrived (from Procurement) · sizes from Branding · ready-to-load date (from the PM)
- **Used by others:** PM and Aman read progress without asking. Paint and Electric see 'parts ready'. Transport reads the pack list. Branding reads sizes
- **Typing saved:** PM writing Carpentry's progress for them; 'is this the latest drawing?' calls
- **Still unknown:** Who does metal; who leads the three seniors; who gives the daily work (PM or Production Coordination)

### Water Paint

*Who: 9 water painters; head not named (HR chart)*

- **Updates:** Task status per part · photo of the finish · colour used (a tap on the spec line) · site painting on the same card · doubts
- **Uses (from others):** Colour and finish spec per element (Design) · 'part ready for paint' (Carpentry) · colour changes as change records
- **Used by others:** PM and Aman see progress and paint work on site. Spray Paint sees which parts are theirs. Branding sees paint order
- **Typing saved:** Asking for colours; repaint after a late colour change
- **Still unknown:** Who leads; how paint use is recorded; how Water and Spray share one stand

### Spray Paint

*Who: 3 including the head (HR chart)*

- **Updates:** Task status per part · spray area booked · photo of the finish · rare site work
- **Uses (from others):** Colour and finish spec · 'part ready' from Carpentry · changes
- **Used by others:** PM and Aman see load on the spray area; Water Paint sees order
- **Typing saved:** Same as Water Paint; the booth schedule on paper
- **Still unknown:** How often they go on site and who decides; what limits the spray area

### Electric

*Who: Foreman, 1 senior, 5 electricians; AV and lighting outsourced (HR chart, told)*

- **Updates:** Task status (fit, test, power on) · test photo · equipment list per stand · outside AV and lighting booked (who, when) · doubts
- **Uses (from others):** Electrical and AV plan, item list · 'parts ready' · changes · venue power details (Coordination via the PM)
- **Used by others:** PM sees on-site electric status without walking; outside AV companies could see their own stands; Procurement sees equipment needs
- **Typing saved:** PM chasing electric status; the paper test notes
- **Still unknown:** Who books outside AV and lighting; how equipment is tracked after the show

### Branding: Printing, Acrylic, CNC

*Who: Head and 5 (HR chart); Logo assumed to be acrylic*

- **Updates:** Printed, packed, fitted per panel with photo · size check at 'printed' · CNC cut done · acrylic and logo done · doubts on measurements
- **Uses (from others):** Artwork zip, sizes and print proof (Design) · client approval (rep) · panel sizes from Carpentry · lightbox needs from Electric · changes
- **Used by others:** PM reads panel status; Carpentry reads CNC output; Transport reads the pack; the rep sees proof status
- **Typing saved:** Getting the zip by chat; asking Design about measurements; printing twice
- **Still unknown:** Whether the mock-up approval is Design's or theirs; where Logo sits

### Transport (Logistics)

*Who: Head and 6 drivers and loaders (HR chart)*

- **Updates:** Truck booked, left, reached, offloaded (by scan or tap) · crate scans in and out · load list checked · return load
- **Uses (from others):** Pack lists (trades) · show dates, slots and passes (via the PM, from Coordination) · furniture and stock to load (Procurement, via the PM) · ready-to-load
- **Used by others:** PM reads truck status; trades see what is missing; Procurement sees returns
- **Typing saved:** 'Where is the truck?' calls; paper load lists
- **Still unknown:** Who plans the trucks; owned or hired vehicles; whether they work on site

### Project managers (3 plus Aman)

*Who: Each PM owns stands*

- **Updates:** Release (6) · handover pack check · site steps and snags (15) · sign-off · lessons · what the client asked (to the rep) · ready-to-load · passes passed to Transport
- **Uses (from others):** Everything above: the board is built from the others' taps, so the PM types almost nothing
- **Used by others:** Aman, the top managers and the rep read the PM's board and status page. Design reads lessons. Transport reads dates
- **Typing saved:** Per-PM Excel, WhatsApp updates to Sales and the boss, relaying doubts and dates
- **Still unknown:** How many stands per PM; what Aman needs on one screen

### Aman and Production Coordination

*Who: Aman allocates; Production Coordination sits between the PMs and the divisions (2 people)*

- **Updates:** Aman: PM allocation (1), outside labour and outside PMs · Production Coordination (if they allocate daily work): head count per stand (14) and which team is on which stand
- **Uses (from others):** Load board (derived), late alarms, pipeline from Sales, show dates
- **Used by others:** Top managers read Aman's load; HR and Finance could read head counts later
- **Typing saved:** Counting people by hand; guessing load
- **Still unknown:** What Production Coordination actually does (Question 96)

### Agency touchpoints (Prateek's side)

*Who: Design, the rep, Procurement, Coordination*

- **Updates:** Design: design set, colour spec, artwork, changes, doubt answers · Rep: job, go-ahead, client approval, client changes · Procurement: stock and purchase status, furniture · Coordination: dates, passes, approvals
- **Uses (from others):** From Build: status, photos, doubts, site changes, lessons
- **Used by others:** The PM reads all of it; trades read their parts
- **Typing saved:** Forwarding files by chat; telling each department a change
- **Still unknown:** Where the latest design lives (Decision A)

## 6. Built from taps: nobody types these

| View | What it shows | Where it comes from |
| --- | --- | --- |
| PM board | every stand: who has seen what, open doubts, last photo, late alarm | Built from tasks (9), changes (8), doubts (7), photos (10). The PM types nothing |
| Load board | stands per PM and per department by week; crowded weeks; shared machines (CNC router, spray area) | Built from stand records (1) and tasks (9); pipeline from quotes shows next weeks early |
| Top managers' board | stands by colour, next shows, risky stands (late, many changes, many doubts) | Built from the same records; no one writes a report |
| Sales status page | what the rep tells the client: steps done, photos, open snags | Built from tasks and photos; replaces messages upward |
| Late alarm | a step not done within the usual time after the one before it | Built from time stamps; the first version learns the usual times from the first stands |
| Lessons | reasons recorded in three taps at close, grouped by cause, sent to Design through the PM | Built from tasks, changes and doubts of a stand |

## 7. The three brochures as one chain (idea)

Adhiraj's catalogues are Ravashing's own words for what goes into a stand: **Design Elements** (57, relative cost 1 to 5), **Materials** (61, with thickness or width) and **Machines** (45, by trade). If Design's item list uses these names, then: Procurement matches each item to stock without guessing, Estimation can price it, and each element tells us which machines it needs, so Aman can see the CNC router or the spray area filling up before it happens. This is `ASSUMED` until we see whether Design's item lists use the brochure names (Open Question 101). Prices are not in the brochures.

## 8. How this joins Prateek's schema

See `BUILD_SCHEMA.md`: 27 Build tables beside Stand Studio's 41, sharing the Project (RV code) as the stand, plus the event list that decides who sees what.

## 9. What we still do not know (blocks the design)

- What Production Coordination (2 people between the PMs and the divisions) does and writes down (Q96).
- Who does the metal work, and who leads the three senior carpenters (Q100).
- Where the latest design lives, Prateek's system or ours (Decision A, Q88).
- Whether doubts go to Design with the PM copied or through the PM first (Q89).
- Whether the foremen will tap their own progress (Q92).
- Phones, languages and venue Wi-Fi (Q90).
- What each top manager wants to see (Q43).
- How much of the Agency-side data (items 1 to 5, 11, 13) Prateek's system will already hold.
