# Build schema: our tables, and how they join Stand Studio

Written 6 Nov 2026. **A design, not code and not final.** Prateek's schema (`Stand Studio Database Blueprint.html`, read from `prisma/schema.prisma` on 6 Nov, his seventh update) has 41 tables in 8 modules. This file proposes a Build module of 27 tables that sits beside his, follows his conventions, and shares one key: the Stand Studio **Project** (RV code) is the stand. Nothing here is built. Everything is `ASSUMED` until Prateek and the people doing the work have looked at it.

## 1. His conventions, which we follow

- **One module writes only its own tables.** Others read by id (a plain id, no database link). Build does the same: it reads Project, Brief, Exhibition, DesignRevision, EstimateLine and the Store, and writes only Build tables.
- **Insert-only logs** for anything that must not change later (approvals, stock movements). We do the same for change notices, seen taps and task events.
- **Derived fields are never typed.** Status roll-ups come from taps.
- **Stable codes, editable labels.** Step names, block reasons, snag kinds and lesson causes are editable lists.
- **Money is a separate class** and is never shown to roles that must not see it. Build has no money fields at all.
- **Roles per module** (ModuleRole). Build adds module BUILD.

## 2. What we reuse from Stand Studio, and do not rebuild

| His table | How Build uses it |
| --- | --- |
| User, ModuleRole | Logins and roles. Build roles are added with module BUILD. |
| FileAsset | All uploaded files, photos and voice notes. Build links to it through BuildAttachment. |
| Notification | In-app alerts. Build adds new kinds only. |
| ActivityLog | The audit trail. Build writes build: events here, and the alerts are fed from it. |
| StatusOption | Editable lists. Build adds kinds: BUILD_STEP, BLOCK_REASON, SNAG_KIND, LESSON_CAUSE. |
| Setting | Thresholds such as the late-alarm hours and the digest time. |
| Exhibition, Project, Brief | Read only: the show, the stand, the venue, the size. |
| DesignRevision | Read only: the design versions and what changed. |
| PurchaseOrderLine, GoodsReceiptLine, StockMovement | Read only: what is bought for this stand, what arrived, what went out and came back. |

## 3. What Build reads from Stand Studio (by id, read only)

| Table | Fields we need | Why |
| --- | --- | --- |
| Project | id, code (RV-year-number), outcome, technicalStatus (DRAFTING, CHECKING, APPROVED, RE_APPROVAL_REQUIRED), technicalApprovedAt, designerId | The stand's key and the gate: Build can release only when outcome is CONFIRMED and the technical is APPROVED. RE_APPROVAL_REQUIRED is the change signal. |
| Brief, Exhibition | clientName, venue, city, country, standNumber, standSize, clientDeadline; show name, eventFrom, eventTo, venue, hall, organiser | Everything about where and how big, so no one retypes it. |
| DesignRevision + FileAsset | revisionNumber, notes (what changed), uploadedBy, files (technical and per revision) | The design set and its versions. Build adds the Seen tap on top. |
| EstimateLine of the issued revision | elementCode, description, unit, quantity. Never unitCost, price or rates | The item list (the 'BOQ'). Build must see it without money. |
| PurchaseOrderLine, GoodsReceiptLine | projectId, description, quantity, neededBy, deliverTo (STORE or WORKSHOP), accepted | What is bought for the stand and what has arrived. Arrival tells the trade 'your material is here' with no message. |
| StockMovement, StockUnit, StockItem | OUT and BACK by projectId; RA-coded units | What stock and furniture went to the stand and came back. |

## 4. What we ask Prateek to add

