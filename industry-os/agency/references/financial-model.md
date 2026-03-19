# Financial Model

Agency financial benchmarks, pricing model, and invoicing rules. Load during onboarding, financial reviews, and when generating invoices or discussing pricing with prospects.

---

## Revenue structure targets

| Revenue type | Target mix | Notes |
|-------------|-----------|-------|
| Retainer MRR | 70–80% of total revenue | Predictable, plannable, high-margin |
| Project revenue | 15–20% | Fills gaps, tests new services, higher per-hour rate |
| Performance / revenue-share | 5–10% | Only for mature client relationships with strong attribution |

If retainer MRR drops below 60% of revenue: flag to ROADMAP.md as a structural risk. Project revenue is lumpy and cannot support team salaries reliably.

---

## Healthy agency benchmarks

| Metric | Benchmark | Notes |
|--------|-----------|-------|
| Gross margin | 55–65% | After direct labor, tools, freelancers, ad spend passthrough (net) |
| Net margin | 15–25% | After all overhead including salaries |
| Revenue per FTE | $150K–$250K/year | Varies by service line; design-heavy agencies trend lower |
| Client concentration | No single client > 25% of MRR | Above this, one churn is a crisis |
| Client LTV | > 24 months average | Target is 3–5 years for retainer clients |
| CAC | 1–3 months of first retainer value | Prospecting + proposal + onboarding time cost |
| LTV:CAC ratio | > 8:1 target | < 5:1 means new business economics are broken |
| Churn rate | < 15% annually | < 10% is excellent |
| Billable utilization | 70–75% of team hours | See capacity-planning.md |

---

## Pricing model

### Pricing philosophy

Value-based pricing is preferred. Price against the value delivered to the client, not the hours spent. Hourly pricing is a fallback only — it commoditizes the work and caps the revenue.

### Retainer pricing

| Agency size | Retainer minimum | Retainer sweet spot |
|-------------|-----------------|---------------------|
| Solo / 1–2 person | $2,000/month | $4,000–$8,000/month |
| Small (3–5 FTE) | $3,000/month | $8,000–$25,000/month |
| Mid-size (6–15 FTE) | $5,000/month | $15,000–$50,000/month |

Below the minimum, delivery quality suffers: the account cannot sustain meaningful account management, strategy, and execution simultaneously.

### Project pricing

- Project work should carry a premium of 20–30% over the retainer equivalent (no ongoing relationship discount; higher risk; no ramp time)
- Minimum project size: [set in PRICING.md] — below this, admin and onboarding costs make the project unprofitable
- Always require 50% deposit before work begins

### Hourly rates (fallback only)

| Role | Rate range |
|------|-----------|
| Senior strategist / director | $200–$350/hour |
| Account manager | $150–$200/hour |
| Specialist (paid, SEO, email) | $150–$250/hour |
| Copywriter | $100–$175/hour |
| Designer | $100–$175/hour |
| Analyst | $100–$150/hour |

Hourly rates are for:
- Out-of-scope revision rounds
- Standalone consulting engagements
- Emergency or rush work (add 25–50% rush premium)

---

## Invoice schedule

### Retainers
- Invoice: 1st of each month
- Due: 15th of each month (Net 15)
- Send via: [agency billing tool / email with PDF]

### Projects
- Invoice 1: 50% deposit on contract signing (before work begins)
- Invoice 2: 25% at agreed midpoint milestone
- Invoice 3: 25% on final delivery and approval

### Late payment protocol

| Day | Action |
|-----|--------|
| Invoice sent | Day 0 |
| No payment | Day 7: send polite reminder email |
| No payment | Day 14: follow-up call or personal email from account manager |
| No payment | Day 21: formal email from principal — payment required or work pauses |
| No payment | Day 30: pause all new work (do not pause in-flight work if it harms the client) |
| No payment | Day 45: refer to collections process if applicable |

Log all late payment events in `clients/{client}/BILLING.md`.

---

## Churn economics

Replacing a churned client costs approximately:

- 3x the client's monthly retainer value in sales and onboarding effort
- 3–6 months of disrupted cash flow during the gap
- Team disruption from sudden capacity shift

**Prevention is 10x cheaper than replacement.** This is why:

- Client health monitoring is weekly, not quarterly
- Renewal outreach starts at 60 days, not 30
- QBRs are mandatory every 90 days for retainer clients
- Red health clients get a same-week intervention, not a scheduled check-in

---

## Revenue concentration risk

If any single client exceeds 25% of total MRR:

1. Flag in FINANCE.md and ROADMAP.md
2. Accelerate new business to reduce concentration
3. Do not let this client exceed 35% under any circumstances
4. Ensure the client relationship is healthy and multi-threaded (multiple contacts, not just one stakeholder)

---

## Tools and cost management

Track all tool costs in COSTS.md. Target tools budget at < 5% of MRR. Review quarterly:

- Are all tools actively used?
- Are credits being wasted?
- Can any tools be consolidated?
- Are any tools being used without a cost log entry?
