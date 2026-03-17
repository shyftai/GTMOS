---
name: ecom:retention
description: Retention analysis and win-back campaign — assess LTV, repeat rates, and reactivate lapsed customers
argument-hint: "<workspace-name>"
---

<objective>
Run a retention health check and identify the highest-leverage retention action: win-back campaign, LTV improvement, subscription or loyalty setup, or flow optimization. Produce an actionable plan with copy assets where applicable.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./references/email-flows.md
@./references/ecom-metrics.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // RETENTION >>
{workspace name} — {date}
```

2. Load METRICS.md, FLOWS.md, AUDIENCES.md, PRODUCTS.md, FINANCE.md, SUPPRESSION.md, LEARNINGS.md.

3. Run retention health check:

Compare each metric against benchmarks from ecom-metrics.md and ecom-benchmarks.md:

| Metric | Current | Benchmark | Status |
|--------|---------|-----------|--------|
| 90d repeat purchase rate | {X%} | 20–30% | Green/Yellow/Red |
| LTV:CAC | {X}:1 | > 3:1 | |
| Email revenue % of total | {X%} | 25–40% | |
| Win-back flow performance | ${rev/recipient} | > $0.15 | |
| Average flow rev/recipient | ${X} | > $0.40 | |

4. Identify win-back queue: customers with no purchase in 90+ days who are not already in a win-back flow and are not suppressed.

5. Ask: What do you want to focus on?
   - A. Win-back campaign — reactivate lapsed customers
   - B. LTV improvement — cross-sell or upsell to existing buyers
   - C. Subscription or loyalty program setup
   - D. Flow optimization — improve underperforming flows
   - E. Full retention review (run all)

---

**WIN-BACK CAMPAIGN:**

6. Confirm win-back segment:
   - Check SUPPRESSION.md (suppression gate — hard) — never contact suppressed contacts
   - Check FLOWS.md (flow conflict check) — exclude contacts already in win-back flow
   - Identify addressable win-back audience size

7. Generate 3-email win-back sequence using email-flows.md template:
   - Email 1 (Day 90): "What's new" — no hard sell, brand warmth
   - Email 2 (Day 97): Offer — 15% off or free shipping
   - Email 3 (Day 104): Last chance urgency

For each email:
   - 3 subject line variants
   - Preview text
   - Full email copy
   - CTA
   - UTM parameters

8. Optional: SMS supplement (one message at Day 97 timing if SMS list is available)

9. Define post-sequence logic: if no purchase after Email 3 → move to low-frequency segment (not hard suppression unless they unsubscribe)

10. Margin check: confirm the win-back offer (% off) does not push featured SKU below contribution margin floor (FINANCE.md).

---

**LTV IMPROVEMENT:**

6. Identify cross-sell opportunity:
   - Most purchased product combinations (from PRODUCTS.md and purchase history)
   - Products that do not have an active post-purchase cross-sell email (check FLOWS.md)

7. Generate cross-sell email:
   - Audience: customers who bought SKU X but not SKU Y
   - Framing: "Complete your routine" / "Customers who bought X also love Y"
   - Subject, copy, CTA, UTMs

8. Identify upsell opportunity:
   - Bundle discount for repurchasers: "Subscribe and save 15%"
   - VIP threshold offer to drive up into higher loyalty tier

---

**SUBSCRIPTION OR LOYALTY SETUP:**

6. Ask: Which does the brand need more — predictable recurring revenue (subscription) or repeat purchase frequency (loyalty)?

7. Subscription setup brief:
   - Which products are candidates (consumables with natural repurchase cadence)?
   - Discount structure recommendation (10–15% off for subscribe-and-save)
   - Platform recommendation based on TOOLS.md (Recharge / Skio)
   - Email flow needed: subscription welcome + skip/pause reminder + churn save

8. Loyalty setup brief:
   - Program type recommendation: points-based or tiered?
   - Platform recommendation based on TOOLS.md (Smile.io / LoyaltyLion)
   - Tier structure and benefits
   - Launch email sequence

---

11. Output retention health summary and recommended action:
```
┌─ RETENTION HEALTH ────────────────────────────────────────────┐
│                                                               │
│  90d repeat rate: {X%}  — {Green/Yellow/Red}                 │
│  LTV:CAC: {X}:1  — {Green/Yellow/Red}                        │
│  Email revenue %: {X%}  — {Green/Yellow/Red}                  │
│                                                               │
│  Win-back queue: {X} addressable contacts                     │
│                                                               │
│  Recommended action: {primary action}                         │
│  Expected impact: {revenue estimate or metric improvement}    │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

12. Update LEARNINGS.md with retention findings and any new strategic insight.

13. Log to `logs/workspace-log.md`.

</process>