| # | Request | Why |
| --- | --- | --- |
| 1 | A Coordination model: show windows (build-up, show, dismantle), loading-bay slots, passes, organiser and venue approvals. Stand Studio has none. Exhibition has only eventFrom and eventTo. | Build needs these dates by stand. Today they come by WhatsApp. |
| 2 | A price-free reading of the estimate lines (a view or an API that leaves out all money fields). | So Build gets the item list without prices. |
| 3 | The rep's go-ahead as a recorded action on the Project (goAheadAt, goAheadById). | The release gate needs it. The chart has it; the schema does not. |
| 4 | Events for technicalStatus changes and for each DesignRevision upload, written to ActivityLog (entity:action). | They are what Build's alerts are built from. |
| 5 | An element-to-trade mapping on EstimatingCode (or let Build keep it). | So a change to a lighting element alerts Electric and not everyone. |
| 6 | Permission for Build to attach files to FileAsset (a link table, or new link columns). | Photos from the floor must live in the same store. |
| 7 | A way to sign in for people without email, or agreement that foremen sign in and crews do not. | User needs an email and a password. Most workers have neither (assumed). |
| 8 | A manual stand: the right to create a Project-less BuildStand with a typed code until Stand Studio is live. | Our plan says Build must not wait for Stand Studio. |

## 5. What Build gives back

| Data | Used by |
| --- | --- |
| BuildStand.buildStatus | The CRM and the rep's status page show where each stand is. |
| Photos, snags, sign-off | The rep's client status page and the final handover. |
| ChangeNotice with billable = yes | Estimating can reprice a client change; Finance sums it into the final invoice. Build holds no price. |
| Lessons | Design, through the PM. |
| Head count and hours (later) | Estimation can learn real hours per element. Hours, not money. |

## 6. Our 27 tables

### A. Join with Stand Studio

| Table | What it is | Fields | Links by id to | Written by |
| --- | --- | --- | --- | --- |
| BuildStand | One row per stand. The key is the Stand Studio Project id (by id). | projectId (unique), source (STAND_STUDIO or MANUAL), manualCode (only if MANUAL), buildStatus (pick), pmUserId, releasedAt, releasedById, goAheadAt, goAheadById | Project, User | PM, Aman |
| HandoverCheck | One row per stand per pack item: is it there? | standId, kind (TECHNICALS, COLOUR_SPEC, PRINT_PROOF, FINISH_SPEC, APPROVALS, PURCHASING_LIST), state (MISSING, PRESENT, WAIVED), sourceType, sourceId, waivedReason, checkedAt, checkedById | DesignRevision, FileAsset | PM; filled by the system when Agency records arrive |
| StandDepartment | Who has to see this stand: one row per stand per department. | standId, department (pick), reason (ELEMENT_RULE or MANUAL), neededFrom, neededBy, foremanUserId | User | System at release, PM edits |
| ElementTrade | Rule: which department a stand element needs (a lighting element needs Electric). | elementCode (an EstimatingCode value), department, note | EstimatingCode | Aman, Narendra |

### B. Changes and doubts

| Table | What it is | Fields | Links by id to | Written by |
| --- | --- | --- | --- | --- |
| ChangeNotice | A change that others must see. Insert-only. | standId, kind (DESIGN_REVISION, CLIENT_CHANGE, SPEC_CHANGE, DATE_CHANGE), designRevisionId, fromNo, toNo, summary, billable (yes/no, no price), severity (MINOR, MAJOR), raisedById, raisedAt | DesignRevision | System from Design uploads; the rep for client changes |
| ChangeSeen | One tap: a department has seen a change. Insert-only. | noticeId, department, userId, seenAt, onBehalfOfCrew (yes/no) | User | Foremen, PMs |
| Doubt | A question on a drawing and its answer. | standId, department, raisedById, designRevisionId, fileAssetId, markX, markY, voiceFileId, text (optional), status (OPEN, ANSWERED, CLOSED), answer, answeredById, answeredAt, changeNoticeId | DesignRevision, FileAsset, User | Trades raise, Design answers |

### C. Tasks and site

