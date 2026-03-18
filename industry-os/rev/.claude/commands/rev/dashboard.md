# /rev:dashboard

Full revenue operations dashboard — comprehensive view of all RevOps metrics in one place.

## When to use

- Weekly before pipeline review
- Monthly before revenue report
- Any time you need the full picture fast

---

## What to produce

Load all workspace files and produce the full dashboard:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
REV:OS DASHBOARD — [Workspace Name] — [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

┌─ REVENUE ────────────────────────────────────────────┐
│                                                       │
│  ARR:       $[X]M    MoM: [+/-X%]   YoY: [+/-X%]    │
│  MRR:       $[X]K    vs. target: [+/-X%]             │
│  NRR:       [X]%     GRR: [X]%                       │
│  Churn:     [X]% MRR churn  |  [X] logos this month  │
│                                                       │
│  MRR waterfall (this month):                         │
│  New: +$[X]K  Expansion: +$[X]K                      │
│  Contraction: -$[X]K  Churn: -$[X]K                  │
│  Net: [+/-$X]K                                       │
│                                                       │
└───────────────────────────────────────────────────────┘

┌─ PIPELINE & FORECAST ─────────────────────────────────┐
│                                                       │
│  Quarter: Q[X] [Year] | Week [X] of 13               │
│  Quota: $[X]M  |  Closed: $[X]M ([X]%)               │
│  Remaining: $[X]M  |  Pipeline: $[X]M ([X]× coverage)│
│                                                       │
│  Forecast:                                            │
│  Commit:      $[X]M  ([X]% of quota)                 │
│  Most likely: $[X]M  ([X]% of quota)                 │
│  Upside:      $[X]M  ([X]% of quota)                 │
│                                                       │
│  Pipeline by stage:                                   │
│  Discovery:    [X] deals · $[X]K                     │
│  Demo/Eval:    [X] deals · $[X]K                     │
│  Proposal:     [X] deals · $[X]K                     │
│  Verbal/Legal: [X] deals · $[X]K                     │
│                                                       │
│  Win rate (QTD): [X]%  |  Avg cycle: [X] days        │
│                                                       │
└───────────────────────────────────────────────────────┘

┌─ DATA QUALITY ─────────────────────────────────────────┐
│                                                       │
│  Overall score: [X]%  (target: 85%+)  [🟢/🟡/🔴]    │
│  Tier 1 accounts: [X]%  |  Active deals: [X]%        │
│                                                       │
│  Duplicates:  Accounts: [X]%  |  Contacts: [X]%      │
│  Enrichment:  [X]% coverage (Tier 1)                 │
│  Stripe sync: [✓ Reconciled / ⚠ $[X]K variance]     │
│                                                       │
│  Open issues: [X]  |  Next dedupe run: [Date]        │
│                                                       │
└───────────────────────────────────────────────────────┘

┌─ CUSTOMER HEALTH ───────────────────────────────────────┐
│                                                       │
│  Active customers: [X]   Total ARR: $[X]M             │
│  🟢 [X] accounts · $[X]K   🟡 [X] accounts · $[X]K   │
│  🔴 [X] accounts · $[X]K   🚨 [X] accounts · $[X]K   │
│  At-risk ARR: $[X]K ([X]%)                            │
│                                                       │
│  Renewals <90d: [X] accounts · $[X]K                  │
│    At risk: [X] accounts · $[X]K                      │
│  Expansion pipeline: [X] accounts · +$[X]K potential  │
│                                                       │
│  Top concern: [🚨 Critical accounts / Renewal / None] │
│                                                       │
└───────────────────────────────────────────────────────┘

┌─ WIN/LOSS ──────────────────────────────────────────────┐
│                                                       │
│  Win rate (QTD): [X]%  (vs. [X]% prior quarter)      │
│  Top loss reason: [Reason] ([X]% of losses)           │
│  Top competitor: [Name] — [X] losses                 │
│  Deals without W/L record: [X] (> 14 days old)       │
│                                                       │
└───────────────────────────────────────────────────────┘

┌─ SIGNALS ───────────────────────────────────────────────┐
│                                                       │
│  🔴 Critical ([X]):                                   │
│  [Signal description]                                 │
│                                                       │
│  🟡 Warning ([X]):                                    │
│  [Signal description]                                 │
│                                                       │
└───────────────────────────────────────────────────────┘

┌─ RECOMMENDED ACTIONS ──────────────────────────────────┐
│                                                       │
│  1. [Action] — [Owner] — [Priority]                  │
│  2. [Action] — [Owner] — [Priority]                  │
│  3. [Action] — [Owner] — [Priority]                  │
│                                                       │
└───────────────────────────────────────────────────────┘
```

## After the dashboard

Offer these follow-on commands based on what the dashboard surfaced:
- Data issues flagged → `/rev:health` for detailed audit
- Pipeline coverage concern → `/rev:pipeline` for velocity analysis
- Forecast concern → `/rev:forecast` for scenario modeling
- Win rate concern → `/rev:win-loss` for pattern analysis
- Stripe variance → `/rev:stripe` for reconciliation
- At-risk customers → `/rev:churn-risk` for triage
- Renewal pipeline concern → `/rev:renewal` for full view
- Expansion opportunity → `/rev:expansion` for pipeline
