---
name: agency:upsell
description: Identify and run an upsell opportunity for an existing client
argument-hint: "<workspace-name> <client-name>"
---
<objective>
Identify the best upsell opportunity for an existing client and produce a 1-page upsell brief plus client-facing outreach.

Workspace and client name: $ARGUMENTS
</objective>

<execution_context>
@./references/retainer-workflows.md
@./references/pitch-frameworks.md
@./../../.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< AGENCY:OS // UPSELL >>`

2. Load workspace files:
   - `CLIENTS.md` — pull client record
   - `SERVICE-LINES.md` — what the agency delivers
   - `PRICING.md` — pricing tiers
   - `CASE-STUDIES.md` — proof points for upsell pitch

3. Load retainer-workflows.md (upsell triggers section).

4. Pull client record from CLIENTS.md:
   - Current services being delivered
   - MRR
   - Tenure (months since start date)
   - Health status
   - Last QBR results
   - Primary contact name and title

5. Health check:
   If health = Red: STOP.
   "Client health is Red. Upsell is not appropriate until health is resolved. Run `/agency:retainer-renewal` first to address the relationship."

   If health = Yellow: Warn.
   "Client health is Yellow. Upsell may not be well-received. Recommend resolving friction before introducing additional scope."

6. Identify upsell opportunities:

   Scan current services against SERVICE-LINES.md and identify services NOT currently in scope.

   Check upsell trigger checklist (from retainer-workflows.md):

   ```
   ┌─ UPSELL OPPORTUNITY SCAN ──────────────────────────┐
   │                                                     │
   │  Current services: {list}                           │
   │                                                     │
   │  Potential upsells:                                 │
   │  [ ] Performance Marketing — not currently in scope │
   │  [ ] Paid Social — not currently in scope           │
   │  [ ] SEO & Content — not currently in scope         │
   │  [ ] Email & Lifecycle — not currently in scope     │
   │  [ ] Analytics & Attribution — not currently in scope│
   │  [ ] Creative & Brand — not currently in scope      │
   │  [ ] Full-Service Retainer — expand current scope   │
   │                                                     │
   │  Trigger signals detected:                          │
   │  [ ] Client hitting goals 2+ months                 │
   │  [ ] New product / market announced                 │
   │  [ ] Hiring for role agency covers                  │
   │  [ ] Cross-sell from current channel results        │
   └─────────────────────────────────────────────────────┘
   ```

   Ask if additional context is available:
   - "Any recent triggers? New product, new market, key hire, or strong recent results?"
   - "Any gaps in their marketing stack they've mentioned?"

7. Select best upsell service line:
   Rank by:
   1. Direct upsell path from current service (per SERVICE-LINES.md "Upsell to" field)
   2. Strongest case study match
   3. Closest to a recent trigger signal
   4. Highest incremental value

   Confirm selection: "Recommended upsell: [service line]. Reason: [1 sentence]"

8. Match case study:
   Find the most relevant case study from CASE-STUDIES.md for the upsell service.
   Must match: service line + ideally the client's vertical or company type.

   If no case study for this upsell: flag. "No case study for [service] in [vertical]. Recommend adding one before this upsell conversation."

9. Select pricing tier for upsell:
   Based on scope and existing relationship.
   Load PRICING.md — default to Growth tier for upsell recommendations.
   Show: existing MRR + upsell MRR = new total MRR.

10. Draft 1-page upsell brief:
    Following the internal champion doc format from pitch-frameworks.md:

    ```
    [Client name] — [Service Line] Addition

    What you're currently getting:
    [Current services, 2–3 bullets]

    The opportunity we see:
    [1–2 sentences on the gap or growth lever]

    What we'd add:
    [3–4 bullets — specific to their situation]

    Proof it works:
    [One result from CASE-STUDIES.md]

    The investment:
    [Pricing tier from PRICING.md — monthly add-on]

    New total:
    Current: $[MRR] / New: $[MRR + upsell]

    Next step:
    [How they can say yes — call or email reply]
    ```

11. Draft client outreach (2-touch):

    **Message 1 (email or Slack — depends on relationship):**
    Subject: [company] — [service] opportunity
    Tone: peer conversation, not a pitch. Reference their results, surface the gap or opportunity, offer to discuss.
    Max 100 words.

    **Message 2 (7–10 days later, if no response):**
    Short follow-up: "Sharing this in case the timing is better now — also happy to cover it in our next call."
    Max 40 words.

12. Update PIPELINE.md:
    Add upsell deal to pipeline table:
    Stage: 3 — Replied (if following a conversation) or 2 — Contacted (if outreach not yet sent).
    Record: client, upsell service, estimated MRR, outreach date, follow-up date.

13. Suggest next steps:
    ```
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      >> Send upsell brief → discuss in next call or async
         If coming up to renewal: /agency:retainer-renewal {workspace} {client}
         If QBR is due: /agency:qbr-prep {workspace} {client}

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ```
</process>
