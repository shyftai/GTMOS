---
name: gtm:account-based
description: Multi-thread a high-value target account
argument-hint: "<workspace-name> <company-name>"
---
<objective>
Run account-based multi-threading — reach 2-4 people at one company with role-appropriate messaging and coordinated timing.

Workspace and company: $ARGUMENTS
</objective>

<execution_context>
@./commands/account-based.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
@./.claude/gtmos/references/campaign-types.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // ACCOUNT-BASED >>`
2. Load ICP.md, PERSONA.md, BRIEFING.md, SUPPRESSION.md
3. Confirm the target company matches ICP
4. Map the buying committee — identify 2-4 contacts by role priority
5. Customize messaging per role (same angle, different framing)
6. Apply timing rules — stagger outreach, don't contact all on same day
7. Set cross-reference rules — any reply pauses all other threads
8. Present multi-thread plan for approval
9. On approval, execute and track all threads in campaign logs
</process>
