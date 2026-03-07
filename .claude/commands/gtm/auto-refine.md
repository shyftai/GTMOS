---
name: gtm:auto-refine
description: Suggest ICP, persona, and copy refinements based on campaign data
argument-hint: "<workspace-name>"
---
<objective>
Analyze campaign performance data and win/loss patterns. Suggest data-backed refinements to ICP, persona, copy, and scoring. Never auto-changes — always presents for approval.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./commands/auto-refine.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/lead-scoring.md
@./.claude/gtmos/references/BENCHMARKS.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // AUTO-REFINE >>`
2. Load all campaign performance data, PIPELINE.md win/loss log, trends.md, AB-TESTS.md
3. Check minimum data thresholds (200+ contacts shipped or 5+ win/loss entries)
4. Run pattern analysis across company fit, persona, signals, copy, and timing
5. Generate suggestion blocks for significant findings (>10% lift or >2x difference)
6. Present suggestions grouped by confidence (high, medium, low)
7. On approval, apply changes and log in PIPELINE.md pattern tracker
8. Add winning copy patterns to global/snippet-library.md
</process>
