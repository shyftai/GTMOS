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
1. Display mode header: `<< GTM:OS // REPLY DESK >>`
2. Load workspace context — PERSONA.md, TOV.md, BRIEFING.md, TOOLS.md
3. Pull unprocessed replies from active tools
4. Classify each reply into one of seven types
5. Draft response per type following handle-replies.md
6. Validate all drafts against TOV.md
7. Display each reply using the reply classification format from ui-brand.md
8. Present each for approval — nothing sent without explicit yes
9. Log all classifications and actions in logs/decisions.md
10. **Update LEARNINGS.md** — if reply patterns emerge (new objections, unexpected positive signals, persona insights), append to relevant sections. Tag source as "Reply analysis — {campaign} — {date}".
11. **Update ROADMAP.md to-dos** — if replies surface actionable improvements. Examples: "Add objection response for '{objection}' to snippet library" (Medium), "Remove {company type} from ICP — 3rd negative reply from this segment" (High). Only add if pattern is clear, not for one-off replies.
12. Save to replies/[date].md
</process>
