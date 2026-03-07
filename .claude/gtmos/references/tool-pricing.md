# Tool Pricing Reference — GTMOS

How each supported tool charges. Use this when setting up COSTS.md during onboarding.
Prices are approximate and change — always verify with the tool's current pricing page.

Last updated: 2026-03

---

## Prospecting & Enrichment

### Apollo
- **Model:** Credit-based
- **Free tier:** 10,000 credits/month (email only)
- **Paid plans:** Basic $49/mo (unlimited emails), Professional $79/mo, Organization $119/mo
- **Credit costs:**
  - Email reveal: 1 credit
  - Phone number reveal: 5 credits
  - Export contact: 1 credit
  - Enrichment: 1 credit per field
- **Lead database:** Yes — 275M+ contacts, searchable by title, industry, company size, tech stack
- **API access:** Professional plan and above
- **GTMOS unit:** contact enriched
- **Typical cost:** $0.01-0.05 per contact depending on plan and volume

### Icypeas
- **Model:** Credit-based (email finding + verification)
- **Free tier:** 50 credits
- **Paid plans:** Lite $39/mo (1,000 credits), Pro $99/mo (5,000 credits), Business $199/mo (15,000 credits)
- **Credit costs:**
  - Email finder: 1 credit
  - Email verifier: 1 credit
  - Domain search: 1 credit per result
  - Bulk enrichment: 1 credit per contact
- **API access:** All paid plans
- **GTMOS unit:** credit used
- **Typical cost:** $0.01-0.04 per contact

### Prospeo
- **Model:** Credit-based (email finder + verifier)
- **Paid plans:** Basic $39/mo (1,000 credits), Pro $99/mo (5,000 credits), Business $199/mo (15,000 credits)
- **Credit costs:**
  - Email finder (from LinkedIn URL): 1 credit
  - Email verifier: 1 credit
  - Domain search: 1 credit per result
  - LinkedIn email finder: 1 credit
- **API access:** All plans
- **GTMOS unit:** credit used
- **Typical cost:** $0.01-0.04 per contact

### Apify
- **Model:** Usage-based (compute units + platform fee)
- **Free tier:** $5/month in usage
- **Paid plans:** Starter $49/mo, Scale $499/mo, Business $999/mo
- **How it charges:**
  - Actors (scrapers) consume compute units (CUs)
  - 1 CU = 1 CPU core for 1 hour at 4GB RAM
  - Cost per CU: ~$0.25-0.40 depending on plan
  - LinkedIn scraping: ~0.005-0.01 CU per profile
  - Google Maps scraping: ~0.002 CU per result
  - Website scraping: varies by complexity
- **API access:** All plans
- **GTMOS unit:** compute unit (CU)
- **Typical cost:** $0.01-0.10 per lead depending on actor and data depth

---

## Lead Databases

### StoreLeads
- **Model:** Subscription-based
- **What it does:** E-commerce store database — Shopify, WooCommerce, BigCommerce, Magento stores with tech stack, traffic, app usage, and contact data
- **Use case:** Prospecting e-commerce companies, identifying stores by platform, app usage, or revenue signals
- **API access:** Paid plans
- **GTMOS unit:** record exported
- **Typical cost:** Varies by plan — check current pricing

### Opemart
- **Model:** Subscription-based
- **What it does:** Small business data — local businesses, SMBs, with contact info, industry, and location data
- **Use case:** Prospecting small businesses, local outreach campaigns, SMB targeting
- **API access:** Paid plans
- **GTMOS unit:** record exported
- **Typical cost:** Varies by plan — check current pricing

---

## Email Verification

### ZeroBounce
- **Model:** Credit-based (bulk or per-email)
- **Free tier:** 100 free verifications/month
- **Bulk pricing:**
  - 2,000 emails: $16 ($0.008/each)
  - 5,000 emails: $35 ($0.007/each)
  - 10,000 emails: $64 ($0.0064/each)
  - 100,000 emails: $390 ($0.0039/each)
