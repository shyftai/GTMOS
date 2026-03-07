---
name: gtm:list-brief
description: Create a structured brief for list building
argument-hint: "<workspace-name> <campaign-name>"
---
<objective>
Build a structured list brief from ICP.md and campaign config — ready to hand to a VA or input into Apollo/Apify.

Workspace and campaign: $ARGUMENTS
</objective>

<execution_context>
@./commands/build-list-brief.md
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // LIST BUILD >>`
2. Load workspace context — ICP.md, campaign.config.md
3. Display workspace header
4. Output structured brief: filter criteria, required fields, enrichment fields, signals, exclusion rules
5. Format as copy-paste ready
</process>
