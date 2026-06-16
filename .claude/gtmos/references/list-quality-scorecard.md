# List Quality Scorecard — GTMOS

A CSV of 5,000 leads is not the same as a good list of 5,000 leads. This scorecard grades a list across 8 dimensions **before** it ships, catching preventable waste — bad lists, unverified emails, and ICP drift.

This is a **list-level** health grade. It complements, not replaces, the per-contact `lead-scoring.md` model: `lead-scoring.md` ranks who to contact first; this scorecard decides whether the list is fit to send at all. Run it inside `/gtm:validate-list` (after cleaning and scoring, before save) and standalone via `/gtm:score-list`.

---

## Why it exists

The three failure modes outbound operators hit most — all catchable before sending:

1. **Bad list** — copy doesn't matter when you're emailing the wrong people
2. **Unverified emails** — bounces burn domain reputation
3. **ICP drift** — you think you're targeting VPs; the list is mostly Managers

---

## Inputs

GTM:OS standard CSV (see `csv-format.md`). Minimum columns: `email`, `first_name`, `last_name`, `job_title`, `company_name`. Optional but used when present: `company_domain`, `company_industry`, `company_headcount`, `email_status` (verification result). When an ICP file is available (`ICP.md` / `PERSONA.md` of the active workspace), the scorecard checks the list against the declared filters.

---

## The 8 dimensions

### 1. Email verification coverage (critical, 2× weight)
% of emails verified (valid, not catch-all/unknown) via the workspace's verifier (MillionVerifier / ZeroBounce / Scrubby — see `tool-pricing.md`). Cold lists should be ~100% verified before sending. Score 100 if all verified, 0 if <50%.

### 2. Duplicate email rate
% of duplicate emails. <1% acceptable, >5% is a problem. Score 100 at 0%, drops linearly.

### 3. Duplicate domain concentration
Average and max leads per domain. 1-2 per domain ideal; 5+ means over-indexing on a few companies. Score 100 if avg <2, 60 if 2-5, 30 if >5. Recommend capping per-domain at 3 unless the campaign is intentionally account-based (`/gtm:account-based`).

### 4. Title relevance (vs PERSONA.md)
% of titles matching the workspace's target-title list (exact + synonyms from `PERSONA.md`). If 40% of a "VP Sales" list is actually "Sales Manager", that's drift. Score 100 if ≥80% match, 50 if 40-80%, 0 if <40%.

### 5. Bad-title detection
% of titles matching known-bad patterns: `intern`, `assistant`, `coordinator`, `student`, `part-time`, `retired`, plus non-target-language titles when targeting a single-language geo. <2% normal, >10% means the sourcing filter is too loose. Score 100 if <2%, drops sharply after.

### 6. Catch-all domain density
% of emails on catch-all or role-based addresses (`info@`, `contact@`, `hello@`, `sales@`). <5% acceptable for B2B. Score 100 if <5%, 50 at 5-15%, 0 if >15%.

### 7. ICP fit (vs ICP.md, 2× weight)
% of leads matching `ICP.md` filters on industry + headcount (+ geography/stage where present). Requires firmographic columns. Score 100 at exact match, scaling down; ≥80% is the target.

### 8. Name quality
% of rows with both `first_name` and `last_name` populated and human-looking (not all-caps, not "Admin"/"Info", not the email used as a name). ≥95% acceptable. Score 100 if ≥95%, drops linearly.

---

## Grade

Weighted average across the 8 dimensions (verification and ICP fit weighted 2×):

| Average | Grade | Action |
|---|---|---|
| 90-100 | A+ / A | Ship it |
| 80-89 | B | Minor fixes, then ship |
| 70-79 | C | Fix the top 3 issues first |
| 60-69 | D | Serious cleanup required |
| <60 | F | Do not send — rebuild the list |

**Ship gate:** a list graded below C must not pass `/gtm:ship`. A list graded C must show its top issues at the launch check and require explicit acknowledgement. This rule is non-overridable in auto mode — treat a sub-C grade like a failed launch-check item.

---

## Output format

Display using `ui-brand.md` conventions:

```
<< GTM:OS // LIST QA >>

  ┌─ LIST SCORECARD ──────────────────────────────┐
  │  File: {file} ({n} rows)                       │
  │  Grade: B (84/100)                             │
  │                                                │
  │  1. Email verification    100   [x]            │
  │  2. Duplicate emails       95   [x]            │
  │  3. Domain concentration   78   [!] avg 2.4    │
  │  4. Title relevance        82   [x]            │
  │  5. Bad-title detection    92   [x]            │
  │  6. Catch-all density      80   [!] 8%         │
  │  7. ICP fit                88   [x]            │
  │  8. Name quality           97   [x]            │
  └────────────────────────────────────────────────┘

  Top issues to fix
    !! 23 duplicate emails (1.1%) — dedupe before upload
    !! 64 catch-all addresses (3.0%) — drop or deprioritise
    !! 64 coordinator titles — filter to seniority ≥ Manager
```

End with a pre-send checklist (dedupe, drop catch-all if >5%, filter bad titles, cap per-domain concentration, re-verify if the list shrank >10%).

---

## When to run

- After list building (`/gtm:list-brief` → sourcing) and after `/gtm:enrich email`
- Inside `/gtm:validate-list`, as the final gate before saving to `lists/validated/`
- Before `/gtm:ship`, as part of the launch check

## When not to run

- Lists under 100 rows — sample too small for reliable stats
- Fully static reused lists — grade once, reuse

---

## Relationship to the 1% rule

A list grading below C is very likely to produce a reply rate under 1%, which breaks the baseline-health threshold used by `/gtm:experiment` and `/gtm:health`. Catching list issues here saves the deliverability hangover later. After a clean grade, the next bottleneck is copy (`/gtm:validate-copy`) and infrastructure (`/gtm:inbox-health`).
