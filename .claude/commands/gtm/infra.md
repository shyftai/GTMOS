---
name: gtm:infra
description: Check sending infrastructure health and readiness
argument-hint: "<workspace-name>"
---
<objective>
Audit the sending infrastructure for a workspace — domains, DNS, mailboxes, warmup status, and inbox health.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/BENCHMARKS.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // INFRASTRUCTURE CHECK >>`
2. Load workspace INFRASTRUCTURE.md
3. Load workspace SUPPRESSION.md
4. Run domain audit:
   - Check all outbound domains have SPF, DKIM, DMARC
   - Flag any domain missing DNS authentication
   - Check domain age (flag if <30 days)
   - Check DMARC policy progression (none → quarantine → reject)
5. Run mailbox audit:
   - Count total inboxes, live vs warming
   - Check per-inbox daily send limits (flag if >50)
   - Check warmup duration (flag if <14 days)
   - Calculate total daily sending capacity
6. Run warmup status check:
   - Show warmup stage for each inbox
   - Flag any inbox that hasn't met go-live criteria
   - Show inbox placement rate if available
7. Run compliance check:
   - Verify CAN-SPAM checklist in SUPPRESSION.md
   - Verify GDPR checklist
   - Check physical address is set
   - Check suppression list is populated and maintained
8. Display infrastructure health dashboard:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  INFRASTRUCTURE HEALTH — {workspace}       ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃  Domains:    {count} active  {issues}      ┃
┃  DNS Auth:   {status}                      ┃
┃  Mailboxes:  {live}/{total} live           ┃
┃  Capacity:   {n} emails/day                ┃
┃  Warmup:     {status}                      ┃
┃  Compliance: {status}                      ┃
┃  Suppression: {count} contacts             ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```
9. List any issues found with severity (critical / warning / info)
10. Suggest next actions:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Next: /gtm:health {workspace} {campaign}
     Also: /gtm:warmup {workspace}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
