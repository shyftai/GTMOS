# Command: Audience Sync

## Trigger
"Sync audiences to ad platforms" or "Push account list to LinkedIn Ads / Meta / Google Ads"

## When to use
Optionally push your ABM target account list or contact list to ad platforms as custom audiences for warming before or during outreach. This is not required for ABM — many campaigns work without ad warming.

**Before using this command, check if the workspace uses HubSpot with ABM features.** HubSpot Marketing Hub Professional+ has built-in Target Accounts, buying role tracking, and native LinkedIn Ads audience sync. If HubSpot ABM is active, suggest using that instead — it's simpler and requires no additional API setup.

## Supported platforms

| Platform | Audience type | Match on | Min audience size | API access |
|----------|--------------|----------|-------------------|------------|
| LinkedIn Ads | Matched Audience (DMP Segment) | Company name, domain, LinkedIn page URL, email (SHA256) | 300 members | Requires Audiences API approval (separate from Marketing API) |
| Meta (Facebook/Instagram) | Custom Audience | Email (SHA256), phone (SHA256), name, city, country | 100 contacts | Marketing API with `ads_management` permission |
| Google Ads | Customer Match | Email (SHA256), phone (SHA256), name, address | 1,000 contacts | Google Ads API with Customer Match access |

## Steps

### 1. Check connected ad platforms
- Load TOOLS.md — check which ad platforms are active
- Check .env for API keys:
  - `LINKEDIN_ADS_TOKEN` — LinkedIn Marketing API OAuth2 token
  - `LINKEDIN_AD_ACCOUNT_ID` — Sponsored Account ID (e.g., `516848833`)
  - `META_ACCESS_TOKEN` — Meta Marketing API access token
  - `META_AD_ACCOUNT_ID` — Ad account ID (e.g., `act_123456789`)
  - `GOOGLE_ADS_DEVELOPER_TOKEN` — Google Ads API developer token
  - `GOOGLE_ADS_CUSTOMER_ID` — Google Ads customer ID
- Skip platforms with missing keys

### 2. Display sync plan

```
  ┌─ AUDIENCE SYNC PLAN ──────────────────────────┐
  │                                                 │
  │  Source: {workspace}/lists/{list_name}.csv       │
  │  Contacts: {count}  |  Companies: {count}       │
  │                                                 │
  │  Platforms:                                     │
  │    [x] LinkedIn Ads    (company matched audience)│
  │    [x] Meta            (email custom audience)   │
  │    [ ] Google Ads      (no API key)              │
  │                                                 │
  │  Action: CREATE new audience                    │
  │  Audience name: "GTM:OS — {campaign_name}"       │
  │                                                 │
  └─────────────────────────────────────────────────┘
  >> Sync now? (y/n)
```

### 3. Prepare data per platform

#### For LinkedIn Ads (company targeting)
- Extract: company name, company domain, LinkedIn company URL (if available)
- No hashing needed for company data
- For contact targeting: SHA256 hash email addresses (lowercase, trimmed)

#### For Meta (contact targeting)
- Extract: email, phone, first name, last name, city, state, country
- SHA256 hash all identifiers (lowercase, trimmed before hashing)
- Format phone as country code + number (e.g., +1234567890)

#### For Google Ads (customer match)
- Extract: email, phone, first name, last name, country, zip
- SHA256 hash email and phone (lowercase, trimmed)
- First/last name: SHA256 hash (lowercase, trimmed)

### 4. Push to each platform

---

#### LinkedIn Ads — Company Matched Audience

**Step 1: Create DMP Segment**
```
POST https://api.linkedin.com/rest/dmpSegments
Headers:
  Authorization: Bearer $LINKEDIN_ADS_TOKEN
  Content-Type: application/json
  Linkedin-Version: 202602
  X-Restli-Protocol-Version: 2.0.0

Body:
{
  "name": "GTM:OS — {campaign_name}",
  "sourcePlatform": "GTM:OS",
  "account": "urn:li:sponsoredAccount:{LINKEDIN_AD_ACCOUNT_ID}",
  "type": "COMPANY",
  "destinations": [{ "destination": "LINKEDIN" }]
}
```

