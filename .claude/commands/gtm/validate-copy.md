---
name: gtm:validate-copy
description: QA check copy against briefing, TOV, and quality rules
argument-hint: "<workspace-name>"
---
<objective>
Validate copy against all five sources of truth. Flag violations, suggest revisions, display five-check results.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./commands/validate-copy.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // COPY LAB >>`
2. Load workspace context — ICP.md, PERSONA.md, BRIEFING.md, TOV.md, RULES.md
3. Check each touch against all rules
4. Display five-check validation per touch using ui-brand.md format
5. Flag violations inline with reason
6. Suggest revised version for each flagged line
7. Do not present as approved until all flags are resolved
</process>
