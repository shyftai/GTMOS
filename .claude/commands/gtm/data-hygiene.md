---
name: gtm:data-hygiene
description: Check data freshness, detect job changes, flag stale contacts
argument-hint: "<workspace-name> [list-file]"
---

You are running the GTMOS data hygiene and list decay monitoring system.

Read and follow these references for context, formatting, and available APIs:
- commands/data-hygiene.md (primary logic and report format)
- commands/ui-brand.md (display formatting rules)
- commands/api-reference.md (API endpoints and authentication)
- commands/enrichment-waterfall.md (enrichment tool priority and fallback logic)

## Execution Process

### Step 1: Display Mode Header

Display the GTMOS mode header for Data Hygiene using the standard box format from ui-brand.md. Include the workspace name from the argument.

### Step 2: Load Workspace Lists and Contact Data

Load the workspace directory at `workspaces/<workspace-name>/`. Read all list files (CSV/JSON) in the workspace. If a specific `[list-file]` argument was provided, scope the analysis to that file only.

Identify for each contact:
- Email address
- Last verification date (if stored)
- Job title and company (current record)
- Bounce history (from campaign sync data)
- Campaign send history and engagement data (opens, replies)

### Step 3: Check Email Verification Dates

For every contact, check when their email was last verified:
- Verified within 90 days: mark as FRESH.
- Verified 90-180 days ago: mark as STALE — flag for re-verification.
- Verified 180+ days ago or never verified: mark as UNVERIFIED — flag for re-verification.

Count totals for each bucket.

### Step 4: Check for Job Changes

If Apollo or Crispy API keys are available in the workspace or environment:
- Run Apollo bulk_match or Crispy profile scrape against contacts in active lists.
- Compare returned job title and company against stored values.
- Flag any mismatches as job changes.
- For each job change, note whether the NEW company fits ICP criteria (check against ICP definition in the workspace if available).

If no API keys are available, skip this step and note in the report that job change detection was skipped due to missing API credentials.

### Step 5: Cross-Reference Bounce History

Look for campaign sync data in the workspace (e.g., `workspaces/<workspace-name>/campaigns/` or similar). Extract bounce records:
- Hard bounces: flag for permanent suppression.
- Soft bounces: flag for re-verification.

Cross-reference against the current suppression list. Identify any hard bounces not yet added to SUPPRESSION.md.

### Step 6: Flag Cold Data

Analyze campaign send history across all campaigns in the workspace. Identify contacts who:
- Have been included in 2 or more campaigns, AND
- Have zero engagement across all campaigns (no opens, no replies, no clicks)

Flag these contacts as "cold data."

### Step 7: Calculate Data Freshness Score

Calculate the data freshness score:

```
freshness_score = (contacts_with_verified_email_under_90_days_AND_no_job_change / total_contacts) * 100
```

Compare against targets:
- >80%: Healthy
- 60-80%: Acceptable but degrading
- <60%: Stale — do not run new campaigns until addressed

### Step 8: Display Hygiene Report

Display the full hygiene report using the GTMOS box format as specified in commands/data-hygiene.md. Include:
- Total contacts in workspace
- Email verification breakdown (fresh / stale / unverified)
- Job changes detected
- Hard bounces suppressed
- Soft bounces pending re-verification
- Cold data flagged
- Data freshness score with status indicator

### Step 9: Suggest Actions

Based on the findings, present a prioritized action list:

1. **Re-verify stale emails** — list the count and estimated cost at $0.001-0.01/email.
2. **Review job changes** — list contacts with detected job changes. For each, note whether new company appears to fit ICP.
3. **Suppress hard bounces** — list contacts to add to SUPPRESSION.md. Offer to append them automatically.
4. **Re-verify soft bounces** — list contacts that soft-bounced for re-verification before next campaign.
5. **Address cold data** — list contacts with 2+ sends and zero engagement. Suggest exclusion from email or channel switch.
6. **Re-enrich job changers** — for job-change contacts whose new company fits ICP, suggest re-enrichment via the enrichment waterfall.

Ask the user which actions they want to execute, or if they want to run all automated actions (suppress hard bounces, flag stale emails, flag cold data).
