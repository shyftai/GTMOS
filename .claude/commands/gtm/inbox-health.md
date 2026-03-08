---
name: gtm:inbox-health
description: Monitor inbox and domain health — deliverability, warmup, reputation
argument-hint: "<workspace-name>"
---
<objective>
Proactive health check on sending infrastructure. Monitor inbox warmup status, bounce rates per inbox, domain reputation indicators, and deliverability trends. Flag problems before they hurt campaigns.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
@./.claude/gtmos/references/BENCHMARKS.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // INBOX HEALTH >>`
2. Load INFRASTRUCTURE.md — domains, inboxes, DNS status, warmup status
3. Load TOOLS.md — which sending tools are active
4. Load campaign performance data — bounce rates, spam complaints per inbox

## Data collection
5. For each sending tool, pull inbox-level metrics:

**Instantly:**
- Per-account warmup score and status
- Per-account bounce rate, spam rate
- Account health score
- Daily sending volume vs limit

**Lemlist:**
- Per-sender delivery stats
- Bounce rate per sender
- Warmup status

**Smartlead:**
- Per-mailbox health metrics
- Warmup progress
- Deliverability scores

6. For each domain, check:
- SPF, DKIM, DMARC status (from INFRASTRUCTURE.md, verify if stale)
- Bounce rate across all inboxes on this domain
- Spam complaint rate
- Age of domain (newer = higher risk)
- Number of inboxes per domain

## Display
7. Show the inbox health dashboard:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  INBOX HEALTH — {Workspace}                                  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  Domains
    outbound-1.co    SPF ✓  DKIM ✓  DMARC ✓    Bounce: 1.2%  ▲ healthy
    outbound-2.co    SPF ✓  DKIM ✓  DMARC ✗    Bounce: 3.8%  !! fix DMARC
    outbound-3.co    SPF ✓  DKIM ✓  DMARC ✓    Bounce: 0.5%  ▲ healthy

  Inboxes
    sarah@outbound-1.co     Warmed ✓   Volume: 35/day   Bounce: 0.8%   ▲
    mike@outbound-1.co      Warmed ✓   Volume: 30/day   Bounce: 1.5%   ▲
    alex@outbound-2.co      Warming     Volume: 15/day   Bounce: 4.2%   !!
    lisa@outbound-2.co      Warmed ✓   Volume: 25/day   Bounce: 3.4%   !!
    tom@outbound-3.co       Warmed ✓   Volume: 40/day   Bounce: 0.3%   ▲

  Summary
    Domains: 3 (2 healthy, 1 needs attention)
    Inboxes: 5 (3 healthy, 1 warming, 1 at risk)
    Total daily capacity: 145 emails/day
    Avg bounce rate: 2.0% (benchmark: <2%)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Risk detection
8. Flag issues with severity:

**Critical (pause sending):**
- Bounce rate >5% on any inbox → pause immediately
- Spam complaint rate >0.1% → investigate
- SPF/DKIM/DMARC failing → emails going to spam

**Warning (fix soon):**
- Bounce rate 3-5% on any inbox → clean list, check sources
- Domain <30 days old still warming → don't increase volume
- Inbox warmup score dropping → check warmup tool settings

**Monitor:**
- Bounce rate 2-3% — trending up?
- Volume approaching daily limit
- One inbox carrying disproportionate load

9. Display action items:
```
  Actions needed
    !! CRITICAL: Pause alex@outbound-2.co — bounce rate 4.2%
       → Clean list sources feeding this inbox
       → Re-verify all emails sent from this inbox
    !! WARNING: Set up DMARC on outbound-2.co
       → Add DMARC record: v=DMARC1; p=none; rua=mailto:{email}
    >> Inbox alex@outbound-2.co approaching daily limit
       → Consider adding another inbox to outbound-2.co
```

10. Update INFRASTRUCTURE.md with latest health status
11. Add critical/warning items as to-dos in ROADMAP.md
12. If issues found, suggest: "Run `/gtm:inbox-health` weekly to catch problems early"
</process>
</content>
