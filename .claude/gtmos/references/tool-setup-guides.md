# Tool Setup Guides — GTMOS

Step-by-step guides for setting up each tool to work with GTMOS. Share these with users during onboarding when they need to configure a tool.

---

## Instantly

### Initial setup
1. Create an account at instantly.ai
2. Go to Settings → API → copy your API key
3. Add to `.env`: `INSTANTLY_API_KEY=your-key`

### Connect email accounts
1. Go to Email Accounts → Add Account
2. Connect Google Workspace or Microsoft 365 (OAuth recommended)
3. Enable warmup on every connected account
4. Set daily sending limit to 30-40 per account for cold

### Create sending campaign
1. Go to Campaigns → New Campaign
2. Set up inbox rotation (assign all connected accounts)
3. Set send timing: Mon-Fri, 8-11 AM recipient timezone
4. Enable bounce detection and auto-pause on spam complaints
5. Copy the Campaign ID — you'll need it for GTMOS shipping

### GTMOS integration
- Reads: campaign analytics, lead status, bounce data
- Writes: add leads to campaigns, pause/resume sequences
- Credit behaviour: confirm-before-every-use (subscription-based, but controls send volume)

---

## Lemlist

### Initial setup
1. Create an account at lemlist.com
2. Go to Settings → Integrations → API → copy your API key
3. Add to `.env`: `LEMLIST_API_KEY=your-key`

### Connect email accounts
1. Go to Settings → Email Providers → Add Provider
2. Connect via SMTP/IMAP or OAuth
3. Set sending limits per provider (Google: stay under 50/day for cold)
4. Configure your sender signature

### Create sending campaign
1. Go to Campaigns → New Campaign
2. Add your sequence steps (email, delay, email, etc.)
3. Configure send window and timezone
4. Enable auto-detect timezone if available
5. Copy the Campaign ID from the URL

### GTMOS integration
- Reads: campaign stats, activities, open/reply rates
- Writes: add leads to campaigns, remove leads
- Credit behaviour: confirm-before-every-use

---

## Smartlead

### Initial setup
1. Create an account at smartlead.ai
2. Go to Settings → API → generate and copy your API key
3. Add to `.env`: `SMARTLEAD_API_KEY=your-key`

### Connect email accounts
1. Go to Email Accounts → Add
2. Connect via SMTP/IMAP credentials
3. Enable unlimited warmup on all accounts
4. Set daily sending limits (25-40 for cold)

### Create sending campaign
1. Go to Campaigns → Create
2. Set up sequence with delays between steps
3. Assign email accounts for rotation
4. Configure send window and timezone
5. Copy the Campaign ID

### GTMOS integration
- Reads: campaign statistics, lead status
- Writes: add leads, create campaigns
- Credit behaviour: confirm-before-every-use

---

## Apollo

### Initial setup
1. Create an account at apollo.io (free tier: 10,000 credits/month)
2. Go to Settings → API → copy your API key
3. Add to `.env`: `APOLLO_API_KEY=your-key`

### Using for prospecting
1. Use the People Search to find contacts matching your ICP
2. Export lists as CSV → import into GTMOS with `/gtm:validate-list`
3. Or use the API directly — GTMOS can search and enrich via API calls

### Credit awareness
- Search is free (unlimited)
- Email reveal: 1 credit each
- Phone reveal: 5 credits each
- GTMOS will always show credit cost before enriching

---

## Crispy (LinkedIn)

### Initial setup
1. Create an account at crispy.sh
2. Install the Crispy MCP server in Claude Code
3. Add to `.env`: `CRISPY_API_KEY=your-key`
4. Connect your LinkedIn account in the Crispy dashboard

### Configure limits
1. In the Crispy dashboard, set daily limits:
   - Connection requests: start at 25/day (increase gradually)
   - Profile views: start at 50/day
   - Messages: up to 100/day for existing connections
2. Enable Safety Mode while you learn the limits of your account

### Sales Navigator (if available)
1. Ensure your LinkedIn account has Sales Navigator
2. Crispy automatically detects Sales Navigator and enables search/filter/extract tools
3. Use Sales Navigator searches to build targeted lists directly from Claude Code

### GTMOS integration
- Claude Code controls LinkedIn directly via MCP tool calls
- No CSV export/import needed
- Connection requests, messages, profile views, Sales Navigator searches all happen via commands

---

## Attio (CRM)

### Initial setup
1. Create an account at attio.com
2. Go to Settings → Developers → API Keys → create new key
3. Add to `.env`: `ATTIO_API_KEY=your-key`

### Configure pipeline
1. Create or customize your pipeline stages to match PIPELINE.md
2. Recommended stages: Prospect → Contacted → Replied → Meeting Booked → Qualified → Proposal → Won/Lost
3. Add custom fields for: campaign_source, first_touch_date, lead_score

