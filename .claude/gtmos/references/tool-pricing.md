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
- **API access:** Professional plan and above
- **GTMOS unit:** contact enriched
- **Typical cost:** $0.01-0.05 per contact depending on plan and volume

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

### RocketReach
- **Model:** Credit-based per lookup
- **Paid plans:** Essentials $53/mo (80 lookups), Pro $107/mo (200 lookups), Ultimate $269/mo (500 lookups)
- **Credit costs:**
  - Contact lookup: 1 credit
  - Company lookup: 1 credit
  - Bulk lookup: 1 credit per contact
- **API access:** Pro plan and above
- **GTMOS unit:** lookup
- **Typical cost:** $0.50-0.70 per lookup

### Lusha
- **Model:** Credit-based
- **Free tier:** 5 credits/month
- **Paid plans:** Pro $29/mo/user (480 credits/yr), Premium $51/mo/user (960 credits/yr)
- **Credit costs:**
  - Email: 1 credit
  - Phone: 1 credit
  - Both: 2 credits
- **API access:** Premium plan and above
- **GTMOS unit:** contact revealed
- **Typical cost:** $0.04-0.10 per credit

### LeadIQ
- **Model:** Credit-based per user
- **Free tier:** 20 verified emails/week
- **Paid plans:** Essential $39/mo/user, Pro $79/mo/user, Enterprise custom
- **Credit costs:**
  - Verified email: 1 credit
  - Mobile number: varies
  - Tracked profile: free
- **API access:** Pro plan and above
- **GTMOS unit:** contact captured
- **Typical cost:** $0.05-0.15 per contact

### Clearbit (now Breeze Intelligence by HubSpot)
- **Model:** Record-based pricing
- **Paid plans:** Starts at $30k/year
- **How it charges:**
  - Enrichment: per record enriched per month
  - Reveal: per anonymous visitor identified
  - Typical: $0.10-0.30 per enrichment
- **API access:** All paid plans
- **GTMOS unit:** record enriched
- **Typical cost:** $0.10-0.30 per record

---

## Email Verification

### ZeroBounce
- **Model:** Credit-based (bulk or per-email)
- **Free tier:** 100 free verifications/month
- **Paid plans:** Pay-as-you-go from $0.008/email at 2,000+ volume
- **Bulk pricing:**
  - 2,000 emails: $16 ($0.008/each)
  - 5,000 emails: $35 ($0.007/each)
  - 10,000 emails: $64 ($0.0064/each)
  - 100,000 emails: $390 ($0.0039/each)
- **API access:** All plans
- **GTMOS unit:** email verified
- **Typical cost:** $0.004-0.008 per email

### NeverBounce
- **Model:** Pay-as-you-go or subscription
- **Pricing:**
  - Up to 10,000: $0.008/email
  - 10,001-100,000: $0.005/email
  - 100,001-250,000: $0.004/email
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

## Email Sequencing

### Lemlist
- **Model:** Per-seat subscription
- **Paid plans:** Email Starter $32/mo/seat, Email Pro $55/mo/seat, Multichannel Expert $79/mo/seat
- **What's included:**
  - Email Starter: 1 sending email, unlimited campaigns
  - Email Pro: 3 sending emails, inbox rotation, CRM integration
  - Multichannel: 5 sending emails, LinkedIn steps, API access
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

### Woodpecker
- **Model:** Per-contact slot pricing
- **Paid plans:** From $20/mo for 500 contacted prospects
- **What's included:**
  - Unlimited email accounts
  - Unlimited team members
  - A/B testing, conditions
- **API access:** All plans
- **GTMOS unit:** prospect contacted
- **Typical cost:** $0.02-0.04 per prospect

---

## LinkedIn Automation

### Crispy
- **Model:** Per-seat subscription
- **Paid plans:** Varies by plan
- **What's included:**
  - Automated connection requests
  - Automated messaging sequences
  - Profile viewing automation
- **LinkedIn limits apply:** Max 25 connections/day, 50 profile views/day
- **GTMOS unit:** LinkedIn action
- **Typical cost:** $0.05-0.15 per action

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

### 6sense
- **Model:** Enterprise subscription
- **Paid plans:** Starts at $25k+/year
- **Signal types:** Intent data, account identification, predictive scoring
- **GTMOS unit:** account identified
- **Typical cost:** Enterprise — contact for pricing

### Bombora
- **Model:** Enterprise subscription
- **Paid plans:** Starts at $25k+/year
- **Signal types:** Topic-level B2B intent data, surge scoring
- **GTMOS unit:** intent signal
- **Typical cost:** Enterprise — contact for pricing

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

### Make (Integromat)
- **Model:** Operation-based
- **Free tier:** 1,000 operations/month
- **Paid plans:** Core $9/mo (10,000 ops), Pro $16/mo (10,000 ops + priority)
- **GTMOS unit:** operation
- **Typical cost:** $0.001-0.01 per operation
