---
name: agency:qbr-prep
description: Prepare a quarterly business review for an existing client
argument-hint: "<workspace-name> <client-name>"
---
<objective>
Prepare a QBR for an existing retainer client: deck outline, executive summary, upsell opportunities to surface, and speaker notes.

Workspace and client name: $ARGUMENTS
</objective>

<execution_context>
@./references/retainer-workflows.md
@./references/client-reporting.md
@./../../.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< AGENCY:OS // QBR PREP >>`

2. Load workspace files:
   - `CLIENTS.md` — pull client record and last QBR data
   - `SERVICE-LINES.md` — active services
   - `PRICING.md` — for renewal or upsell pricing references

3. Load retainer-workflows.md and client-reporting.md.

4. Pull client record from CLIENTS.md:
   - Active services
   - MRR
   - Contract start / end date
   - Last QBR date (and summary if available)
   - Next QBR date
   - Health status
   - Primary contact name, title, preferred comms

   Display:
   ```
   ┌─ QBR CONTEXT ───────────────────────────────────────┐
   │  Client: {name}                                     │
   │  Services: {list}                                   │
   │  MRR: ${amount}                                     │
   │  Tenure: {months}                                   │
   │  Contract renewal: {date} ({n} days away)           │
   │  Last QBR: {date}                                   │
   │  Health: {Green / Yellow / Red}                     │
   └─────────────────────────────────────────────────────┘
   ```

5. Ask for performance data (one block at a time):

   **Block 1: Results this quarter**
   "What were the key metrics this quarter vs. targets? Provide as many as you have:"
   - [Channel 1] metric: target vs. actual
   - [Channel 2] metric: target vs. actual
   - Overall pipeline/revenue contribution (if available)
   - Any anomalies or notable events

   **Block 2: What worked**
   "What are the top 2–3 things that worked well this quarter?"

   **Block 3: What didn't work**
   "What are the 1–3 things that underperformed or didn't work? What was the root cause?"

   **Block 4: Next quarter goals**
   "What are the priorities for next quarter? Any changes to strategy or focus?"

   **Block 5: Upsell / expansion check (optional)**
   "Any opportunities to expand scope or add a service line? (Check retainer-workflows.md for triggers)"

6. Generate QBR deck outline (12-slide structure):

   ```
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   QBR DECK — {client name} — {Quarter Year}
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

   Slide 1: Cover
   - Client name, quarter, agency name

   Slide 2: Executive summary
   - Overall status: {On track / Behind / Ahead}
   - 3-bullet TL;DR
   - [Draft executive summary here]

   Slide 3: Results vs. targets
   | Metric | Target | Actual | Status |
   | ... | ... | ... | ... |

   Slide 4: {Channel 1} breakdown
   - What we ran
   - What happened
   - Key insight

   Slide 5: {Channel 2} breakdown
   ...

   Slide 6: {Channel 3} breakdown (if applicable)
   ...

   Slide 7: Top wins this quarter
   1. [Win — specific + quantified]
   2. [Win]
   3. [Win]

   Slide 8: What didn't work (honest)
   - [Issue] — root cause — what we're changing

   Slide 9: Learnings and optimisations
   | Observation | Action | Expected impact |

   Slide 10: Next quarter plan
   - Priority 1: [specific initiative]
   - Priority 2: [specific initiative]
   - Priority 3: [specific initiative]

   Slide 11: Next quarter targets
   | Metric | Target |

   Slide 12: Questions / open items
   - [Pre-populate with any known open items]
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   ```

7. Draft executive summary (Slide 2):
   3-bullet TL;DR. Honest and direct — acknowledge both wins and gaps.

8. List upsell opportunities to surface in QBR (if applicable):
   Based on retainer-workflows.md upsell trigger checklist.
   "Consider raising these upsell opportunities during the QBR:
   - [Opportunity 1 — trigger / service / angle]
   - [Opportunity 2]"
   Note: only surface if health is Green. Do not raise upsell in a Yellow or Red QBR.

9. Provide speaker notes for key slides:
   For slides 3 (results), 8 (what didn't work), and 10 (next quarter):
   Brief talking points for the account lead to use during the call.

10. Renewal check:
    If contract renewal is within 60 days:
    "Contract renewal is {n} days away. This QBR should lead into the renewal conversation.
    After the QBR call: run `/agency:retainer-renewal {workspace} {client}`."

11. Pre-send checklist:
    ```
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    QBR PRE-SEND CHECKLIST
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    [ ] All metrics are accurate (checked against tool dashboards)
    [ ] Underperformance is acknowledged — not spun
    [ ] Next quarter targets are specific and agreed
    [ ] Deck is max 12 slides
    [ ] Sent to client 3 days before the call
    [ ] Calendar invite sent with agenda
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ```

12. Update CLIENTS.md:
    Update: `Next QBR: [date]` after the call is scheduled.
    Update: health status after the call is completed.

13. Suggest next steps:
    ```
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      >> Send deck 3 days before call
         After QBR call: update CLIENTS.md with health status
         If renewal within 60 days: /agency:retainer-renewal {workspace} {client}
         If upsell opportunity identified: /agency:upsell {workspace} {client}

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ```
</process>
