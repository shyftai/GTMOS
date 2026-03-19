# /rev:cs-health

Fleet-level customer health dashboard — health distribution across all accounts, at-risk MRR, renewal pipeline, and CS team performance.

## When to use

- Weekly CS team standup
- Monday morning alongside /rev:today
- Before monthly revenue review
- When CRO or CEO asks "how are our customers doing?"

---

## What to do

Load `CUSTOMERS.md`, `CS-CONFIG.md`, `REVENUE.md`, and `rev-health-scoring.md`.

### Produce the full fleet health dashboard:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CUSTOMER HEALTH DASHBOARD — [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

┌─ FLEET OVERVIEW ──────────────────────────────────────┐
│                                                        │
│  Active customers:  [X]   Total ARR: $[X]M            │
│  NRR (LTM):         [X]%  GRR (LTM): [X]%            │
│                                                        │
│  Health distribution:                                  │
│  🟢 Green:    [X] accounts · $[X]K ARR ([X]%)         │
│  🟡 Yellow:   [X] accounts · $[X]K ARR ([X]%)         │
│  🔴 Red:      [X] accounts · $[X]K ARR ([X]%)         │
│  🚨 Critical: [X] accounts · $[X]K ARR ([X]%)         │
│                                                        │
│  At-risk ARR (🔴 + 🚨):  $[X]K ([X]% of total ARR)   │
│  vs. last week:          [+/-X accounts / $X ARR]      │
│                                                        │
└────────────────────────────────────────────────────────┘

┌─ ACCOUNTS NEEDING ATTENTION ──────────────────────────┐
│                                                        │
│  🚨 CRITICAL — contact today:                          │
│  [Company] · $[X]K · [Score] · [Top risk signal]      │
│  [Company] · $[X]K · [Score] · [Top risk signal]      │
│                                                        │
│  🔴 RED — contact this week:                           │
│  [Company] · $[X]K · [Score] · [Risk] · CSM: [Name]   │
│  [Company] · $[X]K · [Score] · [Risk] · CSM: [Name]   │
│  [Company] · $[X]K · [Score] · [Risk] · CSM: [Name]   │
│                                                        │
│  🟡 YELLOW — watch list:                               │
│  [Company] · $[X]K · [Score] · [Declining signal]     │
│  [Company] · $[X]K · [Score] · [Declining signal]     │
│                                                        │
└────────────────────────────────────────────────────────┘

┌─ RENEWAL PIPELINE (Next 90 Days) ─────────────────────┐
│                                                        │
│  Renewals due:  [X] accounts · $[X]K ARR              │
│  At risk:       [X] accounts · $[X]K ARR (🔴/🚨)      │
│  On track:      [X] accounts · $[X]K ARR (🟢)         │
│  No conversation started (> 60d away): [X]            │
│                                                        │
│  Next 30 days:                                         │
│  [Company] · $[X]K · [Health] · [Status]              │
│  [Company] · $[X]K · [Health] · [Status]              │
│                                                        │
└────────────────────────────────────────────────────────┘

┌─ EXPANSION PIPELINE ──────────────────────────────────┐
│                                                        │
│  Expansion-eligible accounts: [X]                     │
│  Identified expansion ARR:    $[X]K                   │
│                                                        │
│  Top opportunities:                                    │
│  [Company] · $[X]K ARR · [Signal] · [Potential +$X]   │
│  [Company] · $[X]K ARR · [Signal] · [Potential +$X]   │
│                                                        │
└────────────────────────────────────────────────────────┘

┌─ PRODUCT ENGAGEMENT SUMMARY ──────────────────────────┐
│                                                        │
│  Avg DAU/MAU across fleet:     [X]%                   │
│  Accounts with no login > 14d: [X] ([X]% of fleet)   │
│  Accounts with no login > 30d: [X] ([X]% of fleet)   │
│  Avg seat utilization:         [X]%                   │
│  Avg feature adoption:         [X]%                   │
│                                                        │
└────────────────────────────────────────────────────────┘

┌─ CS TEAM WORKLOAD ────────────────────────────────────┐
│                                                        │
│  [CSM Name]:                                           │
│    Accounts: [X] · At-risk: [X] · Renewals (90d): [X]│
│    ARR managed: $[X]K · At-risk ARR: $[X]K            │
│                                                        │
│  [CSM Name]:                                           │
│    Accounts: [X] · At-risk: [X] · Renewals (90d): [X]│
│    ARR managed: $[X]K · At-risk ARR: $[X]K            │
│                                                        │
│  Overloaded CSMs (> [X] accounts / $[X]K ARR): [X]   │
│                                                        │
└────────────────────────────────────────────────────────┘

┌─ RECOMMENDED ACTIONS ─────────────────────────────────┐
│                                                        │
│  1. [Action] — owner: [CSM/VP CS] — by [Date]        │
│  2. [Action] — owner: [Name] — by [Date]             │
│  3. [Action] — owner: [Name] — by [Date]             │
│                                                        │
└────────────────────────────────────────────────────────┘
```

### Trend analysis (weekly)

If prior week's dashboard data is available in CUSTOMERS.md, show movement:

```
WEEK-OVER-WEEK MOVEMENT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Accounts improved (🔴→🟡 or 🟡→🟢): [X] · $[X]K ARR
Accounts declined (🟢→🟡 or 🟡→🔴): [X] · $[X]K ARR

New 🔴 Red this week:     [X] — [Company names]
Recovered to 🟢 Green:    [X] — [Company names]
New at-risk ARR:          [+/-$X]K
```

### After the dashboard

Offer follow-on commands:
- `/rev:churn-risk` — deep triage on at-risk accounts
- `/rev:renewal` — build the full renewal pipeline
- `/rev:expansion` — expand the expansion pipeline
- `/rev:customer [account]` — 360 view of a specific account
