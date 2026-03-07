# API Reference — GTMOS Supported Tools

Quick reference for making API calls from Claude Code. Auth, base URLs, key endpoints, and request formats.

---

## Apollo

**Auth:** API key in header `X-Api-Key`
**Base URL:** `https://api.apollo.io/api/v1`

Apollo uses **three separate credit pools**: email credits, mobile credits, export credits.

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Search people | POST | `/mixed_people/api_search` | FREE (no email/phone in results) |
| Enrich person | POST | `/people/match` | 1 email + 1 export credit |
| Bulk enrich people | POST | `/people/bulk_match` (max 10) | Same per person |
| Search orgs | POST | `/mixed_companies/search` | Costs credits |
| Enrich org | POST | `/organizations/enrich` | 1 export credit |
| Bulk enrich orgs | POST | `/organizations/bulk_enrich` (max 10) | Same per org |

**Enrich options:** Add `reveal_phone_number: true` for phone (5 mobile credits). Add `reveal_personal_emails: true` for personal emails.

**Search contacts example (FREE):**
```bash
curl -X POST "https://api.apollo.io/api/v1/mixed_people/api_search" \
  -H "X-Api-Key: $APOLLO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "person_titles": ["VP Sales", "Head of Sales"],
    "organization_num_employees_ranges": ["50,200"],
    "person_locations": ["United States"],
    "page": 1,
    "per_page": 25
  }'
```

**Enrich person example (1 email + 1 export credit):**
```bash
curl -X POST "https://api.apollo.io/api/v1/people/match" \
  -H "X-Api-Key: $APOLLO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "first_name": "John",
    "last_name": "Doe",
    "organization_name": "Acme Inc",
    "reveal_phone_number": false
  }'
```

**Enrich org example (1 export credit):**
```bash
curl -X POST "https://api.apollo.io/api/v1/organizations/enrich" \
  -H "X-Api-Key: $APOLLO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "domain": "acme.com"
  }'
```

---

## Instantly

**Auth (V2):** Bearer token in header `Authorization: Bearer {key}`
**Base URL:** `https://api.instantly.ai/api/v2`

**Note:** V1 API is deprecated. Use V2 endpoints below.

| Action | Method | Endpoint |
|--------|--------|----------|
| List campaigns | GET | `/campaigns` |
| Get campaign | GET | `/campaigns/{id}` |
| Add leads | POST | `/leads` |
| Get lead status | GET | `/leads?campaign_id={id}&email={email}` |
| **Analytics overview** | GET | `/campaigns/analytics/overview` |
| **Daily analytics** | GET | `/campaigns/{id}/analytics/daily` |
| List accounts | GET | `/email-accounts` |
| Pause campaign | POST | `/campaigns/{id}/pause` |

**Analytics overview (sync endpoint):**
```bash
curl "https://api.instantly.ai/api/v2/campaigns/analytics/overview?id={campaign_id}&start_date=2026-01-01&end_date=2026-03-07" \
  -H "Authorization: Bearer $INSTANTLY_API_KEY"
```

**Analytics response fields:**
- `emails_sent_count`, `contacted_count`, `completed_count`
- `open_count`, `open_count_unique`, `open_count_unique_by_step`
- `reply_count`, `reply_count_unique`, `reply_count_unique_by_step`
- `reply_count_automatic`, `reply_count_automatic_unique`
- `link_click_count`, `link_click_count_unique`
- `bounced_count`, `unsubscribed_count`
- `total_opportunities`, `total_interested`, `total_meeting_booked`, `total_meeting_completed`, `total_closed`

**Add leads example:**
```bash
curl -X POST "https://api.instantly.ai/api/v2/leads" \
  -H "Authorization: Bearer $INSTANTLY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "campaign_id": "campaign-uuid",
    "skip_if_in_workspace": true,
    "leads": [
      {
        "email": "john@acme.com",
        "first_name": "John",
        "last_name": "Doe",
        "company_name": "Acme Inc",
        "personalization": "Noticed your team just expanded the SDR team"
      }
    ]
  }'
```

---

## Lemlist

**Auth:** API key via Basic Auth (key as password, no username) or header `Authorization: Bearer {key}`
**Base URL:** `https://api.lemlist.com/api`