- **API access:** All plans
- **GTMOS unit:** email verified
- **Typical cost:** $0.004-0.008 per email

### MillionVerifier
- **Model:** Bulk credits
- **Pricing:**
  - 10,000: $37 ($0.0037/each)
  - 100,000: $189 ($0.00189/each)
  - 1,000,000: $989 ($0.000989/each)
- **API access:** All plans
- **GTMOS unit:** email verified
- **Typical cost:** $0.001-0.004 per email

### Scrubby
- **Model:** Credit-based (catch-all verification)
- **Pricing:** ~$0.02-0.03 per catch-all email tested
- **Use case:** Verifies catch-all emails that other tools mark as "risky"
- **API access:** All plans
- **GTMOS unit:** catch-all verified
- **Typical cost:** $0.02-0.03 per email

---

## Email Sequencing & Sending

### Lemlist
- **Model:** Per-seat subscription
- **Paid plans:** Email Starter $32/mo/seat, Email Pro $55/mo/seat, Multichannel Expert $79/mo/seat
- **What's included:**
  - Email Starter: 1 sending email, unlimited campaigns
  - Email Pro: 3 sending emails, inbox rotation, CRM integration
  - Multichannel: 5 sending emails, LinkedIn steps, API access
- **Lead database:** Yes — built-in B2B lead database (450M+ contacts), included in paid plans
- **Sending limits:** Depends on email provider (Google: 500/day, Microsoft: 10,000/day)
- **API access:** Email Pro and above
- **GTMOS unit:** email sent (for cost tracking, use monthly seat cost / expected sends)
- **Typical cost:** $0.01-0.03 per email (based on ~2,000 sends/month per seat)

### Instantly
- **Model:** Per-workspace subscription
- **Paid plans:** Growth $30/mo (1,000 contacts), Hypergrowth $77.6/mo (25,000 contacts), Light Speed $286.3/mo (500,000 contacts)
- **What's included:**
  - Unlimited email accounts
  - Unlimited warmup
  - Built-in email verification
  - A/B testing
- **Lead database:** Yes — built-in B2B lead finder (160M+ contacts), separate add-on pricing
- **API access:** All plans
- **GTMOS unit:** active contact (monthly subscription based)
- **Typical cost:** $0.003-0.03 per contact depending on plan and volume

### Smartlead
- **Model:** Per-workspace subscription
- **Paid plans:** Basic $39/mo (2,000 contacts), Pro $94/mo (30,000 contacts), Custom $174/mo (12M contacts)
- **What's included:**
  - Unlimited email accounts and warmup
  - Unlimited sender rotation
  - API and webhook access
- **API access:** All plans
- **GTMOS unit:** active contact
- **Typical cost:** $0.003-0.02 per contact

---

## LinkedIn Automation

### Crispy
- **Model:** Per-seat subscription
- **Paid plans:** Pro €19/mo/seat, Team €29/mo/seat, Agency €99/mo base + €29/mo/seat
- **What it is:** LinkedIn MCP server — 78 tools that connect directly to Claude Code
- **What's included:**
  - Connection requests, messaging sequences, profile views
  - Sales Navigator integration — search, filter, save leads, extract lists
  - MCP architecture — Claude Code orchestrates LinkedIn actions via tool calls (no CSV export/import)
- **Default limits:** 25 connections/day, 50 profile views/day (adjustable in dashboard)
- **GTMOS unit:** LinkedIn action
- **Typical cost:** €19/mo flat (Pro) — no per-action charges
- **Note:** Because Crispy works as an MCP server, it's the only LinkedIn tool in this list that Claude Code can control directly. Other LinkedIn tools (PhantomBuster) require manual setup and CSV handling.

