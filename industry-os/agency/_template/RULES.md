# Rules — [Agency Name]

Agency-specific rules and constraints. These override and extend the global rules in `../../global/RULES-GLOBAL.md`.

---

## Hard rules — never override

**Client conflict rule:**
Never contact a prospect who appears in CLIENTS.md through any new business sequence. This includes parent companies, subsidiaries, and named contacts at client companies. Violation risks damaging the existing client relationship. This is a hard stop — not a warning.

**Service line rule:**
Never pitch, propose, or commit to a service not listed in SERVICE-LINES.md. If a prospect asks for something not listed, flag it and ask before proceeding. Adding a service to a proposal without adding it to SERVICE-LINES.md is not allowed.

**Proposal quality rule:**
Never generate a proposal without at least one relevant case study from CASE-STUDIES.md. A pitch without proof is a cold claim. If no case study exists for the relevant vertical or service, surface the gap and ask before proceeding.

**Sending domain rule:**
Never send cold outbound from the agency's primary domain. Always use a subdomain (e.g. `news.agencyname.com`, `outreach.agencyname.com`). Primary domain deliverability is an asset — protect it.

**Suppression rule:**
All current clients (from CLIENTS.md) are automatically on the suppression list. Check before every send. Never remove a client from suppression without explicit instruction.

---

## Operational rules

**QBR cadence:**
QBR required every 90 days for any retainer client. If a QBR is overdue, flag it in `/agency:portfolio`. Do not proceed with renewal conversations before completing the QBR.

**Renewal outreach timing:**
Renewal outreach starts 60 days before contract end. Not 30 days. Not 14 days. 60 days — this gives time for a proper QBR, renewal proposal, and negotiation. Flag renewals in the 60-day window in `/agency:portfolio`.

**Health escalation:**
Any Red-health client (from CLIENTS.md) requires account lead involvement before any client-facing communication. Do not draft renewal, upsell, or QBR materials for a Red-health client without first confirming the escalation path.

**Pipeline staleness:**
Any deal in the same stage for 30+ days is stale. Flag it in PIPELINE.md and prompt for a follow-up action. Do not let deals age silently.

---

## Copy rules (agency-specific)

- Never use the agency name in the subject line of cold outbound
- Never open with "I" as the first word
- Never compliment the prospect's company unprompted
- Never reference a case study with placeholder text — proof points must be real
- Maximum cold email length: 80 words (CMO), 100 words (VP Marketing), 60 words (Founder)
- First LinkedIn message: 50 words max, no links

---

## Compliance rules

- Include physical address in all commercial emails (CAN-SPAM requirement)
- Include unsubscribe mechanism in all sequences
- GDPR: If prospect is in EU, email is permissible for B2B under legitimate interest. Follow-up only if first message is relevant and non-intrusive.
- CASL: Canadian prospects require implied or express consent. Implied consent: public contact info + relevant context.
- Never send to personal email addresses harvested from social profiles without consent
- Unsubscribe requests: action within 48 hours, add to SUPPRESSION.md immediately, never contact again

---

## Approval rules

- All cold email sequences: review before shipping (hard gate even in auto mode)
- All proposals: review before sending (hard gate)
- CRM writes: confirm before any create/update/delete
- Renewal proposals: account lead approval required
- Discounts above 10%: account director approval required

---

## Enrichment waterfall overrides

If this workspace uses a different enrichment order than the GTM:OS default, specify it here:

- Email enrichment order: [e.g. Apollo → Hunter.io → Prospeo]
- Company enrichment order: [e.g. Apollo → Firecrawl]
- Override reason: [why this workspace differs]

If not specified, use the default waterfall from `../../.claude/gtmos/references/enrichment-waterfall.md`.

---

## Notes

- Rules can be tightened here (stricter) but not loosened below global minimums
- Any rule change requires explicit instruction — Claude will not modify RULES.md autonomously
- Log any rule exceptions in COSTS.md or `logs/decisions.md` with reason and approver
