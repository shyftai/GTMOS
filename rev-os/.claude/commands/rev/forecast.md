# /rev:forecast

Build and update the revenue forecast — weighted pipeline, rep commits, scenario modeling, and coverage assessment.

## When to use

- Weekly forecast update (every Monday/Tuesday)
- Start of quarter — set the baseline
- Mid-quarter — assess trajectory and flag gaps
- Before board or exec reporting

---

## What to do

Load `FORECAST.md`, `PIPELINE.md`, `rev-forecast-models.md`, and `rev-benchmarks.md`.

### Step 1: Determine mode

Ask: "Is this a weekly update, a fresh quarterly forecast, or a specific scenario analysis?"

- **Weekly update** → pull latest pipeline data, compare to prior week, update FORECAST.md
- **Quarterly forecast** → full model build with all three methods
- **Scenario analysis** → model upside/downside scenarios

### Step 2: Collect inputs

For weekly update, ask:
1. Any significant deals that moved this week (new, closed, lost, slipped)?
2. Any rep commit changes?
3. Any changes to the pipeline that affect the number?

For quarterly forecast, ask:
1. What is this quarter's quota?
2. Are there any deals expected to close that aren't in the CRM yet?
3. Any known risks (deals at risk, holidays, end-of-quarter dynamics)?

### Step 3: Build the forecast

**Method 1: Weighted pipeline**
```
WEIGHTED PIPELINE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Stage              Count  Value    Probability  Expected
──────────────────────────────────────────────────────────
Discovery          [X]    $[X]K    [X]%         $[X]K
Demo/Evaluation    [X]    $[X]K    [X]%         $[X]K
Proposal           [X]    $[X]K    [X]%         $[X]K
Verbal/Legal       [X]    $[X]K    [X]%         $[X]K
Rep Commit         [X]    $[X]K    [X]%         $[X]K
──────────────────────────────────────────────────────────
Total              [X]    $[X]M    weighted     $[X]M
```

**Method 2: Rep commit (with reliability adjustments)**
```
REP COMMITS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Rep        Commit   Reliability   Adjusted
─────────────────────────────────────────
[Rep 1]    $[X]K    +[X]%         $[X]K
[Rep 2]    $[X]K    -[X]%         $[X]K
[Rep 3]    $[X]K    baseline      $[X]K
─────────────────────────────────────────
Total      $[X]M                  $[X]M
```

### Step 4: Produce the RevOps Call

Cross-reference both methods. Identify the RevOps Call:

```
FORECAST CALL — Q[X] [Year] | Week [X] | [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Quota:           $[X]M

Commit:          $[X]M   ([X]% of quota)
Most Likely:     $[X]M   ([X]% of quota)
Upside:          $[X]M   ([X]% of quota)

RevOps Call:     $[X]M   ([X]% of quota)

vs. last week:   [+/-$X]
Reason for change: [One line explanation]

COVERAGE
Pipeline:        $[X]M ([X]× remaining quota)
  [🟢 Sufficient / 🟡 Thin / 🔴 Insufficient]

KEY RISKS
• [Deal] — [Rep] — $[X]K — [Risk description]
• [Deal] — [Rep] — $[X]K — [Risk description]

KEY UPSIDE
• [Deal] — [Rep] — $[X]K — [Upside scenario]
• [Deal] — [Rep] — $[X]K — [Upside scenario]

RECOMMENDATION
[One paragraph — what actions would improve the forecast]
```

### Step 5: Update FORECAST.md

Log the weekly call in the forecast history table. Never revise prior entries.

### Step 6: Distribute (if configured)

If Slack is configured in workspace.config.md, offer to post the forecast summary to the configured channel.

**Hard gate:** Before sharing externally, confirm: "This forecast will be shared with [CRO/CFO/Board]. Confirm?"

### Coverage check (mandatory before every forecast)

Before presenting any forecast, calculate and state coverage:
- Coverage = total open pipeline ÷ remaining quota
- If coverage < 2.5×: flag prominently as "PIPELINE RISK — coverage is below minimum threshold"
- Never omit the coverage check from a forecast output
