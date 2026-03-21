---
name: gtm:validate-list
description: Score and validate a raw prospect list against ICP and rules
argument-hint: "<workspace-name> [file-path]"
---
<objective>
Validate a raw prospect list against ICP.md and RULES.md. Score every record, add validation columns, save to validated/.

Workspace and file: $ARGUMENTS
</objective>

<execution_context>
@./commands/clean-list.md
@./commands/validate-list.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/csv-format.md
@./.claude/gtmos/references/lead-scoring.md
@./.claude/gtmos/references/enrichment-waterfall.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // LIST BUILD >>`
2. Load workspace context — ICP.md, RULES.md, SUPPRESSION.md, global/RULES-GLOBAL.md

## Step 1 — Clean (auto-runs before validation)
3. Run the full cleaning pass from clean-list.md:
   - Names: title case, trim, remove titles, flag empty
   - Companies: normalize casing, preserve acronyms, strip legal suffixes, flag variants
   - Emails: lowercase, trim, flag personal/role-based domains
   - Domains: normalize, cross-check against email domain
   - Job titles: standardize abbreviations
   - Deduplication: exact email match, fuzzy company match
   - Suppression check: remove any matches from SUPPRESSION.md
   - Cross-campaign check: flag contacts in other active campaigns
4. Display cleaning summary
5. Show flagged records for review before proceeding

## Step 1.5 — Normalize columns
5b. Map input columns to GTM:OS standard format (csv-format.md)
    - If imported from Apollo, Sales Navigator, Instantly, or Lemlist: auto-map using import mappings
    - If unknown format: display column mapping for user confirmation

## Step 1.7 — Enrichment gaps check
5c. After cleaning, check for missing data (email, phone, title, company info)
    - If gaps exist, suggest: `/gtm:enrich {workspace} {type}` before scoring
    - If email column has >20% missing, flag: "Run email enrichment before validation"
    - Do not auto-enrich — let the user decide

## Step 2 — Validate and score

Check `workspace.config.md` for `Scoring mode`. Default is `company-first`.

### If scoring mode = company-first (default)

**Pre-check — Company data availability:**
Before scoring, check whether company-level fields are populated (industry, employee_count, geography, funding_stage):
- If > 50% of records are missing company data, pause and ask:
  ```
  Company data is sparse — only {n}% of records have industry, size, or location.
  Company scores will be unreliable without this data.

  Options:
    a) Run /gtm:enrich {workspace} company first — adds firmographic data, then re-run validate-list
    b) Proceed with available data — company scores will be lower due to missing fields

  >> a / b
  ```
- If the user chooses (a): stop, route to `/gtm:enrich {workspace} company`, then resume validate-list when enrichment is complete
- If the user chooses (b) or data coverage is adequate: proceed to Pass 1

**Pass 1 — Account scoring:**
6a. Group records by company domain
6b. For each unique company, calculate `company_score` (0-100) using the account scoring model in lead-scoring.md
6c. Assign account tier: A (80-100), B (60-79), C (40-59), D (20-39), F (0-19)
6d. Remove all contacts at F-tier accounts (company_score < 20) — log removal count, not names
6e. Flag D-tier accounts with `review_flag: account-d-tier` — hold unless user overrides
6f. Display account scoring summary:
```
  Account scoring complete — {n} companies
  A: {n}  B: {n}  C: {n}  D: {n} (held)  F: {n} (removed)
  Proceeding with {n} contacts at A/B-tier accounts.
```

**Pass 2 — Prospect scoring (A/B-tier accounts only):**
7. Score every remaining contact using the rubric in RULES.md (0-3 ICP score)
8. Calculate prospect score (0-100) using lead-scoring.md — company fit component uses `company_score × 0.30` instead of re-scoring firmographics
   - Apply ICP ceiling rule: icp_score 2 → max 79, icp_score 1 → max 59
   - Check RULES.md for `## Lead scoring overrides` — apply any custom weights
9. Assign prospect tier: A (80-100), B (60-79), C (40-59), D (20-39), F (0-19)
10. Add columns: `company_score`, `company_tier`, `icp_score`, `lead_score`, `score_tier`, `rejection_reason`, `review_flag`

### If scoring mode = people-first

6. Score every cleaned record using the rubric in RULES.md (0-3 ICP score)
7. Calculate weighted lead score (0-100) using lead-scoring.md (original 5-component model)
   - Check workspace RULES.md for `## Lead scoring overrides` — apply any custom weights
   - If no overrides, use default weights
8. Assign score tier: A (80-100), B (60-79), C (40-59), D (20-39), F (0-19)
9. Add columns: icp_score, lead_score, score_tier, rejection_reason, review_flag
10. Add expiry columns:
    - `validated_at`: today's ISO date (YYYY-MM-DD)
    - `valid_until`: validated_at + 30 days
    These are non-optional — every validated list must carry its freshness date. Lists older than 30 days are blocked at ship time.
11. Sort by lead_score descending
12. Save to lists/validated/ in GTM:OS standard CSV format — include expiry columns
13. Display list validation summary using ui-brand.md format — include score tier breakdown and expiry date:
    ```
    Validated: {n} contacts  ·  Expires: {valid_until}  ·  Tiers: A:{n} B:{n} C:{n} D:{n} F:{n}
    ```
14. Write to `context/SESSION.md`:
    ```
    # SESSION — {ISO date}
    Campaign: {campaign name}
    Last action: List validated — {n} contacts, expires {valid_until}. Tiers: A:{n} B:{n} C:{n} D:{n} F:{n}
    Status: List ready
    Next: /gtm:write {workspace} — draft copy, then /gtm:ship
    ```
15. Suggest next action: review score-1 records, then `/gtm:ship`
</process>
