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
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display the GTMOS startup banner from ui-brand.md
2. Display mode header: `<< GTMOS // ONBOARDING >>`
3. Create workspace folder by copying _template/ to workspaces/$ARGUMENTS/
4. Run the intake interview from @./commands/intake-interview.md
5. Ask questions in blocks — one block at a time, confirm before moving on
   - Block 8: Cost tracking — per-tool pricing, monthly budget, per-campaign budget, alert threshold
   - Block 9: Sending infrastructure — outbound domains, DNS auth status, mailbox setup, warmup status
   - Block 10: Compliance — physical address, CAN-SPAM/GDPR readiness, existing suppression list
   - Block 11: CRM pipeline — CRM tool, pipeline stages, attribution model, sync preferences
   - Block 12: Multi-channel — channels in use, priority, orchestration preferences
   - Block 13: Booking links — calendar URLs, landing pages, UTM parameters
   - Block 14: Competitors — primary competitors, positioning, do-not-say list
6. Write answers into ICP.md, PERSONA.md, TOV.md, workspace.config.md, TOOLS.md, COSTS.md, INFRASTRUCTURE.md, SUPPRESSION.md, PIPELINE.md, MULTICHANNEL.md, BOOKING.md, COMPETITORS.md
7. Check .env for required API keys
8. Display workspace header with loaded context
9. Suggest next action: `/gtm:research $ARGUMENTS` or `/gtm:infra $ARGUMENTS`
</process>
