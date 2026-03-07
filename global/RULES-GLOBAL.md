# Global Rules

## Email deliverability
- Never send to unverified addresses without flagging catch-all status
- Do not import contacts with known bounce history
- Minimum 3 days between touches in any sequence
- Hard bounces: remove from all lists immediately, add to suppression
- Soft bounces: retry once after 48 hours, then suppress if still bouncing
- Bounce rate target: below 2% per campaign; above 5% = pause and audit
- Spam complaint rate target: below 0.1%; above 0.3% = pause sending immediately
- Never send cold email from the primary business domain

## Sending infrastructure
- All outbound domains must have SPF, DKIM, and DMARC configured before sending
- Minimum 14 days warmup before cold sending (21+ recommended)
- Maximum 40 cold emails per inbox per day
- Warmup must stay active on all sending inboxes — never turn off
- Inbox rotation must be enabled when using multiple inboxes
- Custom tracking domains required — never use shared tracking domains

## Compliance and privacy regulations
- Active regulations are configured per workspace in SUPPRESSION.md `## Active regulations`
- Auto-detected from target geography during onboarding — overridable via `/gtm:compliance`
- Pre-flight checks enforce all active regulation requirements before every send
- Only prospect individuals where legitimate interest or valid consent applies
- Do not store personal data beyond what is needed for the campaign
- Honour unsubscribes immediately — flag any opted-out contact before it enters a sequence
- Every outbound email must include a physical mailing address
- Every outbound email must have a working unsubscribe mechanism
- Unsubscribe requests processed immediately, not "within 10 days"
- Right to erasure: if requested, delete all data about the person within 30 days
- Check SUPPRESSION.md before every send — suppressed contacts are never re-contacted
- CASL (Canada): requires consent tracking — never send to Canadian contacts without documented consent
- Data retention: follow the retention policy in SUPPRESSION.md for each active regulation

## Copy ethics
- Never fabricate proof points, data, or case study details
- Never imply an existing relationship that does not exist
- Never use urgency that is invented (fake deadlines, false scarcity)

## List sourcing
- Only use data from sources with legitimate collection practices
- Do not use scraped personal data without a valid legal basis
- Verify all emails before sending — catch-all addresses must be flagged, not assumed valid
- No personal email domains (gmail, yahoo, hotmail, etc.)
- No role-based emails (info@, sales@, support@)
- Deduplicate within campaign AND across active campaigns in the workspace

## Multi-channel rules
- Never send email and LinkedIn message on the same day to the same contact
- If contact replies on any channel, pause all other channels immediately
- LinkedIn connection requests must be personalized — no generic invites
- Max 25 LinkedIn connection requests per day (adjustable in Crispy dashboard)

## CRM and pipeline
- Every contact shipped in a list must be created in the CRM
- Every reply classification must be synced to the CRM
- Unsubscribes must set do-not-contact flag in CRM
- Deal attribution must trace back to the originating campaign and touch
