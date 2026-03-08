---
name: gtm:use-template
description: Create a new sequence from a saved template
argument-hint: "<workspace-name> <template-name>"
---
<objective>
Load a saved sequence template and adapt it for the current workspace and campaign. Fill placeholders with workspace-specific details, apply TOV and persona rules, and run quality checks.

Workspace and template: $ARGUMENTS
</objective>

<execution_context>
@./commands/validate-copy.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // USE TEMPLATE >>`
2. Load template from global/templates/{template-name}.md
3. Load workspace context — BRIEFING.md, ICP.md, PERSONA.md, TOV.md, RULES.md
4. Load campaign.config.md for current campaign settings
5. Load LEARNINGS.md — check for learnings relevant to this template's type/persona
6. Load PERSONALIZATION.md — available merge fields
7. Load BOOKING.md — booking links and UTMs

## Adaptation
8. Display template metadata and performance history
9. Fill placeholders with workspace-specific content:
   - [YOUR PRODUCT] → from BRIEFING.md
   - [PAIN POINT] → from ICP.md / PERSONA.md
   - [PROOF POINT] → from BRIEFING.md
   - [COMPETITOR] → from COMPETITORS.md
   - Booking links → from BOOKING.md

10. Apply workspace rules:
    - Adjust tone to match TOV.md
    - Apply persona-specific language from PERSONA.md
    - Check merge fields against PERSONALIZATION.md
    - Apply RULES.md constraints (forbidden words, compliance)

11. Apply learnings:
    - If LEARNINGS.md says "question subject lines +40%" → check subject lines match
    - If anti-learnings say "don't use 6 touches for SMB" → adjust touch count
    - Surface relevant learnings: "Based on your learnings, consider..."

12. Display adapted sequence with changes highlighted:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  TEMPLATE ADAPTED — {template-name} → {campaign}             ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                              ┃
┃  Original: {pct}% reply rate on {original persona}           ┃
┃  Adapted for: {current persona} at {current ICP}             ┃
┃                                                              ┃
┃  Changes made:                                               ┃
┃  · Replaced [YOUR PRODUCT] with "{product name}"             ┃
┃  · Adjusted tone from casual → professional (per TOV.md)     ┃
┃  · Applied learning: switched to question subject lines      ┃
┃  · Shortened to 4 touches (anti-learning: SMB drops off)     ┃
┃                                                              ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

13. Show each adapted touch for review
14. Run five-check validation on all touches
15. Present with approval gate
16. On approval, save to copy/approved/ in the campaign folder
17. Suggest: `/gtm:validate-copy` or `/gtm:ship`
</process>
</content>