Wait 5 seconds after creation before streaming data.

**Step 2: Stream companies (batch — up to 5,000 per request)**
```
POST https://api.linkedin.com/rest/dmpSegments/{segmentId}/companies
Headers:
  X-RestLi-Method: BATCH_CREATE
  Authorization: Bearer $LINKEDIN_ADS_TOKEN
  Content-Type: application/json
  Linkedin-Version: 202602
  X-Restli-Protocol-Version: 2.0.0

Body:
{
  "elements": [
    {
      "action": "ADD",
      "companyName": "Acme Inc",
      "companyWebsiteDomain": "acme.com",
      "companyPageUrl": "linkedin.com/company/acme",
      "industries": ["technology"],
      "country": "US"
    },
    ...
  ]
}
```

**Company matching fields (provide as many as possible):**

| Field | Description | Example |
|-------|-------------|---------|
| `companyName` | Company name | "Microsoft" |
| `companyWebsiteDomain` | Website domain | "microsoft.com" |
| `companyEmailDomain` | Email domain (if different) | "microsoft.com" |
| `organizationUrn` | LinkedIn company URN | "urn:li:organizationUrn:123" |
| `companyPageUrl` | LinkedIn company page URL | "linkedin.com/company/microsoft" |
| `stockSymbol` | Stock ticker (max 5 chars) | "MSFT" |
| `industries` | Up to 3 industry names | ["technology", "software"] |
| `city` | HQ city | "Seattle" |
| `state` | HQ state/province | "WA" |
| `country` | ISO 2-letter code | "US" |
| `postalCode` | Postal code | "98052" |

Must provide at least one of: companyName, organizationUrn, companyWebsiteDomain/companyEmailDomain, or companyPageUrl.

**Step 3: Check segment status**
```
GET https://api.linkedin.com/rest/dmpSegments/{segmentId}
Headers:
  Authorization: Bearer $LINKEDIN_ADS_TOKEN
  Linkedin-Version: 202602
  X-Restli-Protocol-Version: 2.0.0
```

Statuses: BUILDING → READY (up to 48 hours for initial processing). Subsequent updates: up to 24 hours.

**Rate limits:** 300 requests/min per user for /companies endpoint. Up to 5,000 companies per batch request.

---

#### LinkedIn Ads — Contact Matched Audience

For targeting specific people (e.g., decision-makers) instead of entire companies:

**Step 1: Create DMP Segment (type: USER)**
```
POST https://api.linkedin.com/rest/dmpSegments
Body:
{
  "name": "GTM:OS — {campaign_name} contacts",
  "sourcePlatform": "GTM:OS",
  "account": "urn:li:sponsoredAccount:{LINKEDIN_AD_ACCOUNT_ID}",
  "type": "USER",
  "destinations": [{ "destination": "LINKEDIN" }]
}
```

**Step 2: Stream users (batch — up to 5,000 per request)**
```
POST https://api.linkedin.com/rest/dmpSegments/{segmentId}/users
Headers:
  X-RestLi-Method: BATCH_CREATE
Body:
{
  "elements": [
    {
      "action": "ADD",
      "userIds": [
        { "idType": "SHA256_EMAIL", "idValue": "{sha256_of_lowercase_email}" }
      ]
    },
    ...
  ]
}
```

Accepted ID types: `SHA256_EMAIL`, `SHA512_EMAIL`, `GOOGLE_AID`, `APPLE_IDFA`

**Rate limits:** 600 requests/min per user for /users endpoint.

---

#### Meta (Facebook/Instagram) — Custom Audience

