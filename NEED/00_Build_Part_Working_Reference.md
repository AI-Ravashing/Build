# Ravashing — Build Part: Working Reference
### Scope: Narendra's task only. Agency is Prateek's — not built or specced here.

**Status:** Working notes from Prateek's walkthrough (4 Nov 2026) plus relevant findings from his research team's "Ops Handover Pack" (shared same day). Nothing below is confirmed by the actual Build department heads yet — that starts tomorrow. Treat every "assumed" line as a question, not a fact.

---

## 1. The two halves of Ravashing

| | Agency | Build |
| --- | --- | --- |
| Departments | Marketing, Sales, HR, Design, Estimation, Finance | Production, Procurement, Logistics |
| Owned by | Prateek (building his own system, "Stand Studio" / internal codename `my-erp`) | **Narendra — this is your task** |
| Bridge between the two | **Project Management** — sits on the Build side operationally, but is the only department that touches both halves |

Prateek is not asking Build department heads anything himself. That's explicitly your job, starting tomorrow. His research team's notes (the zip) cover Production and Project Management in real depth, but were researched generically — nobody on Ravashing's actual Build side has confirmed any of it yet.

## 2. The Agency workflow (context only — not your build, but shapes what Build receives)

1. Sales sources leads itself today (existing/old clients, exhibitions, offline campaigns, referrals) — Marketing is too new to be a real lead source yet.
2. Sales reaches out to the client (call or email).
3. Client gives a brief (requirements) — sent to Design, usually over WhatsApp, email, or Google (Docs/Drive).
4. Design produces a concept, sent back to Sales.
5. Sales shows the client, gets feedback, loops back to Design. Repeats until the client accepts the design.
6. Once design is confirmed, Estimation does a cost estimation.
7. Estimation's number goes to the Top/Sales Manager, who adds markup.
8. That marked-up number goes to Finance, who builds the formal quotation (with VAT).
9. Quotation goes back to Sales, who presents it to the client.
10. Client accepts → deal closes. If not, negotiation continues until a final quotation is agreed.

**This is the handoff point into Build:** once the client accepts the final quotation, the job crosses from Agency into Build.

## 3. The Build workflow, as Prateek described it

1. **Project Management** carries the design printouts and technical documents from Agency into **Production**. This is the literal bridge moment — the first thing that happens on the Build side.
2. **Production** builds the stand/mockup at the workshop — carpentry, painting, printing, electrical work, and other trades Narendra doesn't yet have full visibility into (to be confirmed in discovery).
3. **Procurement** runs in parallel — sources and buys materials/items needed for the build, and also manages inventory (Prateek's wording: "the items, inventory also will be taken care by procurement").
4. Once the stand is ready, it's carried to the event site and built on-site. **Logistics** is described as the department that handles this transport/site-building process — but **Production also has a second role here**: Prateek said Production does both (a) manufacture at the workshop and (b) build it on-site. This overlap between Production's on-site role and Logistics is explicitly unclear and worth asking about directly.
5. After the event, the stand is dismantled. Reusable items/brand elements are kept. **Project Management keeps track of this** (what's reusable, what's dismantled, what happens to it).
6. **Procurement owns items/inventory** more broadly — not just the initial purchase but ongoing inventory tracking.
7. **Project Management is "mostly a helping system"** — in Prateek's words, most of the actual work in Build is physical labor (Production), some is information work (Procurement, Logistics), and "the most work is for project management" — meaning PM's job is to make each department's progress visible and shareable, not necessarily to do the physical/informational work itself.

## 4. Open structural questions this raises (confirm with real people, not assumptions)

1. **Is Logistics a distinct department with its own head, or is "logistics" work actually split across Production (on-site building) and Procurement (inventory/items)?** Prateek named three Build departments (Production, Procurement, Logistics) when describing the org, but when describing the actual workflow, he attributed warehousing/inventory to Procurement and on-site building to Production — Logistics' distinct ownership wasn't pinned down. Ask this directly, early.
2. **What exactly does Production's on-site team do vs. a separate on-site/installation function?** Is it the same people who built it in the workshop, or a dedicated site crew?
3. **Where does Project Management's authority end?** It "carries" documents and "keeps track of" dismantled/reusable items — is it purely a coordination/visibility layer, or does it also make decisions (e.g., prioritizing which job gets the workshop first)?
4. **Does Project Management have any Agency-side visibility**, or does it only pick up the job at the moment of handoff (post-quotation-acceptance)?
5. **Top Managers see everything** across both Agency and Build — but what exactly do they look at, and how often? This matters for designing any dashboard/reporting layer later.

## 5. Useful signal from Prateek's research team (background only — read with caution)

Prateek shared a research pack (`Ops Handover Pack v2`) covering two of the three Build departments in real depth: **Production (called "MRP" internally)** and **Project Management**. A few things worth carrying into your own discovery interviews, translated out of the research team's internal jargon:

- **There's a difference between "Project Management" and "Project Coordination"** that Prateek's team is careful about. *Project Coordination* = dealing with the event organiser/venue directly (submitting stand drawings, electrical plans, labour passes, getting venue approvals). *Project Management* = internal coordination of the job across design, production, and site (timelines, status, handoffs, snags, sign-off). The research pack explicitly excludes Project Coordination ("it stays with RAVS" — presumably an existing team/system already handling organiser submissions). **When you interview Ravashing's "Project Management" people, confirm which of these two things they actually do** — it's easy to conflate them, and they may currently be the same person doing both without the distinction being named.
- **Production's own research suggests two genuinely separate sub-functions worth asking about separately:** (a) workshop fabrication, split by trade/section (carpentry, metal, paint, graphics, electrical), each producing/consuming its own labour hours and materials; and (b) site work (build-up, handover, dismantle) — which may be the same supervisor/crew or a different one.
- **A recurring theme: numbers (cost, pricing, margin) stay out of Production and Project Management entirely** — they deal in quantities, hours, dates, and status, never money. If real Build department heads describe themselves handling pricing decisions, that's a meaningful deviation worth flagging back to Prateek.
- **QC / pre-build checks matter:** the research repeatedly surfaces a "ready to release" gate — material/drawings must be confirmed before a work order starts, and a quality check happens before something leaves the workshop.
- **Status should ideally be computed, not typed** — i.e., "on track / at risk" should come from real dates and milestones already being tracked elsewhere, not from someone manually updating a status field. Worth noting as a design goal for later, not something to ask department heads about directly.
- **The research explicitly treats reusable stock/warehouse ownership as Procurement's, not a separate Logistics function** — this directly supports open question #1 above.

**Caution:** this research was done generically (from open-source ERP/PM tools' public documentation and vendor pages), not from anyone at Ravashing. Prateek's own README says plainly: use what helps, ignore the rest. It's a vocabulary and idea source, not a source of facts about how Ravashing's Build side actually works today.

## 6. What's next

Starting tomorrow: interview the real Production, Procurement, and Logistics department heads (and whoever currently does "project management" work, even informally) on what they actually do, what data they create/use/share, and how they track it. See `01_Build_Discovery_Questions.md` for the structured question set built for exactly this.
