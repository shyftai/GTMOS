# /rev:report

Generate a revenue operations report — weekly pipeline review, monthly revenue report, QBR, or board pack.

## When to use

- Every Monday: weekly pipeline review
- First week of each month: monthly revenue report
- Start of each quarter: QBR
- Before board meetings: board revenue report

---

## What to do

Load `rev-reporting.md`, `REVENUE.md`, `PIPELINE.md`, `FORECAST.md`, `WIN-LOSS.md`, and `DATA-QUALITY.md`.

### Step 1: Determine report type

Ask: "What report do you need?"

Options:
1. **Weekly pipeline review** — for CRO, VP Sales, sales managers
2. **Monthly revenue report** — for exec team
3. **Quarterly business review** — for exec team and optionally board
4. **Win/loss report** — for CRO, product, marketing
5. **Board / investor report** — for board of directors and investors
6. **Custom** — specify audience and content

### Step 2: Data check

Before generating, verify:
- `REVENUE.md` was updated this period (check last updated date)
- Stripe reconciliation is complete and within tolerance (check `STRIPE.md`)
- Pipeline data is current (check `PIPELINE.md` last updated)

If any check fails: flag the gap and ask if they want to proceed with a caveat or fix the data first.

### Step 3: Generate report

Use the template from `rev-reporting.md` that matches the report type.

Fill every `[X]` with actual data from the workspace files.

**Quality gates before presenting:**
1. All metric definitions stated (or reference `rev-metrics.md`)
2. Attribution model stated for any pipeline/revenue by source
3. Time period explicitly stated
4. Variance vs. prior period explained (not left blank)
5. Stripe reconciliation status confirmed
6. Board report: RevOps sign-off required before sharing (state this explicitly)

### Step 4: Review and distribute

Present the completed report. Ask: "Ready to distribute, or do you want to make edits first?"

**For board reports — hard gate:**
> "This report is formatted for board distribution. Before I finalize, confirm: (1) Stripe reconciliation is complete, (2) definitions match prior board reports, (3) you've reviewed the exec summary. Proceed?"

### Step 5: Log

After report is approved:
- Note in SCRAPE-JOURNAL.md that report was produced and distributed
- If any data was pulled via API to produce the report, log credits used in COSTS.md

---

## Reporting schedule

Remind the user of the standard cadence if they haven't run a report recently:

```
REPORTING SCHEDULE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Weekly pipeline review    Every Monday
Monthly revenue report    First week of month
Win/loss report           Monthly (minimum)
QBR                       First 2 weeks of each quarter
Board report              Per board meeting schedule

Last weekly report:   [Date or "Not found"]
Last monthly report:  [Date or "Not found"]
Last QBR:             [Date or "Not found"]
```
