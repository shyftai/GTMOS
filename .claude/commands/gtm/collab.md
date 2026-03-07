---
name: gtm:collab
description: Set up or manage collaboration mode (solo/team)
argument-hint: "<setup|status|invite|sync>"
---
<objective>
Manage GTM:OS collaboration mode. Set up Supabase connection, check status, invite users, or sync local data to the shared database.

Action: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/collaboration.md
</execution_context>

<process>

## Action: setup
1. Display mode header: `<< GTM:OS // COLLABORATION SETUP >>`
2. Check .env for SUPABASE_URL and SUPABASE_ANON_KEY
3. If missing, show what needs to be added to .env and stop
4. Test connection to Supabase (simple query)
5. Check if tables exist (query information_schema)
6. If tables missing, show the migration command:
   `Run supabase/migrations/001_initial_schema.sql in your Supabase SQL editor`
7. If tables exist, update global/COLLABORATION.md to `mode: team`
8. Display connection status:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  COLLABORATION — CONNECTED                 ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃  Mode:       team                          ┃
┃  Supabase:   connected                     ┃
┃  Tables:     {n}/9 ready                   ┃
┃  Users:      {n} registered                ┃
┃  Workspaces: {n} synced                    ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

## Action: status
1. Display mode header: `<< GTM:OS // COLLABORATION STATUS >>`
2. Read global/COLLABORATION.md for current mode
3. If solo: show "Running in solo mode. Run /gtm:collab setup to enable team mode."
4. If team: test connection, show status dashboard, show active users per workspace

## Action: invite
1. Display mode header: `<< GTM:OS // INVITE USER >>`
2. Must be in team mode — if solo, redirect to setup
3. Ask for: email, display name, role (owner/approver/operator/viewer), workspace(s)
4. Create user in Supabase auth (or show manual invite link)
5. Add workspace_members entries
6. Log in activity_feed

## Action: sync
1. Display mode header: `<< GTM:OS // SYNC TO SUPABASE >>`
2. Must be in team mode
3. Ask which workspace to sync
4. Read local files and push to Supabase:
   - SUPPRESSION.md → suppression_list table
   - COSTS.md → cost_transactions table
   - PIPELINE.md → pipeline_contacts table
   - Campaign status from campaign.config.md → campaigns table
5. Show sync summary: records created/updated per table
6. Log sync in activity_feed

</process>
