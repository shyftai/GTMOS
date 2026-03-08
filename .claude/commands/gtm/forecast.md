---
name: gtm:forecast
description: Pipeline forecast based on velocity, conversion rates, and active campaigns
argument-hint: "<workspace-name> [--quarter | --month | --custom <period>]"
---
<objective>
Forecast expected revenue based on current pipeline, historical conversion rates, velocity data, and active campaigns. "At current rates, you'll close $X this quarter."

Workspace and period: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/BENCHMARKS.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // FORECAST >>`
2. Load PIPELINE.md — current pipeline, stage conversion rates, velocity data
3. Load all campaign performance data — active and completed
4. Load LEARNINGS.md — patterns that affect conversion
5. Load ROADMAP.md — planned campaigns and their expected volume

## Data inputs
6. Gather forecast inputs:

**Current pipeline:**
- Deals by stage with values
- Days in current stage per deal
- Historical conversion rate per stage
- Average days per stage (velocity)

**Active campaigns:**
- Contacts in sequence (not yet replied)
- Current reply rate and positive rate
- Historical meeting booking rate from positive replies
- Historical deal close rate from meetings

**Planned campaigns (from ROADMAP.md):**
- Expected contact volume
- Expected reply rates (from similar past campaigns or benchmarks)
- Expected start dates

## Forecast calculation
7. Calculate weighted pipeline:
```
For each deal in pipeline:
  Expected value = Deal value × Stage probability

Stage probabilities (from historical data, or defaults):
  Prospect:    5%
  Contacted:  10%
  Replied:    15%
  Positive:   25%
  Meeting:    40%
  Qualified:  55%
  Proposal:   70%
  Negotiation: 85%
  Verbal:     95%
```

8. Calculate campaign-sourced forecast:
```
For each active campaign:
  Expected replies = Remaining contacts × Reply rate
  Expected positive = Expected replies × Positive rate
  Expected meetings = Expected positive × Meeting rate
  Expected deals = Expected meetings × Close rate
  Expected revenue = Expected deals × Avg deal value

For each planned campaign:
  Same calculation using benchmark rates or similar campaign history
```

9. Calculate velocity-adjusted timeline:
```
For each deal:
  Expected close date = Today + (Remaining stages × Avg days per stage)
  If past expected date → flag as at risk
```

## Forecast display
10. Show the forecast:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  FORECAST — {Workspace} — {Period}                           ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  Weighted pipeline
    Proposal    2 deals    $24,000 × 70%  =  $16,800
    Qualified   3 deals    $36,000 × 55%  =  $19,800
    Meeting     5 deals    $50,000 × 40%  =  $20,000
    Positive    8 deals    $64,000 × 25%  =  $16,000
    ─────────────────────────────────────────────────
    Weighted total:                          $72,600

  From active campaigns
    Q1 Cold Outbound     120 remaining → ~5 replies → ~2 meetings → $16,000
    Signal Campaign      45 remaining  → ~4 replies → ~2 meetings → $16,000
    ─────────────────────────────────────────────────
    Campaign forecast:                                $32,000

  From planned campaigns
    Q2 Expansion         250 contacts  → ~10 replies → ~4 meetings → $32,000
    (starts Apr 1, results expected May-Jun)
    ─────────────────────────────────────────────────
    Planned forecast:                                 $32,000

  ══════════════════════════════════════════════════════════

  Total forecast: $136,600
    This quarter:  $104,600 (pipeline + active campaigns)
    Next quarter:  $32,000 (planned campaigns)

  Confidence:
    High:   $72,600 (weighted pipeline — deals in motion)
    Medium: $32,000 (active campaigns — based on current rates)
    Low:    $32,000 (planned — hasn't started yet)

  ══════════════════════════════════════════════════════════
```

## Risk analysis
11. Flag risks to the forecast:
```
  Risks
    !! 2 deals stalled in Qualified >20 days (avg: 10 days)
       Impact: -$18,000 if lost
    !! Campaign reply rate trending down (4.2% → 2.8%)
       Impact: -$8,000 from reduced meetings
    >> Nurture list: 4 contacts due this month
       Upside: +$32,000 if 2 convert

  Scenarios
    Best case:  $168,600 (stalled deals close + nurture converts)
    Expected:   $136,600
    Worst case:  $88,600 (lose stalled deals + campaign underperforms)
```

12. Save forecast to performance/forecast-{date}.md
13. If previous forecasts exist, show trend:
```
  Forecast trend
    Feb 15: $95,000
    Mar 1:  $110,000 ▲
    Mar 8:  $136,600 ▲
    Trajectory: growing — on track
```

14. Suggest actions to improve forecast:
```
  >> Unblock stalled deals: /gtm:pipeline-velocity {ws}
  >> Check nurture list: /gtm:nurture {ws} --due
  >> Ship planned campaign early: /gtm:ship {ws} q2-expansion
```
</process>
</content>
