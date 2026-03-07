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
</execution_context>

<process>
1. Display mode header: `<< GTMOS // DATA SYNC >>`
2. Load TOOLS.md — identify active tools in bidirectional or read mode
3. For each tool, pull latest data via API
4. Save timestamped snapshots to sync/[tool]/[datetime].json
5. Display sync summary: timestamp, record count per tool, any errors
6. Suggest next action: `/gtm:health <workspace> <campaign>`
</process>
