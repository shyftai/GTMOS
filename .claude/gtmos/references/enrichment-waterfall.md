# Enrichment Waterfall — GTMOS

Cascading enrichment logic based on actual API research. Try the cheapest source first, cascade on misses, stop when data is found. Track hit rates per source per workspace to optimize order over time.

**Override:** Users can change the waterfall order in workspace RULES.md under `## Enrichment waterfall overrides`. If no overrides exist, use the defaults below.

---

## Provider Cost Cheat Sheet

Before the waterfalls — what each action actually costs across providers:

### Email Finding

| Provider | Cost per find | Charged on miss? | Verification included? | Notes |
|----------|--------------|-------------------|----------------------|-------|
| Apollo | 1 email + 1 export credit | No (only on reveal) | No (email_status field only) | Three separate credit pools |
| Icypeas | 1 credit ($0.005-0.019) | No | No (separate 0.01cr verify) | Credits never expire |
| Prospeo | 1 credit ($0.007-0.039) | No | Yes (built-in) | Lifetime dedup — re-enrich same person = free |
| Dropcontact | 1 credit (~$0.024) | No | Yes (built-in) | No database — algorithmic. GDPR compliant |
| FindyMail | 1 credit (~$0.04) | No | Yes (<5% bounce guarantee) | Credits never expire |
| Lemlist | 5 credits ($0.05) | No | Yes (waterfall across 7 sources) | Credits expire monthly |
| Instantly | ~$0.02-0.05 | Separate subscription | Included | Separate lead finder plan required |

### Email Verification (standalone)

| Provider | Cost per verify | Catch-all handling | Enrichment data included? |
|----------|----------------|-------------------|--------------------------|
| MillionVerifier | $0.001-0.004 | Free (not charged) | No |
| Icypeas | ~0.01 credits ($0.00005-0.0002) | Google/Microsoft catch-all detection | No |
| ZeroBounce | $0.008-0.02 | Returns "catch-all" status | Yes (name, gender, location, domain age) |
| Scrubby | $0.0015-0.007 | Specialist — sends real emails to test | No |

### People Enrichment

| Provider | Cost | Email included? | Phone included? | Company data? |
|----------|------|-----------------|-----------------|---------------|
| Apollo | 1 email + 1 export credit | Yes | +5 mobile credits | Yes (basic, embedded) |
| Prospeo | 1 credit | Yes (verified) | +10 credits for mobile | Yes (50+ fields) |
| Icypeas profile scraper | 1.5 credits | No | No | No |
| Crispy / Sales Nav | Included in sub | No | No | No |
| Apify | ~$0.003/profile | No | No | No |

### Company Enrichment

| Provider | Cost | Fields |
|----------|------|--------|
| Apollo org enrich | 1 export credit | Industry, employees, revenue, funding, tech stack, social URLs |
| Icypeas company scraper | 0.5 credits | Name, description, employees, industry, address, website, specialties |
| Icypeas find companies DB | 0.02 credits/result | Basic company records from leads DB |
| Prospeo enrich-company | 1 credit (lifetime dedup) | 50+ fields: industry, employees, revenue, funding, tech, SIC/NAICS |

### Phone Finding

| Provider | Cost | Notes |
|----------|------|-------|
| Apollo | 5 mobile credits | DNC status included. Most reliable for direct dials |
| Prospeo | 10 credits ($0.07-0.39) | Via enrich-person with mobile flag |
| Icypeas | Available (cost TBC) | Non-EU contacts only |
| Lemlist | 25 credits ($0.20) | Via built-in finder |
| FindyMail | 10 credits (~$0.40) | Pay only on success |

---

## Data Fields Returned Per Provider

### Apollo — People Enrichment (`POST /api/v1/people/match`)

