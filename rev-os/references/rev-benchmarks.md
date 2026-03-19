# REV:OS — Revenue Operations Benchmarks

Reference benchmarks for assessing pipeline health, data quality, forecast accuracy, and process performance. Use these when running health checks, producing reports, or calibrating a client's RevOps maturity.

Source: aggregated from OpenView, Salesforce State of Sales, ChurnZero, HubSpot Research, Gartner, and industry surveys 2023–2025.

---

## Pipeline Benchmarks

### Stage conversion rates (B2B SaaS, mid-market ACV $20K–$100K)

| Stage transition | Median conversion | Top quartile |
|-----------------|-------------------|--------------|
| MQL → SQL | 20–30% | 35%+ |
| SQL → Discovery | 55–65% | 70%+ |
| Discovery → Demo | 60–70% | 75%+ |
| Demo → Proposal | 40–55% | 60%+ |
| Proposal → Close | 25–35% | 40%+ |
| Overall (MQL → Close) | 2–5% | 7%+ |

### Pipeline velocity (average deal age per stage)

| Stage | Median days | Flag if > |
|-------|-------------|-----------|
| SQL (pre-discovery) | 3–7 days | 14 days |
| Discovery | 7–14 days | 21 days |
| Demo / evaluation | 14–21 days | 30 days |
| Proposal / negotiation | 10–21 days | 30 days |
| Verbal close (legal/procurement) | 14–30 days | 45 days |

### Pipeline coverage requirements

| Scenario | Recommended coverage |
|----------|---------------------|
| Early stage deals (60+ days) | 4× quota |
| Mid-funnel (30–60 days to close) | 3× quota |
| Near-term (< 30 days to close) | 2× quota |
| Commit + best case combined | 1.5× quota |

### Average sales cycle length by ACV

| ACV range | Typical sales cycle |
|-----------|---------------------|
| < $10K | 14–30 days |
| $10K–$50K | 30–60 days |
| $50K–$150K | 60–120 days |
| $150K+ | 90–180 days |

---

## Forecast Accuracy Benchmarks

| Accuracy level | Definition | Target |
|----------------|------------|--------|
| Excellent | Within 5% of actual | Top quartile RevOps teams |
| Good | Within 10% of actual | Median target |
| Acceptable | Within 15% of actual | Minimum acceptable |
| Poor | > 15% variance | Requires process review |

