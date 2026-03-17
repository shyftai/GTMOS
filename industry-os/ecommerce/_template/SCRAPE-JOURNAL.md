# Scrape Journal — API Audit Trail

Every external data pull, competitor check, trend scan, or API call is logged here. Check this file before any scrape to avoid redundant calls.

Cache rule: if the same data was pulled < 7 days ago for signals, < 30 days ago for product/pricing data, reuse cached results.

---

## Active cache

| Data type | Source | Last pulled | Expires | Status | File / Location |
|-----------|--------|------------|---------|--------|-----------------|
| Competitor pricing — [Name] | Manual / [tool] | [date] | [date] | Fresh / Stale | [path or note] |
| Meta Ad Library — [competitor] | Meta Ad Library | [date] | [date] | Fresh / Stale | [path or note] |
| Google Trends — [keyword] | Google Trends | [date] | [date] | Fresh / Stale | [path or note] |

---

## Scrape log

| Date | Tool / Source | Goal / Angle | Records pulled | Cost | Status | Notes |
|------|--------------|--------------|----------------|------|--------|-------|
| [date] | [tool] | [what and why] | [count] | $[X] | Complete / Partial / Failed | |

---

## Session recovery notes

If a session drops mid-scrape, resume from the last completed batch noted here.

| Session | Started | Stopped at | Resume point |
|---------|---------|-----------|--------------|
| | | | |

---

## Max-pull rules

- Always request maximum page size / record limit per API call
- Cache every page/batch before requesting the next
- If session drops: check this journal, resume from last cached batch
- Never re-pull data that is still within cache window