**Person fields:**
- `first_name`, `last_name`, `name`, `title`, `headline`
- `email`, `email_status` (verified/guessed/unavailable)
- `personal_emails[]` (if `reveal_personal_emails=true`)
- `phone_numbers[]` — raw_number, sanitized_number, type, status, dnc_status (if `reveal_phone_number=true`)
- `seniority`, `departments[]`, `subdepartments[]`, `functions[]`
- `city`, `state`, `country`
- `linkedin_url`, `twitter_url`, `facebook_url`, `github_url`
- `photo_url`
- `employment_history[]` — org name, title, current, start/end date, description

**Embedded company fields:**
- `organization.name`, `website_url`, `primary_domain`
- `organization.industry`, `keywords[]`
- `organization.linkedin_url`, `twitter_url`, `facebook_url`
- `organization.founded_year`, `logo_url`
- Basic firmographics only — for full company data use org enrichment

### Apollo — Organization Enrichment (`POST /api/v1/organizations/enrich`)

- `name`, `website_url`, `primary_domain`, `blog_url`
- `short_description`, `seo_description`
- `industry`, `keywords[]`
- `estimated_num_employees`, `departmental_head_count`
- `annual_revenue`, `annual_revenue_printed`
- `total_funding`, `total_funding_printed`, `latest_funding_stage`, `latest_funding_round_date`, `latest_funding_round_amount`, `funding_events[]`
- `technology_names[]` (tech stack)
- `linkedin_url`, `twitter_url`, `facebook_url`, `angellist_url`
- `primary_phone`
- `city`, `state`, `country`, `street_address`
- `founded_year`
- `publicly_traded_symbol`, `publicly_traded_exchange`
- `alexa_ranking`

### Prospeo — Enrich Person (`POST /enrich-person`)

**Person fields:**
- `person_id`, `first_name`, `last_name`, `full_name`
- `email` (verified), `email_status` (VALID, CATCH_ALL, etc.)
- `mobile` (if requested — 10 credits)
- `linkedin_url`, `linkedin_member_id`
- `current_job_title`, `current_job_key`, `headline`
- `last_job_change_detected_at`
- `job_history[]` — title, company_name, current, start/end dates, duration_in_months, departments, seniority, company_id

**Company fields (embedded, can be null):**
- `company_id`, `name`, `website`, `domain`, `other_websites`
- `description`, `type`, `industry`
- `employee_count`, `employee_range`
- `location` (country, state, city)
- `linkedin_url`
- `sic_codes`, `naics_codes`
- `email_tech` (domain, MX provider)
- `funding`, `technologies`

### Prospeo — Enrich Company (`POST /enrich-company`)

- `company_id`, `name`, `website`, `domain`, `other_websites`
- `description`, `type`, `industry`
- `employee_count`, `employee_range`
- `location` (country, state, city)
- `linkedin_url`, `logo_url`
- `sic_codes`, `naics_codes`
- `funding` (stages, amounts)
- `technologies` (tech stack)
- `email_tech` (MX provider)
- `departments`, `revenue`

### Icypeas — Email Finder (`POST /email-search`)

- `firstname`, `lastname`, `fullname`, `gender`
- `emails[]` — email, certainty (ULTRA_SURE etc.), mxProvider, mxRecords
- `phones` (if available)
- `saasServices`

### Icypeas — Company Scraper (`GET /scrape/company`)

- `name`, `description`, `address`
- `numberOfEmployees`, `industry`
- `website`, `specialties`
- Employee growth data

### ZeroBounce — Email Verification (`GET /v2/validate`)

- `status` (valid, invalid, catch-all, spamtrap, abuse, do_not_mail, unknown)
- `sub_status` (mailbox_not_found, disposable, toxic, role_based, etc.)
- **Enrichment bonus:** `firstname`, `lastname`, `gender`, `country`, `region`, `city`, `zipcode`
- `domain_age_days`, `smtp_provider`, `mx_record`, `free_email`

### Apify + Sales Navigator — Company Search (Account Scraper)

