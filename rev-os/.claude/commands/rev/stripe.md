# /rev:stripe

Stripe data reconciliation — sync Stripe subscription data with CRM, reconcile ARR/MRR, and flag discrepancies.

## When to use

- Monthly, before producing any revenue report
- When Stripe and CRM ARR numbers don't match
- After a pricing change or plan restructure
- Before board or investor reporting

---

## What to do

Load `STRIPE.md`, `REVENUE.md`, and `rev-data-standards.md` (Stripe reconciliation standards section).

### Step 1: Check integration status

```
STRIPE INTEGRATION STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Stripe account:   [Account name]
CRM connection:   [Connected via / Not connected]
Last sync:        [Date and time]
Sync health:      [🟢 Healthy / 🟡 Degraded / 🔴 Error / Not configured]

Last reconciliation: [Date]
Last result: [✓ Within tolerance / ⚠ Variance of $X / 🔴 Hard stop — $X variance]
```

If not configured: prompt to configure integration. Offer to document the manual reconciliation process instead.

### Step 2: Pull Stripe MRR

Calculate MRR from Stripe subscriptions using the definition in `STRIPE.md`:

```
STRIPE MRR CALCULATION — [YYYY-MM-DD]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Active subscriptions:   [X]
Included in MRR:        [X]
Excluded (see below):   [X]

Stripe MRR:  $[X]K

Breakdown by plan:
  [Plan A] — [X] customers — $[X]K
  [Plan B] — [X] customers — $[X]K
  [Plan C] — [X] customers — $[X]K

Excluded:
  Trials:     [X] — $[X]K
  Free plans: [X] — $[X]K
  Paused:     [X] — $[X]K
  One-time:   [X] — $[X]K
```

### Step 3: Pull CRM ARR

```
CRM ARR — [YYYY-MM-DD]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Customer accounts with ARR > 0: [X]
Total ARR in CRM: $[X]M
Implied MRR (ARR ÷ 12): $[X]K
```

### Step 4: Reconciliation

```
RECONCILIATION — [YYYY-MM]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Stripe MRR:     $[X]K
CRM MRR:        $[X]K
Variance:        $[X]K  ([X]%)

Status:
  < 1% variance:  ✓ Within tolerance
  1–5% variance:  ⚠ Investigate
  > 5% variance:  🔴 HARD STOP — do not publish revenue report

[Status for this reconciliation: ✓ / ⚠ / 🔴]
```

### Step 5: Investigate variances

For each variance, identify the root cause:

```
VARIANCE ANALYSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Unmatched Stripe customers (no CRM account found):
  [Customer name] — $[X]K MRR — [email domain]
  [Customer name] — $[X]K MRR — [email domain]

CRM accounts with ARR but no matching Stripe customer:
  [Account name] — $[X]K ARR in CRM — no Stripe match
  [Account name] — $[X]K ARR in CRM — no Stripe match

Plan mapping gaps (Stripe plan not in STRIPE.md):
  [Plan ID/name] — [X] customers — $[X]K — unmapped

Currency conversion issues:
  [X] non-USD subscriptions — not converted

Manually entered CRM ARR (no Stripe source):
  [Account name] — $[X]K — entered manually on [date] — by [user]
```

### Step 6: Resolution

For each discrepancy:
- **Unmatched Stripe customer**: Find matching CRM account; link and update ARR field
- **CRM account with no Stripe match**: Verify if customer is actually paying; update CRM
- **Plan mapping gap**: Add to STRIPE.md plan mapping table
- **Manual CRM entry**: Verify against contract; update or remove

For each resolution, present the action and require approval before writing to CRM.

### Step 7: Update and log

After reconciliation:
1. Update `STRIPE.md` reconciliation log with date, Stripe MRR, CRM ARR, variance, status, notes
2. Update `REVENUE.md` MRR with reconciled Stripe figure
3. Log any CRM writes in SCRAPE-JOURNAL.md

### Hard rule

If variance is > 5%, do not produce or share any revenue report until resolved. State clearly: "This reconciliation shows a variance of [X]% ($[X]K). No revenue report should be shared externally until this is resolved."
