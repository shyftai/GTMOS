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
3. Validate the workspace name from $ARGUMENTS before creating any folder:
   - Only allow letters, numbers, hyphens, and underscores (no spaces, slashes, dots, or special characters)
   - Maximum 64 characters
   - If the name fails validation, stop and explain in plain language:
     ```
     That name won't work — workspace names can only contain letters, numbers, hyphens (-),
     and underscores (_). No spaces or special characters. Try something like "acme-corp" or "client_2024".
     ```
   - Show the validated name back before creating the folder: `Creating workspace folder: workspaces/{name}/ — looks good!`

3.5. Create workspace folder by copying _template/ to workspaces/{validated_name}/

## Environment setup
3.6. Check if `.env` exists at the repo root:
   - If `.env` does NOT exist: copy `.env.example` → `.env` and tell the user:
     ```
     ✓ .env created — this file will store your API keys. It stays on your computer only.
     ```
   - If `.env` already exists: proceed without touching it

3.7. Check if `.env` is in `.gitignore`:
   - Read `.gitignore` at the repo root (if it exists)
   - If `.env` is NOT listed in `.gitignore`:
     - Add `.env` to `.gitignore` automatically
     - Tell the user in plain language:
       ```
       ✓ Added .env to .gitignore — this stops your API keys from being accidentally
         uploaded if you ever share this folder with git. (This is important.)
       ```
   - If `.gitignore` doesn't exist yet, create it with `.env` as the first entry
   - If `.env` is already in `.gitignore`: confirm silently, no message needed

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
10. Ask: "Would you like to receive GTM:OS updates and tips by email? (optional — takes 10 seconds)"
   - If yes: collect email and company name, then show exactly what will be sent before making any request:
     ```
     ┌─ BEFORE WE SEND ANYTHING ──────────────────────────┐
     │                                                      │
     │  We'll send the following to shyft.ai:               │
     │                                                      │
     │    Your email:    {email}                            │
     │    Company name:  {company_name}                     │
     │    GTM:OS version: 1.4.0                            │
     │                                                      │
     │  That's it. No keys, no workspace data, no contacts. │
     │  You can unsubscribe at any time.                    │
     │                                                      │
     │  Send this? (yes / no)                              │
     └──────────────────────────────────────────────────────┘
     ```
   - Only proceed with the POST if the user confirms yes:
     ```
     POST https://shyft.ai/api/hooks/register
     {
       "os": "gtmos",
       "version": "1.4.0",
       "company": "{company_name}",
       "email": "{email}",
       "timestamp": "{ISO 8601}"
     }
     ```
     Note: workspace name is NOT included in the payload.
     Show: `Registered — you'll get updates at {email}`
   - If no: skip gracefully. Show: `Skipped — you can register anytime with /gtm:feedback`
   - If the POST fails, show: `Registration didn't go through — you can try again later with /gtm:feedback. Continuing setup.`
   - Never include API keys, workspace file contents, contact data, or suppression lists in this request.
   - This step never blocks onboarding.

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
17. Check .env for required API keys and MCP servers:
    - Read TOOLS.md to identify tools marked as `active`
    - For each active tool whose key is missing from `.env`, prompt the user:
      ```
      Missing API key: {TOOL_NAME}
      Paste your {TOOL_NAME} API key (or press Enter to skip):
      >>
      ```
    - If any keys are available from an external source (e.g. a connected profile, MCP server, or integration): **do not write them silently**. Collect them into the review step below instead.

    **Before writing anything to .env**, display a full preview of every key that will be written and its source:
      ```
      ┌─ REVIEW: KEYS TO BE WRITTEN TO .env ────────────────────┐
      │                                                           │
      │  The following keys will be added to your .env file.     │
      │  Review each one before confirming.                       │
      │                                                           │
      │  APOLLO_API_KEY      ••••••••••••••••7f3a   [you pasted] │
      │  INSTANTLY_API_KEY   ••••••••••••••••2c91   [you pasted] │
      │  FIRECRAWL_API_KEY   ••••••••••••••••a40e   [Shyft profile] │
      │                                                           │
      │  Keys sourced from your Shyft profile are marked above.  │
      │  They will only be written if you confirm below.         │
      │                                                           │
      └───────────────────────────────────────────────────────────┘

      Write these keys to .env? (yes / no / review each one)
      >>
      ```

    - **If the user selects "review each one"**: step through each key individually, showing the tool name, masked value, and source, and ask yes/no per key.
    - **If the user selects "no"**: skip all writes. Tell the user they can add keys anytime with `/gtm:infra`.
    - **Only write keys the user explicitly confirms.** Never write a key from any source — profile, MCP, or user paste — without this confirmation step.
    - Show values masked (last 4 characters visible, rest replaced with `•`) — never display the full key value.
    - Always disclose the source of each key: `[you pasted]`, `[Shyft profile]`, `[auto-detected]`, etc.

    After confirmed writes, display the final state:
      ```
      ┌─ API KEYS ──────────────────────────────────┐
      │  [x] Apollo          [x] Instantly           │
      │  [ ] Lemlist — add later with /gtm:infra     │
      └──────────────────────────────────────────────┘
      ```
    - Never block onboarding if a key is skipped — the user can add it later
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
