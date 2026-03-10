# Scrape Cache — GTMOS Reference

Rules for caching scrape/enrichment results and journaling every data pull.

---

## Core principle

**Every API call that returns data MUST be cached locally and logged in SCRAPE-JOURNAL.md.** If a session drops mid-scrape, the cache ensures no data is lost and no credits are wasted re-pulling.

---

## Before every scrape

1. **Check the cache first** — search `cache/scrapes/` and SCRAPE-JOURNAL.md for existing data that matches the current angle
   - If a cache file exists and is < 30 days old, use it instead of making a new API call
   - If a cache file exists but is stale (> 30 days), note it and ask the user whether to re-scrape or reuse
2. **Log the scrape in SCRAPE-JOURNAL.md** with status `in-progress`:

```markdown
| 003 | 2026-03-10 | Apollo | VP Sales at SaaS 50-200 emp US | Build target list for Q2 cold campaign | 500 | 0 | in-progress | cache/scrapes/2026-03-10_apollo_vp-sales-saas_003.md | |
```

3. **Create the cache file** with a metadata header BEFORE making the API call:

```markdown
# Scrape Cache: [tool] — [angle]

- **Journal ID:** 003
- **Date:** 2026-03-10
- **Tool:** Apollo
- **Endpoint:** POST /api/v1/mixed_people/api_search
- **Angle:** VP Sales at SaaS companies, 50-200 employees, US
- **Goal:** Build target list for Q2 cold outbound campaign
- **Filters applied:** person_titles=VP Sales, org_employees=50-200, location=US, industries=SaaS
- **Max records requested:** 500
- **Status:** in-progress
- **Pages fetched:** 0
- **Total pages:** unknown

---

## Data

_Fetching..._
```

---

## Maximum data pull rules

**Always pull the maximum amount of data per API call.** This minimizes the number of calls (saves rate limit budget) and ensures the cache is comprehensive.

| Tool | Max per call | Parameter | Notes |
|------|-------------|-----------|-------|
| Apollo search | 100 per page | `per_page: 100` | Default is 25 — always set to 100 |
| Apollo bulk enrich | 10 per call | `people/bulk_match` | API limit is 10 |
| Prospeo search | 25 per call | Default pagination | 1 credit per 25 results |
| Prospeo bulk enrich | 50 per call | `bulk-enrich-person` | API limit is 50 |
| Icypeas bulk | 5,000 per call | `bulk-search` | API limit is 5,000 |
| Icypeas profile scrape | 50 per call | `POST /scrape` | API limit is 50 |
| Crispy search | 25 per page | Default SN pagination | LinkedIn enforces this |
| Exa search | 10 results (free) | `numResults` | Paid plans allow more |
| Firecrawl crawl | All pages | Set `limit` high | 1 credit per page |
| Crunchbase | 25 per page | `limit: 25` | API max |
| Diffbot | 25 per query | `size: 25` | Free tier |
| Ocean.io | 25 per query | `limit: 25` | Default |
| Apify | Actor-dependent | Check actor docs | Usually paginated |

**Pagination rule:** Always paginate through ALL available results, not just page 1. Update the cache file after each page. If the session drops, the partial data is already saved.

---

## During the scrape

1. **After each page/batch**, append results to the cache file immediately
2. **Update the metadata header** — increment `Pages fetched`
3. **Update SCRAPE-JOURNAL.md** — update `Records cached` count
4. If rate-limited, log the pause in the cache file and wait

### Cache file format (after data starts arriving)

```markdown
## Data

### Page 1 (fetched 2026-03-10 14:23)

| # | Name | Title | Company | Email | LinkedIn | Location |
|---|------|-------|---------|-------|----------|----------|
| 1 | John Doe | VP Sales | Acme Inc | — | linkedin.com/in/johndoe | San Francisco, CA |
| 2 | ... | ... | ... | ... | ... | ... |

### Page 2 (fetched 2026-03-10 14:24)

| # | Name | Title | Company | Email | LinkedIn | Location |
|---|------|-------|---------|-------|----------|----------|
| 26 | ... | ... | ... | ... | ... | ... |
```

For enrichment results (JSON-heavy), store as structured tables or fenced JSON blocks.

---

## After the scrape

1. **Update cache file metadata:**
   - Set `Status: complete` (or `partial` if interrupted)
   - Set final `Pages fetched` and `Total records`

2. **Update SCRAPE-JOURNAL.md:**
   - Set status to `complete`, `partial`, or `failed`
   - Fill in `Records cached` count
   - Add any notes (rate limits hit, data quality observations)

3. **Update the angles reference** at the bottom of SCRAPE-JOURNAL.md

4. **If team mode (Supabase connected):** sync the journal entry and cache metadata to `scrape_cache` table

---

## Supabase sync (team mode)

In team mode, scrape metadata syncs to Supabase so all operators can see what's been scraped.

**Dual-write rule applies:** always write to both SCRAPE-JOURNAL.md AND Supabase.

**What syncs to Supabase:**
- Journal entry metadata (tool, angle, goal, record count, status, date)
- Cache file path (so others can find it)
- NOT the raw data itself (too large — stays in local files)

**What stays local:**
- Cache files in `cache/scrapes/` and `cache/enrichments/`
- Raw API response data

---

## Enrichment cache (dedup)

Before enriching any contact or company, check `cache/enrichments/` for existing data:

1. Search by email (people) or domain (companies)
2. If found and < 30 days old, skip the API call
3. If found but stale, re-enrich and overwrite

This is especially important for tools that DON'T have lifetime dedup (Apollo, Icypeas). Prospeo has built-in lifetime dedup, but local cache still prevents unnecessary API calls.

### Enrichment cache format

One file per enrichment batch: `{date}_{tool}_enrich_{batch-id}.md`

```markdown
# Enrichment Cache: Apollo People Enrich — Batch 001

- **Date:** 2026-03-10
- **Tool:** Apollo
- **Type:** People enrichment
- **Records:** 10
- **Credits used:** 10 email + 10 export

## Results

| Email | Name | Title | Company | Phone | Status |
|-------|------|-------|---------|-------|--------|
| john@acme.com | John Doe | VP Sales | Acme Inc | — | verified |
| ... | ... | ... | ... | ... | ... |
```

---

## Session recovery

When starting a new session, ALWAYS:

1. Read SCRAPE-JOURNAL.md
2. Check for `in-progress` or `partial` entries
3. If found, read the corresponding cache file
4. Report what was found and ask: resume, retry, or skip?

This ensures no work is lost across session drops.
