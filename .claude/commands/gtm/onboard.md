---
name: gtm:onboard
description: Onboard a new workspace with structured intake interview
argument-hint: "<workspace-name>"
---
<objective>
Onboard a new workspace through a structured intake interview. Create the folder structure, ask questions in blocks, and populate all source-of-truth files.

Workspace name: $ARGUMENTS
</objective>

<execution_context>
@./commands/intake-interview.md
@./commands/quick-start.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/defaults.md
</execution_context>

<process>
1. Display the GTMOS startup banner from ui-brand.md
2. Display mode header: `<< GTMOS // ONBOARDING >>`
3. Create workspace folder by copying _template/ to workspaces/$ARGUMENTS/
4. Ask: "Full onboarding or quick start? Full covers everything (14 blocks). Quick start gets you running in 5 blocks — you can fill in the rest later."

## Quick start path (--quick or user chooses quick)
5. Run quick-start.md — 5 blocks covering offer, target, pain, angle, voice
6. Pre-fill remaining files with defaults from defaults.md
7. Display quick start completion summary
8. Suggest: `/gtm:new-campaign $ARGUMENTS {name}`

## Full onboarding path (default)
5. Run the intake interview from @./commands/intake-interview.md
6. Ask questions in blocks — one block at a time, confirm before moving on
   - Block 8: Cost tracking — per-tool pricing, monthly budget, per-campaign budget, alert threshold
   - Block 9: Sending infrastructure — outbound domains, DNS auth status, mailbox setup, warmup status
   - Block 10: Compliance — physical address, CAN-SPAM/GDPR readiness, existing suppression list
   - Block 11: CRM pipeline — CRM tool, pipeline stages, attribution model, sync preferences
   - Block 12: Multi-channel — channels in use, priority, orchestration preferences
   - Block 13: Booking links — calendar URLs, landing pages, UTM parameters
   - Block 14: Competitors — primary competitors, positioning, do-not-say list
7. For any field the user skips or doesn't know yet, use defaults from defaults.md
8. Write answers into ICP.md, PERSONA.md, TOV.md, workspace.config.md, TOOLS.md, COSTS.md, INFRASTRUCTURE.md, SUPPRESSION.md, PIPELINE.md, MULTICHANNEL.md, BOOKING.md, COMPETITORS.md
9. Ask if they want to configure Slack notifications (optional)
10. Ask if they want to customize lead scoring weights (optional — defaults apply if not)
11. Check .env for required API keys
12. Display workspace header with loaded context
13. Suggest next action: `/gtm:research $ARGUMENTS` or `/gtm:new-campaign $ARGUMENTS {name}`
</process>