**Step 1: Create custom audience**
```
POST https://graph.facebook.com/v22.0/{META_AD_ACCOUNT_ID}/customaudiences
Headers:
  Content-Type: application/json

Body:
{
  "name": "GTM:OS — {campaign_name}",
  "subtype": "CUSTOM",
  "description": "ABM target accounts from GTM:OS campaign",
  "customer_file_source": "USER_PROVIDED_ONLY",
  "access_token": "$META_ACCESS_TOKEN"
}
```

Returns: `{ "id": "audience_id" }`

**Step 2: Add users to audience**
```
POST https://graph.facebook.com/v22.0/{audience_id}/users
Body:
{
  "payload": {
    "schema": ["EMAIL", "FN", "LN", "CT", "ST", "COUNTRY"],
    "data": [
      ["{sha256_email}", "{sha256_firstname}", "{sha256_lastname}", "{sha256_city}", "{sha256_state}", "{sha256_country}"],
      ...
    ]
  },
  "access_token": "$META_ACCESS_TOKEN"
}
```

**Hashing rules:**
- Lowercase all values before hashing
- Trim whitespace
- SHA256 hash each identifier individually
- Phone: include country code, digits only (e.g., 12025551234)
- Do NOT hash if using `is_raw` parameter set to true (Meta hashes server-side)

**Available schema fields:** EMAIL, PHONE, FN (first name), LN (last name), GEN (gender), DOB (date of birth), CT (city), ST (state), ZIP, COUNTRY, MADID (mobile advertiser ID), EXTERN_ID

**Rate limits:** Max 500 custom audiences per ad account. Batch up to 10,000 rows per request.

---

#### Google Ads — Customer Match

**Step 1: Create user list**
```
POST https://googleads.googleapis.com/v18/customers/{GOOGLE_ADS_CUSTOMER_ID}/userLists:mutate
Headers:
  Authorization: Bearer $GOOGLE_ADS_TOKEN
  developer-token: $GOOGLE_ADS_DEVELOPER_TOKEN
  Content-Type: application/json

Body:
{
  "operations": [{
    "create": {
      "name": "GTM:OS — {campaign_name}",
      "description": "ABM target accounts",
      "membershipLifeSpan": 90,
      "crmBasedUserList": {
        "uploadKeyType": "CONTACT_INFO",
        "dataSourceType": "FIRST_PARTY"
      }
    }
  }]
}
```

**Step 2: Upload user data via OfflineUserDataJob**
```
POST https://googleads.googleapis.com/v18/customers/{GOOGLE_ADS_CUSTOMER_ID}/offlineUserDataJobs:create
Body:
{
  "job": {
    "type": "CUSTOMER_MATCH_USER_LIST",
    "customerMatchUserListMetadata": {
      "userList": "customers/{GOOGLE_ADS_CUSTOMER_ID}/userLists/{list_id}"
    }
  }
}
```

Then add operations:
```
POST https://googleads.googleapis.com/v18/{offlineUserDataJobResourceName}:addOperations
Body:
{
  "operations": [
    {
      "create": {
        "userIdentifiers": [
          { "hashedEmail": "{sha256_email}" },
          { "hashedPhoneNumber": "{sha256_phone}" },
          { "addressInfo": {
              "hashedFirstName": "{sha256_fn}",
              "hashedLastName": "{sha256_ln}",
              "countryCode": "US",
              "postalCode": "98052"
          }}
        ]
      }
    }
  ]
}
```

Then run the job:
```
POST https://googleads.googleapis.com/v18/{offlineUserDataJobResourceName}:run
```

**Important:** Starting April 1, 2026, new developer tokens must use the Data Manager API instead. Check if your token has prior Customer Match access.

**Rate limits:** Up to 100,000 identifiers per request. Max 15 operations per mutate request for user lists.

---

### 5. Display sync summary

