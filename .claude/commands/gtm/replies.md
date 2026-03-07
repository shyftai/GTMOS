---
name: gtm:replies
description: Classify and draft responses to campaign replies
argument-hint: "<workspace-name> [campaign-name]"
---
<objective>
Pull, classify, and draft responses to campaign replies. Present each for approval.

Workspace and campaign: $ARGUMENTS
</objective>

<execution_context>
@./commands/handle-replies.md
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // REPLY DESK >>`
2. Load workspace context — PERSONA.md, TOV.md, BRIEFING.md, TOOLS.md
3. Pull unprocessed replies from active tools
4. Classify each reply into one of seven types
5. Draft response per type following handle-replies.md
6. Validate all drafts against TOV.md
7. Display each reply using the reply classification format from ui-brand.md
8. Present each for approval — nothing sent without explicit yes
9. Log all classifications and actions in logs/decisions.md
10. Save to replies/[date].md
</process>