### GTMOS integration
- Reads: deal stages, contact updates, won/lost outcomes
- Writes: create contacts, update stages, add notes, tag with campaigns
- Credit behaviour: auto-approved (CRM writes are free)

---

## HubSpot (CRM)

### Initial setup
1. Go to Settings → Integrations → API Key (or Private Apps for new accounts)
2. For Private Apps: create app with contacts, deals, and pipelines scopes
3. Copy the access token
4. Add to `.env`: `HUBSPOT_API_KEY=your-token`

### Configure pipeline
1. Go to Sales → Deals → Pipeline settings
2. Set up stages matching PIPELINE.md
3. Create custom properties for campaign attribution

### GTMOS integration
- Reads: deal stages, contact data, marketing analytics
- Writes: create/update contacts, create deals, update stages
- Credit behaviour: auto-approved for CRM, confirm for marketing contacts

---

## Email verification (ZeroBounce / MillionVerifier)

### ZeroBounce
1. Create account at zerobounce.net
2. Go to API → copy your API key
3. Use via GTMOS: verification happens during `/gtm:validate-list`
4. Cost: $0.004-0.008 per email depending on volume

### MillionVerifier
1. Create account at millionverifier.com
2. Upload CSV for bulk verification, or use API
3. Cost: $0.001-0.004 per email (budget option)

---

## Icypeas

### Initial setup
1. Create an account at icypeas.com
2. Go to Settings → API
3. Copy your API key and API secret
4. Add both to `.env`:
   - `ICYPEAS_API_KEY=your-key`
   - `ICYPEAS_SECRET=your-secret`

### GTMOS integration
- Reads: email finder results, company data
- Writes: submit enrichment requests
- Credit behaviour: confirm-before-every-use (1 credit per email find, 0.5 per company scrape)
- Auth uses `key:secret` format in requests

---

## Prospeo

### Initial setup
1. Create an account at prospeo.io
2. Go to Dashboard → API → copy your API key
3. Add to `.env`: `PROSPEO_API_KEY=your-key`

### GTMOS integration
- Reads: enrichment results, email search results
- Writes: submit search/enrich requests
- Credit behaviour: confirm-before-every-use
- Auth header: `X-KEY`
- Note: old endpoints were deprecated March 2025 — use the new `enrich` and `search` endpoints only

---

## Apify

### Initial setup
1. Create an account at apify.com
2. Go to Settings → Integrations → API → copy your API token
3. Add to `.env`: `APIFY_API_KEY=your-token`

### Sales Navigator scraping
1. In the Apify Store, search for "Sales Navigator" actors
2. Recommend using no-cookies actors for account safety (avoids LinkedIn session risks)
3. Configure the actor with your search URL or filters, then run via API

### GTMOS integration
- Reads: actor run results, dataset exports
- Writes: start actor runs, configure actor inputs
- Credit behaviour: confirm-before-every-use (usage-based compute pricing)

---

## Dropcontact

### Initial setup
1. Create an account at dropcontact.com
2. Get your API token from the dashboard
3. Add to `.env`: `DROPCONTACT_API_KEY=your-token`

### GTMOS integration
- Reads: enrichment results (email, phone, company data)
- Writes: submit enrichment requests
- Credit behaviour: confirm-before-every-use
- Auth header: `X-Access-Token`
- No database — 100% algorithmic, GDPR compliant

---

## FindyMail

### Initial setup
1. Create an account at findymail.com
2. Go to Settings → copy your API key
3. Add to `.env`: `FINDYMAIL_API_KEY=your-key`

### GTMOS integration
- Reads: email finder results, verification results
- Writes: submit email search requests
- Credit behaviour: confirm-before-every-use (credits never expire)
- <5% bounce guarantee on found emails

---

## Scrubby

### Initial setup
1. Create an account at scrubby.io
2. Get your API key from the dashboard
3. Add to `.env`: `SCRUBBY_API_KEY=your-key`

### GTMOS integration
- Reads: catch-all verification results
- Writes: submit emails for catch-all verification
- Credit behaviour: confirm-before-every-use
- Specialist in catch-all email verification — use after other verifiers (ZeroBounce, MillionVerifier) return "catch-all" status

---

## Ocean.io

### Initial setup
1. Create an account at ocean.io
2. Contact sales for API access
3. Get your API token once approved
4. Add to `.env`: `OCEAN_API_KEY=your-token`

### Using for lookalike prospecting
1. Feed your best customer domains into Ocean.io
2. It returns ranked lookalike companies based on similarity
3. Export results or pull via API for GTMOS list building

### GTMOS integration
- Reads: lookalike company results, similarity scores
- Writes: submit seed domains for lookalike analysis
- Credit behaviour: confirm-before-every-use
- Auth header: `x-api-token`

---

## DiscoLike

