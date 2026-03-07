# Tools — [Workspace Name]

## Connection mode
All tools connect via direct API from Claude Code.
Reads are always auto-approved. Credit rules apply to writes only.
For pricing details, see .claude/gtmos/references/tool-pricing.md

## Active tools

### Apollo
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Apollo: list exports, contact filters
- Pull from Apollo: enrichment updates, contact status, bounce flags
- Credit behaviour (writes): confirm-before-every-use
- Threshold:
- Notes:

### Apify
- Status: active / inactive
- Mode: bidirectional / read-only
- Push to Apify: scraping jobs, actor configurations
- Pull from Apify: scraped data, enrichment results, lead lists
- Credit behaviour (writes): confirm-above-threshold
- Threshold:
- Notes: Compute-unit based pricing — cost varies by actor and data volume

### HubSpot
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to HubSpot: contacts, deals, campaign tags, notes, sequences
- Pull from HubSpot: deal stage changes, reply status, contact updates, won/lost, marketing data
- Credit behaviour (writes): auto-approved
- Notes: CRM writes are free. Marketing contact charges apply above tier limit.

### Lemlist
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Lemlist: sequences, contacts, campaigns
- Pull from Lemlist: open rates, reply rates, bounce rates, unsubscribes, reply text
- Credit behaviour (writes): confirm-before-every-use
- Notes:

### Instantly
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Instantly: sequences, contacts, sending schedules
- Pull from Instantly: open rates, reply rates, bounce rates, deliverability data
- Credit behaviour (writes): confirm-before-every-use
- Notes:

### Smartlead
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Smartlead: sequences, contacts, sending schedules
- Pull from Smartlead: open rates, reply rates, bounce rates, deliverability data
- Credit behaviour (writes): confirm-before-every-use
- Notes:

### Crispy
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Crispy: connection requests, LinkedIn messages
- Pull from Crispy: connection acceptance rates, reply rates, reply content
- Credit behaviour (writes): confirm-before-every-use
- Notes:

### Attio
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Attio: contacts, deals, campaign tags, notes
- Pull from Attio: deal stage changes, reply status, contact updates, won/lost
- Credit behaviour (writes): auto-approved
- Notes: CRM writes are free

### Signalbase
- Status: active / inactive
- Mode: read-only
- Pull from Signalbase: funding signals, hiring signals, company news, executive changes
- Used for: immediate action triggers during live campaigns
- Notes:

### Commonroom
- Status: active / inactive
- Mode: read-only
- Pull from Commonroom: community signals, social activity, intent signals
- Used for: immediate action triggers and ICP enrichment
- Notes:

---

## Additional tools (activate as needed)

### Email verification
- ZeroBounce: $0.004-0.008/email — bulk verification
- NeverBounce: $0.004-0.008/email — bulk verification
- MillionVerifier: $0.001-0.004/email — budget option
- Scrubby: $0.02-0.03/email — catch-all verification

### Prospecting
- RocketReach: $0.50-0.70/lookup — contact finding
- Lusha: $0.04-0.10/credit — phone + email reveals
- LeadIQ: $0.05-0.15/contact — prospecting from LinkedIn
- Clearbit: $0.10-0.30/record — company enrichment (now HubSpot Breeze)

### LinkedIn automation
- PhantomBuster: $0.01-0.05/lead — execution-time based scraping and automation

### CRM alternatives
- Salesforce: per-seat, API free within limits
- Pipedrive: per-seat, API free within limits

### Signal intelligence
- 6sense: enterprise — intent data and predictive scoring
- Bombora: enterprise — topic-level intent data

### Automation
- Zapier: $0.01-0.03/task — connects tools
- Make: $0.001-0.01/operation — connects tools (cheaper than Zapier)

---

## Default credit behaviour
confirm-before-every-use

## API key reference
All keys stored in .env at repo root:
- APOLLO_API_KEY
- APIFY_API_KEY
- HUBSPOT_API_KEY
- LEMLIST_API_KEY
- INSTANTLY_API_KEY
- SMARTLEAD_API_KEY
- CRISPY_API_KEY
- ATTIO_API_KEY
- SIGNALBASE_API_KEY
- COMMONROOM_API_KEY