| Action | Method | Endpoint |
|--------|--------|----------|
| List campaigns | GET | `/campaigns` |
| Get campaign | GET | `/campaigns/{id}` |
| **Get campaign stats** | GET | `/campaigns/{id}/stats` |
| **Get campaign reports** | GET | `/campaigns/reports` |
| **Export campaign** | POST | `/campaigns/{id}/export` |
| **Get export status** | GET | `/campaigns/{id}/export-status` |
| Add lead to campaign | POST | `/campaigns/{id}/leads/{email}` |
| Export leads | GET | `/campaigns/{id}/leads/export` |
| Mark interested | POST | `/leads/{leadId}/interested` |
| Mark not interested | POST | `/leads/{leadId}/not-interested` |
| Pause lead | POST | `/leads/{leadId}/pause` |
| Unsubscribe lead | DELETE | `/campaigns/{id}/leads/{email}` |
| **List activities** | GET | `/activities?type={type}&campaignId={id}` |

**Activity types:** `emailsSent`, `emailsOpened`, `emailsClicked`, `emailsReplied`, `emailsBounced`, `emailsUnsubscribed`, `emailsFailed`

**Get campaign stats (sync endpoint):**
```bash
curl "https://api.lemlist.com/api/campaigns/{campaign_id}/stats" \
  --user ":$LEMLIST_API_KEY"
```

**Stats response fields:**
- `sent`, `opened`, `clicked`, `replied`, `booked`, `interested`
- `bounced`, `unsubscribed`, `notInterested`
- `invitationAccepted` (LinkedIn)
- Open rate, click rate, reply rate, bounce rate (calculated)

**Add lead example:**
```bash
curl -X POST "https://api.lemlist.com/api/campaigns/{campaign_id}/leads/john@acme.com" \
  --user ":$LEMLIST_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "John",
    "lastName": "Doe",
    "companyName": "Acme Inc",
    "linkedinUrl": "https://linkedin.com/in/johndoe",
    "customField1": "Noticed your team expanded"
  }'
```

---

## Smartlead

**Auth:** API key as query param `api_key`
**Base URL:** `https://server.smartlead.ai/api/v1`

| Action | Method | Endpoint |
|--------|--------|----------|
| List campaigns | GET | `/campaigns?api_key={key}` |
| Create campaign | POST | `/campaigns/create?api_key={key}` |
| Add leads | POST | `/campaigns/{id}/leads?api_key={key}` |
| **Top-level analytics** | GET | `/campaigns/{id}/analytics?api_key={key}` |
| **Lead-level stats** | GET | `/campaigns/{id}/statistics?api_key={key}&email_status={status}` |
| Get leads by status | GET | `/campaigns/{id}/leads?api_key={key}&status={status}` |

**email_status filter values:** `opened`, `clicked`, `replied`, `unsubscribed`, `bounced`

**Get campaign analytics (sync endpoint):**
```bash
curl "https://server.smartlead.ai/api/v1/campaigns/{campaign_id}/analytics?api_key=$SMARTLEAD_API_KEY"
```

**Analytics response fields:**
- `sent_count`, `unique_sent_count`
- `open_count`, `unique_open_count`
- `click_count`, `unique_click_count`
- `reply_count`, `bounce_count`, `unsubscribed_count`
- `total_count`, `drafted_count`
- `campaign_lead_stats` — interested, total, notStarted, inprogress, completed, blocked, paused

**Rate calculations:**
- Open rate: `unique_open_count / unique_sent_count × 100`
- Reply rate (plain text): `reply_count / unique_sent_count × 100`
- Reply rate (tracked): `reply_count / unique_open_count × 100`
- Positive reply rate: `campaign_lead_stats.interested / reply_count × 100`

**Lead-level stats example (get all who replied):**
```bash
curl "https://server.smartlead.ai/api/v1/campaigns/{id}/statistics?api_key=$SMARTLEAD_API_KEY&email_status=replied"
```

**Lead stats response fields:** `lead_name`, `lead_email`, `sequence_number`, `email_subject`, `sent_time`, `open_time`, `click_time`, `reply_time`, `open_count`, `click_count`, `is_unsubscribed`, `is_bounced`

**Add leads example:**
```bash
curl -X POST "https://server.smartlead.ai/api/v1/campaigns/{id}/leads?api_key=$SMARTLEAD_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "lead_list": [
      {
        "email": "john@acme.com",
        "first_name": "John",
        "last_name": "Doe",
        "company": "Acme Inc",
        "custom_fields": {
          "personalization": "Noticed your team expanded"
        }
      }
    ]
  }'
```

---

## Icypeas

