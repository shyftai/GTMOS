---
name: gtm:report
description: Generate a client-facing campaign report
argument-hint: "<workspace-name> <campaign-name> [weekly|monthly|final]"
---
<objective>
Generate a clean, client-ready report for a campaign. Strips internal notes, shows only approved metrics and outcomes.

Workspace, campaign, and report type: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/BENCHMARKS.md
@./.claude/gtmos/references/report-template.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // REPORT >>`
2. Load campaign performance/results.md, PIPELINE.md, COSTS.md, AB-TESTS.md
3. Determine report type (weekly / monthly / final — default: weekly)
4. Generate report with these sections:

   **Weekly report:**
   - Period covered
   - Emails sent / opened / replied
   - Positive replies with company names
   - Meetings booked
   - Pipeline movement
   - Key takeaway (1-2 sentences)
   - Next week plan

   **Monthly report:**
   - All weekly metrics aggregated
   - Funnel conversion rates with benchmark comparison
   - A/B test results and actions taken
   - Top performing angles/touches
   - ICP refinements made
   - Cost summary (spend vs budget)
   - ROI if deals in pipeline

   **Final report:**
   - Full campaign summary
   - Complete funnel analysis
   - Revenue attribution
   - ROI calculation
   - What worked / what didn't
   - Recommendations for next campaign
   - Competitor intelligence gathered

5. Format as clean markdown — no internal file references, no Claude-specific language
6. Save to performance/report-{type}-{date}.md
7. Offer to export as a shareable format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Report saved to performance/report-{type}-{date}.md

  >> Next: /gtm:health {workspace} {campaign}
     Also: /gtm:debrief {workspace} {campaign}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
