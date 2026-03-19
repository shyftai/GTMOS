# REV:OS — Data Standards

Field standards, deduplication rules, and enrichment requirements for CRM objects. Load before any data quality audit, enrichment run, or dedupe operation.

---

## CRM Object Standards

### Account / Company record

**Required fields (block enrichment write if missing):**

| Field | Standard | Example |
|-------|----------|---------|
| Account Name | Legal company name, no "Inc/LLC/Ltd" abbreviations | "Stripe" not "Stripe, Inc." |
| Website / Domain | Clean root domain, no www, no trailing slash | "stripe.com" |
| Industry | Standard taxonomy (see below) | "Financial Technology" |
| Employee Count | Number from enrichment; not a range | 4000 |
| Employee Count Source | Source + date | "Apollo 2025-03-01" |
| HQ Country | ISO 3166-1 alpha-2 | "US" |
| HQ City | Full city name | "San Francisco" |
| CRM Account Owner | Assigned user, not system default | |
| Account Type | Lead / Prospect / Customer / Partner / Churned | |
| Annual Revenue (est.) | USD, from enrichment | 10000000 |

**Standard Industry taxonomy (use these values only):**
- B2B SaaS
- Financial Technology
- Healthcare Technology
- E-Commerce / Retail
- Professional Services
- Marketing / Advertising
- Manufacturing
- Real Estate
- Legal
- Education Technology
- Human Resources Technology
- Logistics / Supply Chain
- Media / Publishing
- Other (use sparingly — investigate and reclassify)

**Recommended fields (flag if missing on ICP accounts):**

| Field | Standard |
|-------|----------|
| LinkedIn Company URL | Full URL: https://linkedin.com/company/[slug] |
| Tech Stack | Comma-separated list from enrichment |
| CRM Stack | Primary CRM in use |
| Funding Stage | Seed / Series A / Series B / Series C+ / Bootstrapped / Public |
| Last Funding Date | YYYY-MM-DD |
| Total Funding (USD) | Numeric, USD |
| Account Tier | Tier 1 / Tier 2 / Tier 3 (defined in ICP.md) |
| Last Activity Date | Auto-populated by CRM |
| Enrichment Date | Date of last enrichment run |

---

### Contact record

**Required fields:**

| Field | Standard | Example |
|-------|----------|---------|
| First Name | Proper case, no titles | "Sarah" |
| Last Name | Proper case | "Chen" |
| Email | Lowercase, verified or sourced from enrichment | "sarah@stripe.com" |
| Job Title | As-is from source; do not standardize | "Head of Revenue Operations" |
| Seniority | VP+ / Director / Manager / IC / Unknown | "Director" |
| Department | Sales / Marketing / RevOps / Finance / Engineering / CS / Exec / Other | "RevOps" |
| Account (linked) | Must be linked to an Account record | |
| Contact Owner | Must be assigned | |
| Lead Source | Standard taxonomy (see below) | "Outbound - Apollo" |
| Contact Status | Active / Inactive / Unsubscribed / Bounced / Do Not Contact | |

**Standard Lead Source taxonomy:**
- Outbound - Email
- Outbound - LinkedIn
- Outbound - Cold Call
- Inbound - Content / SEO
- Inbound - Paid (SEM)
- Inbound - Paid (Social)
- Inbound - Event
- Inbound - Referral
- Inbound - Partner
- Inbound - Product / PLG
- Inbound - Direct (unknown source)
- Import / List Purchase (flag for compliance review)

**Recommended fields:**

| Field | Standard |
|-------|----------|
| LinkedIn URL | Full URL |
| Phone | E.164 format: +1-415-555-0100 |
| Email Validity | Valid / Invalid / Unknown / Risky |
| Email Verified Date | YYYY-MM-DD |
| Enrichment Source | Provider name + date |
| Last Email Open | Auto-populated by sequencing tool |
| Last Reply | Auto-populated |

---

### Opportunity / Deal record

**Required fields (block stage advance if missing):**

| Field | Stage required by | Standard |
|-------|------------------|----------|
| Opportunity Name | Creation | [Company Name] - [Primary Product] - [Quarter] |
| Account (linked) | Creation | Must link to Account |
| Primary Contact | Creation | Must link to Contact |
| Deal Owner | Creation | Assigned AE |
| ARR / Deal Value | SQL | USD, annualized recurring revenue |
| Close Date | SQL | End of projected close quarter (first estimate) |
| Stage | Always | Must match stage definitions in PIPELINE.md |
| Lead Source | SQL | Standard taxonomy (above) |
| Product / Plan | SQL | Must match values in PRODUCTS.md or equivalent |
| Deal Type | SQL | New Business / Expansion / Renewal |
| Competitor (if applicable) | Proposal | Must be from COMPETITORS.md values |

**Stage gate criteria (define in PIPELINE.md — these are the universal minimums):**

| Stage | Required before advancing |
|-------|--------------------------|
| Lead / MQL | Contact created; account linked; lead source set |
| SQL | Discovery call completed; BANT or MEDDIC partially qualified |
| Discovery | Discovery notes logged; pain identified; next step booked |
| Demo / Evaluation | Demo completed; decision-maker identified |
| Proposal | Proposal sent; pricing shared; legal/procurement engaged |
| Verbal Close | Verbal commitment received; paperwork in process |
| Closed Won | Signed agreement; ARR confirmed |
| Closed Lost | Loss reason set; competitor set (if applicable); win/loss record created |