**Auth:** API key + secret in headers `Authorization: {api_key}:{secret}`
**Base URL:** `https://app.icypeas.com/api`
**Rate limit:** 30 requests/minute

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Email finder | POST | `/email-search` | 1 (only on success) |
| Email verifier | POST | `/email-verification` | ~0.01 |
| Domain scan | POST | `/domain-scan` | 0.1 |
| Company scraper | GET | `/scrape/company?url=URL` | 0.5 |
| Profile scraper | POST | `/scrape` (max 50) | 1.5 |
| Find people (DB) | POST | `/leads-db/find-people/` | Low |
| Find companies (DB) | POST | `/leads-db/find-companies/` | 0.02/result |
| Bulk search | POST | `/bulk-search` (max 5,000) | Same as single |

**Email finder example:**
```bash
curl -X POST "https://app.icypeas.com/api/email-search" \
  -H "Authorization: $ICYPEAS_API_KEY:$ICYPEAS_SECRET" \
  -H "Content-Type: application/json" \
  -d '{
    "firstname": "John",
    "lastname": "Doe",
    "domainOrCompany": "acme.com"
  }'
```

**Company scraper example:**
```bash
curl "https://app.icypeas.com/api/scrape/company?url=https://linkedin.com/company/acme" \
  -H "Authorization: $ICYPEAS_API_KEY:$ICYPEAS_SECRET"
```

---

## Prospeo

**Auth:** API key in header `X-KEY`
**Base URL:** `https://api.prospeo.io`

**Note:** Old endpoints (`/email-finder`, `/linkedin-email-finder`, `/email-verifier`, `/domain-search`) were deprecated March 2025. Use the new endpoints below.

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Enrich person | POST | `/enrich-person` | 1 (10 with mobile) |
| Bulk enrich person | POST | `/bulk-enrich-person` (max 50) | Same |
| Enrich company | POST | `/enrich-company` | 1 |
| Bulk enrich company | POST | `/bulk-enrich-company` (max 50) | Same |
| Search person | POST | `/search-person` | 1 per 25 results |
| Search company | POST | `/search-company` | 1 per 25 results |

Credits: 0 if no results found. 0 for re-enriching same record (lifetime dedup). Verification is built into enrichment responses (`email_status` field).

**Enrich person example:**
```bash
curl -X POST "https://api.prospeo.io/enrich-person" \
  -H "X-KEY: $PROSPEO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "linkedin_url": "https://linkedin.com/in/johndoe",
    "only_verified_email": true
  }'
```

**Enrich company example:**
```bash
curl -X POST "https://api.prospeo.io/enrich-company" \
  -H "X-KEY: $PROSPEO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "domain": "acme.com"
  }'
```

---

## Dropcontact

**Auth:** Token in header `X-Access-Token`
**Base URL:** `https://api.dropcontact.com`

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Batch enrich | POST | `/batch` | 1 per success |
| Get results | GET | `/v1/enrich/all/{request-id}` | 0 |

No database — 100% algorithmic. GDPR compliant. Verification built-in.

**Batch enrich example:**
```bash
curl -X POST "https://api.dropcontact.com/batch" \
  -H "X-Access-Token: $DROPCONTACT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "data": [
      { "first_name": "John", "last_name": "Doe", "company": "Acme Inc" }
    ]
  }'
```

---

## FindyMail

**Auth:** API key
**Base URL:** `https://app.findymail.com`
**Docs:** `https://app.findymail.com/docs/`

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Email finder | — | See docs | 1 |
| Phone finder | — | See docs | 10 |
| Email verifier | — | See docs | Included |
| Company info | — | See docs | — |

Guarantees <5% bounce rate. Credits never expire. Pay only on success.

---

## Crunchbase (FREE company search)

**Auth:** Free API key (register at crunchbase.com)
**Base URL:** `https://api.crunchbase.com/api/v4`
**Cost:** FREE (Basic API plan)

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Search organizations | POST | `/searches/organizations` | FREE |
| Get organization | GET | `/entities/organizations/{id}` | FREE |
| Autocomplete | GET | `/autocompletes` | FREE |

**Rate limit:** 200 calls/minute

**Filters:** Categories, location, employee count, company type, domain, funding stage, founding date.

**Fields returned:** Company name, description, address, categories, founding date, employee count range, funding info, news, social profiles.