Via `pratikdani/sales-navigator-company-search-scraper-no-cookies` or similar actors:
- `company_name`, `description`, `tagline`
- `industry`, `industry_type`
- `founding_year`
- `website`, `linkedin_url`, `logo_url`
- `employee_count`, `employee_growth_metrics`
- `headquarters` (city, country, full location)
- `revenue_estimates`
- `specialties[]`
- `saved_status`, `notes_count`
- `employees[]` — name, LinkedIn profile URN, profile picture

**Not available via SN scrape:** email, phone, tech stack, funding rounds, SIC/NAICS codes.

**Reliability warning:** Community-maintained actors (3.4/5 avg rating). May break when LinkedIn changes layout. No-cookies actors are newer but more account-safe. Always have a fallback source.

**Cost structure:** Apify compute (~$0.50/1K companies) + optional residential proxies. No per-result fee from the actor itself (pay-per-event model).

### Crispy / Sales Navigator — People Search

Search returns per result:
- `id` (provider ID — needed for full profile scrape)
- `name`, `headline`, `location`
- `profile_url`, `public_identifier`, `profile_picture`
- `network_distance` (1st, 2nd, 3rd)
- `shared_connections` count
- `current_positions[]` — role, company, company_id, location, tenure
- Flags: `pending_invitation`, `premium`, `open_profile`

### Crispy / Sales Navigator — Full Profile Scrape (`get_profile`)

On top of search fields:
- `summary` — full bio/about text
- `connections` — total connection count
- `work_experience[]` — every role: position, company, company_id, location, description, start/end dates, current flag
- `skills[]` — all listed skills
- `education[]` — school, degree, field of study
- `languages[]` — language + proficiency
- `volunteering[]` — role, organization, cause
- `contact_info.socials[]` — Twitter, websites
- Flags: `premium`, `creator`, `hiring`, `open_to_work`, `can_send_inmail`

### Crispy / Sales Navigator — Company Profile (`get_company_profile`)

- `description`, `tagline`, `website`
- `industry[]`, `employee_count`, `followers`
- `headquarters` (city + country)
- `growth.avg_tenure` — average employee tenure
- `logo`

### Crispy / Sales Navigator — NOT available

- Email addresses (no personal or work email)
- Phone numbers
- Revenue / funding data
- Technologies / tech stack
- Company founding year

---

## Optimal Waterfalls

### 1. Email Finding

Goal: find a verified business email for a known person (have name + company/domain/LinkedIn).

| Step | Source | Cost | Why this order |
|------|--------|------|----------------|
| 1 | **Apollo** | 1 email + 1 export credit | Largest database (275M+), cheap, often has email already |
| 2 | **Icypeas** | 1 credit (only on success) | Very cheap ($0.005 on Hypergrowth), credits never expire |
| 3 | **Prospeo** | 1 credit (lifetime dedup) | Returns verified email + company data. LinkedIn URL to email is a strength |
| 4 | **Dropcontact** | 1 credit (~$0.024) | Algorithmic (no database) — finds emails other tools miss. GDPR compliant |
| 5 | **FindyMail** | 1 credit (~$0.04) | <5% bounce guarantee, good last resort |

**Volume per provider (programmatic API access):**

| Provider | Search volume | Enrichment volume | API batch size | Rate limit |
|----------|--------------|-------------------|----------------|------------|
| Apollo | FREE — 600 calls/day, 50K results/query | Plan credits | 10 per bulk call | 50 req/min (free), higher on paid |
| Icypeas | 0.02cr/result (DB), credits never expire | 1cr/email, 0.5cr/company | 5,000 per bulk | 30 req/min |
| Prospeo | 1cr per 25 results | 1cr/person (lifetime dedup) | 50 per bulk call | Standard |
| Apify+SalesNav | ~$0.50/1K companies (compute) | Same (20+ fields) | Paginated | LinkedIn rate limits, proxy-dependent |
| Crispy/SalesNav | Included in sub, no per-search cost | Included (profile data only) | Per-search | LinkedIn limits |
| Lemlist | Included in sub (Email Pro+) | 5cr/email find | Via campaign API | Per-plan |
| Instantly | Separate lead finder plan ($47-197/mo) | 1K-10K contacts/mo | Via lead API | Per-plan |
| Dropcontact | 1cr/success, credits from ~€24/mo | Same as search | Batch endpoint | Standard |
| FindyMail | 1cr/find, credits never expire | Same | Via API | Standard |
| Crunchbase | FREE — 200 calls/min | Same (basic fields) | 25 per page | 200 req/min |
| Diffbot | FREE — 10K credits/mo (25cr/export) | Same | Per-query | 5 req/min (free) |
| Companies House | FREE — unlimited | Same | Per-query | 600 req/5min |

