# Command: Validate List

## Trigger
"Validate this list" or "Run a validation pass on [file]"

## Steps
1. Confirm active workspace (ICP.md + RULES.md + SUPPRESSION.md loaded)
2. Load the raw CSV from lists/raw/
3. Run cleaning pass first (see clean-list.md) — normalize names, companies, emails, deduplicate, suppress
4. Score every cleaned record against ICP.md using the rubric in RULES.md
5. Add columns to output: icp_score, rejection_reason (if 0), review_flag (if 1)
6. Save validated file to lists/validated/
6. Output summary:
   - Total records reviewed
   - Count by score (0 / 1 / 2 / 3)
   - Top 3 rejection reasons
   - Records flagged for manual review
