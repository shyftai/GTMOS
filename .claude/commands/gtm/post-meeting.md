---
name: gtm:post-meeting
description: Post-meeting follow-up workflow — research brief, follow-up email, CRM updates
argument-hint: "<workspace-name> [contact-name]"
---
<objective>
Run the post-meeting workflow — generate pre-call research brief, draft follow-up email, update CRM pipeline, create next-step tasks.

Workspace and contact: $ARGUMENTS
</objective>

<execution_context>
@./commands/post-meeting.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // POST-MEETING >>`
2. Load workspace context — BRIEFING.md, PERSONA.md, TOV.md, PIPELINE.md, COMPETITORS.md, LEARNINGS.md
3. Determine if this is pre-call (research brief) or post-call (follow-up)
4. Pre-call: generate research brief with company overview, signals, pain points, discovery questions
5. Post-call: log the converting touch to LEARNINGS.md, draft follow-up email, update CRM stage, create tasks
6. If deal is dead: log reason in PIPELINE.md lost deal analysis
7. Log all actions in campaign logs/decisions.md
</process>