### Initial setup
1. Create an account at discolike.com
2. Get your API key from the dashboard
3. Add to `.env`: `DISCOLIKE_API_KEY=your-key`

### GTMOS integration
- Reads: AI-powered lookalike results across 60M+ domains
- Writes: submit seed domains for lookalike discovery
- Credit behaviour: confirm-before-every-use
- Auth header: `x-discolike-key`

---

## Exa

### Initial setup
1. Create an account at exa.ai
2. Get your API key from the dashboard
3. Add to `.env`: `EXA_API_KEY=your-key`

### MCP integration
1. Install the `exa-mcp-server` for Claude Code MCP integration
2. Once installed, tools appear as `web_search_exa`, `company_research_exa`, etc.
3. These tools are available directly in Claude Code sessions

### GTMOS integration
- Reads: web search results, company research data
- Writes: submit search queries
- Credit behaviour: 1,000 free searches/month included

---

## Firecrawl

### Initial setup
1. Create an account at firecrawl.dev
2. Get your API key from the dashboard
3. Add to `.env`: `FIRECRAWL_API_KEY=your-key`

### MCP integration
1. Install the `firecrawl-mcp-server` for Claude Code MCP integration
2. Once installed, crawl and scrape tools are available directly in Claude Code sessions

### GTMOS integration
- Reads: scraped page content, crawl results
- Writes: submit URLs for scraping/crawling
- Credit behaviour: confirm-before-every-use (500 free credits one-time on signup)

---

## Fireflies.ai

### Initial setup
1. Create an account at fireflies.ai (Business plan required for API access)
2. Go to Settings → Integrations → API → copy your API key
3. Add to `.env`: `FIREFLIES_API_KEY=your-key`

### GTMOS integration
- Reads: meeting transcripts, action items, summaries
- Writes: query transcripts via GraphQL API
- Credit behaviour: auto-approved (subscription-based)

---

## Signalbase

### Initial setup
1. Create an account at signalbase.com
2. Get your API key from the dashboard
3. Add to `.env`: `SIGNALBASE_API_KEY=your-key`

### GTMOS integration
- Reads: intent signals, buying signals
- Writes: configure signal tracking
- Credit behaviour: confirm-before-every-use

---

## Commonroom

### Initial setup
1. Create an account at commonroom.io
2. Go to Settings → copy your API key
3. Add to `.env`: `COMMONROOM_API_KEY=your-key`

### GTMOS integration
- Reads: community signals, member activity, digital exhaust data
- Writes: submit queries for signal data
- Credit behaviour: confirm-before-every-use

---

## LinkedIn Ads

### Initial setup
1. Go to LinkedIn Campaign Manager at linkedin.com/campaignmanager
2. Create or select an ad account
3. Apply for Audiences API access (separate from Marketing API) via the Microsoft application form
4. Set up OAuth2 and generate your access token
5. Add to `.env`:
   - `LINKEDIN_ADS_TOKEN=your-oauth-token`
   - `LINKEDIN_AD_ACCOUNT_ID=your-account-id`

### GTMOS integration
- Reads: campaign performance, audience match rates
- Writes: create/update matched audiences, manage campaigns
- Credit behaviour: confirm-before-every-use (ad spend implications)
- Note: DMP Segment APIs require separate approval from LinkedIn

---

## Meta Ads

### Initial setup
1. Go to Meta Business Suite → Settings → Business Settings → System Users
2. Create a system user with `ads_management` permission
3. Generate an access token for the system user
4. Add to `.env`:
   - `META_ACCESS_TOKEN=your-token`
   - `META_AD_ACCOUNT_ID=your-account-id`

### GTMOS integration
- Reads: campaign performance, audience insights
- Writes: create/update custom audiences, manage campaigns
- Credit behaviour: confirm-before-every-use (ad spend implications)

---

## Google Ads

### Initial setup
1. Sign up for Google Ads API access at developers.google.com/google-ads/api
2. Apply for a developer token (requires a Google Ads manager account)
3. Set up OAuth2 credentials in Google Cloud Console
4. Add to `.env`:
   - `GOOGLE_ADS_TOKEN=your-oauth-token`
   - `GOOGLE_ADS_DEVELOPER_TOKEN=your-developer-token`
   - `GOOGLE_ADS_CUSTOMER_ID=your-customer-id`

### GTMOS integration
- Reads: campaign performance, audience match rates
- Writes: create/update Customer Match audiences, manage campaigns
- Credit behaviour: confirm-before-every-use (ad spend implications)
- Note: starting April 2026, new developer tokens must use Data Manager API for Customer Match

---

## Notes

- Always test API connectivity after adding keys: run `/gtm:status` to verify
- Most tools have free tiers or trials — start there
- Credit-based tools (Apollo, Icypeas, Prospeo) show cost before every action
- Flat-rate tools (Instantly, CRMs) are tracked by subscription, not per-action