**Key drivers of forecast inaccuracy:**
- Stage definitions not enforced (deals advanced without completing criteria)
- Close dates not updated (stale close dates inflate the forecast)
- CRM not used consistently (deals in reps' heads, not in the system)
- Late-quarter deals (Q4 hockey stick distorts forecast)

---

## Data Quality Benchmarks

### CRM contact/account record completeness

| Field | Minimum acceptable | Best practice |
|-------|--------------------|---------------|
| Company name | 99% | 100% |
| Industry | 70% | 90%+ |
| Employee count | 60% | 85%+ |
| Primary contact email (valid) | 85% | 95%+ |
| Contact phone | 40% | 70%+ |
| LinkedIn URL | 40% | 70%+ |
| Opportunity owner | 99% | 100% |
| Close date (current + valid) | 95% | 99%+ |
| Deal stage (with last updated) | 99% | 100% |
| ARR / deal value | 95% | 99%+ |

### Duplicate rates (acceptable thresholds)

| Object | Acceptable dupe rate | Action threshold |
|--------|---------------------|-----------------|
| Contacts | < 5% | Dedupe if > 8% |
| Accounts / Companies | < 3% | Dedupe if > 5% |
| Deals / Opportunities | < 2% | Investigate immediately |
| Leads (if separate object) | < 10% | Dedupe if > 15% |

### Data decay rates (industry average)

- Contact email decay: ~25% per year (email changes, people leave jobs)
- Contact phone decay: ~30% per year
- Job title decay: ~20% per year (promotions, restructuring)
- Company headcount decay: ~15% per year

**Recommended enrichment cadence:**
- Full re-enrichment of active deals: every 30 days
- Full re-enrichment of ICP accounts: every 90 days
- Full re-enrichment of cold/unengaged contacts: every 180 days

---

## Win/Loss Benchmarks

### Average win rates by segment

| Segment | Median win rate | Top quartile |
|---------|----------------|--------------|
| SMB (< 100 employees) | 20–30% | 35%+ |
| Mid-market (100–1000 employees) | 15–25% | 30%+ |
| Enterprise (1000+ employees) | 10–20% | 25%+ |
| Overall (blended) | 15–25% | 30%+ |

### Most common loss reasons (B2B SaaS)

1. Lost to competitor (34%)
2. No decision / status quo (26%)
3. Price / budget (18%)
4. Timing (12%)
5. Product gap (10%)

**Win/loss interview completion rate:** Aim for > 50% of all closed deals (won and lost) having a completed win/loss record within 14 days of close.

---

## Attribution Benchmarks

### Typical channel contribution to pipeline (B2B SaaS)

| Channel | Typical % of pipeline created |
|---------|-------------------------------|
| Outbound (SDR/AE-led) | 30–40% |
| Inbound (content/SEO/events) | 25–35% |
| Partner / referral | 15–25% |
| Product-led / self-serve | 10–20% |
| Paid (SEM/social) | 5–15% |

**Note:** These vary significantly by company stage, sales motion, and ACV. Benchmark against your own historical data before comparing to industry averages.

### Multi-touch attribution model selection guide

| Model | Best for | Distortion risk |
|-------|----------|-----------------|
| First touch | Brand awareness measurement | Over-credits top-of-funnel |
| Last touch | Conversion optimization | Over-credits closers |
| Linear | Equal activity weighting | Under-credits high-impact touches |
| Time decay | Recent-touch-heavy sales cycles | Penalizes nurture campaigns |
| Data-driven (Shapley) | Best overall if data volume supports | Requires 1000+ deals |

---

## Retention and Expansion Benchmarks

### Net Revenue Retention (NRR) by company stage

| Company profile | Median NRR | Top quartile |
|----------------|------------|--------------|
| Early stage (< $5M ARR) | 100–110% | 120%+ |
| Growth stage ($5M–$50M ARR) | 105–115% | 125%+ |
| Scale stage ($50M+ ARR) | 110–120% | 130%+ |

### Gross Revenue Retention (GRR) benchmarks

| Segment | Acceptable GRR | Best practice |
|---------|---------------|---------------|
| SMB-focused | 75–85% | 88%+ |
| Mid-market | 82–88% | 92%+ |
| Enterprise | 88–92% | 95%+ |

### Churn alert thresholds

- Gross monthly churn > 2%: immediate investigation
- NRR < 95%: contraction exceeds expansion — priority intervention
- Time-to-first-value (TTFV) > 30 days: onboarding at-risk
- Product login frequency dropping > 30% MoM: churn signal

---

## RevOps Team Benchmarks

### RevOps headcount ratios

| Company stage | RevOps : GTM ratio |
|--------------|-------------------|
| < 50 employees | 1 RevOps per 15–20 GTM |
| 50–200 employees | 1 RevOps per 10–15 GTM |
| 200–500 employees | 1 RevOps per 8–12 GTM |
| 500+ employees | 1 RevOps per 6–10 GTM |

### Typical RevOps time allocation (target vs. reality)

| Activity | Target allocation | Common reality |
|----------|------------------|----------------|
| Strategic analysis | 30% | 10–15% |
| Process improvement | 20% | 10% |
| Reporting and dashboards | 20% | 25–30% |
| Data quality and cleanup | 15% | 25–30% |
| Ad-hoc requests | 15% | 25–35% |

**Signal:** If data quality and ad-hoc requests exceed 50% of time, the RevOps function is in reactive mode — structural process and data fixes are needed.
