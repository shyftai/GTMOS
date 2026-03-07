# Collaboration Reference — For Commands

This file tells commands how to behave depending on collaboration mode.

---

## Detecting mode

1. Read `global/COLLABORATION.md`
2. Check the `mode:` value — either `solo` or `team`
3. If `team`, check `.env` for `SUPABASE_URL` and `SUPABASE_ANON_KEY`
4. If keys are missing, warn and fall back to solo mode

---

## Command behaviour by mode

### Suppression check (before list validation, before sending)

**Solo:**
```
Read workspace SUPPRESSION.md → check email against the table
```

**Team:**
```
Query: select email from suppression_list where workspace_id = '{id}' and email = '{contact_email}'
If match → reject the contact, same as solo
```

### Cost logging (after every tool write)

**Solo:**
```
Append to COSTS.md transaction log
Update running totals in COSTS.md
```

**Team:**
```
Insert into cost_transactions (workspace_id, campaign_id, tool, action, units, cost_per_unit, approved_by)
Running totals are auto-calculated by the cost_summary view
Also update COSTS.md as a local cache
```

### Reply handling

**Solo:**
```
User provides reply → classify → draft response → present for approval
```

**Team:**
```
1. Query: select * from reply_queue where workspace_id = '{id}' and status = 'unhandled' order by received_at limit 1
2. Claim: update reply_queue set status = 'claimed', claimed_by = '{user}', claimed_at = now() where id = '{reply_id}' and status = 'unhandled'
   (If 0 rows updated → someone else claimed it, fetch next)
3. Classify and draft response
4. Update: set status = 'handled', classification = '{type}', response_draft = '{draft}', handled_at = now()
5. If unsubscribe → also insert into suppression_list
```

### Pipeline updates

**Solo:**
```
Update PIPELINE.md manually
```

**Team:**
```
Update pipeline_contacts set stage = '{new_stage}', updated_by = '{user}' where id = '{contact_id}'
Pipeline funnel view auto-recalculates
```

### Approvals

**Solo:**
```
Ask in chat → user says yes/no → log in decisions.md
```

**Team:**
```
Insert into approvals (workspace_id, campaign_id, item_type, item_description, requested_by, status = 'pending')
Approver reviews → update set status = 'approved'/'rejected', decided_by, decided_at
```

### Activity logging

**Solo:**
```
Append to logs/workspace-log.md
```

**Team:**
```
Insert into activity_feed (workspace_id, campaign_id, user_id, action, detail)
Also append to logs/workspace-log.md as local record
```

---

## Dual-write rule

In team mode, always write to BOTH Supabase AND the local markdown file.
The markdown file serves as a local cache and audit trail.
Supabase is the source of truth for shared state.
If there's a conflict, Supabase wins.

---

## Fallback rule

If a Supabase query fails (network error, auth error, table missing):
1. Log the error
2. Fall back to file-based mode for that operation
3. Warn the user: "Supabase unavailable — using local files. Changes won't sync to team."
4. Do NOT block the operation — solo mode is always the safety net
