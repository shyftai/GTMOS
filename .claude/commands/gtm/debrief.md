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
@./LEARNINGS.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // DEBRIEF >>`
2. Load performance/results.md + approved copy + AB-TESTS.md
3. Load PIPELINE.md for full-funnel conversion analysis
4. Load BENCHMARKS.md for industry comparison
5. Cross-reference metrics with touches, angles, and A/B test results
6. Output structured debrief: what worked, what didn't, anomalies, carry-forwards
7. Include ROI analysis: cost per meeting, cost per opportunity, pipeline generated
8. Run forward-feed for ICP, persona, copy, and pipeline
9. Run auto-refinement analysis (from auto-refine.md) — surface ICP/persona/copy patterns
10. Update PIPELINE.md win/loss insight log with campaign outcomes
11. Add winning copy to global/snippet-library.md and global/swipe-file.md
12. **Update LEARNINGS.md** — append new insights to the relevant sections (ICP, persona, copy, channel, signal, objections, anti-learnings). Tag each with source campaign, confidence level, and date. Don't duplicate existing learnings — update confidence if a pattern is confirmed again.
13. **Update ROADMAP.md** — move completed campaign to "Completed campaigns" table with key learning. If debrief surfaces new campaign ideas (e.g. "this segment deserves its own campaign"), add to "Ideas backlog". **Generate to-dos** from learnings — e.g. "Rewrite Touch 1 opener" from copy learnings, "Shorten SMB sequences" from anti-learnings, "Add Series B as signal" from ICP learnings. Each to-do gets priority (Urgent/High/Medium/Low) and source attribution.
14. Display suggestion blocks for each proposed file edit
15. Wait for approval on each
16. Save to performance/debrief-[date].md
17. Update logs/decisions.md
18. If contacts are eligible for re-engagement (60+ days), flag: `/gtm:re-engage`
</process>
