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
</execution_context>

<process>
1. Display mode header: `<< GTMOS // SIGNAL SCAN >>`
2. Load workspace context — ICP.md, TOOLS.md, shipped list, signal-angles.md
3. Query connected signal APIs (Signalbase, Commonroom)
4. Cross-reference signals against shipped list
5. Assess relevance and freshness (flag if >14 days as stale)
6. Draft immediate-action messages for each relevant signal
7. Validate against TOV.md, PERSONA.md, BRIEFING.md
8. Present each signal with draft using approval gate format
9. On approval, push to sending tool with credit check
10. Save signals to signal-angles.md, log to decisions.md
</process>
