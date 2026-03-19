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
- Credit behaviour (writes): confirm-above-threshold
- Threshold: 100 contacts (auto-approve enrichment batches ≤100; confirm larger runs)
- Notes:

### ZoomInfo
- Status: active / inactive
- Mode: read-only
- Pull from ZoomInfo: contacts, companies, org charts, intent data, tech stack, direct dials
- Used for: enterprise-grade prospecting and enrichment — deepest US company data
- Credit behaviour (reads): confirm-above-threshold
- Threshold: 100 contacts (credits vary by plan)
- Notes: Enterprise pricing — API access included on most plans. Strongest for mid-market and enterprise US companies.

### Cognism
- Status: active / inactive
- Mode: read-only
- Pull from Cognism: contacts, phone-verified numbers, company data, GDPR-compliant emails
- Used for: EU/UK prospecting and enrichment — strongest GDPR-compliant phone data outside US
- Credit behaviour (reads): confirm-above-threshold
- Threshold: 100 contacts
- Notes: Best-in-class for EU/UK phone numbers (Diamond Data®). GDPR consent tracking built in. API access on enterprise plans.

### Lusha
- Status: active / inactive
- Mode: read-only
- Pull from Lusha: contact emails, direct dials, LinkedIn enrichment
- Used for: quick enrichment via LinkedIn extension or bulk API enrichment
- Credit behaviour (reads): confirm-above-threshold
- Threshold: 50 contacts (~$18-25 at typical rates)
- Notes: Credit-based. Good for targeted enrichment at per-contact level.

### Kaspr
- Status: active / inactive
- Mode: read-only
- Pull from Kaspr: phone numbers (direct dials + mobile), emails, LinkedIn data
- Used for: European phone number enrichment — strong coverage where others fall short
- Credit behaviour (reads): confirm-above-threshold
- Threshold: 50 contacts
- Notes: GDPR-compliant. Credit-based. Strong for France, DACH, Benelux.

### Hunter.io
- Status: active / inactive
- Mode: read-only
- Pull from Hunter: email finder by domain or name, email verification, domain search
- Used for: lightweight email finding — good free tier, fast for targeted lookups
- Credit behaviour (reads): confirm-above-threshold
- Threshold: 100 requests (auto-approve standard searches)
- Notes: 25 free requests/mo. Paid from $34/mo. Good for one-off lookups and domain-level searches.

### Datagma
- Status: active / inactive
- Mode: read-only
- Pull from Datagma: email, phone, LinkedIn enrichment, company data, job history
- Used for: enrichment waterfall — add as a step between primary sources and Apify fallback
- Credit behaviour (reads): confirm-above-threshold
- Threshold: 100 credits
- Notes: Credit-based. Strong for European enrichment. Real-time API with high accuracy.

### Icypeas
- Status: active / inactive
- Mode: bidirectional / read-only
- Push to Icypeas: email finder jobs, bulk enrichment
- Pull from Icypeas: verified emails, domain search results
- Credit behaviour (writes): confirm-above-threshold
- Threshold: 100 credits (~$1–2 at typical rates — auto-approve small enrichment batches)
- Notes: Credit-based — 1 credit per email find or verify

### Prospeo
- Status: active / inactive
- Mode: bidirectional / read-only
- Push to Prospeo: LinkedIn URLs, domains for email finding
- Pull from Prospeo: verified emails, domain search results
- Credit behaviour (writes): confirm-above-threshold
- Threshold: 100 credits (~$1–4 at typical rates — auto-approve small enrichment batches)
- Notes: Credit-based — 1 credit per email find or verify

### Apify
- Status: active / inactive
- Mode: bidirectional / read-only
- Push to Apify: scraping jobs, actor configurations
- Pull from Apify: scraped data, enrichment results, lead lists
- Credit behaviour (writes): confirm-above-threshold
- Threshold: $5 estimated cost per run (confirm if a single run will exceed $5)
- Notes: Compute-unit based pricing — cost varies by actor and data volume

### HubSpot
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to HubSpot: contacts, deals, campaign tags, notes, sequences
- Pull from HubSpot: deal stage changes, reply status, contact updates, won/lost, marketing data
- Credit behaviour (writes): auto-approved
- Notes: CRM writes are free. Marketing contact charges apply above tier limit.

### Bouncer
- Status: active / inactive
- Mode: read-only
- Push to Bouncer: email lists for verification
- Pull from Bouncer: verified/invalid/risky/unknown status per email
- Credit behaviour (reads): confirm-above-threshold
- Threshold: 500 emails (~$3-4)
- Notes: Strong EU focus, GDPR-compliant. Good for bulk list cleaning before sending. From $0.007/email.

