# /rev:health

Full CRM health check — data quality audit across all objects, enrichment gaps, stale records, and duplicate detection.

## When to use

- Weekly as part of RevOps routine
- Before any major enrichment run
- Before producing a report for exec or board
- After a CRM migration or bulk import

---

## What to do

Load `DATA-QUALITY.md`, `CRM.md`, and `rev-data-standards.md`. Then run the health check in this sequence:

### 1. Field completion audit

For each CRM object (Accounts, Contacts, Opportunities), calculate the completion rate for every required field defined in `rev-data-standards.md`.

Present as:

```
FIELD COMPLETION AUDIT — [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ACCOUNTS ([X] total | [X] Tier 1 | [X] Tier 2)

Field                  Overall   Tier 1    Status
─────────────────────────────────────────────────
Company name           [X]%      [X]%      [🟢/🟡/🔴]
Website / Domain       [X]%      [X]%      [🟢/🟡/🔴]
Industry               [X]%      [X]%      [🟢/🟡/🔴]
Employee count         [X]%      [X]%      [🟢/🟡/🔴]
HQ country             [X]%      [X]%      [🟢/🟡/🔴]
Account tier           [X]%      [X]%      [🟢/🟡/🔴]

CONTACTS ([X] total | [X] on active deals)

Field                  Overall   Active deals  Status
──────────────────────────────────────────────────────
Email (valid)          [X]%      [X]%          [🟢/🟡/🔴]
Job title              [X]%      [X]%          [🟢/🟡/🔴]
Seniority              [X]%      [X]%          [🟢/🟡/🔴]
Lead source            [X]%      [X]%          [🟢/🟡/🔴]
LinkedIn URL           [X]%      [X]%          [🟢/🟡/🔴]

OPPORTUNITIES ([X] total | [X] open)

Field                  Open deals  Status
──────────────────────────────────────────
ARR / deal value       [X]%        [🟢/🟡/🔴]
Close date (current)   [X]%        [🟢/🟡/🔴]
Opportunity owner      [X]%        [🟢/🟡/🔴]
Lead source            [X]%        [🟢/🟡/🔴]
Deal type              [X]%        [🟢/🟡/🔴]
Loss reason (closed L) [X]%        [🟢/🟡/🔴]
```

### 2. Duplicate detection

Run fuzzy match on:
- Accounts: website domain + company name
- Contacts: email + name + account domain
- Opportunities: company + deal type + open/close date proximity

Present as:

```
DUPLICATE DETECTION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Accounts: [X] suspected duplicates ([X]%)
  🔴 High confidence (>95%): [X] pairs
  🟡 Medium confidence (80-95%): [X] pairs

Contacts: [X] suspected duplicates ([X]%)
  🔴 High confidence: [X] pairs
  🟡 Medium confidence: [X] pairs

Opportunities: [X] suspected duplicates ([X]%)

→ Run /rev:dedupe to resolve
```

### 3. Stale record audit

Flag records with no update in > 90 days:

```
STALE RECORDS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Accounts not updated > 90 days:  [X] ([X]%)
Open deals not updated > 14 days: [X]
Contacts with enrichment > 30 days (on active deals): [X]
```

### 4. Integration health

```
INTEGRATION STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Stripe sync:    [✓ Last sync: X / ⚠ Degraded / 🔴 Error]
Enrichment:     [✓ Last run: X / ⚠ Cache expiring / 🔴 Error]
[Other tools]:  [Status]
```

### 5. Data quality score

Calculate the composite score:

```
DATA QUALITY SCORE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Overall: [X]%   [🟢 Healthy / 🟡 Fair / 🔴 Needs work]
  Accounts (Tier 1):    [X]%
  Contacts (active):    [X]%
  Opportunities (open): [X]%

vs. last check: [+/-X%]
vs. target (85%): [+/-X%]
```

### 6. Action plan

```
RECOMMENDED ACTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔴 Do this week:
[ ] [Action] — [X] records affected
[ ] [Action] — [X] records affected

🟡 Do this month:
[ ] [Action] — [X] records affected
[ ] [Action] — [X] records affected
```

### After the audit

Update `DATA-QUALITY.md` with:
- New data quality score
- Duplicate counts
- Date of audit
- Top issues identified

Offer follow-on commands:
- `/rev:dedupe` — resolve detected duplicates
- `/rev:enrich` — fix enrichment gaps
- `/rev:stripe` — investigate any sync issues