| Table | What it is | Fields | Links by id to | Written by |
| --- | --- | --- | --- | --- |
| TaskTemplate | The standard steps for each department and stage. Editable list. | department, stage (BUILD_AREA, SITE, CLOSE), code, label, order, appliesWhen (rule), usualHours (learned later) | none | Aman, heads |
| BuildTask | One step on one stand. | standId, templateId, partLabel, status (NOT_STARTED, WORKING, DONE, BLOCKED), blockReason (pick), startedAt, doneAt, doneById | TaskTemplate | Foremen, PMs (one tap) |
| TaskEvent | Every change to a task. Insert-only. | taskId, kind (START, DONE, BLOCK, UNBLOCK), byId, at, onBehalfOfCrew | User | System |
| BuildAttachment | A photo or voice note tied to a step. | fileAssetId, standId, ownerType (TASK, DOUBT, SNAG, CRATE, TEST, SIGNOFF), ownerId, takenAt, takenById | FileAsset (Stand Studio) | Whoever does the step |
| Snag | A defect found at handover. | standId, department, kind (pick), text (optional), raisedById, status (OPEN, FIXED, CLOSED), closedAt, closedById | User | PM, trades |
| Signoff | Client's sign-off at handover. | standId, signedAt, clientPersonName, method (ON_SCREEN, PAPER_PHOTO), fileAssetId, recordedById | FileAsset, User | Rep or PM |
| Lesson | Why something went wrong or well, in three taps. | standId, department, cause (pick), note (optional), recordedById, recordedAt | User | PM at close |

### D. Logistics and crates

| Table | What it is | Fields | Links by id to | Written by |
| --- | --- | --- | --- | --- |
| Vehicle | A truck or van. | code, kind, ownership (OWN or HIRED), plate, outsideCompanyId, active | OutsideCompany | Transport head |
| TruckTrip | One trip to a venue. | vehicleId, driverCrewId, exhibitionId, plannedAt, departedAt, reachedAt, offloadedAt, returnedAt | Exhibition | Transport |
| TripStand | Which stands ride on a trip. | tripId, standId | none | Transport |
| Crate | One labelled crate with a QR code. | standId, code (CR-year-4 digits, never reused), contents, packedByDepartment, packedAt, tripId, loadedAt, offloadedAt, returnedAt (each with the person) | none | Trades pack, Transport scans |
| StockRequest | Build asks Stand Studio's Store to move something. Build never writes the Store's own movement table. | standId, stockItemId, stockUnitId, kind (OUT or BACK), requestedById, state (REQUESTED, DONE) | StockItem, StockUnit | Transport, Electric, PM |

### E. People and access

| Table | What it is | Fields | Links by id to | Written by |
| --- | --- | --- | --- | --- |
| CrewMember | A person on the floor. A login is optional. | name, department, roleInTeam (FOREMAN, SENIOR, WORKER, DRIVER, LOADER, PM, COORDINATOR), employment (OWN or OUTSIDE), outsideCompanyId, userId (only those who sign in), phone (optional), active | User | Foremen, HR for the names |
| UserDepartment | Which department a login belongs to, and whether they head it. | userId, department, isHead | User | Aman |
| OutsideCompany | A company we hire from. | name, category (LABOUR, AV_LIGHTING, TRANSPORT, PM, PRINT, OTHER), contact, status (ACTIVE, BLOCKED), blockedReason | Supplier? (decision) | Aman |
| HeadCount | People on a stand on a day. | standId, onDate, department, ownCount, outsideCount, outsideCompanyId, enteredById (the latest row wins) | OutsideCompany | Foremen, Production Coordination |
| Resource | A machine or area that can be booked (CNC router, spray area). | code, label, section (from the machine brochure), active | none | Aman |
| Booking | A stand using a resource for a time. | resourceCode, standId, fromAt, toAt, bookedById | none | Foremen, Aman |

### F. Alerts and routing

| Table | What it is | Fields | Links by id to | Written by |
| --- | --- | --- | --- | --- |
| EventRoute | Who sees which event, and how. Editable by management without code. | eventKind, consumer (a department or a role), delivery (INSTANT, DIGEST, NONE), mustAck (yes/no), onlyIfAssigned (yes/no), digestHour | none | Narendra, Aman, top managers |
| Watch | A person who chooses to follow a stand, a department or all shows. | userId, scope (STAND, DEPARTMENT, ALL), standId, kinds, delivery | User | The person |

## 7. Who sees what, when (the event list)

The system writes an event for each change; **EventRoute** says who gets it. Nobody is told about what they do not touch. A stand that has no electrical elements never bothers Electric. Mark: `must tap Seen` means the PM sees who has not.