---

## Deduplication Rules

### Account deduplication

**Match keys (in priority order):**

1. **Website domain** (exact match after normalization: strip www, strip path, lowercase)
2. **Company name** (fuzzy match ≥ 85% similarity using token sort ratio)
3. **LinkedIn company URL** (exact match)

**Merge logic:**
- Keep the record with the most complete data (highest field fill rate)
- Preserve all associated contacts, deals, and activities on the surviving record
- Archive the losing record with a "Merged into [ID]" note
- **Never hard-delete** — archive only

**Confidence scoring for automated review:**

| Score | Action |
|-------|--------|
| 95–100% | Safe to flag as definite duplicate; recommend auto-merge (still requires approval) |
| 80–94% | Flag as probable duplicate; require human review |
| 60–79% | Flag as possible duplicate; human review required |
| < 60% | Do not flag — likely different companies |

### Contact deduplication

**Match keys (in priority order):**

1. **Email address** (exact match, case-insensitive)
2. **First name + Last name + Account domain** (exact match on name, domain extracted from email or account)
3. **LinkedIn URL** (exact match)

**Merge logic:**
- Keep the record with the most recent activity
- If emails differ, keep the most recently verified email as primary; store the other as secondary
- Never merge contacts across different Account records without reviewing both accounts

**Confidence scoring:**

| Score | Action |
|-------|--------|
| 98–100% | Definite duplicate (same email) — flag for auto-merge with approval |
| 85–97% | Probable duplicate — human review required |
| 70–84% | Possible duplicate — human review required |
| < 70% | Do not flag |

---

## Enrichment Standards

### Enrichment waterfall for CRM (in priority order)

Load `references/rev-enrichment.md` for the full enrichment waterfall, cache rules, and provider cost guide. For CRM-specific enrichment, apply this order:

**Account/company enrichment:**
1. Freckle (firmographics, headcount, industry, tech stack)
2. ZoomInfo (enterprise accounts, intent data)
3. Prospeo (domain validation, email format)
4. LinkedIn (public page data — manual or scrape)
5. Manual research (only if all above fail and account is Tier 1)

**Contact enrichment:**
1. Prospeo (email finding by name + domain, verification)
2. Freckle (title, seniority, LinkedIn, direct phone)
3. ZoomInfo (direct dial, verified email — enterprise contacts)
4. LinkedIn (public profile — manual)

### Enrichment rules

- **Always check cache first** — if enriched within 30 days, use cached data
- **Never overwrite manually set fields** — flag conflict and present both values
- **Log every enrichment call** in SCRAPE-JOURNAL.md: date, source, object, field, records processed, cost
- **Enrich in batches** — maximum 1000 records per batch; write cache after each page
- **Validate email format** before writing: must match `^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$`
- **Flag role-based emails** as risky: info@, sales@, contact@, etc.

### Enrichment priority by account tier

| Tier | Re-enrichment frequency | Fields prioritized |
|------|------------------------|--------------------|
| Tier 1 (ICP accounts) | Every 30 days | All fields |
| Tier 2 (active pipeline) | Every 60 days | Email, title, decision-maker contacts |
| Tier 3 (inactive / cold) | Every 180 days | Email, phone only |

---

## Stripe ↔ CRM Reconciliation Standards

### MRR definition (standard — document in STRIPE.md)

- MRR = sum of all active, paid subscriptions normalized to a monthly amount
- Include: monthly plans, annual plans ÷ 12
- Exclude: trials, free plans, paused subscriptions, refunded subscriptions
- Expansion MRR = incremental MRR from existing customers vs. prior month
- Contraction MRR = MRR reduction from existing customers (downgrades)
- Churned MRR = MRR from customers who cancelled

### Account matching (Stripe ↔ CRM)

**Primary match keys:**
1. Stripe customer email → CRM account domain (extract domain from email)
2. Stripe customer name → CRM account name (fuzzy match ≥ 80%)
3. Stripe customer metadata fields (if CRM ID is stored in Stripe metadata)

**Reconciliation tolerance:**
- Acceptable variance: < 1% of total MRR
- Investigation threshold: > 1% variance or > $1,000 absolute discrepancy (use lower of the two)
- Hard stop: > 5% variance — do not produce board report until resolved

### Common reconciliation issues

| Issue | Symptom | Fix |
|-------|---------|-----|
| Trial → paid not synced | Stripe shows paid; CRM shows trial | Update CRM account type + ARR field |
| Annual deal in CRM, monthly in Stripe | ARR mismatch | Verify contract; update Stripe plan or CRM |
| Multi-product subscription | Stripe line items not summed correctly | Re-map product plans in STRIPE.md |
| Currency mismatch | Non-USD subscriptions not converted | Apply FX rate in reconciliation; document conversion date |
| Cancelled but still in CRM pipeline | Churn not reflected | Update CRM: close deal as Churned; update account type |
