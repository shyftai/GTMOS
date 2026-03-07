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
</execution_context>

<process>
1. Display mode header: `<< GTMOS // COPY LAB >>`
2. Load workspace context — BRIEFING.md, ICP.md, PERSONA.md, TOV.md, RULES.md
3. Load campaign.config.md for channel and touch count
4. Load MULTICHANNEL.md if multi-channel campaign
5. Check AB-TESTS.md for winning variants to incorporate
6. Load PERSONALIZATION.md — only use defined merge fields
7. Load BOOKING.md — use correct booking link and UTM parameters
8. Check context/research/signal-angles.md for relevant angles
9. Draft each touch following the sequence structure
10. Verify all {{variables}} exist in PERSONALIZATION.md — flag any that don't
11. Verify all links come from BOOKING.md — never invent URLs
12. If A/B test is planned, create variants A and B clearly labeled
6. Apply TOV.md channel-specific rules
7. Auto-run five-check validation on every touch — display results inline
8. Present with approval gate from ui-brand.md
9. On approval, save to copy/approved/
10. Suggest next action: `/gtm:validate-copy` or `/gtm:ship`
</process>
