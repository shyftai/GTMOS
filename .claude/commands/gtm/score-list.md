---
name: gtm:score-list
description: Grade a lead list across 8 quality dimensions before shipping
argument-hint: "<workspace-name> [file-path]"
---
<objective>
Run the list quality scorecard on a lead CSV — grade it A+ to F across 8 dimensions, surface the top issues, and gate it against shipping. A list-level health check that complements per-contact lead scoring.

Workspace and file: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/list-quality-scorecard.md
@./.claude/gtmos/references/csv-format.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // LIST QA >>`
2. Resolve the list:
   - If a file path is given, load it
   - Otherwise use the most recent file in the active campaign's `lists/validated/` (fall back to `lists/` if none validated yet)
3. Load `ICP.md` and `PERSONA.md` for the active workspace — needed for title-relevance and ICP-fit dimensions. If firmographic columns are missing, score the dimensions that are computable and mark the rest `n/a — needs enrichment`.
4. If the list has fewer than 100 rows, warn that the sample is too small for reliable stats, then proceed for directional signal only.
5. Score all 8 dimensions per `list-quality-scorecard.md` (verification coverage, duplicate emails, domain concentration, title relevance, bad-title detection, catch-all density, ICP fit, name quality). Verification and ICP fit are weighted 2×.
6. Compute the weighted average and letter grade.
7. Display the scorecard box (`ui-brand.md`) with per-dimension scores, status indicators, and the top issues with fix actions and affected counts. Never show contact names in issue output.
8. End with a pre-send checklist (dedupe, drop catch-all if >5%, filter bad titles, cap per-domain concentration, re-verify if shrunk >10%).
9. Apply the ship gate:
   - Grade ≥ B → ready to ship
   - Grade C → show top issues, require explicit acknowledgement before `/gtm:ship`
   - Grade < C → do not ship; route to fix the top 3 issues, then re-run. This gate is non-overridable in auto mode (treat like a failed launch-check item).
10. Write the result to the campaign's `performance/results.md` (list QA section) and note it in `context/SESSION.md`.

───────────────────────────────────────────────────────────────

## ▶ Next Up

**write** — draft copy once the list grades ≥ B (or fix issues and re-score)

`/gtm:write {workspace}`

───────────────────────────────────────────────────────────────
</process>
