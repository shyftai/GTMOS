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
6. Score every cleaned record using the rubric in RULES.md (0-3 ICP score)
7. Calculate weighted lead score (0-100) using lead-scoring.md
   - Check workspace RULES.md for `## Lead scoring overrides` — apply any custom weights
   - If no overrides, use default weights
8. Assign score tier: A (80-100), B (60-79), C (40-59), D (20-39), F (0-19)
9. Add columns: icp_score, lead_score, score_tier, rejection_reason, review_flag
10. Sort by lead_score descending
11. Save to lists/validated/ in GTM:OS standard CSV format
12. Display list validation summary using ui-brand.md format — include score tier breakdown
13. Suggest next action: review score-1 records, then `/gtm:ship`
</process>
