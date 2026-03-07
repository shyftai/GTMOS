---
name: gtm:debrief
description: End-of-campaign performance debrief with forward-feed
argument-hint: "<workspace-name> <campaign-name>"
---
<objective>
Run a full performance debrief. Cross-reference metrics with copy. Feed learnings forward into ICP, persona, and briefing.

Workspace and campaign: $ARGUMENTS
</objective>

<execution_context>
@./commands/performance-review.md
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // DEBRIEF >>`
2. Load performance/results.md + approved copy + AB-TESTS.md
3. Load PIPELINE.md for full-funnel conversion analysis
4. Load BENCHMARKS.md for industry comparison
5. Cross-reference metrics with touches, angles, and A/B test results
6. Output structured debrief: what worked, what didn't, anomalies, carry-forwards
7. Include ROI analysis: cost per meeting, cost per opportunity, pipeline generated
8. Run forward-feed for ICP, persona, copy, and pipeline
6. Display suggestion blocks for each proposed file edit
7. Wait for approval on each
8. Save to performance/debrief-[date].md
9. Update logs/decisions.md
</process>