**After finding — always verify:**

| Step | Source | Cost | Why |
|------|--------|------|-----|
| 1 | **Icypeas verify** | ~0.01 credits | Nearly free, includes Google/Microsoft catch-all detection |
| 2 | **MillionVerifier** | $0.001-0.004 | Cheapest bulk verifier, catch-all results are free |
| 3 | **ZeroBounce** | $0.008-0.02 | Most detailed — returns enrichment data alongside verification |

**If result is catch-all:**

| Step | Source | Cost | Why |
|------|--------|------|-----|
| 1 | **Scrubby** | $0.0015-0.007 | Sends real emails to test. 98% deliverability on validated catch-alls |

**Skip verification if:** Prospeo or Dropcontact found the email (verification is built-in).

### 2. People Search

Goal: find people matching ICP criteria (title, industry, company size, location).

| Step | Source | Cost | Why this order |
|------|--------|------|----------------|
| 1 | **Crispy / Sales Navigator** | Included in sub | Primary discovery engine. LinkedIn-native search with 36+ filters, intent signals, job change alerts, spotlights. No email/phone but best targeting precision |
| 2 | **Apollo** | FREE | People search is free. 275M+ contacts, 600 calls/day. No emails in results (preview only) |
| 3 | **Lemlist built-in DB** | Included in sub | 450M+ contacts, search by filters. Included in Email Pro+ plans |
| 4 | **Instantly lead finder** | Included in lead finder plan | 160M+ contacts. Separate subscription from sending plan |
| 5 | **Prospeo** | 1 credit per 25 results | search-person returns up to 25 per credit. No email (need separate enrich) |
| 6 | **Icypeas leads DB** | Low credit cost | Find People endpoint with filters |
| 7 | **Apify** | ~$0.003/profile | LinkedIn search scraper at volume. Use when you need to bulk-extract from SN search results |

**Strategy:** Crispy is the primary people discovery tool — Sales Navigator's filters (title, seniority, spotlights, job changes) are unmatched. Apollo (free) is the best complement for broad searches. After discovery, run found contacts through the email finding waterfall to get verified emails.

### 3. Company Discovery

Goal: find companies matching ICP firmographics.

**Phase 1 — Discovery (find target companies)**

| Step | Source | Cost | Why this order |
|------|--------|------|----------------|
| 1 | **Crispy / Sales Navigator** | Included in sub | Primary discovery engine. 36+ filters: headcount, growth, industry, funding signals, hiring, tech adoption. Unmatched for precision targeting. Returns: name, industry, headcount, HQ, website, description |
| 2 | **Crunchbase Basic API** | FREE | Best for startup/funded companies. Search by industry, size, funding, location. 200 calls/min |
| 3 | **Icypeas find companies DB** | 0.02 credits/result | Extremely cheap for basic company discovery |
| 4 | **Diffbot Knowledge Graph** | FREE (10K credits/mo) | 10B+ entities, search by industry, revenue, employee count, tech stack |
| 5 | **Prospeo search-company** | 1 credit per 25 results | Good filters, 50+ fields per result |
| 6 | **Apollo org search** | Credits (not free) | Large database but costs credits |
| 7 | **StoreLeads** | Included in sub | E-commerce only: Shopify, WooCommerce, platform/app data |
| 8 | **Opemart** | Included in sub | SMB/local businesses |
| 9 | **Companies House** | FREE | UK companies only. Full government registry, unlimited |

