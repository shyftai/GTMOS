---
name: gtm:warmup
description: Check warmup status and readiness for all inboxes
argument-hint: "<workspace-name>"
---
<objective>
Show detailed warmup status for all mailboxes in a workspace and determine which are ready for cold sending.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/BENCHMARKS.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // WARMUP STATUS >>`
2. Load workspace INFRASTRUCTURE.md
3. For each mailbox, display warmup progress:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  WARMUP STATUS — {workspace}               ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                            ┃
┃  {email}                                   ┃
┃  Week: {n}/4  Volume: {n}/day              ┃
┃  ████████████░░░░  75%                     ┃
┃  Status: {warming/ready/live}              ┃
┃                                            ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```
4. Go-live checklist per inbox:
   - [ ] 14+ days warmup completed
   - [ ] Inbox placement rate >90%
   - [ ] No spam folder placement in 7 days
   - [ ] SPF, DKIM, DMARC verified on domain
   - [ ] Custom tracking domain configured
   - [ ] Test email lands in inbox
5. Show summary:
   - Total inboxes: {n}
   - Ready for cold send: {n}
   - Still warming: {n}
   - Total daily cold capacity: {n} emails/day
6. If any inbox is ready but not yet sending, flag it as available capacity
7. If any inbox has been warming for >28 days without going live, flag as stale
8. Suggest next actions:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Next: /gtm:infra {workspace}
     Also: /gtm:new-campaign {workspace} {name}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
