# Enrichment Waterfall — GTMOS

Cascading enrichment logic. Try the cheapest or most reliable source first. If it misses, fall to the next. Stop as soon as data is found. Track hit rates per source per workspace to optimize the order over time.

**Override:** Users can change the waterfall order in workspace RULES.md under `## Enrichment waterfall overrides`. If no overrides exist, use the defaults below.

---

## People Search

Find people matching ICP criteria (title, industry, company size, location).

| Priority | Source | Cost | How |
|----------|--------|------|-----|
| 1 | Apollo | Free (search) | POST `/mixed_people/search` — no credits for search, only for reveal |
| 2 | Crispy / Sales Navigator | Included in sub | MCP tool: search by title, industry, company, keywords, geo |
| 3 | Lemlist (built-in DB) | Included in sub | 450M+ contacts, search by filters |
| 4 | Instantly (built-in DB) | Included in sub | 160M+ contacts, search by filters |
| 5 | Apify (LinkedIn scraper) | ~$0.01/profile | Actor: LinkedIn search scrape → returns profiles matching query |

**Logic:**
1. Start with Apollo — free search, largest database (275M+)
2. If results are thin, run Crispy/Sales Navigator for LinkedIn-native search
3. Use Lemlist/Instantly built-in DBs if the user has those tools active
4. Apify as last resort — slower, costs compute units

**Stop condition:** Enough contacts to fill the list brief target (e.g., 500 contacts needed, stop when reached).

---

## Company Search

Find companies matching ICP firmographics (industry, size, tech stack, funding).

| Priority | Source | Cost | How |
|----------|--------|------|-----|
| 1 | Apollo | Free (search) | POST `/mixed_organizations/search` — free org search |
| 2 | Apollo (org enrich) | Free | GET `/organizations/enrich?domain={domain}` — free enrichment |
| 3 | StoreLeads | Included in sub | E-commerce companies by platform, traffic, tech stack |
| 4 | Opemart | Included in sub | SMB data by industry, location, size |
| 5 | Apify (website scraper) | ~$0.01/site | Scrape company website for tech stack, team size, signals |

**Logic:**
1. Apollo org search first — free and comprehensive
2. StoreLeads if targeting e-commerce (Shopify, WooCommerce, etc.)
3. Opemart if targeting SMBs/local businesses
4. Apify for custom scraping when structured databases don't cover the niche

**Stop condition:** Enough companies to build target account list.

---

## People Enrichment

Enrich a known person (have name + company or LinkedIn URL) with title, seniority, location, social profiles.

| Priority | Source | Cost | How |
|----------|--------|------|-----|
| 1 | Apollo | 1 credit | POST `/people/match` — match by name + company or LinkedIn |
| 2 | Crispy | Included in sub | MCP tool: get LinkedIn profile data (title, company, location, bio) |
| 3 | Apify | ~$0.005-0.01/profile | Actor: LinkedIn profile scraper → full profile data |
| 4 | Prospeo | 1 credit | POST `/linkedin-email-finder` — also returns profile data |

**Logic:**
1. Apollo first — 1 credit, returns structured data (title, seniority, company details, phone, social)
2. Crispy if Apollo misses — LinkedIn profile data via MCP, included in subscription
3. Apify for bulk enrichment or when Apollo credits are limited
4. Prospeo as final fallback — primarily an email tool but returns person data too

**Stop condition:** Title, company, and seniority confirmed. Location is a bonus.

---

## Company Enrichment

Enrich a known company (have domain or name) with firmographics, tech stack, funding, headcount.

| Priority | Source | Cost | How |
|----------|--------|------|-----|
| 1 | Apollo | Free | GET `/organizations/enrich?domain={domain}` — industry, size, funding, tech |
| 2 | Freckle | Included in sub | Auto-enriches CRM records with firmographics, tech, funding |
| 3 | StoreLeads | Included in sub | E-commerce: platform, apps, traffic, Alexa rank |
| 4 | Apify | ~$0.01/site | Custom scrape: about page, team page, job board, tech stack detection |

**Logic:**
1. Apollo always first — free org enrichment, returns industry, employee count, funding, tech stack
2. Freckle if connected to CRM — auto-enriches in the background
3. StoreLeads if e-commerce vertical — deeper platform/app data
4. Apify for anything Apollo misses — website scraping fills gaps

**Stop condition:** Industry, employee count, and at least one of (funding stage, tech stack, revenue range) confirmed.

---

## Email Enrichment

Find and verify a business email for a known person (have name + company or LinkedIn URL).

| Priority | Source | Cost | How |
|----------|--------|------|-----|
| 1 | Apollo | 1 credit | POST `/people/match` — returns email if found |
| 2 | Icypeas | 1 credit | POST `/email-search` — firstname + lastname + domain |
| 3 | Prospeo | 1 credit | POST `/email-finder` or `/linkedin-email-finder` |
| 4 | Lemlist (built-in) | Included in sub | Built-in email finder from contact database |

**After finding — verify:**

| Priority | Source | Cost | How |
|----------|--------|------|-----|
| 1 | ZeroBounce | $0.004-0.008 | GET `/validate?email={email}` — valid/invalid/catch-all |
| 2 | MillionVerifier | $0.001-0.004 | Bulk upload or API — valid/invalid/catch-all |

**If result is catch-all:**

