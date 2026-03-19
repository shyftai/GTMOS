# /rev:cohort

Cohort analysis — retention, expansion, and churn by acquisition cohort, segment, channel, or plan.

## When to use

- Quarterly deep-dive on retention health
- When NRR or GRR is moving and you need to understand why
- Before investor reporting or board presentation
- When evaluating a new product, pricing tier, or channel

---

## What to do

Load `REVENUE.md`, `STRIPE.md`, and `rev-metrics.md`.

### Step 1: Scope

Ask:
1. Cohort type? (Acquisition month / Quarter / Channel / Segment / Plan / Custom)
2. Metric to track? (Retention % / NRR / GRR / Logo churn / Expansion MRR)
3. Time window? (6 months / 12 months / 24 months / All time)
4. Segment filter? (All customers / SMB / Mid-market / Enterprise / Specific plan)

### Step 2: Data requirements

For cohort analysis, you need:
- Subscription start date per customer
- MRR per customer per month
- Cancellation date (if applicable)
- Segment/plan/channel per customer

State clearly: "This analysis requires customer-level billing data. If your Stripe or billing data isn't connected, I can work from whatever export you provide."

### Step 3: Cohort retention table (MRR-based)

```
COHORT RETENTION — MRR | [Period range]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Cohort    Size  M0    M1    M2    M3    M6    M12
──────────────────────────────────────────────────────
[YYYY-MM] [X]   100%  [X]%  [X]%  [X]%  [X]%  [X]%
[YYYY-MM] [X]   100%  [X]%  [X]%  [X]%  [X]%  [X]%
[YYYY-MM] [X]   100%  [X]%  [X]%  [X]%  [X]%  [X]%
[YYYY-MM] [X]   100%  [X]%  [X]%  [X]%  [X]%  [X]%
──────────────────────────────────────────────────────
Average         100%  [X]%  [X]%  [X]%  [X]%  [X]%

Values > 100% = expansion (good). Values < 100% = churn + contraction.
Benchmark (mid-market SaaS): M12 retention ≥ 105% (NRR) / ≥ 88% (GRR)
```

### Step 4: Key cohort insights

```
COHORT ANALYSIS INSIGHTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Best-performing cohort:  [YYYY-MM] — [X]% M12 retention
  Pattern: [What this cohort has in common]

Worst-performing cohort: [YYYY-MM] — [X]% M12 retention
  Pattern: [What was different — channel, segment, onboarding?]

Trend: [Cohort retention improving / declining / stable]
  [Last 3 cohorts vs. first 3 cohorts of the window]

Early warning (M1 churn):
  [X] cohorts show M1 churn > [X]% — suggests onboarding issue
  [Or: "M1 churn is consistent at [X]% — onboarding stable"]
```

### Step 5: Segment comparison

```
RETENTION BY SEGMENT — M12 NRR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Segment      M12 NRR  M12 GRR  Best cohort  Worst cohort
─────────────────────────────────────────────────────────
SMB          [X]%     [X]%     [YYYY-MM]    [YYYY-MM]
Mid-market   [X]%     [X]%     [YYYY-MM]    [YYYY-MM]
Enterprise   [X]%     [X]%     [YYYY-MM]    [YYYY-MM]

By plan:
  [Plan A]   [X]%     [X]%     [notes]
  [Plan B]   [X]%     [X]%     [notes]

By channel:
  Outbound   [X]%     [X]%     [notes]
  Inbound    [X]%     [X]%     [notes]
  Partner    [X]%     [X]%     [notes]
```

### Step 6: Expansion analysis

```
EXPANSION COHORT ANALYSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

% of cohort that expanded at least once: [X]%
Average time to first expansion: [X] months
Median expansion amount: $[X]K ARR

Expansion triggers (most common):
1. [Trigger] — [X]% of expansions
2. [Trigger] — [X]% of expansions
3. [Trigger] — [X]% of expansions

Best segment for expansion: [Segment] — [X]% expand within 12 months
```

### Step 7: Recommendations

```
RECOMMENDED ACTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Retention:
→ [Specific action based on cohort data]

Expansion:
→ [Action to increase expansion rate in specific segment]

Onboarding (if M1 churn is high):
→ [Action to improve early retention]

Segment strategy:
→ [Prioritization recommendation based on NRR/GRR by segment]
```

**Note on sample size:** Cohort analysis requires meaningful sample sizes per cohort (minimum 10 customers per cohort). Flag if any cohort is too small for reliable conclusions.
