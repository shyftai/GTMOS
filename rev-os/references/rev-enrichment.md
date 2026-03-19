# Enrichment Reference

Enrichment waterfall, provider options, cache rules, and cost guidelines for REV:OS. Load this file before any enrichment run, API call, or cache check.

---

## Core rule

**Always check cache before making an API call.** If a record was enriched within 30 days, use cached data. Do not call an API for data you already have.

Cache TTL: **30 days** for all providers. Override in `DATA-QUALITY.md` if workspace requires fresher data.

---

## Enrichment waterfall

Run providers in this order. Stop when all required fields are filled. Do not call every provider for every record.

### Account / Company enrichment

| Priority | Provider | Best for | Cost model |
|----------|---------|---------|-----------|
| 1 | Freckle | Company firmographics, headcount, industry, tech stack | Per enrichment / subscription |
| 2 | ZoomInfo | Enterprise accounts, intent data, technographics | Subscription |
| 3 | Prospeo | Domain validation, email format inference | Credits per lookup |
| 4 | LinkedIn (manual) | Company size, recent news, leadership changes | Free (manual) |
| 5 | Company website | Industry, product, leadership (scrape or manual) | Free |

Stop after each provider if required fields are filled. Log which provider filled which fields.

### Contact enrichment

| Priority | Provider | Best for | Cost model |
|----------|---------|---------|-----------|
| 1 | Prospeo | Email finding by name + domain, email verification | Credits per search |
| 2 | Freckle | Title, seniority, LinkedIn profile, direct phone | Per enrichment / subscription |
| 3 | ZoomInfo | Direct dial, mobile, verified email (enterprise) | Subscription |
| 4 | LinkedIn (manual) | Title, tenure, recent activity | Free (manual) |

### Enrichment orchestration tools

**Clay** — recommended for automating the waterfall:
- Connect multiple providers in one workflow; cascade automatically
- Waterfall logic: try Provider A → if empty, try Provider B → etc.
- AI rows for custom enrichment (scraping, summarising, inferring)
- Cost: credits per row enriched; pricing varies by provider

---

## Cache management

### What to cache

Every enrichment result — successful or empty — is cached. Cache the following:
- All field values returned by the provider
- Provider name and timestamp
- Fields that returned empty (so you don't re-call for the same empty data)

### Cache storage

Store in the workspace record — write to these fields in CRM or SCRAPE-JOURNAL.md:
- `Enrichment source` — which provider filled the record
- `Enrichment date` — date enriched (drives 30-day TTL)

### Cache invalidation

Invalidate cache (force re-enrichment) when:
- 30 days have passed since last enrichment
- A major company event occurs (funding, acquisition, leadership change)
- The user explicitly requests fresh data
- A field value is known to be stale (e.g., bounced email)

### Before every enrichment call

```
1. Check Enrichment date field on record
2. If Enrichment date < 30 days ago → use cached data, skip API call
3. If Enrichment date > 30 days ago OR empty → proceed with enrichment
4. Log in SCRAPE-JOURNAL.md regardless of whether cache was used or not
```

---

## Provider details

### Prospeo

**Strengths:** Email finding by name + domain; email verification; deliverability checks; bulk email finding
**Weaknesses:** Focused on email — limited firmographic data
**Credit model:** Credits per search/verification; bulk pricing available
**Best use in RevOps:** Finding email addresses for inbound leads and CRM contacts; verifying email deliverability before outreach sequences; domain-level email format inference when individual lookup returns empty

### Freckle

**Strengths:** Company and contact enrichment; firmographic data; seniority and role mapping; direct phone
**Weaknesses:** Coverage may vary by region and company size — validate match rate in your segment before committing to bulk runs
**Credit model:** Per enrichment or subscription
**Best use in RevOps:** Enriching accounts with firmographic data (headcount, industry, revenue); contact enrichment for title, seniority, LinkedIn; primary waterfall provider for both accounts and contacts

### ZoomInfo

**Strengths:** Largest B2B database; direct dial phones; intent data; technographics; org chart data
**Weaknesses:** Expensive; contract-heavy; data accuracy varies by region
**Credit model:** Subscription; typically per-seat or per-credit depending on contract
**Best use in RevOps:** Enterprise-segment enrichment; companies where phone outreach is important; intent data for pipeline prioritisation

### Clay

**Strengths:** Multi-source waterfall automation; connects to 150+ data providers; AI enrichment rows; cost efficiency through cascading
**Weaknesses:** Requires setup time; credits consumed per row across multiple providers
**Credit model:** Credits per table row; provider costs vary
**Best use in RevOps:** Automating the enrichment waterfall across multiple providers in one workflow; custom enrichment (scraping job titles, inferring ICP fit); building enrichment pipelines that run on schedule

---

## Cost tracking

Log every enrichment credit spend in `COSTS.md`:

```
| Date | Provider | Records | Credits used | Cost | Purpose |
|------|---------|---------|-------------|------|---------|
| [Date] | Prospeo | 50 contacts | 50 | [currency][X] | Verify emails on active deal contacts |
| [Date] | Freckle | 100 accounts | 100 | [currency][X] | Monthly Tier 1 account refresh |
```

**Session budget limit:** [currency]50 per enrichment session (default from `rev-defaults.md`). Alert and pause if this threshold is reached.

**Match rate monitoring:** If match rate falls below 70% in the first 50 records, stop the run. Low match rate indicates wrong provider for this segment, stale domain data, or mismatched record format. Investigate before continuing.

---

## Enrichment by CRM tier

Apply enrichment effort based on account tier (defined in `DATA-QUALITY.md`):

| Tier | Enrichment frequency | Providers to use | Required fields |
|------|---------------------|-----------------|----------------|
| Tier 1 (key accounts) | Monthly | Freckle → ZoomInfo → Prospeo | All required fields at 100% |
| Tier 2 (target accounts) | Quarterly | Freckle → Prospeo | Email, title, headcount, industry |
| Tier 3 (long-tail) | On demand | Prospeo only | Email, company name only |
| Active deal contacts | Weekly | Prospeo + Freckle | Email, phone, title, LinkedIn |

---

## SCRAPE-JOURNAL.md entry format

Log every enrichment run — whether it used cache or made a live API call:

```
[Date] | [Provider] | [Object type] | [X] records | [Cache hit / Live call] | [Cost or N/A] | [Match rate] | [Notes]
```

Example:
```
2025-11-14 | Prospeo | Contacts | 45 records | Live call | [currency]0.90 | 93% match | Verified emails on Q4 active deal contacts
2025-11-14 | Freckle | Accounts | 120 records | Cache hit | N/A | — | All Tier 1 accounts within 30-day window
```

---

## Compliance

Before enriching any contact data:

1. **Suppression check** — is the contact on `SUPPRESSION.md`? If yes, skip. Do not enrich suppressed contacts.
2. **Geography check** — if the contact is in the EU, enrichment and storage must comply with GDPR. Do not store personal data beyond what is necessary.
3. **Consent basis** — enrichment of B2B contact data for sales outreach is generally permissible under legitimate interest in the EU, but document this in `RULES.md`.

When in doubt: check `workspace.config.md` for the configured geography and regulations.