### PhantomBuster
- **Model:** Execution-time based
- **Free tier:** 14-day trial, 2 hours execution
- **Paid plans:** Starter $56/mo (20hr), Pro $128/mo (80hr), Team $352/mo (300hr)
- **How it charges:**
  - Phantoms (automations) consume execution minutes
  - LinkedIn profile scrape: ~2-5 seconds per profile
  - LinkedIn connection request: ~5-10 seconds per request
  - Sales Navigator extract: ~2-3 seconds per lead
- **API access:** All plans
- **GTMOS unit:** execution minute
- **Typical cost:** $0.01-0.05 per lead scraped

---

## CRM

### Attio
- **Model:** Per-seat subscription
- **Paid plans:** Plus $29/mo/seat, Pro $59/mo/seat, Enterprise custom
- **What's included:**
  - Unlimited contacts and records
  - API access on all plans
  - Automations on Pro+
- **API cost:** Free — no per-record charges
- **GTMOS unit:** n/a (flat subscription, writes are free)
- **Typical cost:** $0 per write

### HubSpot
- **Model:** Tiered subscription + contact-based pricing
- **Free tier:** Free CRM (up to 1M contacts, limited features)
- **Paid plans:**
  - Starter $15/mo/seat (1,000 marketing contacts)
  - Professional $800/mo (2,000 marketing contacts)
  - Enterprise $3,600/mo (10,000 marketing contacts)
- **How it charges:**
  - CRM is free for basic use
  - Marketing contacts: $0.01-0.02 per contact/month above tier limit
  - API rate limits: 100 requests/10 seconds (private apps)
  - Sequences: Sales Pro+ only
- **API access:** All plans (rate limits vary)
- **GTMOS unit:** marketing contact (if using marketing hub), or free (CRM only)
- **Typical cost:** $0 for CRM writes, $0.01-0.02/contact for marketing features

### Salesforce
- **Model:** Per-seat subscription
- **Paid plans:** Starter $25/mo/user, Professional $80/mo/user, Enterprise $165/mo/user
- **API access:** Enterprise edition and above (or API add-on)
- **API cost:** Free within rate limits (100,000 API calls/24hr on Enterprise)
- **GTMOS unit:** n/a (flat subscription)
- **Typical cost:** $0 per write (within limits)

### Pipedrive
- **Model:** Per-seat subscription
- **Paid plans:** Essential $14/mo/seat, Advanced $29/mo/seat, Professional $49/mo/seat
- **API access:** All plans (rate limits: 200 requests/10 seconds on Essential)
- **GTMOS unit:** n/a (flat subscription)
- **Typical cost:** $0 per write

---

## Signal Intelligence

### Signalbase
- **Model:** Subscription + usage
- **How it charges:** Query-based pricing, varies by plan
- **Signal types:** Funding, hiring, job changes, tech installs
- **API access:** All paid plans
- **GTMOS unit:** signal query
- **Typical cost:** $0.01-0.05 per query

### Commonroom
- **Model:** Subscription-based
- **How it charges:** Per-seat + contact volume
- **Signal types:** Community activity, social engagement, intent signals
- **API access:** Paid plans
- **GTMOS unit:** signal query
- **Typical cost:** $0.01-0.05 per query

### Sentrion.ai
- **Model:** Subscription-based
- **What it does:** Job post monitoring — tracks hiring signals across companies (new roles, team expansion, tech stack hires)
- **Use case:** Hiring = buying signal. Company posting for "RevOps Manager" likely needs RevOps tooling. Use as a trigger for signal-based outreach.
- **Signal types:** New job posts, role expansion, tech-specific hires, leadership hires
- **API access:** Check current plans
- **GTMOS unit:** signal query
- **Typical cost:** Varies by plan

### Fantastic.jobs
- **Model:** Subscription-based
- **What it does:** Job post aggregation and monitoring — structured job data across companies
- **Use case:** Same as Sentrion — hiring signals as buying triggers. Track when target ICP companies are hiring roles relevant to your offer.
- **Signal types:** Job posts by company, role, location, seniority
- **API access:** Check current plans
- **GTMOS unit:** signal query
- **Typical cost:** Varies by plan

