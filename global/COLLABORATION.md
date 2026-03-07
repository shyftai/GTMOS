# Collaboration Mode — GTMOS

## Mode
Set the collaboration mode for this GTMOS instance.

```
mode: solo
```

Options:
- **solo** — File-based only. All state lives in markdown files. No database needed. Default.
- **team** — Shared state via Supabase. Suppression lists, costs, pipeline, replies, and approvals sync in real-time. Markdown files still hold context (ICP, persona, briefing, etc.).

---

## When to use team mode

Use team mode when:
- Multiple people work on the same workspace
- You need real-time suppression list enforcement across operators
- You want claim-based reply handling (no double-responses)
- You need an audit trail of who approved what
- You run an agency with multiple operators per client

Solo mode is fine when:
- One person manages the workspace end-to-end
- You don't need real-time sync between operators

---

## Supabase connection (only needed in team mode)

Set these in `.env`:
```
SUPABASE_URL=
SUPABASE_ANON_KEY=
SUPABASE_SERVICE_KEY=
```

The service key is only needed for admin operations (workspace creation, user management).
The anon key is used for all scoped operations (RLS enforces workspace isolation).

---

## What changes in team mode

| Operation | Solo mode | Team mode |
|-----------|-----------|-----------|
| Suppression check | Read SUPPRESSION.md | Query `suppression_list` table |
| Cost logging | Write to COSTS.md | Insert into `cost_transactions` |
| Cost summary | Read COSTS.md | Query `cost_summary` view |
| Pipeline status | Read PIPELINE.md | Query `pipeline_contacts` |
| Reply handling | Manual (one at a time) | Claim from `reply_queue` (locked) |
| Approvals | Verbal in chat | Logged in `approvals` table |
| Activity tracking | Workspace log file | `activity_feed` table |
| Campaign status | Read campaign.config.md | Query `campaigns` table |

### What stays file-based in both modes
- ICP.md, PERSONA.md, TOV.md, RULES.md (context — changes infrequently)
- BRIEFING.md (campaign context)
- Copy drafts and approved sequences
- Research, meeting notes, assets
- INFRASTRUCTURE.md (reference, not operational state)
- AB-TESTS.md (test design and results)
- BENCHMARKS.md (static reference)

---

## Setup instructions

1. Create a Supabase project at https://supabase.com
2. Run the migration: `supabase/migrations/001_initial_schema.sql`
3. Add your keys to `.env`
4. Change `mode: solo` to `mode: team` in this file
5. Run `/gtm:collab setup` to verify the connection and sync existing data

---

## User roles

| Role | Can do |
|------|--------|
| **owner** | Everything — manage workspace, users, settings |
| **approver** | Approve copy, lists, replies, budget overrides |
| **operator** | Build lists, write copy, handle replies, run campaigns |
| **viewer** | Read-only — dashboards, reports, health checks |

Roles are set per workspace in the `workspace_members` table.
