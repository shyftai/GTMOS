# Command: ICP Auto-Refinement

## Trigger
"Refine ICP based on data" or triggered during `/gtm:debrief` and `/gtm:dashboard` when enough data exists

## What it does
Analyzes campaign performance data and win/loss patterns to suggest ICP, persona, and copy refinements. Does NOT make changes automatically — always presents suggestions for approval.

## Minimum data required
- At least 2 completed campaigns in the workspace, OR
- At least 200 contacts shipped with reply data, OR
- At least 5 entries in the win/loss insight log (PIPELINE.md)

## Steps
1. Load all performance data:
   - Campaign trends from performance/trends.md across campaigns
   - Win/loss insight log from PIPELINE.md
   - Reply classifications from campaign logs/decisions.md
   - A/B test results from AB-TESTS.md
   - Persona performance data
   - Signal performance data

2. Analyze patterns across these dimensions:

### Company fit patterns
- Which company sizes convert best? (compare to ICP.md range)
- Which industries over/underperform?
- Does funding stage correlate with conversion?
- Does geography matter?

### Persona patterns
- Which titles convert best? (compare to PERSONA.md)
- Which seniority levels respond most?
- Are there titles we're NOT targeting that keep converting?
- Are there titles in PERSONA.md that never convert?

### Signal patterns
- Which signals correlate with higher reply rates?
- Which signals lead to meetings (not just replies)?
- Are there signals we should add to ICP.md?
- Are there signals that don't actually predict anything?

### Copy patterns
- Which subject line patterns work best?
- Which opening line frameworks convert?
- Which CTAs get the most positive responses?
- Which angles work for which persona?

### Timing patterns
- Which days/times get the best open and reply rates?
- Which touch in the sequence converts most?
- Is there an optimal sequence length?

3. For each significant finding (>10% lift or >2x difference), generate a suggestion:

```
  ┌─ ICP REFINEMENT SUGGESTION ──────────────────┐
  │                                                │
  │ Finding: Series B companies reply at 8.2%      │
  │          vs. 2.1% for all others               │
  │                                                │
  │ Evidence: 14 of 17 meetings came from          │
  │           post-Series B companies              │
  │                                                │
  │ Suggested change:                              │
  │   File: ICP.md                                 │
  │   Section: Signals                             │
  │   Add: "Series B funding = high-priority       │
  │          signal (8x reply rate lift)"           │
  │                                                │
  └────────────────────────────────────────────────┘
  >> Apply? (y/n)
```

4. Group suggestions by confidence:
   - **High confidence:** 3+ data points, >2x lift, consistent across campaigns
   - **Medium confidence:** 2 data points, >50% lift
   - **Low confidence:** emerging pattern, needs more data to confirm

5. Present high-confidence suggestions first
6. On approval, make the change to the relevant file
7. Log all applied refinements in PIPELINE.md pattern tracker
8. Add winning copy patterns to global/snippet-library.md