### NeverBounce
- Status: active / inactive
- Mode: read-only
- Push to NeverBounce: email lists for verification
- Pull from NeverBounce: valid/invalid/disposable/accept-all status
- Credit behaviour (reads): confirm-above-threshold
- Threshold: 500 emails (~$1.50)
- Notes: From $0.003/email on bulk. Real-time API available. 1K free on signup.

### Woodpecker
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Woodpecker: sequences, contacts, campaigns
- Pull from Woodpecker: open rates, reply rates, bounce rates, deliverability data
- Credit behaviour (writes): confirm-before-every-use
- Notes: Strong EU user base. GDPR-compliant. Per-seat pricing from $29/mo.

### Reply.io
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Reply.io: sequences, contacts, multi-channel steps (email, LinkedIn, SMS, calls)
- Pull from Reply.io: open rates, reply rates, step-level performance, contact status
- Credit behaviour (writes): confirm-before-every-use
- Notes: Multi-channel — one platform for email, LinkedIn DMs, SMS, WhatsApp, and calls. Built-in AI for sequence steps.

### Klenty
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Klenty: cadences, contacts, CRM sync
- Pull from Klenty: engagement data, reply detection, CRM stage updates
- Credit behaviour (writes): confirm-before-every-use
- Notes: Deep two-way sync with HubSpot, Salesforce, Pipedrive. Good for teams where CRM is the source of truth.

### Outreach.io
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Outreach: sequences, prospects, accounts
- Pull from Outreach: sequence performance, reply status, meeting booked events, deal data
- Credit behaviour (writes): confirm-before-every-use
- Notes: Enterprise sales engagement platform. API access on all plans. Webhook support for real-time events.

### Salesloft
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Salesloft: cadences, people, accounts
- Pull from Salesloft: cadence performance, activity data, conversation intelligence, deal data
- Credit behaviour (writes): confirm-before-every-use
- Notes: Enterprise. Deep Salesforce integration. Conversation intelligence (Drift) built in on higher tiers.

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

### UserGems
- Status: active / inactive
- Mode: read-only
- Pull from UserGems: job change alerts for past customers, champions, and key contacts; new hire tracking at target accounts
- Used for: warmest outreach signal available — a past champion who moves to a new company is a hot lead. Trigger signal-based outreach immediately.
- Notes: Webhook support for real-time job change alerts. Integrate with CRM for automatic contact updates.

### Keyplay
- Status: active / inactive
- Mode: read-only
- Pull from Keyplay: ICP account scores, account rankings, fit tier classifications (A/B/C/D), signal-based scoring
- Used for: rank your entire TAM by ICP fit — prioritize outreach and enrichment on highest-score accounts first
- Notes: Scores accounts using custom signals you define (tech stack, hiring patterns, funding, growth signals). Syncs with HubSpot and Salesforce.

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

### HeyReach
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to HeyReach: LinkedIn outreach campaigns, connection requests, messages
- Pull from HeyReach: connection rates, reply rates, reply content, campaign performance
- Credit behaviour (writes): confirm-before-every-use
- Notes: LinkedIn at scale — run multiple LinkedIn accounts, agency mode for clients, webhook support. From $79/mo.

### La Growth Machine
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to LGM: multi-channel sequences (email + LinkedIn + Twitter), lead lists
- Pull from LGM: per-step engagement, reply detection, activity logs
- Credit behaviour (writes): confirm-before-every-use
- Notes: Multi-channel sequences from one builder. Strong for LinkedIn + email coordinated campaigns. API access on Team plan.

### Gong
- Status: active / inactive
- Mode: read-only
- Pull from Gong: call transcripts, deal insights, talk track analysis, coaching scores, forecast data
- Used for: data deep-dive — extract buyer language, objections, and winning patterns from recorded calls. Feed insights into LEARNINGS.md and PERSONA.md.
- Notes: API access on enterprise plans. Pull transcripts via `/gtm:deep-dive`. Complements Fireflies.ai — use whichever your team records calls with.

### Fireflies.ai
- Status: active / inactive
- Mode: read-only
- Pull from Fireflies: meeting transcripts, speaker-attributed text, AI summaries, action items
- Used for: data deep-dive — extract pain points, buying triggers, objections, and prospect language from sales calls
- Notes: GraphQL API. Business plan required for API access. Pull transcripts via `/gtm:deep-dive`.

