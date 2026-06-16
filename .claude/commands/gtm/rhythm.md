---
name: gtm:rhythm
description: Show the weekly outbound operating cadence and what is due now
argument-hint: "<workspace-name>"
---
<objective>
Display the operating rhythm (Monday / Wednesday / Friday / biweekly / monthly / quarterly) and surface which tasks are due based on the current date and campaign state. The cadence is what separates a hobbyist from a top-1% operator — consistency, not tooling.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/weekly-rhythm.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // RHYTHM >>`
2. Load workspace context — campaigns, `performance/results.md`, last health-check date, last reply-score date, inbox state from `INFRASTRUCTURE.md`.
3. Display the full cadence table from `weekly-rhythm.md`.
4. Compute what is **due now** based on the current date and state:
   - Monday → deliverability audit due (`/gtm:health`, `/gtm:inbox-health`)
   - Wednesday → positive-reply sweep due (`/gtm:reply-score`)
   - Friday → any campaign hitting its 21-day mark this week → retrospective (`/gtm:reply-score`, `/gtm:debrief`)
   - Every other Monday → inbox rotation (`/gtm:inbox-health --all`)
   - 1st of month → spam-placement test
   - First Monday of quarter → experiment review (`/gtm:experiment`)
   Also flag overdue items (e.g. last health check > 7 days ago; campaigns past 21 days never retro'd; insurance inbox pool < 5).
5. Display a "Due now" block and a "Coming up this week" block using `ui-brand.md` formatting, each line linking the exact command to run.
6. Recommend the single highest-priority task to do right now.
7. This command is read-only — it does not run the underlying tasks. It points; the operator (or `/gtm:today`) acts.

───────────────────────────────────────────────────────────────

## ▶ Next Up

**{the top due task}** — run it now

`/gtm:{due-command} {workspace}`

───────────────────────────────────────────────────────────────
</process>