| Event | Comes from | Who sees it | How | Must tap Seen |
| --- | --- | --- | --- | --- |
| project:confirmed | Agency (rep) | Aman, the PM if assigned | Instant | No |
| technical:approved | Agency (Design) | PM | Instant | No |
| technical:re_approval_required | Agency (Design) | PM, plus assigned departments as a warning | Instant | No |
| design:revision_uploaded | Agency (Design) | Only departments whose elements changed | Instant | Yes: Seen |
| coordination:window_changed | Agency (Coordination) | PM, then Transport through the PM | Instant | No |
| po_line:received | Agency (Procurement) | The department that needs the item; the PM | Digest | No |
| build:released | Build (PM) | Every assigned department, Transport (heads-up), Aman | Instant | Yes: Seen |
| build:doubt_raised | Build (trade) | Design to answer; PM copied | Instant to Design; digest to PM | No |
| build:doubt_answered | Design | The person who asked; the PM; everyone if it became a change | Instant | Yes if it became a change |
| build:task_done | Build (trade) | The next department waiting on it; the PM board | Instant to the next trade | No |
| build:task_blocked | Build (trade) | PM and the department head | Instant | No |
| build:step_late | System | PM first, then Aman after twice the usual time | Instant | No |
| build:trip_moved | Build (Transport scan) | PM; the rep's status page | Digest, instant on reached | No |
| build:signoff | Build or rep | Rep, Finance (for the invoice) | Instant | No |
| build:lesson | Build (PM) | Design, weekly | Digest | No |
| build:headcount_missing | System | The foreman, once at 10:00 | Instant | No |

## 8. How the data moves without extra work

1. **Enter once, at the source.** Stand size, venue, dates and the design set come from Stand Studio. Build forms start pre-filled.
2. **Arrival is automatic.** When Procurement records a delivery against a stand, the trade sees 'your material arrived'. Nobody sends it.
3. **Relevance, not broadcast.** A design change goes only to departments whose elements changed (ElementTrade). Everyone else sees nothing.
4. **Quiet by default.** Routine events are batched into one daily digest. Only things that change someone's current work are instant. People are not told about their own actions.
5. **One nudge, then escalate.** A missing Seen or head count is a reminder once, then it shows on the PM's board. It does not repeat.
6. **Crews do not need logins.** Foremen tap for the crew. A worker is a name on a list.
7. **Works on site.** Taps and photos queue on the phone and send when there is a signal.
8. **The PM is the screen, not the relay.** The board shows who has seen what. The PM does not forward anything.
9. **No second copy.** Build links to Stand Studio's design files and never copies them.

## 9. The burden budget

Targets to test in a pilot, not promises.

| Role | Time and taps | What they do |
| --- | --- | --- |
| Worker (no login) | 0 | The foreman taps for the crew. A worker is a name on a list, not a user. |
| Foreman | under 5 minutes a day (target, to verify) | Looks at My stands once. Taps Done on parts, adds a photo or two, one head count, taps Seen on a change. Never types a status. |
| Project manager | review the board 5 minutes; release check 10 minutes per stand, once | The board is built from others' taps. No weekly Excel, no WhatsApp to Sales and the boss. Site: one tap per step. |
| Aman | glance at the load board; one tap per allocation | Books outside labour in one short form. No gathering of PM lists. |
| Production Coordination (if they allocate daily work) | one head count screen | Enters who is on which stand once; everyone else reads it. |
| Transport | one scan per crate, three taps per trip | Loaded, reached and offloaded come from scans. |
| Design (Agency) | unchanged, plus answering doubts on the card | Uploads as today; the Seen tracking is automatic. |
| Rep (Agency) | go-ahead, client approvals, client changes | One button each; no forwarding. |
| Top managers | 0 | Read only. |

## 10. What else we can digitize

Ranked by value against effort. Evidence is stated.