**Phase 2 — Company Enrichment at Volume (fill gaps on discovered companies)**

Once you have a company list from discovery, enrich missing fields (tech stack, revenue, funding, SIC/NAICS) via API:

| Step | Source | Cost | What it adds |
|------|--------|------|-------------|
| 1 | **Icypeas company scraper** | 0.5 credits | Employees, industry, specialties, growth data. Cheapest option |
| 2 | **Prospeo enrich-company** | 1 credit (lifetime dedup) | 50+ fields: revenue, funding, tech stack, SIC/NAICS. Re-enrich same company = free forever |
| 3 | **Apollo org enrich** | 1 export credit | Industry, employees, revenue, funding rounds, tech stack, social URLs, HQ |
| 4 | **Apify scraper** | ~$0.50/1K companies | Custom scrape for data not in databases (website tech stack, team pages, about pages) |

**Volume scraping alternative:** When you need to pull large company lists from Sales Navigator filters at scale (1K+ companies), use **Apify + Sales Navigator** (~$0.50/1K, no-cookies actors available) instead of Crispy. Crispy is best for discovery and precision targeting; Apify handles bulk extraction.

**Strategy:** Crispy is the go-to for discovering companies — Sales Navigator's filters are the most powerful for ICP targeting. Once you have a list, enrich at volume via Icypeas (cheapest), Prospeo (most fields + lifetime dedup), or Apollo (deepest tech/funding data). Use Apify for bulk SN extraction when Crispy isn't practical at scale.

### 4. People Enrichment

Goal: enrich a known person (have name + company or LinkedIn URL) with title, seniority, employment history, company data.

| Step | Source | Cost | What you get |
|------|--------|------|-------------|
| 1 | **Apollo** | 1 email + 1 export credit | Title, seniority, employment history, social URLs, email, basic company data |
| 2 | **Prospeo** | 1 credit (lifetime dedup) | Title, seniority, job history, verified email, 50+ company fields |
| 3 | **Icypeas profile scraper** | 1.5 credits | LinkedIn-style profile data (title, company, location) |
| 4 | **Crispy / Sales Navigator** | Included in sub | Full LinkedIn profile: experience, education, skills, about section |
| 5 | **Apify** | ~$0.003/profile | Same as Sales Nav but via scraping. No subscription needed |

**Note:** Apollo and Prospeo both return email alongside person data — if you need people enrichment AND email, use step 1-2 and skip the separate email waterfall.

### 5. Company Enrichment

Goal: enrich a known company (have domain or name) with firmographics, tech stack, funding, headcount. Same providers as Company Discovery Phase 2, but used standalone when you already have a company list.

| Step | Source | Cost | What you get |
|------|--------|------|-------------|
| 1 | **Icypeas company scraper** | 0.5 credits | Name, description, employees, industry, address, website, specialties, growth. Cheapest |
| 2 | **Prospeo enrich-company** | 1 credit (lifetime dedup) | 50+ fields: industry, employees, revenue, funding, tech, SIC/NAICS codes. Re-enrich = free |
| 3 | **Apollo org enrich** | 1 export credit | Industry, employees, revenue, funding rounds, tech stack, social, HQ address |
| 4 | **StoreLeads** | Included in sub | E-commerce only: platform, apps, traffic, Alexa rank |
| 5 | **Apify** | ~$0.01/site | Custom website scrape for tech stack, team page, about page |

**Strategy:** Icypeas is cheapest at 0.5 credits. Prospeo's lifetime dedup makes it ideal for companies you'll look up repeatedly. Apollo gives the deepest tech/funding data for 1 credit.

### 6. Phone Number Finding

Goal: find a direct dial or mobile number for a known person.

