# /rev:expansion

Surface and prioritize expansion opportunities from customer health and product usage data — seat additions, plan upgrades, and cross-sell.

## When to use

- Monthly expansion pipeline review
- When NRR is below target and you need to find growth in the base
- When a CSM asks "which of my accounts should I pitch an upgrade to?"
- Before a QBR — identify expansion to bring to the conversation

---

## What to do

Load `CUSTOMERS.md`, `CS-CONFIG.md`, `REVENUE.md`, and `rev-metrics.md`.

### Step 1: Scope

Ask:
1. Segment filter? (All / SMB / Mid-market / Enterprise / Specific CSM)
2. Minimum ARR threshold? (Default: all accounts)
3. What types of expansion? (Seat expansion / Plan upgrade / Cross-sell / All)

### Step 2: Identify expansion signals

Scan all accounts in CUSTOMERS.md for expansion signals:

**Signal 1: Seat utilization ≥ 90%**
- Account is at or near seat capacity
- High intent signal — they're actively using what they have
- Pitch: additional seats or enterprise tier

**Signal 2: Feature adoption ≥ 80% on current plan with premium features gated**
- Account has adopted most available features and is hitting plan limits
- Pitch: upgrade to unlock premium features they're clearly ready for

**Signal 3: Health 🟢 (score > 75) + NPS ≥ 8 (Promoter)**
- Customer is happy and engaged — highest conversion rate for expansion
- Pitch: any expansion; this is the right time to ask

**Signal 4: Product usage growing > 20% MoM**
- Account's usage is accelerating — they're getting more value
- Pitch: ensure they have capacity to continue growing; proactive upgrade conversation

**Signal 5: Multiple departments using the tool (breadth signal)**
- Product is spreading organically within the company
- Pitch: enterprise/company-wide deal; bring in economic buyer for broader license

**Signal 6: Account grew (hired) > 20% in last 6 months**
- Organizational growth means more potential users
- Pitch: headcount-based expansion; update seat count to match new team size

**Signal 7: QBR showing strong ROI metrics**
- Account can quantify the value — makes expansion conversation easy
- Pitch: double down on what's working; expand to adjacent team or use case

### Step 3: Expansion pipeline view

```
EXPANSION PIPELINE — [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total expansion opportunities: [X] accounts
Identified expansion ARR:      $[X]K
Expected to convert (3 months): $[X]K (est. [X]% conversion)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TIER 1 — READY TO PITCH NOW (🟢 health + strong signal)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

┌──────────────┬────────┬────────┬──────────────────────┬──────────┐
│ Account      │ ARR    │ Signal │ Pitch                │ Potential│
├──────────────┼────────┼────────┼──────────────────────┼──────────┤
│ [Company]    │ $[X]K  │ Seats  │ Add [X] seats        │ +$[X]K   │
│ [Company]    │ $[X]K  │ Usage  │ Upgrade to [Plan]    │ +$[X]K   │
│ [Company]    │ $[X]K  │ NPS 9  │ Company-wide license │ +$[X]K   │
└──────────────┴────────┴────────┴──────────────────────┴──────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TIER 2 — DEVELOP FIRST (🟡 health — fix, then expand)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Company] · $[X]K · Signal: [X] · Block: [What needs to improve first]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TIER 3 — NOT YET (🔴 health — do not pitch expansion)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Company] · $[X]K · Has expansion signal but health is 🔴 — resolve first
```

### Step 4: Expansion card per Tier 1 account

For each Tier 1 account, produce a ready-to-use expansion card:

```
EXPANSION CARD: [Company Name]
─────────────────────────────────────────────────
Current ARR:      $[X]K  ([Plan name])
Expansion type:   [Seat expansion / Plan upgrade / Cross-sell]
Signal:           [Specific signal — e.g., "92% seat utilization"]
Potential ARR:    +$[X]K → Total: $[X]K
Health:           🟢 Score: [X]/100  NPS: [X]

Conversation context:
  "[Tailored 2-sentence pitch based on their specific usage]"

Timing:
  Best moment: [At renewal / Post-QBR / Now — at usage limit]
  Owner: [CSM name]
  Suggested contact: [Champion name, Title]

Next step:
  [Specific action — e.g., "Schedule an upsell call with Sarah (Head of RevOps) using QBR ROI slide deck"]
```

### Step 5: Expansion forecast

```
EXPANSION FORECAST — Next 90 Days
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Pipeline identified:       $[X]K
Tier 1 (likely to convert): $[X]K  [X]% est. conversion
Tier 2 (possible):          $[X]K  [X]% est. conversion
Expected expansion MRR:     +$[X]K/mo

vs. expansion target:  $[X]K target  |  Gap: $[X]K
```

### Step 6: Update CUSTOMERS.md

Mark identified expansion accounts as "Expansion Eligible" and update with:
- Expansion signal
- Potential ARR
- CSM assigned to expansion conversation
- Target date for conversation

### Anti-pattern: never pitch expansion to 🔴 accounts

If a 🔴 account has an expansion signal (e.g., seat limit), do not pitch expansion. Fix the health problem first. Pitching expansion to an unhappy customer accelerates churn.

Flag these separately and route to the churn-risk workflow instead.