**Search example:**
```bash
curl -X POST "https://api.crunchbase.com/api/v4/searches/organizations" \
  -H "X-cb-user-key: $CRUNCHBASE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "field_ids": ["identifier", "short_description", "num_employees_enum", "categories"],
    "query": [
      { "type": "predicate", "field_id": "num_employees_enum", "operator_id": "includes", "values": ["c_00051_00100", "c_00101_00250"] }
    ],
    "limit": 25
  }'
```

---

## Diffbot Knowledge Graph (FREE tier)

**Auth:** API token
**Base URL:** `https://kg.diffbot.com/kg/v3`
**Cost:** FREE — 10,000 credits/month, no credit card required

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Search entities | GET | `/dql?query=X` | 25 per export |
| Enhance (enrich) | GET | `/enhance?url=X` | 25 per entity |

**Search capabilities:** DQL (Diffbot Query Language) — search 10B+ entities by industry, location, revenue, employee count, tech stack.

**Fields returned:** Company profiles, employee data, financials, news, products, technologies used.

**Search example:**
```bash
curl "https://kg.diffbot.com/kg/v3/dql?token=$DIFFBOT_API_KEY&query=type%3AOrganization+industries%3A%22SaaS%22+nbEmployeesMin%3A50+nbEmployeesMax%3A200&size=25"
```

---

## Companies House (UK — FREE)

**Auth:** Free API key (register at developer.company-information.service.gov.uk)
**Base URL:** `https://api.company-information.service.gov.uk`
**Cost:** Completely free. No paid tiers.

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Search companies | GET | `/search/companies?q=X` | FREE |
| Get company | GET | `/company/{number}` | FREE |
| Get officers | GET | `/company/{number}/officers` | FREE |
| Get filing history | GET | `/company/{number}/filing-history` | FREE |

**Rate limit:** 600 requests per 5 minutes

**Fields returned:** Company name, number, status, registered address, SIC codes, incorporation date, officers/directors, filing history, Persons with Significant Control.

**Coverage:** UK companies only (~5M+).

---

## HubSpot

**Auth:** Bearer token in header `Authorization: Bearer {key}`
**Base URL:** `https://api.hubapi.com`

| Action | Method | Endpoint |
|--------|--------|----------|
| Create contact | POST | `/crm/v3/objects/contacts` |
| Update contact | PATCH | `/crm/v3/objects/contacts/{id}` |
| Search contacts | POST | `/crm/v3/objects/contacts/search` |
| Create deal | POST | `/crm/v3/objects/deals` |
| Update deal | PATCH | `/crm/v3/objects/deals/{id}` |
| Get pipeline | GET | `/crm/v3/pipelines/deals` |
| Batch create | POST | `/crm/v3/objects/contacts/batch/create` |

**Create contact example:**
```bash
curl -X POST "https://api.hubapi.com/crm/v3/objects/contacts" \
  -H "Authorization: Bearer $HUBSPOT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "properties": {
      "email": "john@acme.com",
      "firstname": "John",
      "lastname": "Doe",
      "company": "Acme Inc",
      "jobtitle": "VP Sales"
    }
  }'
```

---

## Attio

**Auth:** Bearer token in header `Authorization: Bearer {key}`
**Base URL:** `https://api.attio.com/v2`

| Action | Method | Endpoint |
|--------|--------|----------|
| List records | POST | `/objects/{object}/records/query` |
| Create record | POST | `/objects/{object}/records` |
| Update record | PATCH | `/objects/{object}/records/{id}` |
| List objects | GET | `/objects` |
| Create note | POST | `/notes` |
| List lists | GET | `/lists` |
| Add to list | POST | `/lists/{id}/entries` |

**Create contact example:**
```bash
curl -X POST "https://api.attio.com/v2/objects/people/records" \
  -H "Authorization: Bearer $ATTIO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "data": {
      "values": {
        "email_addresses": [{"email_address": "john@acme.com"}],
        "name": [{"first_name": "John", "last_name": "Doe"}]
      }
    }
  }'
```

---

## Apify

**Auth:** Bearer token or query param `token`
**Base URL:** `https://api.apify.com/v2`

| Action | Method | Endpoint |
|--------|--------|----------|
| Run actor | POST | `/acts/{actorId}/runs` |
| Get run | GET | `/actor-runs/{runId}` |
| Get dataset | GET | `/datasets/{datasetId}/items` |
| List actors | GET | `/acts` |