| Step | Source | Cost | Notes |
|------|--------|------|-------|
| 1 | **Apollo** | 5 mobile credits | Most reliable for direct dials. Includes DNC status |
| 2 | **Prospeo** | 10 credits ($0.07-0.39) | Via enrich-person with mobile flag |
| 3 | **Icypeas mobile finder** | TBC | Non-EU contacts only. Expanding coverage |
| 4 | **FindyMail** | 10 credits (~$0.40) | Pay only on success |
| 5 | **Lemlist** | 25 credits ($0.20) | Most expensive option |

**Important — only enrich phone for:**
- A-tier leads (lead score 80+)
- ABM campaigns where phone is a required channel
- Contacts that haven't responded to email after full sequence
- Phone is 5-10x more expensive than email — use selectively

---

## Clay — Optional Orchestration Layer

Clay is NOT a data provider — it's a waterfall orchestration tool that connects to 100+ providers.

**When to use Clay:**
- You want a no-code UI to run enrichment workflows
- You need Claygent (AI web research for unstructured data)
- You want to combine providers you don't have direct API access to

**When NOT to use Clay:**
- You need API-level programmatic enrichment (Clay has no real API unless Enterprise)
- You're cost-sensitive at scale (25-50 Clay credits per full enrichment)
- Credits are charged on attempts, not results (unlike Icypeas/Prospeo/Apollo)

**BYOK tip:** If using Clay, bring your own Apollo/Icypeas/Prospeo API keys — those calls use 0 Clay credits.

**Pricing:** Starter $149/mo (2K credits), Explorer $349/mo (10K), Pro $800/mo (50K). Credits don't roll over.

---

## Waterfall Execution Rules

### Before starting any enrichment
1. Check which tools are active in TOOLS.md — skip inactive tools
2. Check .env for API keys — skip tools with missing keys
3. Check COSTS.md — ensure budget allows estimated enrichment cost
4. Display the enrichment plan:

```
  ┌─ ENRICHMENT PLAN ───────────────────────────┐
  │                                               │
  │  Type:      Email enrichment                  │
  │  Contacts:  127 missing emails                │
  │                                               │
  │  Waterfall:                                   │
  │    1. Apollo        (1+1 credits)    ~$X.XX   │
  │    2. Icypeas       (1 credit/hit)   fallback │
  │    3. Prospeo       (1 credit/hit)   fallback │
  │    4. Verify: Icypeas (0.01cr)       ~$X.XX   │
  │    5. Catch-all: Scrubby             if needed│
  │                                               │
  │  Est. max cost:  $XX.XX                       │
  │  Budget remaining: $XXX.XX                    │
  │                                               │
  └───────────────────────────────────────────────┘
  >> Proceed? (y/n)
```

### During enrichment
1. Process in batches (Apollo: 10 per bulk call, Prospeo: 50 per bulk call, Icypeas: 5,000 per bulk)
2. Only send misses from previous step to the next source
3. Report progress after each source:

```
  ── ENRICHMENT PROGRESS ─────────────────────────
  Apollo:     94/127 found  (74%)    94 email + 94 export credits
  Icypeas:    21/33 found   (64%)    21 credits
  Prospeo:    8/12 found    (67%)    8 credits (verified, deduped)
  Not found:  4 contacts
  ────────────────────────────────────────────────
```

4. Log every enrichment action in COSTS.md

### After enrichment
1. Display final results with source breakdown and cost
2. Update COSTS.md with actual spend per tool
3. Update enrichment hit rate tracker in TOOLS.md
4. Save enriched list to lists/validated/
5. Flag not-found contacts — suggest removing or manual research

### Hit rate tracking

After every enrichment run, update the workspace hit rate tracker in TOOLS.md:

```
## Enrichment hit rates

| Source | Email | Phone | People | Company | Last updated |
|--------|-------|-------|--------|---------|-------------|
| Apollo | 74% | 62% | 89% | 95% | 2026-03-07 |
| Icypeas | 64% | — | — | 48% | 2026-03-07 |
| Prospeo | 67% | — | 82% | 91% | 2026-03-07 |
| Crispy | — | 12% | 71% | — | 2026-03-07 |
```

