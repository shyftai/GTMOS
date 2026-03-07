# Data Hygiene / List Decay Monitoring

## The Problem

B2B contact data decays at roughly 30% per year. People change jobs, companies get acquired, emails go stale, domains expire. Every month you wait, your list gets worse.

The consequences of ignoring data decay:

- **Bounced emails** burn your sending domain reputation. ISPs track bounce rates — exceed 2-3% and you risk deliverability drops across your entire sending infrastructure.
- **Wasted credits** on enrichment, verification, and sending tools aimed at people who no longer match the record you have.
- **Damaged sender reputation** compounds over time. Once a domain is flagged, recovery takes weeks or months of warm-up.
- **Missed signals** — a job change is one of the strongest buying triggers in B2B. If you are not detecting them, you are leaving pipeline on the table.

Data hygiene is not a one-time cleanup. It is a continuous operating discipline.

---

## What Gets Monitored

### Email Validity

Re-verify any email older than 90 days before using it in a new campaign. Email validity changes constantly — domains expire, companies migrate providers, catch-all configurations change.

- Emails verified within the last 90 days: eligible for campaigns.
- Emails verified 90-180 days ago: must be re-verified before use.
- Emails verified 180+ days ago: treat as unverified. Re-verify or exclude.

### Job Changes

Detect via:
- **Apollo bulk_match**: compare current job title and company against previous enrichment. If either field changed, flag the record.
- **Crispy profile scrape**: pull current_position and compare against stored record.

Job changes invalidate the contact's company email (they no longer work there) and may invalidate persona fit (new title may not match your targeting).

### Company Changes

Detect via:
- **Exa news search**: surface acquisitions, rebrandings, shutdowns for companies in your active lists.
- **Crunchbase**: funding events, acquisitions, closures.

Company-level changes affect every contact at that company. An acquisition may mean new decision-makers, different tech stack, or consolidated purchasing.

### Bounce History

Contacts that bounced in previous campaigns carry critical signal:
- **Hard bounce** (invalid address, domain not found): suppress permanently. The email does not exist.
- **Soft bounce** (mailbox full, temporary failure): re-verify before next use. May recover, but do not assume it will.

Bounce data comes from your sending tool (Smartlead, Instantly, etc.) after campaign syncs.

### Engagement Decay

Contacts who have been reached 2+ times across campaigns with zero engagement — no opens, no replies, no clicks — are "cold data." They are either:
- Not receiving your emails (deliverability issue at their end)
- Not interested and never will be
- No longer at that email address (undetected bounce)

Cold data dilutes your campaign metrics and wastes volume. Flag it.

---

## Hygiene Checks — What to Run and When

| Check | Frequency | Tool | Cost |
|---|---|---|---|
| Re-verify emails | Before every new campaign (if >90 days old) | MillionVerifier / Icypeas | $0.001-0.01/email |
| Job change detection | Monthly for active lists, quarterly for archived | Apollo bulk_match / Crispy | 1 credit per check |
| Bounce list cleanup | After every campaign sync | Sending tool data | Free |
| Suppression dedup | Before every ship | Local check | Free |
| Cold data flagging | After every campaign completes | Local analysis | Free |

The most expensive check (email re-verification) is also the most important. At $0.001-0.01 per email, the cost of verifying is negligible compared to the cost of a burned domain.

---

## Job Change Handling

Job changes are not just a data quality issue — they are a buying signal. People in new roles often buy tools in their first 90 days as they build their stack and establish processes.

### When a person changed company:

1. Check if the NEW company still fits your ICP (industry, size, tech stack, geography).
2. If yes: update the record with new company, re-enrich for new email and title, mark as eligible for a new campaign with a job-change signal angle.
3. If no: archive the record. The person may still be a buyer, but the company does not fit.

### When a person changed title:

1. Check if the new title still matches your persona targeting.
2. If yes: update the record. The contact remains eligible.
3. If no: archive or re-classify to a different persona if applicable.

### Job change as campaign signal:

Job-change campaigns consistently outperform cold outbound. The messaging angle is natural: "Congrats on the new role at [Company]. When people step into [Title], they usually need to figure out [problem you solve]..."

Flag all job changes for review. Do not auto-archive without checking ICP fit first.

---

## Hygiene Report Display

The hygiene report uses the standard GTMOS box format:

```
+=========================================================+
|                   DATA HYGIENE REPORT                    |
|                    workspace: [name]                     |
+=========================================================+

  Total contacts in workspace .............. 12,847
  Emails verified <90 days ................. 9,412  (73.2%)
  Emails verified >90 days .................  3,435  (26.8%)

  Job changes detected (last 30d) ..........    218
  Hard bounces suppressed ..................    147
  Soft bounces pending re-verify ...........     63
  Cold data flagged (2+ sends, 0 engage) ...    892

+---------------------------------------------------------+
|  DATA FRESHNESS SCORE:  73.2%        Target: >80%       |
|  Status: BELOW TARGET — re-verification recommended     |
+---------------------------------------------------------+

  SUGGESTED ACTIONS:
  [1] Re-verify 3,435 emails older than 90 days
  [2] Review 218 job changes for ICP fit
  [3] Re-enrich job-change contacts that still fit ICP
  [4] Suppress 147 hard bounces (add to SUPPRESSION.md)
  [5] Re-verify 63 soft bounces before next campaign
  [6] Review 892 cold-data contacts for exclusion

+=========================================================+
```

---

## Automated Actions

### Hard Bounces

Auto-add to SUPPRESSION.md with reason `hard_bounce` and the date of the bounce. These contacts should never be emailed again from any campaign.

### Job Changes

Flag for review. Do not auto-suppress — job changes are valuable signal. Suggest re-enrichment for contacts whose new company fits ICP.

### Emails >90 Days Old

Flag for re-verification before next use. Do not include in any new campaign until verified. Bulk re-verification via MillionVerifier or Icypeas is the fastest path.

### Cold Data (2+ Campaigns, Zero Engagement)

Suggest exclusion from email campaigns. These contacts may be reachable via different channels (LinkedIn, phone) but email is not working. Options:
- Exclude from future email campaigns
- Move to a LinkedIn-only or phone-only sequence
- Archive if no alternative channel is viable

---

## Data Freshness Score

The data freshness score measures the percentage of contacts in a workspace that have:
- A verified email less than 90 days old, AND
- No detected job change since last enrichment

**Calculation:**

```
freshness_score = (contacts_with_fresh_verified_email_AND_no_job_change / total_contacts) * 100
```

**Targets:**
- **>80%**: Healthy. Lists are well-maintained.
- **60-80%**: Acceptable but degrading. Schedule re-verification.
- **<60%**: Stale. Do not run new campaigns until hygiene is addressed.

A workspace with a freshness score below 60% will generate more bounces, lower reply rates, and risk domain reputation. Fix the data before spending credits on sending.
