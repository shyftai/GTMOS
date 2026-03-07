---
name: gtm:re-engage
description: Re-engagement campaign for contacts who went cold
argument-hint: "<workspace-name> [source-campaign]"
---
<objective>
Create a re-engagement campaign for contacts from a previous sequence who didn't convert. Different rules than cold outreach.

Workspace and source campaign: $ARGUMENTS
</objective>

<execution_context>
@./commands/re-engage.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
@./.claude/gtmos/references/campaign-types.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // RE-ENGAGE >>`
2. Load SUPPRESSION.md, ICP.md, PERSONA.md
3. Pull non-responders from source campaign (minimum 60 days since last touch)
4. Filter out: replied contacts, suppressed contacts, ICP mismatches
5. Check for new signals on remaining contacts
6. Choose re-engagement angle (must differ from original campaign)
7. Draft 2-touch sequence following re-engagement rules
8. Validate and present for approval
9. Track separately in PIPELINE.md with "re-engagement" tag
</process>
