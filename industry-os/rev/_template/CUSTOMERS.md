# Customer Health Registry

Single source of truth for all active customer accounts — health status, ARR, renewal pipeline, and CS ownership. Update at minimum weekly. Source of truth for `/rev:cs-health`, `/rev:renewal`, `/rev:churn-risk`, and `/rev:expansion`.

---

## Health Summary

**Last updated:** [Date]
**Total active customers:** [X]
**Total ARR:** $[X]M

| Status | Count | ARR | % of ARR |
|--------|-------|-----|----------|
| 🟢 Green | [X] | $[X]K | [X]% |
| 🟡 Yellow | [X] | $[X]K | [X]% |
| 🔴 Red | [X] | $[X]K | [X]% |
| 🚨 Critical | [X] | $[X]K | [X]% |

**At-risk ARR (🔴 + 🚨):** $[X]K ([X]% of total ARR)

---

## Customer Registry

One row per account. Update health status and score weekly.

| Account | ARR | Health | Score | NPS | Last login | CSM | Renewal | Days |
|---------|-----|--------|-------|-----|-----------|-----|---------|------|
| [Company] | $[X]K | 🟢 | [X] | [X] | [X]d ago | [Name] | [YYYY-MM-DD] | [X] |
| [Company] | $[X]K | 🟡 | [X] | [X] | [X]d ago | [Name] | [YYYY-MM-DD] | [X] |
| [Company] | $[X]K | 🔴 | [X] | [X] | [X]d ago | [Name] | [YYYY-MM-DD] | [X] |

---

## Renewal Pipeline (Next 90 Days)

| Account | ARR | Renewal date | Health | Risk | CSM | Status | Last touch |
|---------|-----|-------------|--------|------|-----|--------|-----------|
| [Company] | $[X]K | [Date] | 🟢 | Low | [Name] | On track | [Date] |
| [Company] | $[X]K | [Date] | 🟡 | Medium | [Name] | In conversation | [Date] |
| [Company] | $[X]K | [Date] | 🔴 | High | [Name] | At risk | [Date] |

**Renewal ARR at risk:** $[X]K ([X] accounts flagged)

---

## Expansion Pipeline

Accounts flagged for expansion conversations.

| Account | Current ARR | Expansion signal | Potential | CSM | Status |
|---------|------------|-----------------|-----------|-----|--------|
| [Company] | $[X]K | At seat limit | $[X]K | [Name] | Conversation started |
| [Company] | $[X]K | High feature adoption | $[X]K | [Name] | Pending QBR |

**Identified expansion ARR:** $[X]K

---

## Churn Incidents (This Quarter)

| Account | ARR lost | Churn date | Reason | Warning signs missed | W/L recorded |
|---------|----------|-----------|--------|---------------------|--------------|
| [Company] | $[X]K | [Date] | [Reason] | [Signs] | [Yes/No] |

---

## Health Score Methodology

**Platform:** [Gainsight / ChurnZero / Vitally / Planhat / Manual]
**Score range:** 0–100
**Status thresholds:** 🟢 75–100 | 🟡 50–74 | 🔴 25–49 | 🚨 0–24
**Weights:** Product [X]% | Relationship [X]% | Support [X]% | Commercial [X]% | Org [X]%
**Last calibrated:** [Date]
**Reference:** `references/rev-health-scoring.md`

---

## Individual Account Records

For key accounts, maintain a full record below. Use `/rev:customer [account]` to generate.

```
### [Company Name]

ARR:            $[X]K
Health:         🟢/🟡/🔴 | Score: [X]/100
Renewal date:   [YYYY-MM-DD] ([X] days)
CSM:            [Name]
Segment:        [SMB / Mid-market / Enterprise]
Plan:           [Plan name]

Product engagement:
  Last login:         [X] days ago
  DAU/MAU:            [X]%
  Core feature use:   [X]% of seats
  Feature adoption:   [X]%

Relationship:
  Last CSM touch:     [Date] ([X] days ago)
  Last QBR:           [Date] ([X] days ago)
  Champions:          [Name, Title] | [Name, Title]
  Exec sponsor:       [Name, Title]

Sentiment:
  NPS:                [X] (as of [Date])
  Open tickets:       [X]
  Last CSAT:          [X]/5

Commercial:
  Seat utilization:   [X]% ([X] of [X] seats active)
  Payment status:     ✓ Current / ⚠ Overdue
  Expansion signal:   [Description or "None"]

Notes:
  [CSM notes, context, open issues]

Renewal plan:
  [What needs to happen for this account to renew]
```
