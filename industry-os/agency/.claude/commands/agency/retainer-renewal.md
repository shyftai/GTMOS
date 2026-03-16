---
name: agency:retainer-renewal
description: Run the renewal workflow for an existing client
argument-hint: "<workspace-name> <client-name>"
---
<objective>
Run the full renewal workflow for an existing retainer client: health review, QBR trigger, renewal proposal, and follow-up sequence.

Workspace and client name: $ARGUMENTS
</objective>

<execution_context>
@./references/retainer-workflows.md
@./references/client-reporting.md
@./../../.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< AGENCY:OS // RETAINER RENEWAL >>`

2. Load workspace files:
   - `CLIENTS.md` — pull client record
   - `PIPELINE.md` — check renewal pipeline entry
   - `SERVICE-LINES.md` — current and potential services
   - `PRICING.md` — renewal pricing tiers

3. Load retainer-workflows.md.

4. Pull client record from CLIENTS.md:
   - Current services
   - MRR
   - Contract start / end dates
   - Health status (Green / Yellow / Red)
   - Last QBR date
   - Primary contact
   - Account lead

5. Calculate days to renewal:
   ```
   ┌─ RENEWAL STATUS ────────────────────────────────────┐
   │  Client: {name}                                     │
   │  Contract end: {date}                               │
   │  Days remaining: {n}                                │
   │  Current MRR: ${amount}                             │
   │  Health: {Green / Yellow / Red}                     │
   │  Last QBR: {date or "overdue"}                      │
   └─────────────────────────────────────────────────────┘
   ```

6. Check client health — route accordingly:

   **If health = Red:**
   STOP renewal workflow.
   "Client health is Red. Do not start renewal conversation before addressing the health issue. Recommend: escalation call with account lead + senior sponsor first."
   Provide escalation protocol steps from retainer-workflows.md.
   Ask: "Do you want to run the escalation protocol first, or proceed anyway (not recommended)?"

   **If health = Yellow:**
   Flag before proceeding.
   "Client health is Yellow — some friction detected. Recommend addressing [specific issue] before renewal conversation. Renewal may need to include a scope adjustment."
   Ask: "Do you want to proceed with renewal anyway, or resolve the yellow issue first?"

   **If health = Green:**
   Proceed to renewal preparation.

7. QBR status check:
   - If last QBR was >90 days ago: "QBR is overdue. A QBR should happen before the renewal conversation. Recommend running `/agency:qbr-prep {workspace} {client}` first."
   - If QBR is recent (within 30 days): "QBR completed recently — good. Using QBR data to inform renewal."
   - If QBR not yet done but renewal is imminent: "QBR and renewal can be combined — recommend scheduling them together."

8. Ask for renewal scenario (default based on health + results):
   ```
   What renewal approach?
   1. Renew at same scope and price (results on track, client happy)
   2. Expand scope — upsell to next service tier (strong results, growth opportunity)
   3. Adjust scope down (relationship at risk, retain at lower commitment)
   ```
   Default based on health: Green → Option 2 if results strong, Option 1 if steady. Yellow → Option 3 first.

9. Draft renewal proposal (1-page):
   Following retainer-workflows.md template:
   - Results delivered vs. targets this period
   - Continuation services
   - Any scope changes
   - New pricing (from PRICING.md — same or adjusted tier)
   - Sign-by date (today + 14 days)
   - Next step

10. Draft renewal email sequence (3-touch):

    **Email 1 (Day -30 from renewal):**
    Subject: [company] renewal — [month]
    Body: QBR results summary + renewal proposal attached + sign-by date
    Max 100 words.

    **Email 2 (Day -14, if no response):**
    Subject: re: [company] renewal
    Body: Practical follow-up — team capacity confirmation needed, sign-by reminder
    Max 60 words.

    **Email 3 (Day -7, final):**
    Subject: [company] — confirming next steps
    Body: Final practical note — holding team capacity, please confirm by [date]
    Max 40 words.

11. Update PIPELINE.md:
    Add renewal deal to renewal pipeline table:
    - Client, current MRR, renewal date, proposed tier, status = "Renewal outreach sent"

12. Suggest next steps:
    ```
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      >> Send proposal → await response
         If upsell opportunity identified: /agency:upsell {workspace} {client}
         If QBR needed first: /agency:qbr-prep {workspace} {client}
         Next renewal: set calendar reminder for {date - 60 days}

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ```
</process>
