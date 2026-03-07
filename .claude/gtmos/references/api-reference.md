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

**Auth:** API key as query param `api_key`
**Base URL:** `https://api.instantly.ai/api/v1`

| Action | Method | Endpoint |
|--------|--------|----------|
| List campaigns | GET | `/campaign/list` |
| Get campaign | GET | `/campaign/get?api_key={key}&campaign_id={id}` |
| Add leads | POST | `/lead/add` |
| Get lead status | GET | `/lead/get?api_key={key}&email={email}` |
| Get campaign analytics | GET | `/analytics/campaign/summary?api_key={key}&campaign_id={id}` |
| List accounts | GET | `/account/list` |
| Pause campaign | POST | `/campaign/pause` |

**Add leads example:**
```bash
curl -X POST "https://api.instantly.ai/api/v1/lead/add" \
  -H "Content-Type: application/json" \
  -d '{
    "api_key": "'$INSTANTLY_API_KEY'",
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

**Get campaign analytics:**
```bash
curl "https://api.instantly.ai/api/v1/analytics/campaign/summary?api_key=$INSTANTLY_API_KEY&campaign_id=uuid&start_date=2024-01-01&end_date=2024-03-01"
```

---

## Lemlist

**Auth:** API key via Basic Auth (key as password, no username) or header `Authorization: Bearer {key}`
**Base URL:** `https://api.lemlist.com/api`

| Action | Method | Endpoint |
|--------|--------|----------|
| List campaigns | GET | `/campaigns` |
| Get campaign | GET | `/campaigns/{id}` |
| Add lead to campaign | POST | `/campaigns/{id}/leads/{email}` |
| Get campaign stats | GET | `/campaigns/{id}/export` |
| Unsubscribe lead | DELETE | `/campaigns/{id}/leads/{email}` |
| List activities | GET | `/activities` |

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
| Get campaign stats | GET | `/campaigns/{id}/statistics?api_key={key}` |
| Get leads by status | GET | `/campaigns/{id}/leads?api_key={key}&status={status}` |

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

## Hunter.io

**Auth:** API key as query param `api_key`
**Base URL:** `https://api.hunter.io/v2`

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Email finder | GET | `/email-finder?domain=X&first_name=X&last_name=X` | 1 |
| Email verifier | GET | `/email-verifier?email=X` | 1 |
| Domain search | GET | `/domain-search?domain=X` | 1 |

**Rate limits:** 15 req/s (finder), 10 req/s (verifier)

**Email finder example:**
```bash
curl "https://api.hunter.io/v2/email-finder?domain=acme.com&first_name=John&last_name=Doe&api_key=$HUNTER_API_KEY"
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

## Notes

- Always check remaining credits/balance before batch operations
- Rate limits vary by plan — add delays between requests if hitting limits
- Store API responses in campaign `sync/` folder for reference
- Log every write operation in COSTS.md
- For tools not listed here, check the tool's API documentation — most follow REST patterns with key-based auth
