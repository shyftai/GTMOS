# /rev:attribution

Multi-touch attribution analysis — understand which channels and sources are driving pipeline and revenue, and how your attribution model is performing.

## When to use

- Monthly pipeline review
- Before budget planning or channel investment decisions
- When marketing and sales disagree on "what's working"
- When setting pipeline targets by source

---

## What to do

Load `ATTRIBUTION.md`, `PIPELINE.md`, `REVENUE.md`, and `rev-metrics.md`.

### Step 1: Scope

Ask:
1. Time period? (Current quarter / Last quarter / Last 12 months / Custom)
2. Metric? (Pipeline created / Closed won revenue / Both)
3. Attribution model? (Default from ATTRIBUTION.md, or specify: first touch / last touch / linear / time-decay)

### Step 2: Data quality check

```
ATTRIBUTION DATA QUALITY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Deals with lead source set:     [X]% ([X] of [X] deals)
Contacts with source set:       [X]%
UTM data coverage (inbound):    [X]%

Missing source rate: [X]%
[🟢 Good / 🟡 Gaps exist — results directional / 🔴 High missing rate — treat with caution]
```

If missing source > 20%: flag prominently. Results are directional, not reliable.

### Step 3: Pipeline attribution

```
PIPELINE ATTRIBUTION — [Period] | Model: [Attribution model]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Source                  Deals  Pipeline   % Total  Win rate  Avg ACV
──────────────────────────────────────────────────────────────────────
Outbound - Email        [X]    $[X]K      [X]%     [X]%     $[X]K
Outbound - LinkedIn     [X]    $[X]K      [X]%     [X]%     $[X]K
Inbound - Content/SEO   [X]    $[X]K      [X]%     [X]%     $[X]K
Inbound - Paid (SEM)    [X]    $[X]K      [X]%     [X]%     $[X]K
Inbound - Referral      [X]    $[X]K      [X]%     [X]%     $[X]K
Partner                 [X]    $[X]K      [X]%     [X]%     $[X]K
Inbound - Direct        [X]    $[X]K      [X]%     [X]%     $[X]K
Unknown / Missing       [X]    $[X]K      [X]%     —        —
──────────────────────────────────────────────────────────────────────
Total                   [X]    $[X]M      100%     [X]%     $[X]K

vs. prior period:
  Outbound:  [+/-X%]  Inbound: [+/-X%]  Partner: [+/-X%]

Benchmark (B2B SaaS):
  Outbound: 30–40% | Inbound: 25–35% | Partner: 15–25%
```

### Step 4: Revenue attribution

```
REVENUE ATTRIBUTION — Closed Won | [Period] | Model: [Model]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Source               Deals closed  Revenue    % Total  Avg cycle
──────────────────────────────────────────────────────────────────
[Source]             [X]           $[X]K      [X]%     [X] days
[Source]             [X]           $[X]K      [X]%     [X] days
──────────────────────────────────────────────────────────────────
Total                [X]           $[X]M      100%     [X] days
```

### Step 5: Channel efficiency analysis

```
CHANNEL EFFICIENCY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Channel         Pipeline created  Win rate  Revenue  Efficiency score*
──────────────────────────────────────────────────────────────────────
[Channel A]     $[X]K             [X]%      $[X]K    [X]
[Channel B]     $[X]K             [X]%      $[X]K    [X]
[Channel C]     $[X]K             [X]%      $[X]K    [X]

*Efficiency score = (Revenue ÷ Pipeline created) × Win rate
Higher score = more efficient channel
```

### Step 6: Gaps and recommendations

```
ATTRIBUTION GAPS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Unknown source: [X] deals · $[X]K pipeline
  → Fix: [Specific action to recover source attribution]

UTM coverage gaps: [X]% of inbound deals missing UTM
  → Fix: [Action]

RECOMMENDATIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. [Recommendation based on data — what to invest more or less in]
2. [Recommendation on attribution gaps — how to fix]
3. [Recommendation for marketing/demand gen based on channel efficiency]
```

### Step 7: Update ATTRIBUTION.md

Log period, model used, and pipeline/revenue by source in ATTRIBUTION.md.

### Model comparison note

If user wants to compare attribution models:

> "Attribution model choice significantly affects which sources get credit. Here's what changes if we switch from [current model] to [alternative model]:
> [Show the top 3 sources and how their % changes between models]
>
> Neither model is 'right' — but you should use one model consistently for trend analysis. Mixing models period-over-period makes comparisons meaningless."