If a source consistently outperforms another, suggest reordering the waterfall for this workspace.

---

## Overriding the waterfall

Users can override the default order in workspace RULES.md:

```markdown
## Enrichment waterfall overrides

### Email enrichment order
1. Icypeas
2. Apollo
3. Prospeo

### Skip sources
- Hunter.io (not using)
- Lemlist DB (data quality issues)

### Phone enrichment threshold
- Only enrich phone for lead_score >= 85 (default: 80)

### Verification
- Use MillionVerifier instead of Icypeas for verification
```

If overrides exist, use them. If not, use the defaults in this file.

---

## API Endpoint Quick Reference

### Apollo
- People Search: `POST /api/v1/mixed_people/api_search` (FREE)
- People Enrich: `POST /api/v1/people/match` (1 email + 1 export credit)
- Bulk People: `POST /api/v1/people/bulk_match` (max 10)
- Org Search: `POST /api/v1/mixed_companies/search` (costs credits)
- Org Enrich: `POST /api/v1/organizations/enrich` (1 export credit)
- Bulk Org: `POST /api/v1/organizations/bulk_enrich` (max 10)
- Auth: `X-Api-Key` header

### Prospeo (new endpoints — old ones deprecated March 2025)
- Enrich Person: `POST /enrich-person` (1 credit, 10 with mobile)
- Bulk Enrich Person: `POST /bulk-enrich-person` (max 50)
- Enrich Company: `POST /enrich-company` (1 credit)
- Bulk Enrich Company: `POST /bulk-enrich-company` (max 50)
- Search Person: `POST /search-person` (1 credit per 25 results)
- Search Company: `POST /search-company` (1 credit per 25 results)
- Auth: `X-KEY` header
- Base: `https://api.prospeo.io`

### Icypeas
- Email Finder: `POST /email-search` (1 credit on success)
- Email Verify: `POST /email-verification` (~0.01 credits)
- Domain Scan: `POST /domain-scan` (0.1 credits)
- Bulk Search: `POST /bulk-search` (max 5,000)
- Company Scraper: `GET /scrape/company?url=URL` (0.5 credits)
- Profile Scraper: `POST /scrape` (1.5 credits, max 50)
- Find People: `POST /leads-db/find-people/`
- Find Companies: `POST /leads-db/find-companies/` (0.02 credits/result)
- Auth: `Authorization: {api_key}:{secret}`
- Base: `https://app.icypeas.com/api`
- Rate limit: 30 req/min

### Dropcontact
- Batch Enrich: `POST /batch` (1 credit, pay on success only)
- Get Results: `GET /v1/enrich/all/{request-id}`
- Auth: `X-Access-Token` header
- Base: `https://api.dropcontact.com`

### FindyMail
- Email Finder, Verifier, Phone Finder, Company Info
- Auth: API key
- Base: `https://app.findymail.com`
- Docs: `https://app.findymail.com/docs/`

### Apify (Sales Navigator company scraping)
- Run Actor: `POST /v2/acts/{actorId}/runs` (start scrape)
- Get Results: `GET /v2/actor-runs/{runId}/dataset/items` (fetch results)
- Recommended actor: `pratikdani/sales-navigator-company-search-scraper-no-cookies`
- Auth: `Authorization: Bearer {APIFY_API_KEY}`
- Base: `https://api.apify.com`
- Input: Sales Navigator account search URL or filter params
- Note: No-cookies actor — does not require LinkedIn session. Community-maintained

### Verification
- ZeroBounce: `GET /v2/validate?api_key=KEY&email=EMAIL` (1 credit)
- ZeroBounce Batch: `POST /v2/validatebatch` (max 200)
- MillionVerifier: `GET /api/v3/?api=KEY&email=EMAIL` (rate: 160/sec)
- Scrubby: See `https://docs.scrubby.io/`
