# CRM Migration Log

Tracks the full migration from source CRM to destination CRM — pre-migration scores, field mapping, execution log, validation results, and issue tracker.

Created by `/rev:migrate`. Updated throughout the migration process.

---

## Migration Overview

**Source CRM:** [Salesforce / HubSpot / Pipedrive / Other]
**Destination CRM:** [Salesforce / HubSpot / Pipedrive / Other]
**Migration owner:** [Name]
**Migration start:** [Date]
**Target completion:** [Date]
**Status:** [Planning / Phase 1 — Audit / Phase 2 — Execution / Phase 3 — Validation / Complete]

---

## Pre-Migration Baseline

*Captured before any data is moved. Compare against post-migration scores.*

**Record counts (source CRM):**

| Object | Total | Active | Archived |
|--------|-------|--------|---------|
| Companies / Accounts | [X] | [X] | [X] |
| Contacts | [X] | [X] | [X] |
| Deals (open) | [X] | $[X] value | — |
| Deals (closed won, LTM) | [X] | $[X] value | — |
| Deals (closed lost, LTM) | [X] | — | — |

**Data quality baseline:**

| Metric | Score | Target |
|--------|-------|--------|
| Overall data quality | [X]% | ≥ [X]% post-migration |
| Lead source coverage | [X]% | ≥ [X]% post-migration |
| Duplicate rate | [X]% | ≤ [X]% post-migration |
| Enrichment coverage (Tier 1) | [X]% | ≥ [X]% post-migration |

**Attribution snapshot (pre-migration):**

| Source | Contacts | Deals (open) | Deals (won LTM) |
|--------|----------|--------------|----------------|
| [Source 1] | [X] | [X] · $[X]K | [X] · $[X]K |
| [Source 2] | [X] | [X] · $[X]K | [X] · $[X]K |
| [Source 3] | [X] | [X] · $[X]K | [X] · $[X]K |
| Unknown / NULL | [X] | [X] · $[X]K | [X] · $[X]K |

---

## Field Mapping

*Completed in Phase 1. Reference `references/rev-migration.md` for standard mapping.*

### Companies / Accounts

| Source field | Destination field | Transform | Status |
|-------------|------------------|-----------|--------|
| [Field] | [Field] | [None / Remap values / Custom field required] | [✅ / ⚠ / ❌] |

### Contacts

| Source field | Destination field | Transform | Status |
|-------------|------------------|-----------|--------|
| [Field] | [Field] | [None / Remap values / Custom field required] | [✅ / ⚠ / ❌] |

### Deals / Opportunities

| Source field | Destination field | Transform | Status |
|-------------|------------------|-----------|--------|
| [Field] | [Field] | [None / Remap values / Custom field required] | [✅ / ⚠ / ❌] |

### Stage name mapping

| Source stage | Destination stage | Probability |
|-------------|------------------|-------------|
| [Stage] | [Stage] | [X]% |

### Lead source value mapping

| Source value | REV:OS standard | Destination value |
|-------------|----------------|------------------|
| [Value] | [Standard] | [Value] |

---

## Pre-Migration Checklist

### Data preparation

- [ ] Lead source set on > 95% of contacts and deals
- [ ] Duplicate accounts and contacts resolved (`/rev:dedupe` run: [Date])
- [ ] Dead records archived and excluded from export
- [ ] Field values normalized
- [ ] Custom fields created in destination CRM
- [ ] UTM fields confirmed as custom field values (not just tracking cookies)

### Documentation

- [ ] Field mapping table completed (this file)
- [ ] Pre-migration scores documented (above)
- [ ] Attribution snapshot saved (above)
- [ ] Active deal list exported and saved
- [ ] Integration list documented (below)
- [ ] Report/dashboard screenshots archived

### Backup

- [ ] Full export from source CRM downloaded and stored at: [Location]
- [ ] Report/dashboard screenshots archived at: [Location]
- [ ] Key account files downloaded
- [ ] Workflow/sequence enrollment states documented

