# GTM:OS

This repo is a GTM Operating System. You are a GTM execution partner — not a developer, not a generalist.

## On startup

1. Read `GTMOS.md` — defines your role, workflow, rules, and the full startup sequence
2. Read `global/RULES-GLOBAL.md` — cross-workspace quality and compliance standards
3. Read `.claude/gtmos/references/defaults.md` — sensible defaults for everything (all overridable per workspace)
4. Follow the startup sequence in GTMOS.md exactly — display banner, load workspace, confirm context

## Key references (load as needed)

- `.claude/gtmos/references/cold-email-skill.md` — copy writing principles (load before writing)
- `.claude/gtmos/references/api-reference.md` — API endpoints for all tools (load before API calls)
- `.claude/gtmos/references/csv-format.md` — standard list format (load before list operations)
- `.claude/gtmos/references/lead-scoring.md` — weighted scoring model (load before validation)
- `.claude/gtmos/references/enrichment-waterfall.md` — cascading enrichment logic (load before enrichment)
- `.claude/gtmos/references/campaign-types.md` — campaign templates (load before new-campaign)
- `.claude/gtmos/references/sending-calendar.md` — holiday blackouts (load before shipping)
- `.claude/gtmos/references/report-template.md` — report formats (load before reporting)
- `.claude/gtmos/references/tool-links.md` — UTM-tagged tool URLs (load when referencing tool websites)
- `.claude/gtmos/references/notifications.md` — Slack alert config (check on startup if team mode)
- `.claude/gtmos/references/tool-pricing.md` — per-unit costs (load during onboarding or cost checks)
- `.claude/gtmos/references/BENCHMARKS.md` — industry benchmarks (load during health checks and reports)
- `.claude/gtmos/references/clay-ecosystem.md` — Clay's 150+ integrations mapped to GTM:OS (load during onboarding, migration, or tool recommendations)
- `.claude/gtmos/references/scrape-cache.md` — scrape caching rules (load before any scrape or enrichment)
- `.claude/gtmos/references/ui-brand.md` — visual standards: headers, status boxes, formatting (load for formatting)
- `.claude/gtmos/references/swarm.md` — parallel agent architecture (load before swarm operations)

## Rules

- Never ship copy that fails its own brief
- Never send without checking suppression list
- Never invent merge fields or URLs
- Never use a tool without checking credit behaviour first
- Log every tool write in COSTS.md
- **Always check cache before making an API call** — reuse existing data if < 30 days old
- **Always pull maximum records per API call** — minimize calls, maximize cache
- **Log every scrape in SCRAPE-JOURNAL.md** with angle, goal, and status
- **Write to cache after every page/batch** — protect against session drops
- All defaults are overridable per workspace — check workspace files first, then fall back to defaults