```
  ── AUDIENCE SYNC COMPLETE ────────────────────────
  LinkedIn Ads:  ✓  142 companies pushed → "GTM:OS — Q1 ABM"
                    Status: BUILDING (ready in ~48h)
                    Segment ID: 10804
  Meta:          ✓  287 contacts pushed → "GTM:OS — Q1 ABM"
                    Audience ID: 23850123456
                    Est. match rate: processing...
  Google Ads:    ○  skipped (no API key)
  ──────────────────────────────────────────────────
  Synced at: {timestamp}

  >> Next: Wait for audiences to build (24-48h),
     then launch awareness ads before outreach starts.
```

### 6. Post-sync actions
- Save audience IDs to campaign workspace for future updates
- Log sync in COSTS.md (ad platform API calls are typically free — ad spend is separate)
- Suggest ad campaign timing: start ads 7-14 days before cold outreach begins
- For ABM: suggest running brand awareness + thought leadership content ads

### 7. Updating existing audiences
When running subsequent syncs for the same campaign:
- Check if audience already exists (by name or saved ID)
- LinkedIn Streaming API: just ADD new companies/users — existing ones are deduplicated
- Meta: POST to existing audience's /users endpoint — adds incrementally
- Google Ads: create new OfflineUserDataJob for the existing user list
- For removals: use `"action": "REMOVE"` (LinkedIn) or `DELETE` operations (Meta/Google)

---

## HubSpot ABM Alternative

If the workspace uses HubSpot Marketing Hub Professional or higher, HubSpot has built-in ABM features that may be simpler than direct API audience sync:

**What HubSpot ABM includes:**
- **Target Accounts** — mark companies as target accounts, track engagement at the account level
- **Buying Roles** — assign roles (Decision Maker, Champion, etc.) to contacts at target accounts
- **Account Overview** — dashboard showing all activity across contacts at an account
- **ABM Lists** — auto-segmenting lists based on target account status and buying roles
- **LinkedIn Ads sync** — native integration to push target account lists to LinkedIn Ads without separate API setup
- **Account scoring** — built-in account-level scoring based on engagement signals

**When to use HubSpot ABM instead of direct API sync:**
- HubSpot is already the primary CRM
- Marketing Hub Professional+ is active
- Team already uses HubSpot for ad management
- Don't want to manage separate ad platform API tokens

**How to check:** Look at TOOLS.md — if HubSpot is active with a paid Marketing Hub plan, suggest HubSpot ABM first.

**Adding a target account via API:**
```
PATCH https://api.hubapi.com/crm/v3/objects/companies/{companyId}
Header: Authorization: Bearer $HUBSPOT_API_KEY
Body:
{
  "properties": {
    "hs_target_account": "true",
    "hs_target_account_probability": "0.85"
  }
}
```

**Assigning buying roles:**
```
PUT https://api.hubapi.com/crm/v4/objects/contacts/{contactId}/associations/companies/{companyId}
Header: Authorization: Bearer $HUBSPOT_API_KEY
Body: [{ "associationCategory": "HUBSPOT_DEFINED", "associationTypeId": 1 }]
```

Then set the buying role via contact property `hs_buying_role` (values: BLOCKER, BUDGET_HOLDER, CHAMPION, DECISION_MAKER, END_USER, EXECUTIVE_SPONSOR, INFLUENCER, LEGAL_AND_COMPLIANCE, OTHER).

---

## Ad Warming Strategy (optional)

If you do run ads alongside ABM outreach, here's a suggested timeline:

| Day | Action |
|-----|--------|
| Day -14 | Push account list to ad platforms |
| Day -14 to -1 | Run brand awareness ads (thought leadership, case studies) |
| Day 0 | Start cold outreach sequence |
| Day 0+ | Optionally switch ads to retargeting content |

### Budget guidance
- LinkedIn Ads: ~$10-25/day per 500-company audience
- Meta: ~$5-15/day per 1,000-contact audience
- Google Display: ~$5-10/day for awareness
