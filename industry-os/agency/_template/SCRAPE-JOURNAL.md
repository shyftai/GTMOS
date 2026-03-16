# Scrape Journal — [Agency Name]

Audit trail for all API calls and data pulls. Every scrape and enrichment operation must be logged here before and after execution.

See `../../.claude/gtmos/references/scrape-cache.md` for full caching rules.

---

## In-progress and partial scrapes

Check this section on every session startup. If any entries have status `in-progress` or `partial`, report them and ask: resume, retry, or skip?

| ID | Date | Angle | Tool | Status | Records | Cache file |
|----|------|-------|------|--------|---------|------------|
| | | | | | | |

---

## Scrape log

| ID | Date | Angle / goal | Tool | Records pulled | Cache file | Cost | Status | Notes |
|----|------|-------------|------|---------------|------------|------|--------|-------|
| | | | | | | | complete / partial / failed | |

---

## Cache index

| Cache file | Date | Records | Angle | Expires | Used in |
|------------|------|---------|-------|---------|---------|
| | | | | | |

---

## Rules reminder

- **Always check this file before any API call** — if usable cache exists (<30 days), use it
- **Always pull maximum records per call** — Apollo: 100/page, Icypeas: 5000/batch
- **Log status as `in-progress` before the first API call**
- **Write to cache after every page/batch** — protect against session drops
- **Update status to `complete` or `partial` after run**
- **Log cost in COSTS.md** after every run
