---
name: gtm:experiment
description: Design a single-variable outbound experiment with success criteria up front
argument-hint: "<workspace-name> <campaign-name> [list|copy|combined]"
---
<objective>
Plan a clean experiment that isolates one variable, so the result is attributable. Force a one-sentence hypothesis, lock the constants, set the minimum sample size and success criteria before launch, and write an experiment plan. Optionally evaluate a finished experiment.

Workspace, campaign, and experiment type: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/experiment-design.md
@./.claude/gtmos/references/positive-reply-scoring.md
@./.claude/gtmos/references/BENCHMARKS.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // EXPERIMENT >>`
2. Load workspace context — `ICP.md`, `PERSONA.md`, `BRIEFING.md`, `LEARNINGS.md` (apply prior learnings and anti-learnings), and the campaign's `performance/results.md` for the current baseline.
3. **Baseline sanity check (the 1% rule):** confirm overall reply rate ≥1% after 200+ sends. If the baseline is broken, stop and route to `/gtm:inbox-health` / `/gtm:validate-copy` — an experiment on a broken baseline only teaches "both arms are bad."
4. Determine the experiment type (list-only / copy-only / combined). Default to single-variable; warn that combined experiments cannot produce HIGH-confidence learnings and must be split into follow-ups.
5. Walk the framework from `experiment-design.md`:
   - Write the one-sentence hypothesis (if it can't be stated in one sentence, the experiment isn't ready)
   - Name the single variable; list every constant explicitly (industry, headcount, geo, copy, offer, infrastructure, schedule). If any "constant" is actually changing, lock it or reclassify.
   - Compute minimum sample size per arm from the baseline + expected lift table
   - Set success / failure / inconclusive criteria and the measurement date (≈ day 21) — before launch, not after
6. Define both arms (control + variant), each with its own list/copy as appropriate. Both must launch the same day on the same infrastructure split.
7. Write the experiment plan to `campaigns/{campaign}/performance/experiments/{date}-{name}.md` (create the folder if absent), with an empty results block.
8. **Evaluate mode** — if the experiment has finished (≥ day 21): pull each arm via `/gtm:reply-score`, compare positive reply rates, weight the confidence (HIGH only if the type isolates the variable AND the sample meets the minimum), check bounce-rate divergence as a disqualifier, and record the verdict + decision (adopt / replicate / drop) back into the plan file and `LEARNINGS.md`.
9. Suggest the priority order if the user is unsure what to test (list > offer > subject > opener > CTA > timing > length).

───────────────────────────────────────────────────────────────

## ▶ Next Up

**ship** — launch both arms simultaneously, then evaluate at day 21

`/gtm:ship {workspace} {campaign}`

───────────────────────────────────────────────────────────────
</process>
