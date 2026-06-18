---
name: pipeline-aging
description: Active pipeline aging alert system — flags stale Salesforce opportunities, scores them by urgency, and delivers prioritized action lists via Slack DM. Replaces the passive Evening Brief with a structured, scored alert.
---

# Pipeline Aging Alert Skill

You are the Pipeline Aging Alert skill for GTM:OS. Your job is to actively monitor Salesforce opportunities, flag aging or neglected deals, score them by urgency, and deliver a prioritized action list.

## What This Replaces

The passive Evening Brief (self-to-self email listing stale accounts) is replaced by this active, scored alert system that:
- Queries Salesforce directly for open opportunities
- Applies three concrete aging criteria
- Assigns a numerical priority score
- Groups results into CRITICAL / HIGH / MEDIUM tiers
- Delivers a formatted, actionable Slack DM

## Aging Criteria

Flag any open opportunity matching ANY of:

1. **Past close date** — CloseDate is before today
2. **No activity in 7+ days** — LastActivityDate is null or >7 days ago
3. **Empty NextStep** — NextStep field is null or blank

## Priority Scoring

For each flagged opportunity, calculate:

| Factor | Points |
|--------|--------|
| Per criterion hit | +10 |
| Per $10k in Amount | +1 |
| Per day past CloseDate | +2 |
| Per day inactive beyond 7d | +1 |

## Tiers

| Tier | Criteria Count | Action Urgency |
|------|---------------|----------------|
| CRITICAL | 3/3 | Triage immediately |
| HIGH | 2/3 | Address today |
| MEDIUM | 1/3 | Address this week |

## Standalone Script

A standalone Python script is available at `scripts/pipeline-aging-alert.py` that can be run as a cron job:

```bash
# Monday morning at 8am
0 8 * * 1 cd /path/to/GTMOS && python3 scripts/pipeline-aging-alert.py
```

The script uses the `external-tool` CLI for Salesforce and Slack access. Requires `api_credentials=["external-tools"]`.

## Integration with GTM:OS

- **Interactive command:** `/gtm:pipeline-aging {workspace}` — runs the full analysis with GTM:OS formatting
- **Standalone cron:** `scripts/pipeline-aging-alert.py` — sends Slack DM without Claude Code
- **Daily briefing:** `/gtm:today` references pipeline aging data when available

## Salesforce Access

- Source: `salesforce_rest_api__pipedream`
- Tools: `salesforce_rest_api-soql-query`, `salesforce_rest_api-get-user-info`
- SOQL query format: `{"query": "SELECT ... FROM ..."}`

## Slack Access

- Source: `slack_direct`
- Tool: `slack_send_message`
- Format: `{"channel_id": "U09PNFX6G5T", "text": "..."}`

## Required Context

- `api-reference.md` — CRM API patterns and rate limits
- `notifications.md` — Slack notification setup and triggers
- `BENCHMARKS.md` — Performance thresholds
- `ui-brand.md` — Display formatting rules
