---
name: gtm:migrate
description: Step-by-step tool migration playbook
argument-hint: "<workspace-name> <from-tool> <to-tool>"
---
<objective>
Guide a tool migration — export data from the old tool, map to GTM:OS format, import to the new tool, verify, and update workspace config.

Workspace and tools: $ARGUMENTS
</objective>

<execution_context>
@./commands/migrate-tool.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
@./.claude/gtmos/references/csv-format.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // MIGRATION >>`
2. Identify source and target tools from $ARGUMENTS
3. Load the relevant migration playbook from commands/migrate-tool.md
4. Walk through pre-migration checklist
5. Guide data export from source tool
6. Map columns to GTM:OS standard format
7. Guide data import to target tool
8. Update TOOLS.md, COSTS.md, .env, campaign.config.md
9. Run post-migration checklist
10. Verify with a test batch
</process>
