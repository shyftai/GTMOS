# /rev:dedupe

Find and resolve duplicate CRM records — accounts, contacts, and opportunities.

## When to use

- After `/rev:health` flags duplicate rate above threshold
- After a bulk import or list upload
- After a CRM migration
- Monthly as part of data hygiene routine

---

## What to do

Load `DATA-QUALITY.md` and `rev-data-standards.md` for thresholds and merge rules.

### Step 1: Scope

Ask the user:
1. Which object to dedupe? (Accounts / Contacts / Opportunities / All)
2. Starting point — fresh scan, or resolve from a prior `/rev:health` run?
3. Focus area — all records, or specific segment (e.g., "Tier 1 accounts only", "contacts on active deals")?

### Step 2: Duplicate detection

**For Accounts:**
Match keys (in priority order):
1. Website domain (normalize: strip www, strip path, lowercase)
2. Company name (fuzzy match — token sort ratio ≥ 85%)
3. LinkedIn company URL

**For Contacts:**
Match keys:
1. Email address (exact, case-insensitive)
2. First name + Last name + Account domain
3. LinkedIn profile URL

**For Opportunities:**
Match keys:
1. Same account + same deal type + overlapping close dates (within 30 days)
2. Same account + same ARR value + same stage

### Step 3: Present results

For each duplicate cluster, present:

```
DUPLICATE CLUSTER [X] of [X]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Object: Account

Record A (KEEP CANDIDATE):
  Name:      Acme Corporation
  Domain:    acme.com
  Owner:     Sarah Chen
  Created:   2024-01-15
  Fields:    18/20 complete
  Deals:     3 open ($240K)
  Activity:  Last updated 3 days ago

Record B (MERGE INTO A):
  Name:      ACME Corp
  Domain:    acme.com
  Owner:     (unassigned)
  Created:   2024-09-03
  Fields:    7/20 complete
  Deals:     1 open ($45K) — WILL MOVE TO RECORD A
  Activity:  Last updated 47 days ago

Match confidence: 97% (same domain + similar name)
Recommendation: MERGE B into A

Action options:
  [1] Merge (B → A)
  [2] Skip this cluster
  [3] Not a duplicate — flag as different companies
  [4] Review manually

→ Enter choice:
```

### Step 4: Execute merge

For approved merges:
- **NEVER hard-delete** — archive the losing record
- Move all deals, contacts, and activities from losing record to surviving record
- Add note to surviving record: "Merged from [ID] on [Date] by RevOps"
- Tag losing record: "Archived — duplicate of [Surviving Record ID]"

Log each merge in SCRAPE-JOURNAL.md:
```
[Date] | CRM Dedupe | Merged [Object] | [X] pairs merged | No cost | [User] | Notes
```

### Step 5: Summary

```
DEDUPE COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Object: Accounts
Clusters reviewed: [X]
Merged: [X]
Skipped: [X]
Not duplicates: [X]

Duplicate rate before: [X]%
Duplicate rate after:  [X]%

Activities preserved: [X]
Deals moved: [X]
Contacts consolidated: [X]
```

Update `DATA-QUALITY.md` with new duplicate count and date.

### Hard rules for dedupe

- **Never merge contacts across different Account records** without reviewing both accounts first
- **Never auto-merge** without presenting the cluster to the user first (unless user has explicitly enabled auto-merge in workspace.config.md)
- **Never delete** — archive only
- **Log every merge** in SCRAPE-JOURNAL.md
- If confidence score < 80%, do not flag as duplicate
