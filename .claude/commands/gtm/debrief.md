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
@./commands/auto-refine.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/BENCHMARKS.md
@./.claude/gtmos/references/report-template.md
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
6. Run auto-refinement analysis (from auto-refine.md) — surface ICP/persona/copy patterns
7. Update PIPELINE.md win/loss insight log with campaign outcomes
8. Add winning copy to global/snippet-library.md and global/swipe-file.md
9. Display suggestion blocks for each proposed file edit
10. Wait for approval on each
11. Save to performance/debrief-[date].md
12. Update logs/decisions.md
13. If contacts are eligible for re-engagement (60+ days), flag: `/gtm:re-engage`
</process>
