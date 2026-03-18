# /rev:today

Daily RevOps action briefing — what you need to know and do today.

## When to use

Run at the start of every workday. Gets you oriented in under 2 minutes.

---

## What to do

Load workspace files, then produce the daily briefing in this format:

```
REV:OS DAILY BRIEFING — [Day, Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

QUARTER STATUS: Q[X] [Year] | Week [X] of 13
ARR:      $[X]M  |  MRR: $[X]K  |  vs. target: [+/-X%]
Forecast: $[X]M ([X]% of quota) — [Commit / Most Likely]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔴 URGENT — DO TODAY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[List only actionable, time-sensitive items. Max 5.]

[ ] [Action] — [context]
[ ] [Action] — [context]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 PIPELINE ALERTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Deals stalled > 21 days, overdue close dates, single-threaded high-value deals]
[Or: "No pipeline alerts today"]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🗃️ DATA ALERTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Stripe sync issues, data quality drops, enrichment expiring on active deals]
[Or: "No data alerts today"]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💰 REVENUE ALERTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Renewals due within 60 days without action, churn-risk accounts, payment failures]
[Or: "No revenue alerts today"]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📅 THIS WEEK'S CALENDAR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[ ] Monday: Pipeline review with sales team
[ ] Tuesday: Forecast call with CRO/CFO
[ ] [Other scheduled RevOps activity]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Run /rev:dashboard for the full picture
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Source files

Pull data from:
- `REVENUE.md` — ARR/MRR snapshot
- `PIPELINE.md` — pipeline status and alerts
- `FORECAST.md` — current quarter forecast
- `DATA-QUALITY.md` — data quality score and known issues
- `STRIPE.md` — reconciliation status
- `WIN-LOSS.md` — recent win/loss entries (for context)

If any file is missing or empty, note the gap and suggest running `/rev:onboard`.
