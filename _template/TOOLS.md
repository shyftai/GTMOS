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

### Icypeas
- Status: active / inactive
- Mode: bidirectional / read-only
- Push to Icypeas: email finder jobs, bulk enrichment
- Pull from Icypeas: verified emails, domain search results
- Credit behaviour (writes): confirm-above-threshold
- Threshold:
- Notes: Credit-based — 1 credit per email find or verify

### Prospeo
- Status: active / inactive
- Mode: bidirectional / read-only
- Push to Prospeo: LinkedIn URLs, domains for email finding
- Pull from Prospeo: verified emails, domain search results
- Credit behaviour (writes): confirm-above-threshold
- Threshold:
- Notes: Credit-based — 1 credit per email find or verify

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
- Lead database: built-in (450M+ contacts) — can source leads directly
- Credit behaviour (writes): confirm-before-every-use
- Notes:

### Instantly
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Instantly: sequences, contacts, sending schedules
- Pull from Instantly: open rates, reply rates, bounce rates, deliverability data
- Lead database: built-in (160M+ contacts) — separate add-on pricing
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
- Push to Crispy: connection requests, LinkedIn messages, Sales Navigator searches
- Pull from Crispy: connection acceptance rates, reply rates, reply content, Sales Navigator lead lists
- Credit behaviour (writes): confirm-before-every-use
- Notes: MCP server with 78 tools — connects directly to Claude Code. Includes Sales Navigator integration. No CSV exports needed — Claude Code can run LinkedIn actions via tool calls.

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

### Sentrion.ai / Fantastic.jobs
- Status: active / inactive
- Mode: read-only
- Pull: job post data, hiring signals, role expansion alerts
- Used for: hiring = buying signal — company hiring for roles your product serves means they're investing in that area
- Notes: Pick one — both do job post monitoring

### Jungler.ai
- Status: active / inactive
- Mode: read-only
- Pull from Jungler: social signals, LinkedIn activity tracking, engagement signals
- Used for: identifying prospects actively engaging with relevant content — warm outreach triggers
- Notes:

### Trigify
- Status: active / inactive
- Mode: read-only
- Pull from Trigify: social signals, LinkedIn engagement data, content interaction tracking
- Used for: social selling signals — detect when prospects engage with competitor content, industry topics, or relevant posts
- Notes:

### Fireflies.ai
- Status: active / inactive
- Mode: read-only
- Pull from Fireflies: meeting transcripts, speaker-attributed text, AI summaries, action items
- Used for: data deep-dive — extract pain points, buying triggers, objections, and prospect language from sales calls
- Notes: GraphQL API. Business plan required for API access. Pull transcripts via `/gtm:deep-dive`.

---

## Additional tools (activate as needed)

### Email verification
- ZeroBounce: $0.004-0.008/email — bulk verification
- MillionVerifier: $0.001-0.004/email — budget option
- Scrubby: $0.02-0.03/email — catch-all verification

### Lead databases
- StoreLeads: e-commerce store database (Shopify, WooCommerce, etc.)
- Opemart: small business and SMB data

### LinkedIn automation
- PhantomBuster: $0.01-0.05/lead — execution-time based scraping and automation

### CRM enrichment
- Freckle: CRM data enrichment — auto-fills missing company and contact data

### CRM alternatives
- Salesforce: per-seat, API free within limits
- Pipedrive: per-seat, API free within limits

### Automation
- N8N: self-hosted workflow automation — free (self-hosted) or $20/mo (cloud)
- Supabase Edge Functions: serverless functions — $0.00002/invocation, first 500K free/mo
- Zapier: $0.01-0.03/task — connects tools
- Make: $0.001-0.01/operation — connects tools

---

## Default credit behaviour
confirm-before-every-use

## API key reference
All keys stored in .env at repo root:
- APOLLO_API_KEY
- ICYPEAS_API_KEY
- PROSPEO_API_KEY
- APIFY_API_KEY
- HUBSPOT_API_KEY
- LEMLIST_API_KEY
- INSTANTLY_API_KEY
- SMARTLEAD_API_KEY
- CRISPY_API_KEY
- ATTIO_API_KEY
- SIGNALBASE_API_KEY
- COMMONROOM_API_KEY
- JUNGLER_API_KEY
- TRIGIFY_API_KEY
- FIREFLIES_API_KEY
