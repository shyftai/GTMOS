# Stripe Configuration

Stripe billing integration, plan mapping, MRR definition, and reconciliation status. Load before any billing reconciliation or MRR analysis.

---

## Integration Status

**Stripe account:** [Account name / ID]
**CRM connection:** [Connected via: Zapier / Workato / Custom / Not connected]
**Sync direction:** Stripe → CRM (one-way) / Bi-directional
**Last sync:** [Date and time]
**Sync health:** [🟢 Healthy / 🟡 Degraded / 🔴 Error]

---

## MRR Definition

**What counts as MRR in this workspace:**

> MRR = [Write your exact definition here]

Example:
> MRR = sum of all active, paid Stripe subscriptions, normalized to monthly value. Annual plans are divided by 12. Monthly plans are used as-is. Excludes: trials, free plans, paused subscriptions, one-time charges, refunded subscriptions, subscriptions in grace period.

**MRR freeze date:** End-of-month snapshot taken at [midnight UTC / 11:59 PM local] on the last calendar day of each month.

**Do not change this definition mid-period.** If the definition changes, document it below as a methodology change and create a new baseline from the change date.

---

## Plan Mapping

Map every Stripe product/price to a CRM product and ARR contribution.

| Stripe Product | Stripe Price ID | Billing | Monthly Value | CRM Product | Segment |
|---------------|----------------|---------|---------------|-------------|---------|
| [Plan name] | price_xxx | Monthly | $[X] | [CRM product] | [SMB/MM/ENT] |
| [Plan name] | price_xxx | Annual | $[X]/mo | [CRM product] | [SMB/MM/ENT] |
| [Plan name] | price_xxx | Monthly | $[X] | [CRM product] | [SMB/MM/ENT] |

**Plans excluded from MRR:**

| Stripe Product | Reason for exclusion |
|---------------|---------------------|
| [Free plan] | Freemium — no revenue |
| [Trial plan] | Trial — unconverted |
| [Setup fee] | One-time — not recurring |

---

## Account Matching

**How Stripe customers are linked to CRM accounts:**

Primary match key: [Stripe customer email domain → CRM account domain]
Secondary match key: [Stripe customer name → CRM account name (fuzzy)]
Manual override: [Stripe metadata field: `crm_account_id` if populated]

**Unmatched customers (resolve manually):**

| Stripe Customer | Email | MRR | CRM Match | Status |
|----------------|-------|-----|-----------|--------|
| [Customer name] | [email] | $[X] | Not found | [Pending / Resolved] |

---

## Reconciliation Log

Run reconciliation monthly. Document results here.

| Month | Stripe MRR | CRM ARR/12 | Variance | Variance % | Status | Notes |
|-------|-----------|------------|----------|-----------|--------|-------|
| [YYYY-MM] | $[X] | $[X] | $[X] | [X]% | [✓ / ⚠ / 🔴] | [Notes] |
| [YYYY-MM] | $[X] | $[X] | $[X] | [X]% | [✓ / ⚠ / 🔴] | [Notes] |

**Reconciliation tolerance:** < 1% variance = acceptable | > 1% = investigate | > 5% = hard stop — do not publish report

---

## Common Reconciliation Issues (Workspace)

[Document any recurring reconciliation issues specific to this workspace.]

| Issue | Frequency | Root cause | Fix |
|-------|-----------|-----------|-----|
| [Issue] | [Monthly/Quarterly] | [Cause] | [Fix] |

---

## Churn Events

Log significant churn events for context.

| Date | Customer | MRR lost | Plan | Churn reason | Win/loss recorded |
|------|----------|----------|------|-------------|------------------|
| [Date] | [Name] | $[X] | [Plan] | [Reason] | [Yes/No] |
