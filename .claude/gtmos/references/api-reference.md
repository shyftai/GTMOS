# API Reference — GTMOS Supported Tools

Quick reference for making API calls from Claude Code. Auth, base URLs, key endpoints, and request formats.

---

## Apollo

**Auth:** API key in header `X-Api-Key` or query param `api_key`
**Base URL:** `https://api.apollo.io/v1`

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Search contacts | POST | `/mixed_people/search` | 0 (search is free) |
| Enrich contact | POST | `/people/match` | 1 per match |
| Get contact | GET | `/people/{id}` | 0 |
| Search organizations | POST | `/mixed_organizations/search` | 0 |
| Enrich org | GET | `/organizations/enrich?domain={domain}` | 0 |
| Get lists | GET | `/labels` | 0 |
| Add to list | POST | `/labels/{id}/add` | 0 |

**Search contacts example:**
```bash
curl -X POST "https://api.apollo.io/v1/mixed_people/search" \
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

**Enrich contact example:**
```bash
curl -X POST "https://api.apollo.io/v1/people/match" \
  -H "X-Api-Key: $APOLLO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "first_name": "John",
    "last_name": "Doe",
    "organization_name": "Acme Inc",
    "linkedin_url": "https://linkedin.com/in/johndoe"
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

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Email finder | POST | `/email-search` | 1 |
| Email verifier | POST | `/email-verification` | 1 |
| Domain search | POST | `/domain-search` | 1 per result |
| Bulk enrichment | POST | `/bulk-search` | 1 per contact |

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

---

## Prospeo

**Auth:** API key in header `X-KEY`
**Base URL:** `https://api.prospeo.io`

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Email finder | POST | `/email-finder` | 1 |
| LinkedIn email finder | POST | `/linkedin-email-finder` | 1 |
| Email verifier | POST | `/email-verifier` | 1 |
| Domain search | POST | `/domain-search` | 1 per result |

**LinkedIn email finder example:**
```bash
curl -X POST "https://api.prospeo.io/linkedin-email-finder" \
  -H "X-KEY: $PROSPEO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://linkedin.com/in/johndoe"
  }'
```

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

## Notes

- Always check remaining credits/balance before batch operations
- Rate limits vary by plan — add delays between requests if hitting limits
- Store API responses in campaign `sync/` folder for reference
- Log every write operation in COSTS.md
- For tools not listed here, check the tool's API documentation — most follow REST patterns with key-based auth
