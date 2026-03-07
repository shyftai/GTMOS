---
name: gtm:health
description: Run a full campaign health check with pattern detection
argument-hint: "<workspace-name> <campaign-name>"
---
<objective>
Analyse campaign performance across all dimensions. Surface patterns. Suggest specific file edits backed by data.

Workspace and campaign: $ARGUMENTS
</objective>

<execution_context>
@./commands/campaign-health-check.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/BENCHMARKS.md
@./.claude/gtmos/references/sending-calendar.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // HEALTH CHECK >>`
2. Load all workspace context + sync data + shipped list + approved copy
3. Load INFRASTRUCTURE.md and SUPPRESSION.md for deliverability context
4. Load PIPELINE.md for funnel conversion data
5. Load BENCHMARKS.md from references for comparison
6. Load AB-TESTS.md from campaign for test status
7. Run deliverability analysis (bounce rate, spam complaints, inbox placement vs benchmarks)
8. Run engagement analysis (open rate, reply rate vs benchmarks)
9. Run pipeline analysis (conversion rates per stage vs benchmarks, revenue attribution)
10. Run persona performance analysis
11. Update performance/trends.md with this week's data
12. Check sending-calendar.md for upcoming holiday conflicts
13. Display health check dashboard from ui-brand.md
14. Display week-over-week trends if 2+ weeks of data exist
15. Run pattern detection — for each pattern, display suggestion block
16. If enough data exists for auto-refinement, suggest: `/gtm:auto-refine`
17. Wait for approval on each suggestion before applying
18. Display health check summary: status, top 3 working, top 3 to fix
19. Save to performance/health-check-[date].md
</process>
