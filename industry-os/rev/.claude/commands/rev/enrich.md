# /rev:enrich

Run enrichment on CRM records to fill gaps in firmographic, contact, and technographic data.

## When to use

- Weekly on active deal contacts
- Monthly on Tier 1 accounts
- After importing a new list
- When `/rev:health` surfaces enrichment gaps

---

## What to do

Load `../../.claude/gtmos/references/enrichment-waterfall.md`, `../../.claude/gtmos/references/scrape-cache.md`, `rev-data-standards.md`, and `COSTS.md`.

**Always check cache first** — if a record was enriched within 30 days, use cached data and do not make a new API call.

### Step 1: Scope

Ask the user:
1. What to enrich? (Accounts / Contacts / Both)
2. Which segment? (Tier 1 only / Active deals / All / Specific list)
3. Which fields are the priority? (Email, phone, title, firmographics, tech stack)
4. Which enrichment provider to use? (Default: Apollo → Clearbit → Hunter waterfall)

### Step 2: Cache check

Before any API call:
```
CACHE CHECK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Records in scope:       [X]
Already enriched < 30d: [X] (skip — use cache)
Needs enrichment:       [X]
Estimated credits:      [X]
Estimated cost:         $[X]

→ Proceed? [Y/N]
```

Require approval before spending credits.

### Step 3: Enrichment run

Run in batches of max 1000 records. After each batch:
1. Write results to cache
2. Log batch to SCRAPE-JOURNAL.md
3. Present progress update

**Field write rules:**
- Only write to empty fields (unless field is stale > 90 days and source has higher confidence)
- Flag any field conflict (enrichment value ≠ existing manual value) — do not overwrite without user approval
- Validate email format before writing
- Flag role-based emails (info@, sales@, etc.) as "risky" rather than "verified"

### Step 4: Present results

```
ENRICHMENT COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Records processed:  [X]
Records enriched:   [X] ([X]%)
Cache hits (skipped): [X]
Fields written:     [X]

By field:
  Email:           [X] records updated
  Phone:           [X] records updated
  Job title:       [X] records updated
  Industry:        [X] records updated
  Employee count:  [X] records updated
  LinkedIn URL:    [X] records updated

Conflicts flagged (requires manual review): [X]
Invalid emails flagged: [X]
Credits used: [X] | Cost: $[X]

Coverage (before → after):
  Email (active deals):   [X]% → [X]%
  Industry (Tier 1):      [X]% → [X]%
```

### Step 5: Log and update

1. Log run in SCRAPE-JOURNAL.md: date, provider, object, records, fields, credits, cost
2. Log cost in COSTS.md
3. Update `DATA-QUALITY.md` enrichment coverage numbers
4. Present any conflicts requiring manual resolution

### Step 6: Conflict resolution

For each conflict:
```
FIELD CONFLICT — [Record Name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Field:          Job Title
Existing value: "VP Sales" (set manually 2024-11-01)
Enriched value: "Chief Revenue Officer" (Apollo 2025-03-18)

Options:
  [1] Keep existing (manual value)
  [2] Use enriched value
  [3] Keep existing, add note that title may have changed
```