---

## Integration Status

*Track all integrations — disconnect from source, reconnect to destination.*

| Integration | Source CRM status | Destination CRM status | Reconnection date |
|-------------|------------------|----------------------|------------------|
| Stripe | [Connected / Disconnected] | [Pending / Connected] | [Date] |
| Gong / Chorus | [Connected / Disconnected] | [Pending / Connected] | [Date] |
| CS platform ([Name]) | [Connected / Disconnected] | [Pending / Connected] | [Date] |
| Enrichment ([Name]) | [Connected / Disconnected] | [Pending / Connected] | [Date] |
| Sequencing ([Name]) | [Connected / Disconnected] | [Pending / Connected] | [Date] |
| Marketing automation | [Connected / Disconnected] | [Pending / Connected] | [Date] |

---

## Migration Execution Log

*Updated during Phase 2. One row per object batch.*

| Date | Object | Records sent | Records arrived | Delta | Notes |
|------|--------|-------------|----------------|-------|-------|
| [Date] | Companies | [X] | [X] | [X] | [Any issues] |
| [Date] | Contacts | [X] | [X] | [X] | |
| [Date] | Deals (historical) | [X] | [X] | [X] | |
| [Date] | Deals (open) | [X] | [X] | [X] | |
| [Date] | Activities / notes | [X] | [X] | [X] | |

**Test batch result:** [Pass / Fail — notes]
**Full migration started:** [Date]
**Full migration completed:** [Date]

---

## Post-Migration Validation

*Completed in Phase 3.*

### Record count comparison

| Object | Pre-migration | Post-migration | Delta | Status |
|--------|--------------|----------------|-------|--------|
| Companies | [X] | [X] | [X] | [✅/🔴] |
| Contacts | [X] | [X] | [X] | [✅/🔴] |
| Open deals | [X] | [X] | [X] | [✅/🔴] |
| Open deal value | $[X] | $[X] | $[X] | [✅/🔴] |

### Data quality comparison

| Metric | Pre-migration | Post-migration | Delta | Status |
|--------|--------------|----------------|-------|--------|
| Overall quality | [X]% | [X]% | [+/-X pp] | [✅/⚠/🔴] |
| Lead source coverage | [X]% | [X]% | [+/-X pp] | [✅/⚠/🔴] |
| Duplicate rate | [X]% | [X]% | [+/-X pp] | [✅/⚠/🔴] |

### `/rev:health` run (post-migration)

**Date:** [Date]
**Score:** [X]% (pre-migration: [X]%)
**Status:** [On track / Issues found — see issue tracker]

---

## Issue Tracker

*Log any problems found during or after migration.*

| Date | Object | Issue | Records affected | Resolution | Status |
|------|--------|-------|-----------------|-----------|--------|
| [Date] | [Object] | [Issue description] | [X] | [How resolved] | [Open / Resolved] |

---

## Parallel Running Period

**Old CRM read-only from:** [Migration completion date]
**Old CRM read-only until:** [Migration completion date + 30 days]
**Old CRM subscription cancel date:** [Date]

Access instructions for old CRM during parallel period:
- [Admin login / read-only URL]
- Use ONLY for: looking up historical records, retrieving data missing from new CRM
- Do NOT: create new records, update records, run active reports

---

## Migration Complete

**Completion date:** [Date]
**Final data quality score:** [X]%
**Final attribution coverage:** [X]%
**Total records migrated:** [X] companies · [X] contacts · [X] deals
**Integrations connected:** [X]/[X]

**What was not migrated (and where it lives):**
- [Item] — [Location / reason]
- [Item] — [Location / reason]

**Learnings added to LEARNINGS.md:** [Yes / No — add before closing this file]

---

## How to use this file

- Update Phase and Status at the top after each phase completes
- Add every field mapping decision — future you will need this if something breaks
- Log every batch in the Execution Log as it runs
- Use the Issue Tracker for anything that doesn't arrive cleanly
- Keep this file even after migration is complete — it's the audit trail