**Run LinkedIn scraper example:**
```bash
curl -X POST "https://api.apify.com/v2/acts/anchor~linkedin-profile-scraper/runs?token=$APIFY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "urls": ["https://linkedin.com/in/johndoe"],
    "proxy": { "useApifyProxy": true }
  }'
```

---

## ZeroBounce (email verification)

**Auth:** API key as query param `api_key`
**Base URL:** `https://api.zerobounce.net/v2`

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Validate email | GET | `/validate?api_key={key}&email={email}` | 1 |
| Batch validate | POST | `/validatebatch` | 1 per email |
| Get credits | GET | `/getcredits?api_key={key}` | 0 |

---

## Fireflies.ai (meeting transcripts)

**Auth:** Bearer token in header `Authorization: Bearer {key}`
**Base URL:** `https://api.fireflies.ai/graphql`
**API type:** GraphQL

| Action | Query/Mutation | Description |
|--------|---------------|-------------|
| List transcripts | `transcripts` | All transcripts with filters |
| Get transcript | `transcript(id)` | Full transcript with sentences, speakers, timestamps |
| Get user | `user` | Account info and remaining credits |

**List transcripts example:**
```bash
curl -X POST "https://api.fireflies.ai/graphql" \
  -H "Authorization: Bearer $FIREFLIES_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "{ transcripts { id title date duration organizer_email participants sentences { text speaker_name start_time end_time } summary { overview shorthand_bullet } } }"
  }'
```

**Get single transcript with full detail:**
```bash
curl -X POST "https://api.fireflies.ai/graphql" \
  -H "Authorization: Bearer $FIREFLIES_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "query Transcript($id: String!) { transcript(id: $id) { id title date duration organizer_email participants sentences { text speaker_name start_time end_time } summary { overview shorthand_bullet action_items } } }",
    "variables": { "id": "transcript-id-here" }
  }'
```

**Key fields per transcript:**
- `title` — meeting title
- `date` — meeting date
- `duration` — length in minutes
- `participants` — list of attendees (names/emails)
- `organizer_email` — who scheduled the meeting
- `sentences` — full transcript broken into speaker-attributed segments
- `summary.overview` — AI-generated summary
- `summary.shorthand_bullet` — bullet point summary
- `summary.action_items` — extracted action items

**Filtering transcripts (by date range):**
```bash
curl -X POST "https://api.fireflies.ai/graphql" \
  -H "Authorization: Bearer $FIREFLIES_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "{ transcripts(date_from: \"2025-01-01\", date_to: \"2026-03-07\", limit: 50) { id title date participants sentences { text speaker_name } summary { overview } } }"
  }'
```

---

## Ocean.io (lookalike company search)

**Auth:** `x-api-token` header or `apiToken` query param
**Base URL:** `https://api.ocean.io/v2`
**Cost:** 0.2 credits/search result, 1 credit/enrich (with domain), 5 credits/enrich (without domain)

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Lookalike company search | POST | `/search/companies` | 0.2 per result |
| Lookalike people search | POST | `/search/people` | 0.2 per result |
| Enrich company | POST | `/enrich/company` | 1 (with domain) / 5 (without) |
| Enrich person | POST | `/enrich/person` | Credits vary |
| Reveal emails | POST | `/reveal/emails` | Credits vary |
| Reveal phones | POST | `/reveal/phones` | Credits vary |
| Credit balance | GET | `/credits` | 0 |

**Search parameters:** Feed customer domains for lookalike, or filter by industry, company size, location, technologies, keywords, revenue range, headcount growth.

**Fields returned per company:** name, domain, description, locations, employeeCount (Ocean + LinkedIn), departmentSizes, headcountGrowth, revenue, yearFounded, fundingRound, industries, technologies, technologyCategories, webTraffic (visits, pageViews, bounceRate), emails, phones, social media URLs, logo.

**Lookalike search example:**
```bash
curl -X POST "https://api.ocean.io/v2/search/companies" \
  -H "x-api-token: $OCEAN_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "domains": ["bestcustomer1.com", "bestcustomer2.com"],
    "filters": {
      "companySize": ["11-50", "51-200"],
      "countries": ["US", "UK"]
    },
    "limit": 25
  }'
```

---

## DiscoLike (AI lookalike discovery)

**Auth:** `x-discolike-key` header
**Base URL:** `https://api.discolike.com/v1`
**Cost:** $0.10/API call + $2/1K records

