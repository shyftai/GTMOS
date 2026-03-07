# Sending Infrastructure — [Workspace Name]

## Domains

### Primary domain
- Domain: (your main business domain — NEVER use this for cold outbound)
- Purpose: Website, corporate email only

### Outbound domains
Buy 2-5 secondary domains that are similar to your primary. Use these for all cold sending.

| Domain | Provider | Status | Mailboxes | DNS auth | Warmup status |
|--------|----------|--------|-----------|----------|---------------|
| | | setup / warming / live / paused | | | |
| | | | | | |
| | | | | | |

### Domain naming strategy
- Use variations of primary domain (e.g. if primary is acme.com: getacme.com, tryacme.com, acmehq.com)
- Avoid exact match — protect primary domain reputation at all costs
- Buy .com only — other TLDs have lower trust
- Register for at least 1 year (short registrations flag as spam)

---

## DNS Authentication

Complete ALL of these before sending a single email. Missing any one drops deliverability by up to 30%.

### Per outbound domain checklist
| Domain | SPF | DKIM | DMARC | Custom tracking domain | MX record |
|--------|-----|------|-------|----------------------|-----------|
| | [ ] | [ ] | [ ] | [ ] | [ ] |
| | [ ] | [ ] | [ ] | [ ] | [ ] |

### SPF (Sender Policy Framework)
- Add a TXT record listing authorized sending IPs/services
- Example: `v=spf1 include:_spf.google.com ~all`
- Only one SPF record per domain

### DKIM (DomainKeys Identified Mail)
- Generate DKIM keys through your email provider
- Add the CNAME or TXT record to DNS
- Verify with your provider's tool

### DMARC (Domain-based Message Authentication)
- Add after SPF and DKIM are verified
- Start with monitoring: `v=DMARC1; p=none; rua=mailto:dmarc@yourdomain.com`
- Move to quarantine after 2 weeks of clean data: `p=quarantine`
- Move to reject after 4 weeks: `p=reject`

### Custom tracking domain
- Required for link tracking — do not use shared tracking domains
- Set up a CNAME record pointing to your sending tool's tracking domain
- Isolates your click tracking reputation from other senders

---

## Mailboxes

### Mailbox setup
| Email address | Domain | Provider | Daily send limit | Warmup status | Go-live date |
|--------------|--------|----------|-----------------|---------------|-------------|
| | | Google / Microsoft / other | | | |
| | | | | | |
| | | | | | |

### Naming convention
- Use real names: james@getacme.com, sarah.c@tryacme.com
- Avoid generic: info@, sales@, noreply@
- Add profile photos and signatures to every mailbox
- Fill in the "About" section in Google/Microsoft admin

### Sending limits per inbox
- **Google Workspace:** 500/day total (warmup + cold combined)
- **Microsoft 365:** 10,000/day (but stay under 100 for cold)
- **Safe cold sending limit:** 25-40 emails per inbox per day
- **Warmup emails count toward daily limit**

---

## Warmup

### Warmup schedule
| Week | Daily volume | Notes |
|------|-------------|-------|
| Week 1 | 5-10 emails/day | Warmup tool only, no cold sends |
| Week 2 | 15-25 emails/day | Warmup tool only, no cold sends |
| Week 3 | 30-40 emails/day | Can begin cold sends at 10-15/day if metrics are good |
| Week 4 | 40-50 emails/day | Ramp cold to 25-30/day, keep warmup running |
| Ongoing | Maintain | Never turn off warmup — it maintains inbox reputation |

### Warmup tool
- Tool: (Instantly warmup / Mailreach / Warmup Inbox / other)
- Status: active / inactive
- Mailboxes connected:

### Go-live criteria (all must be met)
- [ ] Minimum 14 days of warmup completed (21+ recommended)
- [ ] Inbox placement rate above 90%
- [ ] No spam folder placement in last 7 days
- [ ] SPF, DKIM, DMARC all verified
- [ ] Custom tracking domain configured
- [ ] Test emails landing in inbox (check with seed list)

---

## Inbox Rotation

### Strategy
Distribute sending volume across multiple inboxes to stay under per-inbox limits.

- **Target volume:** [total emails per day]
- **Inboxes available:** [count]
- **Emails per inbox:** [volume / inbox count] (keep under 40)

### Rotation config
| Sending tool | Rotation enabled | Inboxes in rotation | Per-inbox limit |
|-------------|-----------------|--------------------|-----------------|
| | yes / no | | |

### Rules
- If any inbox bounces above 3%, pause it immediately
- If any inbox gets a spam complaint, pause and investigate
- Rotate sender names — not just addresses — to feel natural
- Spread sends across 8-12 hours (mimic human sending patterns)

---

## Health monitoring

### Weekly checks
- [ ] Inbox placement rate (should be >90%)
- [ ] Bounce rate per inbox (should be <3%)
- [ ] Spam complaint rate (should be <0.1%)
- [ ] Domain blacklist check (MXToolbox, Google Postmaster)
- [ ] Warmup engagement metrics still healthy

### Red flags — pause sending immediately if:
- Bounce rate exceeds 5% on any inbox
- Spam complaints exceed 0.3%
- Google Postmaster shows domain reputation drop
- Any inbox lands in spam on seed test
