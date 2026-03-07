---
name: gtm:research
description: Research ICP companies and market landscape for a workspace
argument-hint: "<workspace-name>"
---
<objective>
Run structured research for a workspace — ICP company research, market landscape, and signal-to-angle extraction.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./commands/run-research.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // RESEARCH >>`
2. Load workspace context from workspaces/$ARGUMENTS/
3. Display workspace header
4. Execute research workflow from @./commands/run-research.md
5. Save outputs to context/research/
6. Update context/INDEX.md
7. Display top 3 recommended angles
8. Suggest next action: `/gtm:brief-audit $ARGUMENTS` or `/gtm:list-brief $ARGUMENTS`
</process>
