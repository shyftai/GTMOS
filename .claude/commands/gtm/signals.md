---
name: gtm:signals
description: Scan for time-sensitive signals on active contacts
argument-hint: "<workspace-name> [campaign-name]"
---
<objective>
Scan for live signals on contacts in the shipped list. Draft immediate-action messages for fresh, relevant signals.

Workspace and campaign: $ARGUMENTS
</objective>

<execution_context>
@./commands/scan-signals.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
@./.claude/gtmos/references/api-reference.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // SIGNAL SCAN >>`
2. Load workspace context — ICP.md, TOOLS.md, shipped list, signal-angles.md
3. Check which signal tools are active in TOOLS.md — skip inactive/missing keys
4. Display signal scan plan (active sources, skipped sources, contact count)
5. Query all active signal sources in waterfall order (Tier 1 → 2 → 3 → 4)
6. Cross-reference signals against shipped list, deduplicate across sources
7. Assess relevance and freshness (flag if >14 days as stale)
8. Draft immediate-action messages using Trigger > Relevance > Value > Ask framework
9. Validate against TOV.md, PERSONA.md, BRIEFING.md
10. Present each signal with draft using approval gate format
11. On approval, push to sending tool with credit check
12. Save signals to signal-angles.md, log to decisions.md
</process>