### Ocean.io
- Status: active / inactive
- Mode: read-only
- Pull from Ocean.io: lookalike company lists, company enrichment (revenue, tech stack, headcount growth, web traffic)
- Used for: finding companies similar to your best customers — feed domains, get ranked lookalikes with firmographic + semantic matching
- Credit behaviour (reads): confirm-above-threshold
- Threshold: 500 results per query (auto-approve standard searches; confirm large pulls)
- Notes: 0.2 credits per search result. Enrich: 1 credit (with domain), 5 credits (without). Contact sales for pricing plans.

### DiscoLike
- Status: active / inactive
- Mode: read-only
- Pull from DiscoLike: lookalike company lists, technographic data, website semantic matching
- Used for: discovering high-fit companies that traditional databases miss — analyzes 60M+ domains across 45 languages using AI
- Credit behaviour (reads): confirm-above-threshold
- Threshold: 500 records per query (~$1 at typical rates — confirm larger pulls)
- Notes: $0.10/API call + $2/1K records. Platform $99/mo. SaaS $1,000/mo. API access conditional on plan.

### Exa
- Status: active / inactive
- Mode: read-only
- Pull from Exa: semantic web search results, company research reports, industry intelligence
- Used for: market research (`/gtm:research`), finding ICP-matching companies semantically, competitor intelligence, list building seeds
- Credit behaviour (reads): auto-approved (1K free/mo)
- Notes: MCP server available — Claude Code can use `web_search_exa`, `company_research_exa`, `deep_researcher_start` directly. $0.007/search on paid.

### Firecrawl
- Status: active / inactive
- Mode: read-only
- Pull from Firecrawl: scraped web pages as clean markdown, structured data extraction from any URL
- Used for: competitor website scraping, extracting company data from directories/award lists, job board scraping for hiring signals, pricing page analysis
- Credit behaviour (reads): auto-approved (500 free one-time)
- Notes: MCP server available — Claude Code can use `FIRECRAWL_SCRAPE_EXTRACT_DATA_LLM`, `FIRECRAWL_EXTRACT` directly. 1 credit/page.

### LinkedIn Ads
- Status: active / inactive
- Mode: write-only
- Push to LinkedIn Ads: company lists and contact lists as matched audiences (DMP segments)
- Used for: ABM audience warming — run brand awareness ads to target accounts before cold outreach
- Credit behaviour (writes): confirm-before-every-use
- Notes: Requires Audiences API approval (separate from Marketing API). Min 300 matched members. Up to 5,000 companies per batch. Processing: 24-48 hours.

### Meta Ads
- Status: active / inactive
- Mode: write-only
- Push to Meta: contact lists as custom audiences for Facebook/Instagram ad targeting
- Used for: ABM audience warming — show thought leadership ads to prospects across Facebook and Instagram
- Credit behaviour (writes): confirm-before-every-use
- Notes: Max 500 custom audiences per ad account. 10,000 rows per upload. Requires `ads_management` permission.

### Google Ads
- Status: active / inactive
- Mode: write-only
- Push to Google Ads: contact lists as customer match audiences for search, display, YouTube targeting
- Used for: ABM audience warming — show brand ads across Google ecosystem
- Credit behaviour (writes): confirm-before-every-use
- Notes: Min 1,000 matched users. Starting April 2026, new dev tokens need Data Manager API.

## Website visitor identification
Identifies companies (and sometimes people) visiting your website. Feeds into signal scan as a buying intent signal.

### Snitcher
- Status: [ ] active
- Mode: API + integrations
- What it does: IP-to-company identification, behavioral tracking, page intent signals
- Data: Company name, industry, size, location, pages visited, session behavior
- Integrations: HubSpot, Salesforce, Pipedrive, Attio, Slack, Zapier, webhooks
- Credit behaviour: Monthly subscription based on unique companies identified
- Key: SNITCHER_API_KEY

### RB2B
- Status: [ ] active
- Mode: Webhooks + integrations
- What it does: Person-level visitor identification (US only), company-level (global)
- Data: Full name, job title, LinkedIn URL, business email, company data
- Integrations: HubSpot, Salesforce, Slack, Zapier, webhooks
- Credit behaviour: Free plan available, paid for higher volume
- Limitation: Person-level identification is US-only
- Key: RB2B_WEBHOOK_URL

### Warmly
- Status: [ ] active
- Mode: Platform + API
- What it does: Company + person identification, AI chat/email agents, intent signals
- Data: Company firmographics, contact details, intent signals, engagement data
- Integrations: HubSpot, Salesforce (others via Zapier)
- Credit behaviour: Enterprise pricing — contact sales
- Key: WARMLY_API_KEY

