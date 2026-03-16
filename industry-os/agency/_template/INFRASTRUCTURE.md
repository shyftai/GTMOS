# Infrastructure — [Agency Name]

Sending infrastructure for new business outbound. Never send from the agency's primary domain.

---

## Sending domains

| Domain | Purpose | Warmup status | Health | DNS | Inboxes |
|--------|---------|--------------|--------|-----|---------|
| outreach.[agencyname].com | Cold outbound | [ ] warming / [x] warm | Green | [ ] SPF [ ] DKIM [ ] DMARC | 3 |
| news.[agencyname].com | Newsletter / nurture | [ ] warming / [x] warm | Green | [ ] SPF [ ] DKIM [ ] DMARC | 2 |

**Never send from:** [agencyname].com (primary domain — protect deliverability)

---

## Email inboxes

| Inbox | Domain | Provider | Sending tool | Daily limit | Warmup started | Status |
|-------|--------|----------|--------------|-------------|---------------|--------|
| [name@outreach.agency.com] | outreach.[agencyname].com | Google Workspace | Instantly | 30/day | [date] | Warming |
| [name@outreach.agency.com] | outreach.[agencyname].com | Google Workspace | Instantly | 30/day | [date] | Warm |

**Daily send capacity:** [total across all warm inboxes]
**Recommended daily sends:** [total x 0.8 for safety buffer]

---

## DNS records

### outreach.[agencyname].com

- [ ] SPF: `v=spf1 include:sendgrid.net ~all`
- [ ] DKIM: configured in sending tool
- [ ] DMARC: `v=DMARC1; p=quarantine; rua=mailto:[postmaster@agencyname.com]`
- [ ] MX: routing to Google Workspace
- [ ] Custom tracking domain: configured in sending tool

---

## Sending tool config

**Tool:** [Instantly / Lemlist / Smartlead]

- Daily sending limit per inbox: 30 emails (warming) / 50 emails (warm)
- Sending window: 8am–5pm prospect local time
- Randomised delays between sends: 3–5 minutes
- Reply detection: enabled — pause sequence on reply
- Bounce handling: hard bounce = auto-suppress
- Open tracking: enabled
- Click tracking: enabled (use custom tracking domain)

---

## Inbox health monitoring

Check deliverability weekly. Run `/gtm:inbox-health` to automate.

| Inbox | Spam rate | Bounce rate | Open rate | Last checked | Status |
|-------|----------|------------|-----------|-------------|--------|
| | | | | | |

**Thresholds:**
- Spam rate > 0.1%: yellow alert
- Spam rate > 0.3%: red alert — pause inbox immediately
- Bounce rate > 2%: audit list source
- Bounce rate > 5%: pause and diagnose

---

## Notes

- Rotate sending inboxes across multiple domains to distribute risk
- Never send from a domain less than 14 days into warmup
- Always use the custom tracking domain — never the sending tool's default
