# /rev:churn-risk

Identify and triage at-risk accounts — rank by ARR at risk, surface root causes, and build intervention plans.

## When to use

- Weekly as part of CS standup
- When NRR drops below target
- After CS health dashboard flags new 🔴 accounts
- Before board or exec reporting on retention

---

## What to do

Load `CUSTOMERS.md`, `CS-CONFIG.md`, `REVENUE.md`, `rev-signals.md`, and `rev-health-scoring.md`.

### Step 1: Scope

Ask: "All at-risk accounts, or focus on a specific segment/CSM/ARR threshold?"

### Step 2: At-risk account list

Pull all 🔴 and 🚨 accounts from CUSTOMERS.md, ranked by ARR at risk:

```
CHURN RISK TRIAGE — [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

At-risk accounts:  [X]
At-risk ARR:       $[X]K ([X]% of total ARR)
vs. last week:     [+/-X accounts / +/-$X ARR]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚨 CRITICAL — Escalate today
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Company] · $[X]K · Score: [X] · Renewal: [X] days
  Root cause: [Primary signal — e.g., "no login 45 days, champion left"]
  Last touch: [X] days ago
  CSM: [Name]
  Status: [No response to last outreach / In crisis / Unknown]
  Required: CSM + VP CS call today

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔴 RED — Intervention this week
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Company] · $[X]K · Score: [X] · Renewal: [X] days
  Root cause: [Primary signal]
  Last touch: [X] days ago · CSM: [Name]
  Plan: [What CSM has committed to do]

[Company] · $[X]K · Score: [X] · Renewal: [X] days
  Root cause: [Primary signal]
  Last touch: [X] days ago · CSM: [Name]
  Plan: [Action]
```

### Step 3: Root cause analysis

For each at-risk account, identify the primary churn driver:

```
ROOT CAUSE BREAKDOWN — All At-Risk Accounts
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Primary churn driver          Count  ARR at risk
─────────────────────────────────────────────────
No product engagement         [X]    $[X]K
Champion / exec departed      [X]    $[X]K
NPS Detractor / poor support  [X]    $[X]K
Seat underutilization         [X]    $[X]K
Payment / billing issue       [X]    $[X]K
Competitor evaluation active  [X]    $[X]K
Company in distress           [X]    $[X]K
Unknown / needs investigation [X]    $[X]K
─────────────────────────────────────────────────
Total                         [X]    $[X]K

Pattern insight:
[One paragraph — what the root cause distribution tells us about systemic issues.
E.g., "60% of at-risk accounts have low product engagement — this is an onboarding
or adoption problem, not a pricing or support problem."]
```

### Step 4: Intervention plan per account

For each 🔴/🚨 account, produce an intervention card:

```
INTERVENTION CARD: [Company Name]
─────────────────────────────────────────────────
ARR:             $[X]K
Health:          🔴/🚨 Score: [X]/100
Renewal:         [Date] ([X] days)
CSM:             [Name]

Risk signals:
  🔴 [Signal 1 — specific, with data]
  🔴 [Signal 2]
  🟡 [Signal 3]

Root cause (primary): [One sentence]

Recovery playbook:
  Step 1 (Day 1–3):   [Specific action — who, what, how]
  Step 2 (Day 4–7):   [Follow-up action]
  Step 3 (Week 2):    [Deeper action if not responding]
  Escalation trigger: [What happens if no response by X]

Success criteria (how we know they're recovering):
  [ ] [Specific measurable criterion — e.g., "user logs in within 7 days"]
  [ ] [Criterion — e.g., "NPS call completed"]
  [ ] [Criterion — e.g., "Renewal conversation started"]

Owner: [CSM name]  |  Manager visibility: [Yes/No]  |  Exec sponsor engaged: [Yes/No]
```

### Step 5: Churn forecast

```
CHURN FORECAST — Next [X] Days
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

At-risk ARR:         $[X]K
Likely to save:      $[X]K (🔴 accounts with active recovery plan)
Likely to churn:     $[X]K (🚨 accounts with no engagement)
Uncertain:           $[X]K

Expected churn MRR:  $[X]K/mo
Implied GRR:         [X]%

To protect $[X]K at-risk ARR, we need:
  [X] accounts to respond to outreach
  [X] accounts to complete onboarding or re-onboarding
  [X] accounts to replace churned champion
```

### Step 6: Systemic actions

If the root cause analysis reveals a pattern, recommend systemic fixes beyond account-level triage:

```
SYSTEMIC RECOMMENDATIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[If product engagement is the top driver]:
→ Review onboarding flow — [X]% of at-risk accounts never reached activation event
→ Implement 14-day no-login alert to trigger proactive CSM outreach
→ Consider in-app reactivation campaign for low-engagement accounts

[If champion departure is top driver]:
→ Implement champion departure monitoring (enrichment decay alert)
→ Build multi-threading into onboarding — require ≥2 contacts on every account
→ Executive sponsor identification mandatory for accounts > $[X]K

[If support/NPS is top driver]:
→ Escalation SLA review — [X] at-risk accounts have P1 tickets > 7 days
→ NPS follow-up call within 24h for Detractors — currently not happening
```

### Step 7: Update CUSTOMERS.md

After triage, update each at-risk account with:
- Updated intervention plan
- Next action and date
- Manager/exec visibility flag

### Hard rules

- Every 🚨 Critical account must have VP CS visibility — no exceptions
- CSM cannot mark an at-risk account as resolved without a health score improvement
- Churn cannot be logged in REVENUE.md until WIN-LOSS.md has a record for the account
- No expansion motion on 🔴/🚨 accounts — route to this workflow first
