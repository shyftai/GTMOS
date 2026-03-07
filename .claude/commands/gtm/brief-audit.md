---
name: gtm:brief-audit
description: Check briefing for gaps before campaign start
argument-hint: "<workspace-name>"
---
<objective>
Audit BRIEFING.md for gaps. Surface missing or vague fields with specific questions to resolve each one.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./commands/audit-briefing.md
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // AUDIT >>`
2. Load BRIEFING.md from workspace
3. Check: offer specificity, hook defensibility, tone guidelines, CTA clarity, constraints
4. Display five-check format for each area — [x] or [ ] with reason
5. Output specific question to resolve each gap
6. Do not allow copy tasks until critical gaps are filled
</process>
