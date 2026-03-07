---
name: gtm:linkedin-warm
description: Pre-outreach LinkedIn engagement warming
argument-hint: "<workspace-name>"
---
<objective>
Run a LinkedIn warming sequence — engage with prospect content before sending connection requests. Increases acceptance and reply rates.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./commands/linkedin-warming.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // LINKEDIN WARMING >>`
2. Load the target list segment about to enter a LinkedIn sequence
3. Check LinkedIn activity per contact via Crispy
4. For active profiles: plan 3-7 day warming sequence (view → like → comment → connect)
5. For inactive profiles: skip warming, go straight to connection request
6. Present warming plan for approval
7. Execute warming actions via Crispy
8. Track warming status per contact
9. After warming period, transition to connection requests
</process>
