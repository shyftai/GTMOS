# /rev:customer [account name]

Full 360-degree view of a specific customer account — contract, health, product usage, relationship, support, and commercial signals in one place.

## When to use

- Before any CSM call or QBR
- When an account goes 🔴 Red
- Before a renewal conversation
- When an exec asks "how are we doing with [Company]?"
- Before an expansion pitch

---

## What to do

Load `CUSTOMERS.md`, `CS-CONFIG.md`, `REVENUE.md`, `STRIPE.md`, and `rev-health-scoring.md`.

### Step 1: Identify the account

If the account name is ambiguous, show matching accounts and ask which one. If not found in CUSTOMERS.md, check CRM.md and prompt to add the account.

### Step 2: Pull all data

Compile the 360 view from all available sources:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[COMPANY NAME] — Customer 360
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

┌─ OVERVIEW ────────────────────────────────────────────┐
│                                                        │
│  ARR:          $[X]K    Plan: [Plan name]              │
│  Customer since: [Date] ([X] months)                   │
│  Segment:      [SMB / Mid-market / Enterprise]         │
│  CSM:          [Name]   AE (original): [Name]          │
│  Renewal:      [YYYY-MM-DD] ([X] days)                 │
│                                                        │
│  Health:       [🟢/🟡/🔴/🚨]   Score: [X]/100         │
│  Trend:        [↑ Improving / → Stable / ↓ Declining]  │
│                                                        │
└────────────────────────────────────────────────────────┘

┌─ PRODUCT ENGAGEMENT ──────────────────────────────────┐
│                                                        │
│  Last login:        [X] days ago ([🟢/🟡/🔴])         │
│  DAU/MAU:           [X]%  (benchmark: > 30%)           │
│  Core feature use:  [X]% of seats ([🟢/🟡/🔴])        │
│  Feature adoption:  [X]% of features licensed          │
│  Seats active:      [X] of [X] ([X]%)                  │
│  API calls (7d):    [X]  ([+/-X%] vs. prior week)      │
│  Time to value:     [X] days from signup               │
│                                                        │
│  Notable activity:                                     │
│  [Last key action by a user, if available]             │
│                                                        │
└────────────────────────────────────────────────────────┘

┌─ RELATIONSHIP ────────────────────────────────────────┐
│                                                        │
│  Champions:                                            │
│  • [Name, Title] — [last contact date]                 │
│  • [Name, Title] — [last contact date]                 │
│                                                        │
│  Economic buyer:  [Name, Title]                        │
│  Exec sponsor:    [Name, Title] — [last contact date]  │
│                                                        │
│  Last CSM activity:    [Date] — [Type: call/email/QBR] │
│  Last QBR:             [Date] ([X] days ago)           │
│  QBR status:           [🟢 On schedule / 🔴 Overdue]   │
│  Onboarding complete:  [Yes / In progress / No]        │
│                                                        │
└────────────────────────────────────────────────────────┘

┌─ SUPPORT & SENTIMENT ─────────────────────────────────┐
│                                                        │
│  NPS:           [X]  ([Promoter/Passive/Detractor])    │
│                 as of [Date] — [↑/→/↓ vs. prior]       │
│  CSAT:          [X]/5  (last [X] tickets)              │
│                                                        │
│  Open tickets:  [X]  ([X] P1 / [X] P2 / [X] other)    │
│  Tickets (30d): [X]  ([+/-X] vs. prior 30d)           │
│  Oldest open:   [X] days ([ticket summary])            │
│  Escalations:   [X] in last 90 days                    │
│                                                        │
└────────────────────────────────────────────────────────┘

┌─ COMMERCIAL ──────────────────────────────────────────┐
│                                                        │
│  ARR:           $[X]K  (vs. $[X]K at signing)         │
│  ARR trend:     [+$X] expansion / [$0] stable          │
│  Invoices:      [✓ Current / ⚠ [X] days overdue]      │
│  Contract:      [Annual / Month-to-month]              │
│  Renewal type:  [Auto-renew / Manual]                  │
│  Expansion:     [Eligible — [signal] / Not identified] │
│                                                        │
└────────────────────────────────────────────────────────┘

┌─ SIGNALS & RISKS ─────────────────────────────────────┐
│                                                        │
│  🔴 Risk signals:                                      │
│  [Signal description — why this is a risk]             │
│  [Or: "No critical risk signals"]                      │
│                                                        │
│  🟡 Watch:                                             │
│  [Signal description]                                  │
│                                                        │
│  🟢 Positive signals:                                  │
│  [Expansion signal / engagement increase / NPS up]     │
│                                                        │
└────────────────────────────────────────────────────────┘

┌─ RECOMMENDED ACTIONS ─────────────────────────────────┐
│                                                        │
│  1. [Action] — [Why] — [Who] — [When]                 │
│  2. [Action] — [Why] — [Who] — [When]                 │
│  3. [Action] — [Why] — [Who] — [When]                 │
│                                                        │
└────────────────────────────────────────────────────────┘
```

### Step 3: After the 360 view

Offer follow-on options based on what the data shows:

**If renewal < 60 days:** "Run `/rev:renewal` to build the renewal plan for this account."

**If health is 🔴/🚨:** "Run `/rev:churn-risk` to see this account in the context of all at-risk accounts."

**If expansion signal present:** "Run `/rev:expansion` to model the expansion opportunity."

**If QBR overdue:** "I can draft a QBR agenda for this account. Want me to?"

### Missing data

If a data field is not available (no CS platform connected, or field not synced), display `—` and note at the bottom:

> ⚠️ Missing data: [list fields not available]. Connect [CS platform] to get full 360 visibility. See `references/rev-cs-platforms.md`.
