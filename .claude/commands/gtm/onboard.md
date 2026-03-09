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

## Collaboration mode (after role)
7. Ask: "Are you working solo or with a team?"
   - **Solo** (default) — everything stays in local files, no setup needed
   - **Team** — shared state via Supabase: real-time suppression lists, claim-based reply handling, live cost tracking, approval audit trail, activity feed

   Role-based defaults:
   - **SDR** → ask (depends on team size)
   - **GTM Engineer** → suggest team mode if multiple operators
   - **Head of Sales** → suggest team mode (needs visibility into what SDRs are doing)
   - **Founder** → default solo (unless they have a team)
   - **Agency** → strongly suggest team mode (multiple operators, multiple clients, need audit trail)

   If **Team** selected:
   a. Check .env for SUPABASE_URL, SUPABASE_ANON_KEY, SUPABASE_SERVICE_KEY
   b. If keys present → test connection, confirm tables exist, set mode to `team` in COLLABORATION.md
   c. If keys missing → show setup steps:
      ```
      1. Create a free Supabase project at supabase.com
      2. Run the migration: supabase/migrations/001_initial_schema.sql
      3. Copy your project URL and keys to .env
      4. Run /gtm:collab setup to connect
      ```
   d. Ask: "Want to set this up now or skip and add it later?"
   e. If skip → set mode to `solo`, note in workspace.config.md that team mode is pending

   If **Solo** selected:
   - Set mode to `solo` in COLLABORATION.md
   - Skip Supabase setup entirely

## Execution mode (after collaboration)
8. Ask: "How should I handle approvals?"
   - **Interactive** (default) — I'll confirm each major decision before proceeding
   - **Auto** — I'll auto-approve and keep moving. Only stops for shipping, suppression violations, budget overages, and compliance failures.

   Role-based defaults:
   - **SDR** → suggest auto (they want speed)
   - **GTM Engineer** → default interactive (configuring infra needs precision)
   - **Head of Sales** → default interactive (reviewing strategy)
   - **Founder** → suggest auto (they want to move fast)
   - **Agency** → default interactive (client work needs checkpoints)

   Save to workspace.config.md as `**Execution mode:** auto` or `**Execution mode:** interactive`

9. Ask if they want Slack notifications (works in both modes if Slack MCP connected):
   - If Slack MCP detected → "Want alerts for positive replies, budget warnings, and domain issues in Slack?"
   - If not detected → skip

## Registration (optional)
10. Ask: "Would you like to register this workspace for updates, tips, and priority support? (just your email and company name)"
   - If yes: collect email and company name, then POST to the registration endpoint:
     ```
     POST https://hooks.shyftai.com/register
     {
       "os": "gtmos",
       "version": "1.4.0",
       "company": "{company_name}",
       "email": "{email}",
       "workspace": "$ARGUMENTS",
       "timestamp": "{ISO 8601}"
     }
     ```
     Show: `Registered — you'll get updates at {email}`
   - If no: skip gracefully. Show: `Skipped — you can register anytime with /gtm:feedback`
   - This step never blocks onboarding. If the POST fails, ignore silently and continue.

## Onboarding path selection
11. Ask: "How do you want to onboard?"
   - **Quick start** (5 blocks) — get running in minutes, fill the rest later (default for Founders)
   - **Full onboarding** (14 blocks) — covers everything up front
   - **Data deep-dive** — pull from CRM, existing campaigns, and transcripts to build ICP from evidence. Run `/gtm:deep-dive` first, then onboard from the data.

## Quick start path (--quick or user chooses quick)
12. Run quick-start.md — 5 blocks covering offer, target, pain, angle, voice
13. Pre-fill remaining files with defaults from defaults.md
14. Display quick start completion summary
15. Suggest role-appropriate next steps (see step 21)

## Full onboarding path (default)
12. Run the intake interview from @./commands/intake-interview.md
13. Ask questions in blocks — one block at a time, confirm before moving on
    - Skip or lighten blocks based on role:
      - SDR: skip Block 9 (infra), Block 11 (CRM pipeline) unless they manage it
      - GTM Engineer: deep-dive on Block 7 (tools), Block 9 (infra)
      - Head of Sales: light on Block 7, deep on Block 11 (pipeline), Block 14 (competitors)
      - Founder: suggest quick start, or keep blocks short
      - Agency: ask about multi-workspace needs, client reporting preferences
14. For any field the user skips or doesn't know yet, use defaults from defaults.md
15. Write answers into ICP.md, PERSONA.md, TOV.md, workspace.config.md, TOOLS.md, COSTS.md, INFRASTRUCTURE.md, SUPPRESSION.md, PIPELINE.md, MULTICHANNEL.md, BOOKING.md, COMPETITORS.md, LEARNINGS.md, ROADMAP.md
16. Ask if they want to customize lead scoring weights (optional — defaults apply if not)
17. Check .env for required API keys and MCP servers
18. If team mode: run initial sync to Supabase (`/gtm:collab sync`)
19. Display workspace header with loaded context — include collaboration mode, execution mode, and Slack status

## Role-based next steps
20. Suggest next actions based on role:

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
