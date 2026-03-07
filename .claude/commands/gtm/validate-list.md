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
</execution_context>

<process>
1. Display mode header: `<< GTMOS // LIST BUILD >>`
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

## Step 2 — Validate
6. Score every cleaned record using the rubric in RULES.md
7. Add columns: icp_score, rejection_reason, review_flag
8. Save to lists/validated/
9. Display list validation summary using ui-brand.md format
10. Suggest next action: review score-1 records, then `/gtm:ship`
</process>
