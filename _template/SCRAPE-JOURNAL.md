# Scrape Journal — [Workspace Name]

Every scrape operation is logged here before it starts. If a session drops mid-scrape, resume from the last in-progress entry.

## How to use this file

1. **Before scraping** — add an entry with status `in-progress`
2. **After scraping** — update status to `complete` or `failed` with results summary
3. **On session resume** — check for `in-progress` entries and resume or retry

---

## Active scrapes

_None_

---

## Scrape log

| ID | Date | Tool | Angle | Goal | Records requested | Records cached | Status | Cache file | Notes |
|----|------|------|-------|------|-------------------|----------------|--------|------------|-------|
| | | | | | | | | | |

---

## Status definitions

- **in-progress** — scrape has started, cache file created, not yet complete
- **complete** — all data pulled and cached, ready for use
- **partial** — session dropped or rate-limited mid-scrape, partial data in cache
- **failed** — scrape errored out, see notes for reason
- **stale** — data older than 30 days, should re-scrape before using

---

## Scrape angles reference

Track which angles have been scraped so you don't repeat work or can reuse cached data.

| Angle | Last scraped | Cache file | Records | Still valid? |
|-------|-------------|------------|---------|-------------|
| | | | | |
