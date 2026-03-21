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
4. Test connection to Supabase (simple query). If connection fails:
   - Log the full error (including any connection string details) to `logs/auto-audit.md` only
   - Show the user only: `Couldn't connect to Supabase. Check your URL and key in .env, then try again. Details saved to logs/auto-audit.md.`
   - Never display raw Supabase error messages to the user
5. Verify RLS (Row-Level Security) is protecting workspace isolation:
   a. Attempt a query for a workspace_id that does not exist or does not match the current workspace
   b. If the query returns any rows: stop setup, warn the user:
      ```
      ⚠ Security check failed — your Supabase database may not have workspace isolation
      configured correctly. Before enabling team mode, ensure Row-Level Security (RLS)
      is enabled on all tables and that policies filter by workspace_id.

      This protects your data from being visible to other workspaces.
      Run the migration script and try again: supabase/migrations/001_initial_schema.sql
      ```
   c. If the query returns no rows: RLS is working — continue
6. Check if tables exist (query information_schema)
7. If tables missing, show the migration command:
   `Run supabase/migrations/001_initial_schema.sql in your Supabase SQL editor`
8. If tables exist and RLS verified, update global/COLLABORATION.md to `mode: team`
9. Display connection status:
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
4. Before syncing suppression list, show a plain-language preview and ask for confirmation:
   ```
   ┌─ BEFORE SYNCING SUPPRESSION LIST ──────────────────┐
   │                                                      │
   │  Your suppression list contains {n} contacts who     │
   │  have unsubscribed or should not be contacted.       │
   │                                                      │
   │  Uploading this to Supabase means it will be         │
   │  shared with everyone on your team who has access    │
   │  to this workspace.                                  │
   │                                                      │
   │  Upload suppression list? (yes / no)                 │
   └──────────────────────────────────────────────────────┘
   ```
   Only proceed if the user confirms yes. If no, skip suppression list and continue with other tables.
5. Read local files and push to Supabase:
   - SUPPRESSION.md → suppression_list table (only if confirmed above)
   - COSTS.md → cost_transactions table
   - PIPELINE.md → pipeline_contacts table
   - Campaign status from campaign.config.md → campaigns table
6. Show sync summary: records created/updated per table (counts only — no individual contact names or emails)
7. Log sync in activity_feed with timestamp and record counts

</process>