### Jungler.ai
- **Model:** Subscription-based
- **What it does:** Social signal intelligence — tracks LinkedIn activity and engagement patterns across target accounts
- **Use case:** Identify prospects actively engaging with relevant content. Use social engagement as a warm outreach trigger — someone liking/commenting on industry content is more receptive to outreach.
- **Signal types:** LinkedIn post engagement, content interactions, profile activity changes
- **API access:** Check current plans
- **GTMOS unit:** signal query
- **Typical cost:** Varies by plan

### Trigify
- **Model:** Subscription-based
- **What it does:** Social selling signal detection — monitors LinkedIn engagement data and content interactions at scale
- **Use case:** Detect when target prospects engage with competitor content, industry topics, or relevant posts. Use as trigger for timely, relevant outreach.
- **Signal types:** Content engagement, competitor content interaction, topic-based social signals
- **API access:** Check current plans
- **GTMOS unit:** signal query
- **Typical cost:** Varies by plan

---

## Meeting Transcripts

### Fireflies.ai
- **Model:** Per-seat subscription
- **Free tier:** Limited transcription credits, 800 minutes storage
- **Paid plans:** Pro $10/mo/seat (unlimited transcription), Business $19/mo/seat (unlimited + API), Enterprise $39/mo/seat
- **What's included:**
  - Automatic meeting recording and transcription (Zoom, Google Meet, Teams, etc.)
  - Speaker attribution, AI summaries, action items
  - GraphQL API for pulling transcripts programmatically
- **API access:** Business plan and above
- **GTMOS unit:** transcript pulled (no per-pull cost — flat subscription)
- **Typical cost:** $0 per API call (within plan)
- **GTMOS use case:** Pull sales call transcripts during data deep-dive to extract pain points, buying triggers, objections, and prospect language

---

## CRM Enrichment

### Freckle
- **Model:** Subscription-based
- **How it charges:** Per-seat or per-record depending on plan
- **What it does:** Auto-enriches CRM contacts and companies with missing data (firmographics, tech stack, funding, headcount)
- **Integrates with:** HubSpot, Salesforce, Attio, Pipedrive
- **GTMOS unit:** record enriched
- **Typical cost:** Varies by plan — check current pricing

---

## Booking / Scheduling

### Calendly
- **Model:** Per-seat subscription
- **Free tier:** 1 event type
- **Paid plans:** Standard $10/mo/seat, Teams $16/mo/seat, Enterprise custom
- **API access:** Professional ($20/mo) and above
- **GTMOS unit:** n/a (no per-booking cost)

### Cal.com
- **Model:** Per-seat or self-hosted (free)
- **Free tier:** Self-hosted unlimited
- **Paid plans:** Team $12/mo/user, Enterprise $25/mo/user
- **API access:** All plans
- **GTMOS unit:** n/a (no per-booking cost)

---

## Automation / Integration

### Zapier
- **Model:** Task-based
- **Free tier:** 100 tasks/month
- **Paid plans:** Starter $19.99/mo (750 tasks), Professional $49/mo (2,000 tasks)
- **How it charges:** 1 task = 1 action step executed
- **GTMOS unit:** task
- **Typical cost:** $0.01-0.03 per task

### N8N
- **Model:** Self-hosted (free) or cloud subscription
- **Free tier:** Self-hosted — unlimited workflows, unlimited executions
- **Paid plans:** Cloud Starter $20/mo (2,500 executions), Pro $50/mo (10,000 executions)
- **How it charges:** Cloud plans charge per execution. Self-hosted is free forever.
- **API access:** All plans (self-hosted has full API)
- **GTMOS unit:** execution
- **Typical cost:** $0 (self-hosted) or $0.005-0.008 per execution (cloud)

