# Data Quality Standards

Hygiene rules, enrichment standards, deduplication thresholds, and current data quality scores for this workspace. Load before any data audit or enrichment run.

---

## Data Quality Score

**Last calculated:** [Date]
**Method:** Average field completion rate across required fields, weighted by field importance

| Object | Required fields filled | Score | Target | Status |
|--------|----------------------|-------|--------|--------|
| Accounts (Tier 1) | [X]% | [X]% | 95%+ | [🟢/🟡/🔴] |
| Accounts (Tier 2) | [X]% | [X]% | 85%+ | [🟢/🟡/🔴] |
| Contacts (active deals) | [X]% | [X]% | 90%+ | [🟢/🟡/🔴] |
| Opportunities (open) | [X]% | [X]% | 95%+ | [🟢/🟡/🔴] |
| **Overall** | — | **[X]%** | **85%+** | **[🟢/🟡/🔴]** |

---

## Duplicate Status

**Last dedupe run:** [Date]

| Object | Total records | Suspected dupes | Dupe rate | Action taken |
|--------|--------------|----------------|-----------|-------------|
| Accounts | [X] | [X] | [X]% | [Reviewed / Merged / Pending] |
| Contacts | [X] | [X] | [X]% | [Reviewed / Merged / Pending] |
| Opportunities | [X] | [X] | [X]% | [Reviewed / Merged / Pending] |

---

## Deduplication Thresholds (Workspace)

*Default thresholds from rev-data-standards.md — override here if needed.*

| Object | Auto-flag threshold | Human review required |
|--------|--------------------|-----------------------|
| Accounts | ≥ 95% match confidence | 80–94% |
| Contacts | ≥ 98% (same email) | 85–97% |

**Merge policy:** Archive, never delete. Keep record with highest field fill rate. Preserve all activity history on surviving record.

---

## Enrichment Standards

**Approved enrichment sources (in waterfall order):**

1. [Provider 1, e.g., Apollo] — accounts and contacts
2. [Provider 2, e.g., Clearbit] — account firmographics
3. [Provider 3, e.g., Hunter.io] — email verification
4. Manual research — Tier 1 accounts only, approved by RevOps lead

**Enrichment cadence by tier:**

| Account tier | Re-enrich every | Priority fields |
|-------------|-----------------|----------------|
| Tier 1 (ICP) | 30 days | All required fields |
| Tier 2 (active pipeline) | 60 days | Email, title, decision-maker |
| Tier 3 (cold / inactive) | 180 days | Email, phone |

**Enrichment rules:**
- Check cache before every enrichment call — use data if < 30 days old
- Never overwrite manually set fields without flagging the conflict
- Log every enrichment run in SCRAPE-JOURNAL.md
- Batch size: max 1000 records per run; write to cache after each page

---

## Field Standards

*Reference rev-data-standards.md for the full field standard. Workspace-specific overrides below.*

**Industry taxonomy for this workspace:**
[List the industry values you actually use — delete unused options from the standard list]

**Custom fields and valid values:**
[Document any workspace-specific picklist values or formats that differ from the standard]

---

## Data Quality Issues (Backlog)

| Issue | Records affected | Priority | Owner | Due | Status |
|-------|-----------------|----------|-------|-----|--------|
| [Issue description] | [X] | High/Med/Low | [Name] | [Date] | [Open/In progress/Done] |
| Missing industry field on ICP accounts | [X] | High | [Name] | [Date] | Open |
| Contacts without email on active deals | [X] | High | [Name] | [Date] | Open |

---

## Data Quality Improvement History

| Date | Action | Records improved | Score before | Score after |
|------|--------|-----------------|-------------|------------|
| [Date] | [Action taken] | [X] records | [X]% | [X]% |