| What | How | Value | Effort | Who gains | Evidence |
| --- | --- | --- | --- | --- | --- |
| Head count and hours, own and outside | QR or phone check-in per stand per day | High | Low | Planning, safety, cost; HR and Finance read it | ASSUMED: labour is recorded almost nowhere (told) |
| Machine and spray-area booking | Book CNC router, saws, spray area per stand | High | Low | Aman sees crowding before it happens. The machine brochure lists 45 | ASSUMED |
| Crate and truck tracking | QR on crates; scans at load, arrival, offload, return | High | Medium | No 'where is it' calls; shows what is missing at site | ASSUMED |
| Equipment register for lights, cables, AV, tools | Reuse Store's RA-coded units; scan out and in | High | Medium | Reuse and loss; Electric and Procurement | ASSUMED |
| Print and cut queue (Printing, Acrylic, CNC) | File, size check, printed, packed | Medium-high | Low | No double printing | told: printed twice |
| Snags and on-screen sign-off with photos | Snag list by department; client signs on screen | High | Low | Faster handover; feeds the invoice | told: handover sheet on paper |
| Daily site report | Built from taps and photos, no writing | High | Low | Replaces the PM's messages upward | told: WhatsApp updates |
| Outside company register and booking | Who, what, when, status | Medium | Low | Aman; HR; Finance | told: Aman outsources |
| Planned versus actual hours per stand | From tasks and head counts | High later | Medium | Estimation learns real hours (hours, not money) | ASSUMED |
| Pipeline early warning | Quotes sent become likely stands by week | High | Low | Aman plans load before WON | ASSUMED |
| Show calendar and build-up windows | Coordination's dates, once | High | Medium | Agency owns it; Build depends on it | told: dates by WhatsApp |
| Safety and worker permits | Method statements, venue passes, labour permits | Medium-high | Medium | Venues may require them; Coordination and HR | ASSUMED; ask HR and Coordination |
| Damage and return condition | Condition grade on return (Store has this) | Medium | Low | Reuse decisions | told: most is scrapped |
| Scrap versus keep, with disposal record | One tap per item at dismantle | Medium | Low | Scrap cost visible; reuse tracked | told: dismantle and scrap |
| Lessons loop | Three-tap reasons at close, to Design | High | Low | Prateek: the missing loop | Prateek |
| Skills and machine permissions | Who may run CNC or spray | Low-medium | Low | Safety; HR | ASSUMED |
| Client status page | What the rep tells the client, from taps | Medium | Low | Replaces messages | ASSUMED |
| Vehicle log, delivery notes | Trips, fuel, maintenance, driver | Medium | Medium | Transport | ASSUMED |

## 11. Conflicts and decisions

| Topic | What we see | Ask |
| --- | --- | --- |
| BOQ | His EstimateLine is described as 'a line of the bill of quantities', yet his clash note says there is no per-stand BOQ. Both can hold: the BOQ exists in Estimating with money, and Build needs only the price-free item list. Name it once. | Prateek 3 |
| Stand and Project | One Brief per Lead and one Project per Brief. Can one client have two stands at one show? If so, is that two leads? | Prateek 3 |
| Doubts and DesignMessage | DesignMessage is a thread between sales and design. Build's Doubt is a different thread (trade to Design). Keep both; Design answers doubts on the Doubt card, and the rep can open it by link. | Prateek, Aman |
| Outside companies and Supplier | Supplier already has a category. Are outside labour and AV companies Suppliers, or a separate list? One owner only. | Prateek |
| Users with no email | User requires email and password. Foremen can sign in; most workers cannot. We use CrewMember for people without a login. | Prateek, Aman |
| Photos and storage | FileAsset keeps files under one upload folder. Photos from many phones add up fast. Who sizes the storage? | Prateek |
| Money | Estimating holds money fields marked money-class. Build roles must never read them. | Prateek |
| A moving schema | Seven updates so far. We read it through one thin layer and a written list of the fields we depend on, checked at every change. | Narendra, Prateek |

## 12. Order of work (proposal)

1. **Slice 1: one current design and who has seen it.** BuildStand, StandDepartment, ElementTrade, ChangeNotice, ChangeSeen, Doubt, EventRoute. Manual stands first, joined to Stand Studio later.
2. **Slice 2: tasks, photos, boards.** BuildTask, TaskTemplate, TaskEvent, BuildAttachment, HandoverCheck, Watch.
3. **Slice 3: Transport.** Vehicle, TruckTrip, TripStand, Crate, StockRequest.
4. **Slice 4: people and capacity.** CrewMember, HeadCount, OutsideCompany, Resource, Booking.
5. **Slice 5: close-out.** Snag, Signoff, Lesson.

Honest estimate: no build time can be given yet. The slice 1 tables are small; the work is in agreeing the joins with Prateek and in habit.
