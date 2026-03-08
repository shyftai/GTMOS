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
1. Display the GTM:OS startup banner from ui-brand.md
2. Display mode header: `<< GTM:OS // ONBOARDING >>`
3. Create workspace folder by copying _template/ to workspaces/$ARGUMENTS/

## Block 0 — Role selection (always first)
4. Ask: "What's your role?"
   - **SDR** — I'm prospecting, writing sequences, and managing replies daily
   - **GTM Engineer** — I set up tools, automation, and data infrastructure
   - **Head of Sales** — I need pipeline visibility, attribution, and strategy
   - **Founder** — I'm doing it all, just get me running
   - **Agency** — I manage outbound for multiple clients
5. Save role to workspace.config.md
6. Adjust onboarding path based on role (see intake-interview.md Block 0)

## Onboarding path selection
7. Ask: "How do you want to onboard?"
   - **Quick start** (5 blocks) — get running in minutes, fill the rest later (default for Founders)
   - **Full onboarding** (14 blocks) — covers everything up front
   - **Data deep-dive** — pull from CRM, existing campaigns, and transcripts to build ICP from evidence. Run `/gtm:deep-dive` first, then onboard from the data.

## Quick start path (--quick or user chooses quick)
8. Run quick-start.md — 5 blocks covering offer, target, pain, angle, voice
9. Pre-fill remaining files with defaults from defaults.md
10. Display quick start completion summary
11. Suggest role-appropriate next steps (see step 16)

## Full onboarding path (default)
8. Run the intake interview from @./commands/intake-interview.md
9. Ask questions in blocks — one block at a time, confirm before moving on
   - Skip or lighten blocks based on role:
     - SDR: skip Block 9 (infra), Block 11 (CRM pipeline) unless they manage it
     - GTM Engineer: deep-dive on Block 7 (tools), Block 9 (infra)
     - Head of Sales: light on Block 7, deep on Block 11 (pipeline), Block 14 (competitors)
     - Founder: suggest quick start, or keep blocks short
     - Agency: ask about multi-workspace needs, client reporting preferences
10. For any field the user skips or doesn't know yet, use defaults from defaults.md
11. Write answers into ICP.md, PERSONA.md, TOV.md, workspace.config.md, TOOLS.md, COSTS.md, INFRASTRUCTURE.md, SUPPRESSION.md, PIPELINE.md, MULTICHANNEL.md, BOOKING.md, COMPETITORS.md, LEARNINGS.md, ROADMAP.md
12. Ask if they want to configure Slack notifications (optional)
13. Ask if they want to customize lead scoring weights (optional — defaults apply if not)
14. Check .env for required API keys
15. Display workspace header with loaded context

## Role-based next steps
16. Suggest next actions based on role:

**SDR:**
- `/gtm:research $ARGUMENTS` — research your market
- `/gtm:new-campaign $ARGUMENTS {name}` — start your first campaign
- After shipping: `/gtm:replies`, `/gtm:signals`

**GTM Engineer:**
- `/gtm:visitor-id $ARGUMENTS --setup` — set up website visitor identification
- `/gtm:enrich $ARGUMENTS` — configure enrichment waterfall
- `/gtm:data-hygiene $ARGUMENTS` — set up data quality monitoring

**Head of Sales:**
- `/gtm:dashboard $ARGUMENTS` — see what needs attention
- `/gtm:deep-dive $ARGUMENTS` — analyze existing CRM and campaign data
- `/gtm:pipeline-velocity $ARGUMENTS` — track stage durations and bottlenecks

**Founder:**
- `/gtm:research $ARGUMENTS` — research your market
- `/gtm:new-campaign $ARGUMENTS {name}` — start your first campaign
- `/gtm:dashboard $ARGUMENTS` — check status anytime

**Agency:**
- `/gtm:onboard {next-client}` — onboard your next client
- `/gtm:clone-campaign` — clone proven campaigns across clients
- `/gtm:report $ARGUMENTS` — generate client-facing reports
</process>
