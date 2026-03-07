---
name: gtm:clean-list
description: Clean and normalize a raw prospect list before validation
argument-hint: "<workspace-name> [file-path]"
---
<objective>
Clean a raw prospect list — normalize names, companies, emails, domains, titles, and deduplicate. Can run standalone or as step 1 of validate-list.

Workspace and file: $ARGUMENTS
</objective>

<execution_context>
@./commands/clean-list.md
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // LIST CLEAN >>`
2. Load workspace context — SUPPRESSION.md, RULES.md
3. Load the raw CSV from lists/raw/ (or specified file path)
4. Display record count and column headers

5. Run cleaning pass (from clean-list.md):
   a. Names — title case, trim, remove titles, flag empty
   b. Companies — normalize casing, preserve acronyms, strip legal suffixes, flag variants
   c. Emails — lowercase, trim, flag personal/role-based domains
   d. Domains — normalize, cross-check against email domain
   e. Job titles — standardize abbreviations
   f. Location — normalize country/state formats
   g. LinkedIn URLs — normalize format, flag missing
   h. Deduplication — exact email match, fuzzy company match
   i. Suppression check — remove matches from SUPPRESSION.md
   j. Cross-campaign check — flag contacts in other active campaigns

6. Display cleaning summary:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  LIST CLEAN — COMPLETE                     ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                            ┃
┃  Records processed:     {n}                ┃
┃  Names corrected:       {n}                ┃
┃  Emails normalized:     {n}                ┃
┃  Companies standardized:{n}                ┃
┃  Duplicates removed:    {n}                ┃
┃  Suppressed removed:    {n}                ┃
┃  Flagged for review:    {n}                ┃
┃  Clean records:         {n}                ┃
┃                                            ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

7. Show flagged records for review (personal domains, fuzzy dupes, missing names)
8. Save cleaned file to lists/raw/{filename}-cleaned.csv
9. Suggest next action:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Next: /gtm:validate-list {workspace}
     (validation will use the cleaned file)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