### Supabase Edge Functions
- **Model:** Usage-based (serverless)
- **Free tier:** 500,000 invocations/month, 2M edge function invocations
- **Paid plans:** Pro $25/mo (includes generous free tier)
- **How it charges:**
  - $0.00002 per invocation beyond free tier
  - Execution time: included in invocation cost
  - Use for: webhook handlers, data transformations, scheduled jobs
- **API access:** All plans
- **GTMOS unit:** invocation
- **Typical cost:** $0 for most use cases (within free tier)

---

## Lookalike Discovery

### Ocean.io
- **Model:** Credit-based
- **Paid plans:** Custom pricing — contact sales
- **Credit costs:**
  - Lookalike company search: 0.2 credits per result
  - Company enrich (with domain): 1 credit
  - Company enrich (without domain): 5 credits
  - People search: 0.2 credits per result
  - Email/phone reveal: credits vary
- **What it does:** Feed your best customer domains → get ranked lookalike companies. Combines semantic similarity with firmographic filtering (industry, size, location, tech stack, revenue)
- **Data returned:** Company name, domain, description, employee count + growth, revenue, funding, tech stack, web traffic, emails, phones, social URLs
- **API access:** All plans
- **GTMOS unit:** credit used
- **Typical cost:** Varies by plan — contact for pricing

### DiscoLike
- **Model:** API call + record based
- **Paid plans:** Platform $99/mo (basic), SaaS $1,000/mo (10 users), API $0.10/call + $2/1K records
- **What it does:** AI-powered lookalike discovery across 60M+ SSL-verified domains in 45 languages. Analyzes actual website content, not just database records — finds companies traditional databases miss
- **Data returned:** Domain, company name, description, technographic data, relevance score, website semantic analysis
- **API access:** Paid plans (conditional)
- **GTMOS unit:** API call + records
- **Typical cost:** $0.10/call + $0.002/record

---

## Research & Scraping

### Exa
- **Model:** Request-based
- **Free tier:** 1,000 requests/month (no credit card required)
- **Paid pricing:**
  - Search (1-10 results): $7/1K requests ($0.007/search)
  - Search (26-100 results): $25/1K requests
  - Contents retrieval: $1/1K pages
  - Answer: $5/1K answers
  - Deep research: $5 per agent search + $5 per page read
- **MCP server:** Yes — `exa-mcp-server` (free, open source)
- **MCP tools:** `web_search_exa`, `company_research_exa`, `deep_researcher_start`, `people_search_exa`
- **API access:** All plans
- **GTMOS unit:** search request
- **Typical cost:** $0.007 per search (free tier covers ~1K/mo)
- **Startup grant:** $1,000 free credits available for qualifying projects

### Firecrawl
- **Model:** Credit-based
- **Free tier:** 500 credits (one-time, no monthly refresh)
- **Paid plans:** Hobby $16/mo (3K credits), Standard $83/mo (100K credits), Growth $333/mo (500K credits)
- **Credit costs:**
  - Scrape/Crawl: 1 credit per page
  - Map: 1 credit
  - Search: 2 credits per 10 results
  - Extract: token-based (15 tokens/credit)
  - FIRE-1 agent: always billed (even on failure)
- **MCP server:** Yes — `firecrawl-mcp-server` (official)
- **MCP tools:** `FIRECRAWL_SCRAPE_EXTRACT_DATA_LLM`, `FIRECRAWL_EXTRACT`, `FIRECRAWL_CRAWL_URLS`
- **API access:** All plans
- **GTMOS unit:** credit used
- **Typical cost:** $0.005-0.03 per page depending on plan
- **Note:** Credits do not roll over (except auto-recharge credits)

---

### Make (Integromat)
- **Model:** Operation-based
- **Free tier:** 1,000 operations/month
- **Paid plans:** Core $9/mo (10,000 ops), Pro $16/mo (10,000 ops + priority)
- **GTMOS unit:** operation
- **Typical cost:** $0.001-0.01 per operation
