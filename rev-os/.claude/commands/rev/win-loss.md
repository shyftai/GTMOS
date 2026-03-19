# /rev:win-loss

Win/loss analysis — capture deal outcomes, surface patterns, and produce actionable insight for sales, marketing, and product.

## When to use

- Monthly (minimum) — analyze all deals closed in the period
- Quarterly — deeper analysis with segment breakdowns and trend comparison
- After a notable win or loss streak
- Before a sales kickoff or strategic planning session

---

## What to do

Load `WIN-LOSS.md`, `PIPELINE.md`, `rev-benchmarks.md`, and `rev-metrics.md`.

### Step 1: Scope

Ask:
1. Time period for analysis? (Current quarter / Last quarter / Last 6 months / Custom)
2. Segment filter? (All / SMB / Mid-market / Enterprise / Specific rep or territory)
3. Purpose? (Routine analysis / Board prep / Sales training / Product roadmap input)

### Step 2: Data check

**Minimum sample size: 10 deals before drawing conclusions.**

If N < 10: "We only have [X] closed deals in this period. Analysis with this sample size should be treated as directional, not conclusive. [Proceed anyway? Y/N]"

Count deals with complete win/loss records vs. total closed deals. If < 50% have records:

> "Only [X]% of closed deals have win/loss records. Before analysis, should we fill in the gaps? I can walk through the top [X] missing deals."

### Step 3: Win/loss summary

```
WIN/LOSS ANALYSIS — [Period]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

N = [X] deals ([X] won · [X] lost)
Win rate: [X]%  vs. [X]% prior period  ([+/-X%])

Average ACV (won):   $[X]K  |  Avg cycle (won):  [X] days
Average ACV (lost):  $[X]K  |  Avg cycle (lost): [X] days

Pattern: [One sentence — e.g., "We're winning deals faster but at lower ACV"]
```

### Step 4: Theme analysis

For wins and losses, group outcomes into themes:

```
WIN THEMES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. [Theme] — [X]% of wins
   "[Representative buyer quote or rep note]"
   Pattern: [What these wins have in common — segment, product, channel]

2. [Theme] — [X]% of wins
   "[Quote]"

3. [Theme] — [X]% of wins

LOSS REASONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Lost to competitor — [X]%
   Primary competitor: [Name] ([X] losses)
   Their advantage: [What reps report as the differentiator]

2. No decision / Status quo — [X]%
   Common context: [What these deals had in common]

3. Price / Budget — [X]%
   Avg ACV of budget-loss deals: $[X]K
   Were these actually ICP deals? [Yes/No/Mixed]

4. Timing — [X]%
5. Product gap — [X]%
   Gap mentioned: [Feature or capability]
```

### Step 5: Segment analysis

```
WIN RATE BY SEGMENT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Segment     Win rate  vs. Prior  Trend    Top loss reason
─────────────────────────────────────────────────────────
SMB         [X]%      [+/-X%]    [↑/→/↓]  [Reason]
Mid-market  [X]%      [+/-X%]    [↑/→/↓]  [Reason]
Enterprise  [X]%      [+/-X%]    [↑/→/↓]  [Reason]

By lead source:
Outbound    [X]%   avg ACV $[X]K
Inbound     [X]%   avg ACV $[X]K
Partner     [X]%   avg ACV $[X]K

By rep (if relevant — use for coaching, not ranking):
[Rep 1]     [X]%   [X] deals   top strength: [Theme]
[Rep 2]     [X]%   [X] deals   top strength: [Theme]
```

### Step 6: Competitive analysis

```
COMPETITIVE WIN/LOSS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Competitor      Mentions  Wins vs.  Losses vs.  Win rate
─────────────────────────────────────────────────────────
[Competitor A]  [X]       [X]       [X]         [X]%
[Competitor B]  [X]       [X]       [X]         [X]%
No competitor   [X]       [X]       [X]         [X]%

Key competitive theme: [What we win on / lose on vs. top competitor]
```

### Step 7: Recommended actions

```
RECOMMENDED ACTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SALES (from [X] losses to [reason]):
→ [Action] — owner: [Rep/Manager] — due: [Date]
→ [Action]

MARKETING (from [X] losses to [reason] / win themes):
→ [Action] — owner: [Name] — due: [Date]
→ [Action]

PRODUCT (from [X] product-gap losses):
→ [Action] — owner: [Product lead] — due: [Date]
→ Flag: [Feature or capability mentioned in [X] losses]
```

### Step 8: Update WIN-LOSS.md

1. Add summary section for the period
2. Update win themes and loss reason tables
3. Update competitive analysis section
4. Log key recommendations

After analysis: Check if any loss pattern belongs in LEARNINGS.md — if it represents a new insight or a pattern that changed, capture it.

### Sample size warning

If N < 10: Prepend every output with:
> ⚠️ SMALL SAMPLE WARNING: This analysis is based on [X] deals. Treat all percentages as directional signals, not statistically reliable conclusions. Recommend confirming patterns with a larger dataset next quarter.
