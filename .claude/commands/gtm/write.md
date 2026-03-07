---
name: gtm:write
description: Draft an outbound sequence for the active campaign
argument-hint: "<workspace-name> [touches] [channel]"
---
<objective>
Write an outbound sequence. Load all context, draft each touch, auto-validate, present for approval.

Workspace and options: $ARGUMENTS
</objective>

<execution_context>
@./commands/write-sequence.md
@./commands/validate-copy.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
@./.claude/gtmos/references/campaign-types.md
@./global/snippet-library.md
@./global/swipe-file.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // COPY LAB >>`
2. Load workspace context — BRIEFING.md, ICP.md, PERSONA.md, TOV.md, RULES.md
3. Load campaign.config.md for channel and touch count
4. Load campaign type from campaign-types.md — use type defaults for touch count, spacing, and structure
5. Load MULTICHANNEL.md if multi-channel campaign
6. Check AB-TESTS.md for winning variants to incorporate
7. Load PERSONALIZATION.md — only use defined merge fields
8. Load BOOKING.md — use correct booking link and UTM parameters
9. Check context/research/signal-angles.md for relevant angles
10. Load global/snippet-library.md — reference proven opening lines, CTAs, and proof lines matching this campaign's channel and angle
11. Load global/swipe-file.md — reference full sequence examples matching this campaign type as structural guides (adapt, never copy-paste)
12. Draft each touch following the sequence structure
13. Verify all {{variables}} exist in PERSONALIZATION.md — flag any that don't
14. Verify all links come from BOOKING.md — never invent URLs
15. If A/B test is planned, create variants A and B clearly labeled
16. Apply TOV.md channel-specific rules
17. Auto-run five-check validation on every touch — display results inline
18. Present with approval gate from ui-brand.md
19. On approval, save to copy/approved/
20. Suggest next action: `/gtm:validate-copy` or `/gtm:ship`
</process>