| Priority | Source | Cost | How |
|----------|--------|------|-----|
| 1 | Scrubby | $0.02-0.03 | Catch-all verification — confirms if the mailbox actually exists |

**Logic:**
1. Try Apollo first — cheapest and often has the email already from enrichment
2. If Apollo returns no email, try Icypeas — pattern-based email finder
3. If Icypeas misses, try Prospeo — LinkedIn URL to email is their strength
4. Lemlist built-in DB as final finder attempt
5. Once an email is found, always verify:
   - ZeroBounce first (more accurate), MillionVerifier as backup
   - If verification returns "catch-all", run through Scrubby
   - If Scrubby says risky: flag the contact, do not send
6. Never ship an unverified email

**Stop condition:** Verified email (valid status). Catch-all only if Scrubby confirms deliverable.

---

## Phone Number Enrichment

Find a direct phone number for a known person (have name + company).

| Priority | Source | Cost | How |
|----------|--------|------|-----|
| 1 | Apollo | 5 credits | POST `/people/match` with `reveal_phone_number: true` |
| 2 | Crispy | Included in sub | MCP tool: LinkedIn profile may include phone if publicly listed |
| 3 | Apify | ~$0.01/profile | LinkedIn profile scrape — phone only if publicly visible |

**Logic:**
1. Apollo is the only reliable source for direct dials — costs 5 credits per reveal
2. Crispy/LinkedIn only returns phone if the person has it on their public profile (rare)
3. Apify same as Crispy — limited to publicly visible data

**Important:** Phone numbers are expensive (5x email cost on Apollo). Only enrich phone for:
- A-tier leads (lead score 80+)
- ABM campaigns where phone is a required channel
- Contacts that haven't responded to email after full sequence

**Stop condition:** Direct dial or mobile number confirmed. Do not ship landlines or switchboard numbers.

---

## Waterfall Execution Rules

### Before starting any enrichment
1. Check which tools are active in TOOLS.md — skip inactive tools in the waterfall
2. Check .env for API keys — skip tools with missing keys
3. Check COSTS.md — ensure budget allows the estimated enrichment cost
4. Display the enrichment plan before executing:

```
  ┌─ ENRICHMENT PLAN ───────────────────────────┐
  │                                               │
  │  Type:      Email enrichment                  │
  │  Contacts:  127 missing emails                │
  │                                               │
  │  Waterfall:                                   │
  │    1. Apollo        (1 credit/ea)    ~$6.35   │
  │    2. Icypeas       (1 credit/ea)    fallback │
  │    3. Prospeo       (1 credit/ea)    fallback │
  │    4. Verify: ZeroBounce             ~$1.02   │
  │    5. Catch-all: Scrubby             if needed│
  │                                               │
  │  Est. max cost:  $12.70                       │
  │  Budget remaining: $187.30                    │
  │                                               │
  └───────────────────────────────────────────────┘
  >> Proceed? (y/n)
```

### During enrichment
1. Process contacts in batches (50 at a time for API rate limits)
2. After each source in the waterfall, report coverage:

```
  ── ENRICHMENT PROGRESS ─────────────────────────
  Apollo:     94/127 found  (74%)    94 credits
  Icypeas:    21/33 found   (64%)    21 credits
  Prospeo:    8/12 found    (67%)    8 credits
  Not found:  4 contacts — no email from any source
  ────────────────────────────────────────────────
```

3. Do NOT send all 127 contacts to every source — only send the misses from the previous step
4. Log every enrichment action in COSTS.md

### After enrichment
1. Display final results:

```
  ┌─ ENRICHMENT COMPLETE ───────────────────────┐
  │                                               │
  │  Contacts enriched:  123/127  (97%)           │
  │  Not found:          4                        │
  │                                               │
  │  Source breakdown:                             │
  │    Apollo:    94  (76%)     $4.70              │
  │    Icypeas:   21  (17%)     $0.84              │
  │    Prospeo:    8  (7%)      $0.32              │
  │                                               │
  │  Verification:                                │
  │    Valid:      118                             │
  │    Catch-all:   3  (Scrubby: 2 ok, 1 risky)  │
  │    Invalid:     2  (removed)                  │
  │                                               │
  │  Total cost:  $7.12                           │
  │                                               │
  └───────────────────────────────────────────────┘
```

2. Update COSTS.md with actual spend per tool
3. Save enrichment log to campaign `logs/decisions.md`
4. Flag not-found contacts — suggest removing or manual research

### Hit rate tracking

After every enrichment run, update the workspace hit rate tracker in TOOLS.md:

```
## Enrichment hit rates

| Source | Email | Phone | People | Company | Last updated |
|--------|-------|-------|--------|---------|-------------|
| Apollo | 74% | 62% | 89% | 95% | 2026-03-07 |
| Icypeas | 64% | — | — | — | 2026-03-07 |
| Prospeo | 67% | — | — | — | 2026-03-07 |
| Crispy | — | 12% | 71% | — | 2026-03-07 |
```

Over time, if a source consistently outperforms another, suggest reordering the waterfall for this workspace.

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
- PhantomBuster (not using)
- Lemlist DB (data quality issues)

### Phone enrichment threshold
- Only enrich phone for lead_score >= 85 (default: 80)
```

If overrides exist, use them. If not, use the defaults in this file.
