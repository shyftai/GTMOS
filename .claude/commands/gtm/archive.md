---
name: gtm:archive
description: Archive a completed campaign or workspace
argument-hint: "<workspace-name> [campaign-name]"
---
<objective>
Archive a completed campaign or workspace. Moves to archived status, preserves all data, prevents accidental sends.

Workspace and optional campaign: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // ARCHIVE >>`

## If campaign specified:
2. Load campaign.config.md — verify status is "complete" or "paused"
3. If status is "active", warn: "Campaign is still active. Run /gtm:debrief first or confirm you want to archive an active campaign."
4. Pre-archive checklist:
   - [ ] Final performance data saved in performance/results.md
   - [ ] All replies handled (none in "unhandled" status)
   - [ ] Bounced contacts added to suppression list
   - [ ] Unsubscribes added to suppression list
   - [ ] Decision log complete
   - [ ] Debrief completed (or explicitly skipped)
5. Update campaign.config.md status to "archived"
6. Update workspace.config.md — remove from active campaigns
7. Log archive in logs/workspace-log.md
8. If team mode: update campaigns table in Supabase

## If workspace (no campaign specified):
2. Check all campaigns in workspace are complete or archived
3. If any campaign is active, list them and warn
4. Pre-archive checklist:
   - [ ] All campaigns archived or complete
   - [ ] Final costs reconciled
   - [ ] Suppression list exported as backup
   - [ ] Client report generated (if agency workspace)
5. Update workspace.config.md status to "archived"
6. Log in logs/workspace-log.md

7. Display confirmation:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  ARCHIVED                                  ┃
┃  {workspace} / {campaign}                  ┃
┃  All data preserved. No sends possible.    ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```
</process>
