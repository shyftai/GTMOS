# /rev:renewal

Renewal pipeline management — track all upcoming renewals, assess risk, plan outreach, and ensure nothing slips through the cracks.

## When to use

- Weekly as part of CS operations
- Monthly renewal pipeline review with VP CS and CRO
- When a renewal is flagged as at-risk
- 90 days before quarter end to assess renewal forecast

---

## What to do

Load `CUSTOMERS.md`, `CS-CONFIG.md`, `REVENUE.md`, and `rev-metrics.md`.

### Step 1: Scope

Ask: "Time window? (Next 30 days / Next 60 days / Next 90 days / This quarter / Custom)"

### Step 2: Renewal pipeline view

```
RENEWAL PIPELINE — Next [X] Days | [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total renewals:    [X] accounts · $[X]K ARR
At risk:           [X] accounts · $[X]K ARR ([X]%)
On track:          [X] accounts · $[X]K ARR ([X]%)
Not yet engaged:   [X] accounts · $[X]K ARR ([X]%)

Forecast:
  Expected to renew:   $[X]K ([X]%)
  Expected to churn:   $[X]K ([X]%)
  Uncertain:           $[X]K ([X]%)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
RENEWALS BY DATE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚨 OVERDUE (renewal date passed — no renewal logged):
┌─────────────────┬───────┬───────┬──────────┬─────────┐
│ Account         │ ARR   │ Health│ CSM      │ Action  │
├─────────────────┼───────┼───────┼──────────┼─────────┤
│ [Company]       │ $[X]K │ [🔴]  │ [Name]   │ Escalate│
└─────────────────┴───────┴───────┴──────────┴─────────┘

🔴 NEXT 30 DAYS:
┌─────────────────┬───────┬───────┬────────────┬──────────────────┐
│ Account         │ ARR   │ Health│ Renew date │ Status           │
├─────────────────┼───────┼───────┼────────────┼──────────────────┤
│ [Company]       │ $[X]K │ 🔴    │ [Date]     │ At risk — [reason]│
│ [Company]       │ $[X]K │ 🟢    │ [Date]     │ On track         │
└─────────────────┴───────┴───────┴────────────┴──────────────────┘

🟡 31–60 DAYS:
[Same format]

🟢 61–90 DAYS:
[Same format]
```

### Step 3: Renewal motion status

For each renewal, check whether the correct motion has been activated based on days remaining:

```
RENEWAL MOTION AUDIT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Standard renewal timeline:
  90 days out: Initial renewal conversation initiated
  60 days out: Renewal call completed; pricing discussed
  45 days out: Contract draft shared
  30 days out: Legal/procurement engaged (enterprise)
  14 days out: Signed or escalated

Accounts behind motion:
  [Company] — [X] days to renewal — missing: [step not taken]
  [Company] — [X] days to renewal — missing: [step not taken]

→ These accounts need immediate CSM action.
```

### Step 4: Renewal risk assessment

For at-risk accounts, produce a risk card:

```
RENEWAL RISK CARDS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Company Name] · $[X]K · Renews [Date] · [X] days
─────────────────────────────────────────────────
Health:       🔴 Score: [X]/100
Risk factors: [Factor 1] | [Factor 2] | [Factor 3]
Last CSM touch: [X] days ago
Champions:    [Name] — [still at company? Y/N]
Conversation: [Not started / In progress — [status]]

Recommended action:
  [Specific action this week — who does what by when]

Likelihood to renew: [High / Medium / Low]
ARR outcome:
  Best case:  Full renewal at $[X]K
  Base case:  Renewal at $[X]K (downsell to [plan])
  Worst case: Churn — $[X]K ARR at risk
```

### Step 5: Expansion at renewal

Flag accounts where renewal is an opportunity to expand:

```
EXPANSION AT RENEWAL
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Company] · Renews [Date] · Current: $[X]K
  Expansion signal: [At seat limit / Feature adoption high]
  Expansion potential: +$[X]K
  Pitch: [One-line expansion angle]

Total expansion opportunity at renewal: $[X]K
```

### Step 6: Renewal forecast

```
RENEWAL FORECAST — [Period]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ARR up for renewal:    $[X]K
Expected to renew:     $[X]K ([X]%)
  At current ARR:      $[X]K
  With expansion:      $[X]K (if expansion converts)
Expected to churn:     $[X]K ([X]%)
Uncertain:             $[X]K ([X]%)

Net renewal ARR:       $[X]K
Implied GRR:           [X]%
Implied NRR (incl. expansion): [X]%
```

### Step 7: Action plan

```
RENEWAL ACTION PLAN — This Week
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚨 TODAY:
[ ] [Account] — [CSM] — [Specific action]

🔴 THIS WEEK:
[ ] [Account] — [CSM] — [Specific action]
[ ] [Account] — [CSM] — [Specific action]

🟡 THIS MONTH:
[ ] [Account] — [CSM] — [Specific action]
```

Update `CUSTOMERS.md` with renewal status changes after each session.

### Hard rules

- Renewal outreach must start at 60 days minimum — flag immediately if not started
- No renewal marked "churned" without a win/loss record created in WIN-LOSS.md
- Any renewal > $50K that is at-risk requires VP CS visibility before the renewal date
- Overdue renewals (date passed, no signed contract) escalate to VP CS + CRO same day
