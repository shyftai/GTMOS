---
name: agency:portfolio
description: Show a portfolio overview of all clients and new business pipeline
argument-hint: "<workspace-name>"
---
<objective>
Display a portfolio dashboard: active clients, MRR, health, pipeline, alerts, and recommended actions.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./../../.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< AGENCY:OS // PORTFOLIO >>`

2. Load workspace files:
   - `CLIENTS.md` — full client roster and health
   - `PIPELINE.md` — new business pipeline by stage
   - `COSTS.md` — current month spend

3. Calculate summary metrics:
   - Total active clients (count)
   - Total MRR (sum)
   - Green / Yellow / Red client counts
   - Pipeline count and estimated total value
   - Renewals within 60 days
   - QBRs overdue (last QBR > 90 days ago)
   - Stale pipeline deals (same stage > 30 days)

4. Display portfolio dashboard:

   ```
   ┌─ AGENCY PORTFOLIO ──────────────────────────────────────┐
   │                                                          │
   │  Active clients:  {count}      MRR: ${total}/mo         │
   │  New pipeline:    {count}      Est. value: ${total}      │
   │  At-risk clients: {count Red}  Renewals due (<60d): {n} │
   │                                                          │
   │  Health breakdown:                                       │
   │  Green: {n}  Yellow: {n}  Red: {n}                      │
   │                                                          │
   └──────────────────────────────────────────────────────────┘
   ```

5. Display client table:

   ```
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   ACTIVE CLIENTS
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

   | Client | Industry | Services | MRR | Since | Health | Next QBR | Renewal |
   | ------ | -------- | -------- | --- | ----- | ------ | -------- | ------- |
   {render from CLIENTS.md — sorted by health: Red first, Yellow, Green}
   ```

6. Display pipeline by stage:

   ```
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   NEW BUSINESS PIPELINE
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

   | Stage | Count | Est. Value | Stale (>30d) |
   | ----- | ----- | ---------- | ------------ |
   {render from PIPELINE.md summary table}

   Pipeline total: ${total}
   ```

7. Display alerts — prioritised by urgency:

   ```
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   ALERTS
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   ```

   **Red health clients (action required):**
   For each Red client:
   "[!] {client} — Red health — escalation call recommended
        Action: /agency:retainer-renewal {workspace} {client}"

   **Renewals due within 60 days:**
   For each renewal:
   "[!] {client} — renewal in {n} days — start workflow now
        Action: /agency:retainer-renewal {workspace} {client}"

   **QBRs overdue:**
   For each client where last QBR > 90 days:
   "[~] {client} — QBR overdue ({n} days since last QBR)
        Action: /agency:qbr-prep {workspace} {client}"

   **Stale pipeline deals:**
   For each deal in same stage >30 days:
   "[~] {company} — {stage} — {n} days stale — follow-up needed"

   **Yellow health clients (watch):**
   For each Yellow client:
   "[~] {client} — Yellow health — review before renewal conversation"

   If no alerts: "No alerts — portfolio looks healthy."

8. Display action recommendations (top 3):

   Based on alerts, show the three highest-priority actions:

   ```
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   RECOMMENDED ACTIONS
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

   1. [Highest priority — e.g. "Red client needs escalation call"]
      >> /agency:retainer-renewal {workspace} {client}

   2. [Second priority — e.g. "Renewal due in 18 days"]
      >> /agency:retainer-renewal {workspace} {client}

   3. [Third priority — e.g. "QBR overdue for 2 clients"]
      >> /agency:qbr-prep {workspace} {client}
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   ```

9. Referral opportunity check:
   Count Green-health clients.
   If Green clients > 0 and last referral ask > 90 days ago (or never):
   "You have {n} Green-health clients. Consider running referral activation.
   >> /agency:referral {workspace}"

10. Monthly metrics summary (if end of month):
    If run within 5 days of month end, show:
    - MRR this month vs. last month (from CLIENTS.md)
    - New clients added this month
    - Clients churned this month
    - Net MRR movement
</process>
