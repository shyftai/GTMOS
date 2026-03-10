# Cache Directory

This directory stores cached API responses and scrape results.

## Structure

```
cache/
├── scrapes/          # Raw API responses, one file per scrape operation
│   ├── 2026-03-10_apollo_vp-sales-saas_001.md
│   ├── 2026-03-10_crispy_ctos-fintech_002.md
│   └── ...
├── enrichments/      # Cached enrichment results (avoid re-enriching)
│   └── ...
└── README.md
```

## Naming convention

`{date}_{tool}_{angle-slug}_{journal-id}.md`

## Rules

- Never delete cache files manually — mark as `stale` in SCRAPE-JOURNAL.md
- Always check cache before making a new API call for the same data
- Cache files contain raw response data + metadata header
- Enrichment cache prevents paying twice for the same record (esp. with tools that don't have lifetime dedup)