| Action | Method | Endpoint | Cost |
|--------|--------|----------|------|
| Discover entities | POST | `/discover` | $0.10/call |
| Bulk match | POST | `/bulk-match` | $2/1K records |
| Extract from URL | POST | `/extract` | $0.10/call |
| Domain metrics | GET | `/metrics/{domain}` | $0.10/call |
| Subsidiaries | GET | `/subsidiaries/{domain}` | $0.10/call |
| Count keywords | POST | `/count` | $0.10/call |

**How it works:** Analyzes 60M+ SSL-verified domains across 45 languages. Uses LLM-powered semantic matching against actual website content — finds companies traditional databases miss.

**Discovery example:**
```bash
curl -X POST "https://api.discolike.com/v1/discover" \
  -H "x-discolike-key: $DISCOLIKE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "domains": ["bestcustomer1.com", "bestcustomer2.com"],
    "query": "B2B SaaS companies selling sales enablement tools"
  }'
```

---

## Exa (AI-powered web search)

**Auth:** API key in header `x-api-key`
**Base URL:** `https://api.exa.ai`
**Cost:** 1,000 free requests/month. Paid: $7/1K searches (1-10 results), $1/1K content pages

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Search | POST | `/search` | 1 search |
| Get contents | POST | `/contents` | 1 per page |
| Find similar | POST | `/findSimilar` | 1 search |
| Answer | POST | `/answer` | 1 answer |

**MCP tools (preferred — use these directly in Claude Code):**
- `web_search_exa` — semantic web search, returns clean content
- `company_research_exa` — deep company research (crawls company website)
- `deep_researcher_start` — starts AI research agent, returns task ID
- `deep_researcher_check` — check status / get research report
- `people_search_exa` — find people and professional profiles (enable via config)
- `web_search_advanced_exa` — advanced search with domain/date filters (enable via config)
- `crawling_exa` — get full content from a known URL (enable via config)

**Search example:**
```bash
curl -X POST "https://api.exa.ai/search" \
  -H "x-api-key: $EXA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "B2B SaaS companies that raised Series A in 2025",
    "type": "neural",
    "numResults": 10,
    "contents": { "text": true }
  }'
```

**GTMOS use cases:**
- Market research: find companies matching ICP semantically (not just keyword match)
- Competitor intelligence: find reviews, comparisons, "alternatives to X" content
- Signal discovery: find news about funding, launches, expansions in target market
- Content research: find pain language, terminology, and framing buyers use

---

## Firecrawl (web scraping & extraction)

**Auth:** Bearer token in header `Authorization: Bearer {key}`
**Base URL:** `https://api.firecrawl.dev/v1`
**Cost:** 500 free credits (one-time). Hobby $16/mo (3K credits), Standard $83/mo (100K credits)

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Scrape page | POST | `/scrape` | 1 per page |
| Crawl site | POST | `/crawl` | 1 per page |
| Map site URLs | POST | `/map` | 1 |
| Extract structured data | POST | `/extract` | Token-based (15 tokens/credit) |
| Search web | POST | `/search` | 2 per 10 results |

**MCP tools (preferred — use these directly in Claude Code):**
- `FIRECRAWL_SCRAPE_EXTRACT_DATA_LLM` — scrape a URL, returns clean markdown
- `FIRECRAWL_EXTRACT` — extract structured data using prompt/schema
- `FIRECRAWL_CRAWL_URLS` — crawl entire site with filters
- `FIRECRAWL_CRAWL_JOB_STATUS` — check crawl progress

**Scrape example:**
```bash
curl -X POST "https://api.firecrawl.dev/v1/scrape" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://competitor.com/pricing",
    "formats": ["markdown"]
  }'
```

**Extract example (structured data without knowing exact URL):**
```bash
curl -X POST "https://api.firecrawl.dev/v1/extract" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "urls": ["https://competitor.com/*"],
    "prompt": "Extract pricing tiers, features per tier, and target audience",
    "enableWebSearch": true
  }'
```

**GTMOS use cases:**
- Scrape competitor pricing, features, and positioning pages
- Extract team/about pages for decision-maker intel
- Crawl job boards for hiring signals
- Extract structured company data from websites Exa finds
- Build prospect lists from directory pages, award lists, conference speaker lists

---

## Notes

- Always check remaining credits/balance before batch operations
- Rate limits vary by plan — add delays between requests if hitting limits
- Store API responses in campaign `sync/` folder for reference
- Log every write operation in COSTS.md
- For tools not listed here, check the tool's API documentation — most follow REST patterns with key-based auth
