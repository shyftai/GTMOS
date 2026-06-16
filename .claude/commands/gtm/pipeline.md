---
name: gtm:pipeline
description: View CRM pipeline — funnel, conversion, revenue attribution, and velocity
argument-hint: "<workspace-name> [campaign] [--velocity]"
---
<objective>
Display the CRM pipeline for a workspace or campaign: funnel, conversion rates vs benchmark, revenue attribution, lost-deal analysis, and a velocity read (stalled deals + bottlenecks). Pass `--velocity` for the deep velocity analysis (stage durations, velocity score, week-over-week trend), which also refreshes the velocity tables in PIPELINE.md.

Workspace, optional campaign, optional --velocity: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/BENCHMARKS.md
@./.claude/gtmos/references/api-reference.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // PIPELINE >>`
2. Parse $ARGUMENTS — workspace, optional campaign filter, optional `--velocity` flag
3. Load workspace PIPELINE.md and BENCHMARKS.md. If a campaign is specified, filter all data to that campaign.

## Default view (always shown)
4. Display the pipeline funnel visualization:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  PIPELINE — {workspace}                    ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                            ┃
┃  Shipped        ████████████████████  250   ┃
┃  Contacted      ████████████████████  250   ┃
┃  Replied        ██                    11    ┃
┃  Positive       █                     6     ┃
┃  Meeting        █                     4     ┃
┃  Held           █                     3     ┃
┃  Qualified      █                     3     ┃
┃  Proposal       █                     2     ┃
┃  Won            ░                     0     ┃
┃                                            ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```
5. Show conversion rates with benchmark comparison:
   - Green: above benchmark average
   - Yellow: at benchmark average
   - Red: below benchmark average
6. Show revenue attribution if deals exist
6b. **Campaign attribution** (join the touch ledger with CRM opps — see attribution-ledger.md): rank campaigns by **sourced** pipeline/revenue (one campaign per opp; sums to the total) and show **influenced** pipeline (every campaign that touched the account in-window — flagged non-additive, never summed). With `--campaign`, show that campaign's sourced-vs-influenced split.
7. Show lost-deal analysis if any closed-lost
8. Flag any stage with unusual drop-off
9. **Velocity summary** (always shown — the high-signal subset of the deep pass below):
```
  Velocity
    Score: {velocity score}   ({▲/▼} vs last week)
    Stalled: {n} deals past their stage stall threshold
      !! {deal} ({company}) — {stage}, {days}d (threshold {n}d) → {next action}
    Bottleneck: {stage} — {n}% of deals stalling  (or "none")
```
   Run only the lightweight read here — full stage-duration math and the PIPELINE.md write-back happen in `--velocity` mode.

## Deep velocity analysis (--velocity)
When `--velocity` is passed, after the default view run the full velocity pass:
10. Pull latest stage-transition timestamps from the CRM (Attio/HubSpot per api-reference.md); match deals by contact/company
11. For each active deal, compute days spent in each stage (use the current date for the stage it's sitting in)
12. Across all deals compute: average days per stage transition, median, stall threshold (2× average per stage), and overall stall rate (% of deals past threshold)
13. Identify bottlenecks — any stage where >30% of deals are stalling — and surface the recommended fix
14. Compute pipeline velocity:
```
Velocity = (# deals × avg deal value × win rate) / avg sales-cycle length
```
    Pull deal values from CRM, win rate from PIPELINE.md conversion tracking, cycle length from the calculated stage durations.
15. Display the velocity dashboard (ui-brand box): velocity score, stage-duration table (avg / median / stall threshold / stall count), bottleneck flags with actions, stalled-deals list with specific next actions per deal
16. Compare to the previous period from PIPELINE.md velocity trend — call out improvements or regressions
17. **Write back to PIPELINE.md:** populated stage-duration table, a new velocity-trend row for the current week, and the stalled-deals table

## Next
18. Suggest next actions:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Next: /gtm:health {workspace} {campaign}
     Also: /gtm:debrief {workspace} {campaign}
     Also: /gtm:sync {workspace}
  {if stalls exist and --velocity was not used:}
     Deep velocity: /gtm:pipeline {workspace} --velocity

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
