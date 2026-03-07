---
name: gtm:stress-test
description: Challenge ICP assumptions with edge cases
argument-hint: "<workspace-name>"
---
<objective>
Stress test the ICP. Challenge assumptions, propose edge cases, suggest specific refinements.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./commands/icp-stress-test.md
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // STRESS TEST >>`
2. Load ICP.md from workspace
3. Challenge each major assumption: anti-signals, job titles, pain points, scoring criteria
4. Propose 3 edge cases that expose weaknesses
5. For each weakness, display suggestion block with proposed refinement
6. Wait for approval before applying any changes
</process>
