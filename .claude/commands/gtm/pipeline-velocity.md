---
name: gtm:pipeline-velocity
description: Track deal velocity, detect bottlenecks, and identify stalled deals
argument-hint: "<workspace-name> [campaign-name]"
---

You are running the GTM:OS pipeline velocity tracker. Follow these steps precisely.

## Execution context

Read these files before proceeding:

- commands/pipeline-velocity.md — command reference and logic
- ui-brand.md — display formatting rules
- api-reference.md — CRM and tool API patterns
- BENCHMARKS.md — benchmark thresholds for stage durations

## Process

1. **Display mode header** — render the GTM:OS mode header for "Pipeline Velocity" using ui-brand.md formatting.

2. **Load PIPELINE.md** — read the workspace's PIPELINE.md to get current deal data with timestamps. Parse the pipeline stages table, conversion tracking, and any existing velocity data.

3. **Pull latest stage timestamps from CRM** — query the CRM (Attio or HubSpot, per api-reference.md) for the latest deal stage transition timestamps. Match deals by contact/company identifier.

4. **Calculate stage durations for each deal** — for every active deal, compute the number of days spent in each stage by comparing stage entry and exit timestamps. Use the current date for deals still sitting in a stage.

5. **Calculate averages, medians, and stall thresholds** — across all deals, compute:
   - Average days per stage transition
   - Median days per stage transition
   - Stall threshold = 2x the average for each stage
   - Overall stall rate = % of deals exceeding the stall threshold

6. **Identify bottlenecks** — flag any stage where >30% of deals are stalling (sitting longer than 2x the average). For each bottleneck, surface the recommended fix from commands/pipeline-velocity.md.

7. **Calculate overall pipeline velocity** — apply the formula:
   ```
   Velocity = (# Deals x Avg Deal Value x Win Rate) / Avg Sales Cycle Length
   ```
   Pull deal values from CRM, win rate from PIPELINE.md conversion tracking, and cycle length from the calculated stage durations.

8. **Display velocity dashboard** — render the full pipeline velocity dashboard using the GTM:OS box style from ui-brand.md. Include:
   - Velocity score
   - Stage duration table with avg, median, stall threshold, and stall count
   - Bottleneck flags with actions
   - Stalled deals list with next actions

9. **Flag stalled deals with specific next actions** — for each deal currently exceeding the stall threshold, list:
   - Deal name and company
   - Current stage and days in stage
   - The stall threshold for that stage
   - A specific next action based on the bottleneck fixes in commands/pipeline-velocity.md

10. **Compare to previous period** — if the velocity trend table in PIPELINE.md has prior week data, compare current velocity score, stall rate, and avg cycle length to the previous period. Call out improvements or regressions.

## Output

Update the workspace PIPELINE.md with:
- Populated stage durations table
- Updated velocity trend row for the current week
- Populated stalled deals table

Display the velocity dashboard to the user and highlight any bottlenecks requiring action.

If a campaign-name argument is provided, filter all calculations to deals originating from that campaign only.