### Leadinfo
- Status: [ ] active
- Mode: Integrations only (no API)
- What it does: Company-level visitor identification, decision-maker data
- Data: Company name, industry, size, decision-makers
- Integrations: 70+ integrations including HubSpot, Salesforce, Pipedrive, Slack
- Credit behaviour: From EUR69/mo based on unique companies identified
- Limitation: No API — integration-only

---

## Additional tools (activate as needed)

### Email verification
- ZeroBounce: $0.004-0.008/email — bulk verification
- MillionVerifier: $0.001-0.004/email — budget option
- Scrubby: $0.02-0.03/email — catch-all verification

### Lead databases
- StoreLeads: e-commerce store database (Shopify, WooCommerce, etc.)
- Openmart: small business and SMB data

### LinkedIn automation
- PhantomBuster: $0.01-0.05/lead — execution-time based scraping and automation

### CRM enrichment
- Freckle: CRM data enrichment — auto-fills missing company and contact data
- Surfe: push LinkedIn contacts directly to CRM (HubSpot, Salesforce, Pipedrive, Attio)

### CRM alternatives
- Salesforce: per-seat, API free within limits
- Pipedrive: per-seat, API free within limits

### Scheduling
- Calendly: meeting scheduling with calendar sync — free 1 event type, from $10/mo
- Cal.com: open-source scheduling, self-hosted option — free self-hosted, from $12/mo

### Automation
- N8N: self-hosted workflow automation — free (self-hosted) or $20/mo (cloud)
- Supabase Edge Functions: serverless functions — $0.00002/invocation, first 500K free/mo
- Zapier: $0.01-0.03/task — connects tools
- Make: $0.001-0.01/operation — connects tools

---

## Enrichment hit rates

Track hit rates per source to optimize the waterfall over time. Updated automatically after each enrichment run.

| Source | Email | Phone | People | Company | Last updated |
|--------|-------|-------|--------|---------|-------------|
| Apollo | — | — | — | — | — |
| ZoomInfo | — | — | — | — | — |
| Cognism | — | — | — | — | — |
| Lusha | — | — | — | — | — |
| Kaspr | — | — | — | — | — |
| Hunter.io | — | — | — | — | — |
| Datagma | — | — | — | — | — |
| Icypeas | — | — | — | — | — |
| Prospeo | — | — | — | — | — |
| Crispy | — | — | — | — | — |
| Apify | — | — | — | — | — |

---

## Default credit behaviour
confirm-before-every-use

## API key reference
All keys stored in .env at repo root:
- APOLLO_API_KEY
- ZOOMINFO_API_KEY
- COGNISM_API_KEY
- LUSHA_API_KEY
- KASPR_API_KEY
- HUNTER_API_KEY
- DATAGMA_API_KEY
- ICYPEAS_API_KEY
- PROSPEO_API_KEY
- DROPCONTACT_API_KEY
- FINDYMAIL_API_KEY
- APIFY_API_KEY
- ZEROBOUNCE_API_KEY
- MILLIONVERIFIER_API_KEY
- BOUNCER_API_KEY
- NEVERBOUNCE_API_KEY
- SCRUBBY_API_KEY
- LEMLIST_API_KEY
- INSTANTLY_API_KEY
- SMARTLEAD_API_KEY
- WOODPECKER_API_KEY
- REPLYIO_API_KEY
- KLENTY_API_KEY
- OUTREACH_API_KEY
- SALESLOFT_API_KEY
- CRISPY_API_KEY
- HEYREACH_API_KEY
- LGM_API_KEY
- HUBSPOT_API_KEY
- ATTIO_API_KEY
- SALESFORCE_API_KEY
- PIPEDRIVE_API_KEY
- GONG_API_KEY
- FIREFLIES_API_KEY
- USERGEMS_API_KEY
- KEYPLAY_API_KEY
- SIGNALBASE_API_KEY
- COMMONROOM_API_KEY
- JUNGLER_API_KEY
- TRIGIFY_API_KEY
- OCEAN_API_KEY
- DISCOLIKE_API_KEY
- EXA_API_KEY
- FIRECRAWL_API_KEY
- SNITCHER_API_KEY
- RB2B_WEBHOOK_URL
- WARMLY_API_KEY
- LINKEDIN_ADS_TOKEN
- LINKEDIN_AD_ACCOUNT_ID
- META_ACCESS_TOKEN
- META_AD_ACCOUNT_ID
- GOOGLE_ADS_TOKEN
- GOOGLE_ADS_DEVELOPER_TOKEN
- GOOGLE_ADS_CUSTOMER_ID
