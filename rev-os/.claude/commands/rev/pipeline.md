# /rev:pipeline

Pipeline velocity and health analysis — stage conversion, deal age, bottleneck identification, and coverage assessment.

## When to use

- Weekly before pipeline review meeting
- When forecast is uncertain and you need to understand the pipeline math
- When win rate or cycle time is changing
- When building a pipeline generation plan

---

## What to do

Load `PIPELINE.md`, `FORECAST.md`, `rev-metrics.md`, and `rev-benchmarks.md`.

### Step 1: Scope

Ask: time window? (Current quarter / Next quarter / Rolling 90 days / Specific period)

### Step 2: Pipeline snapshot

```
PIPELINE SNAPSHOT — Q[X] [Year] | [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

COVERAGE
Quota:           $[X]M
Closed to date:  $[X]M ([X]%)
Remaining:       $[X]M
Pipeline:        $[X]M ([X]× remaining quota)
Weighted (exp):  $[X]M ([X]× remaining quota)

Status: [🟢 Sufficient / 🟡 Thin / 🔴 Insufficient]

PIPELINE BY STAGE
┌──────────────────────┬───────┬──────────┬──────────────┬──────────────┐
│ Stage                │ Count │ Value    │ Avg age      │ Benchmark    │
├──────────────────────┼───────┼──────────┼──────────────┼──────────────┤
│ SQL / Discovery      │ [X]   │ $[X]K    │ [X] days     │ < [X] days   │
│ Demo / Evaluation    │ [X]   │ $[X]K    │ [X] days     │ < [X] days   │
│ Proposal             │ [X]   │ $[X]K    │ [X] days     │ < [X] days   │
│ Verbal / Legal       │ [X]   │ $[X]K    │ [X] days     │ < [X] days   │
├──────────────────────┼───────┼──────────┼──────────────┼──────────────┤
│ TOTAL                │ [X]   │ $[X]M    │ [X] days avg │              │
└──────────────────────┴───────┴──────────┴──────────────┴──────────────┘
```

### Step 3: Conversion and velocity analysis

```
CONVERSION RATES (QTD vs. Prior Quarter)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Stage → Stage          QTD     Prior Q   Δ        Benchmark
──────────────────────────────────────────────────────────────
SQL → Discovery        [X]%    [X]%      [+/-X%]  [X]%
Discovery → Demo       [X]%    [X]%      [+/-X%]  [X]%
Demo → Proposal        [X]%    [X]%      [+/-X%]  [X]%
Proposal → Close       [X]%    [X]%      [+/-X%]  [X]%
Overall win rate       [X]%    [X]%      [+/-X%]  [X]%

BOTTLENECK: [Stage with lowest conversion vs. benchmark]

PIPELINE VELOCITY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Formula: (Deals × Win rate × Avg ACV) ÷ Avg cycle days

  Deals in pipeline:   [X]
  Win rate:            [X]%
  Avg ACV:             $[X]K
  Avg cycle:           [X] days
  Velocity:            $[X]/day

vs. prior quarter: [+/-$X/day]

To hit $[X]M more this quarter at current velocity: [X] more days needed
```

### Step 4: Risk flags

```
DEAL RISK FLAGS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Stalled > 21 days:
  🔴 [Company] — [Stage] — $[X]K — [X] days — Rep: [Name]
  🔴 [Company] — [Stage] — $[X]K — [X] days — Rep: [Name]

Close date overdue:
  🔴 [Company] — [Stage] — $[X]K — was due [date]

Single-threaded (1 contact, deal > $[threshold]):
  🟡 [Company] — [Stage] — $[X]K — [Contact name only]

No next step scheduled:
  🟡 [Company] — [Stage] — $[X]K
```

### Step 5: Pipeline generation math

```
PIPELINE GENERATION ANALYSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

For next quarter (Q[X] [Year]):

Quota:               $[X]M
Pipeline needed:     $[X]M (4× coverage)
Pipeline created:    $[X]M
Gap:                 $[X]M

At current creation rate ([X] deals/week × $[X]K avg):
  Weeks to close gap: [X] weeks
  [🟢 On track / 🟡 Behind / 🔴 Significantly behind]

Recommended SDR/marketing pipeline target: $[X]M by [Date]
```

### Step 6: Recommendations

Based on the analysis, produce 3–5 concrete actions:

```
RECOMMENDATIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. [Action — specific, with owner and timeline]
   Why: [What the data shows]

2. [Action]
   Why: [Data driver]

3. [Action]
   Why: [Data driver]
```

Update `PIPELINE.md` with current pipeline state and flags.
