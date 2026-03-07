---
name: gtm:sync
description: Pull latest data from all connected tools
argument-hint: "<workspace-name> [campaign-name]"
---
<objective>
Sync live data from all active tools for the specified campaign. Data pull only — no analysis.

Workspace and campaign: $ARGUMENTS
</objective>

<execution_context>
@./commands/sync-data.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // DATA SYNC >>`
2. Load TOOLS.md — identify active tools in bidirectional or read mode
3. Check .env for API keys — skip tools with missing keys
4. Display sync plan: active tools, skipped tools, last sync timestamp
5. For each active tool, pull data via specific API endpoints (see sync-data.md)
6. Calculate rates inline (open, reply, bounce, unsubscribe)
7. Save timestamped snapshots to sync/[tool]/[YYYY-MM-DD-HH].json
8. Display sync summary with key metrics and threshold flags
9. Flag any metrics crossing red/amber thresholds
10. Suggest next action: `/gtm:health <workspace> <campaign>`
</process>
