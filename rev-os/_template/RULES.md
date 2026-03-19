# Workspace Rules

Workspace-level rules for this RevOps instance. These extend (not override) the hard rules in REVOS.md.

---

## Data Rules

- All CRM records must have a lead source set — no null sources on any contact or opportunity
- Opportunities must be updated at least weekly during active pursuit — stale deals are flagged in pipeline review
- Duplicate records must be resolved within [X] business days of detection
- Enrichment runs must be logged in SCRAPE-JOURNAL.md with source, cost, and field coverage
- No manual edits to ARR fields without RevOps approval — all ARR changes must reconcile to Stripe

---

## Forecast Rules

- Rep commits are due by [Monday 9 AM / other] each week
- Close dates must reflect the rep's honest best estimate — "end of quarter" is not a close date
- Any deal where the close date has passed without closing must be updated or marked Closed Lost
- Forecast calls are not shared externally until RevOps and CRO have both approved
- Historical forecast numbers are never revised — document variances in FORECAST.md

---

## Reporting Rules

- Monthly revenue report is due by [day X of the month] each month
- Stripe reconciliation must be completed before any revenue number is shared with finance or board
- All reports must state the metric definitions and attribution model used
- Board-level reports require RevOps lead sign-off before sharing

---

## Access and Permissions

- CRM admin access: RevOps team only
- Stripe read access: RevOps team + Finance
- Stripe write access (plan changes, refunds): [Name] only
- Data warehouse access: RevOps team + data team
- Forecast data: RevOps + CRO + CFO

---

## Workspace-Specific Exceptions

[Document any exceptions to standard rules that apply to this specific workspace.]

- [Exception description — rationale — approved by — date]
