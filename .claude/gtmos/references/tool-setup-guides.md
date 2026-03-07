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

## Notes

- Always test API connectivity after adding keys: run `/gtm:status` to verify
- Most tools have free tiers or trials — start there
- Credit-based tools (Apollo, Icypeas, Prospeo) show cost before every action
- Flat-rate tools (Instantly, CRMs) are tracked by subscription, not per-action
