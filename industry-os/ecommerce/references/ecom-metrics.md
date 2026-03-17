# Ecommerce Metrics Reference

KPI definitions, formulas, benchmarks, and interpretation guidance for ecommerce operators.

---

## Revenue metrics

### MER — Marketing Efficiency Ratio
**Formula:** Total revenue / Total marketing spend
**What it is:** Blended ROAS across all channels — the single most reliable scaling metric.
**Why it matters:** Individual channel ROAS is biased by attribution model. MER ignores attribution and tells you if marketing is working overall.
**Target:** > 3x for most DTC brands at scale. < 2x is unsustainable unless intentional for acquisition-phase brands with strong LTV.
**When MER falls:** audit spend allocation, ROAS by channel, conversion rates, AOV.

### ROAS — Return on Ad Spend
**Formula:** Revenue attributed to channel / Ad spend on that channel
**What it is:** Platform-level efficiency metric.
**Warning:** Always biased by attribution model. Last-click overstates email and Google Brand; understates Meta and TikTok.
**Use it for:** Comparing campaigns within a channel, not across channels.

### CAC — Customer Acquisition Cost
**Formula:** Total new customer acquisition spend / Number of new customers acquired
**What it is:** The real cost to acquire a new buyer.
**Key relationship:** CAC must be < LTV for a sustainable business. CAC < LTV/3 = excellent.
**Common mistake:** Blending new and returning customer orders in the denominator — this understates true CAC.

### LTV — Customer Lifetime Value
**Formula (simple 12-month):** Average revenue from customers in their first 12 months after first purchase
**Formula (cohort-accurate):** Track cohort of first-time buyers, sum revenue per customer at 12-month mark.
**Why 12 months:** Standard comparison period. Also calculate 6-month LTV for faster feedback loop.

### LTV:CAC Ratio
**Formula:** LTV / CAC
**Targets:**
- < 2:1 = unsustainable (spending more to acquire than they're worth)
- 2–3:1 = acceptable but tight
- 3–5:1 = healthy growth
- > 5:1 = excellent — potentially under-investing in acquisition

### Payback Period
**Formula:** CAC / (Monthly revenue per customer × gross margin %)
**What it is:** Months to recover the cost of acquiring a customer.
**Targets:**
- < 6 months = excellent
- 6–12 months = good
- 12–18 months = acceptable if LTV is high
- > 18 months = risky — cash flow and business model risk

---

## Conversion metrics

### CVR — Conversion Rate
**Formula:** Orders / Sessions × 100
**Benchmarks:** 1.5–3.5% for DTC.
**Below 1%:** Usually a traffic quality or product-market fit issue — not a CRO problem.
**Split by device:** Mobile CVR typically 30–40% lower than desktop. If mobile is > 50% lower, mobile UX is broken.

### AOV — Average Order Value
**Formula:** Total revenue / Number of orders
**How to increase:**
1. Free shipping threshold (set just above current AOV)
2. Bundle pricing ("buy 2, save 15%")
3. Post-add-to-cart upsell (app or native)
4. Gift with purchase threshold
**Don't sacrifice CVR to increase AOV** — a 10% CVR drop for a 10% AOV gain is a break-even trade.

### Cart Abandonment Rate
**Formula:** (Initiated checkouts − Completed orders) / Initiated checkouts × 100
**Industry standard:** 70–80% — this is normal, not a failure.
**Recovery approach:** Abandoned cart flow (email + SMS) recovers 5–15% of abandoned carts.
**Below 70%:** Excellent — usually achieved through streamlined checkout, express payment options, and strong trust signals.

### Add-to-Cart Rate
**Formula:** Add to cart events / Product page views × 100
**Benchmark:** 8–12% for a healthy product page.
**Below 5%:** Product page issue — investigate price, images, copy, reviews.
**Above 15%:** Strong product-page performance — focus optimization energy on checkout.

---

## Retention metrics

### Repeat Purchase Rate (90d)
**Formula:** Customers who made a 2nd purchase within 90 days / All first-time buyers in the period
**Benchmarks:** 20–30% good, 35%+ excellent.
**Why 90d matters:** The 90-day window captures customers who are genuinely retained vs. one-time buyers.
**Low repeat rate (< 15%):** Product or experience issue — investigate returns, reviews, post-purchase flow.

### Email Revenue %
**Formula:** Email-attributed revenue / Total revenue × 100
**Benchmark:** 25–40% for a healthy email program.
**Below 20%:** Email underperforming — check flows, list health, sending frequency.
**Above 40%:** Strong program — monitor for over-reliance on email (suppresses new channel growth).

### Revenue Per Email Sent
**Formula:** Email revenue / Emails sent
**Benchmarks:**
- Flows: $0.50–$2.00+ per email sent (higher because triggered, contextual)
- Campaigns: $0.08–$0.20 per email sent
- Below $0.05: list quality, segmentation, or offer issue

### Churn Rate (subscriptions)
**Formula:** Subscribers cancelled / Total active subscribers × 100 (monthly)
**Benchmarks:** < 5% monthly = acceptable, < 3% = good, < 2% = excellent.
**Annual churn calc:** Monthly churn × 12 (approximate for low churn rates).

---

## Financial metrics

### Gross Margin
**Formula:** (Revenue − COGS) / Revenue × 100
**DTC benchmarks:** 50–70% for physical products. Below 40% = pricing or sourcing issue.
**COGS includes:** Product cost, shipping to customer, returns, packaging.

### Contribution Margin
**Formula:** (Revenue − COGS − Variable marketing costs) / Revenue × 100
**Variable marketing:** Paid ad spend, email/SMS variable costs, affiliate commissions.
**Why it matters:** Gross margin tells you product profitability; contribution margin tells you marketing profitability.
**Floor:** Set minimum contribution margin per SKU in FINANCE.md — never run promotions below this floor.

### Inventory Turnover
**Formula:** COGS / Average inventory value
**Target:** > 4x per year for most categories.
**Below 4x:** Overstock risk — consider liquidation promotion or reduce reorder volumes.
**Above 12x:** Stockout risk — increase safety stock or reduce lead time.

---

## Cohort analysis

Cohort analysis tracks groups of customers who first purchased in the same month, measuring their cumulative revenue over time.

### How to read cohort data
- Row = acquisition month (e.g., "January 2025 cohort")
- Column = months since first purchase (M+1, M+2, etc.)
- Cell value = cumulative revenue per customer in that cohort at that time point

### What to look for
- LTV curves: how does revenue per customer accumulate over 12 months?
- Cohort quality: do recent acquisition cohorts have better or worse LTV than older ones?
- Retention dip: where do customers typically drop off? (This is where to focus retention efforts)
- BFCM cohorts: BFCM buyers typically have lower LTV — factor this out when calculating true CAC efficiency

### Payback calculation using cohorts
Divide CAC by contribution per order. Find the month where cumulative contribution crosses CAC. That's your payback period.
