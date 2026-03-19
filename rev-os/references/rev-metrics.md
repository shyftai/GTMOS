# REV:OS — Metric Definitions

Canonical definitions, formulas, and calculation standards for all RevOps metrics. Use these definitions as the single source of truth when producing reports, forecasts, or dashboards. When stakeholders use different definitions, align them to these or document the variant explicitly.

---

## Revenue Metrics

### ARR (Annual Recurring Revenue)
**Definition:** The annualized value of all active, recurring subscription revenue at a point in time.
**Formula:** Sum of all active subscriptions × 12 (for monthly plans) or direct annual value
**Include:** All paying customers on active subscriptions
**Exclude:** One-time fees, professional services, trials, freemium, paused subscriptions
**Calculation date:** Use end-of-period snapshot (last day of month/quarter)
**Note:** ARR is a point-in-time metric, not a flow metric. It answers "what is the run rate today?"

### MRR (Monthly Recurring Revenue)
**Definition:** The monthly recurring revenue value of all active subscriptions.
**Formula:** ARR ÷ 12
**Use:** Operational metric for month-over-month tracking; ARR is preferred for board reporting

### MRR Movements (the four components)
Track monthly. These four movements sum to the change in MRR from one month to the next.

| Component | Definition | Formula |
|-----------|------------|---------|
| New MRR | MRR from brand-new customers (first payment) | Sum of MRR from customers with no prior subscription |
| Expansion MRR | Incremental MRR from existing customers (upgrades, seat adds) | MRR this month − MRR last month for customers who increased spend |
| Contraction MRR | MRR reduction from existing customers (downgrades) | MRR last month − MRR this month for customers who reduced spend |
| Churned MRR | MRR lost from customers who cancelled entirely | MRR from customers who were active last month and are not active this month |

**Net New MRR = New MRR + Expansion MRR − Contraction MRR − Churned MRR**

### NRR (Net Revenue Retention)
**Definition:** Revenue retained from existing customers over a period, including expansion and contraction, expressed as a percentage.
**Formula:** ((Opening MRR + Expansion MRR − Contraction MRR − Churned MRR) ÷ Opening MRR) × 100
**Period:** Typically measured over 12 months (annual NRR)
**Cohort:** Measure for the cohort of customers who were active at the start of the period
**Good:** > 110% | Excellent: > 120% | Warning: < 100%

### GRR (Gross Revenue Retention)
**Definition:** Revenue retained from existing customers, excluding expansion. Measures pure retention.
**Formula:** ((Opening MRR − Contraction MRR − Churned MRR) ÷ Opening MRR) × 100
**Note:** GRR can never exceed 100%. It measures your floor — how well you hold onto revenue without expansion.
**Good:** > 88% (mid-market) | Warning: < 80%

### Churn Rate (Revenue Churn)
**Definition:** The percentage of MRR lost in a period from cancellations only (not contraction).
**Formula:** (Churned MRR ÷ Opening MRR) × 100
**Period:** Monthly or annualized
**Annual churn = 1 − (1 − Monthly Churn Rate)^12**
**Warning threshold:** > 2% monthly (> ~22% annual)

### Logo Churn Rate
**Definition:** The percentage of customer accounts that cancelled in a period.
**Formula:** (Customers lost ÷ Opening customer count) × 100
**Note:** Distinguish from revenue churn — a small account churning is a low revenue impact but the same logo churn signal.

---

## Pipeline Metrics

### Pipeline Value
**Definition:** Total ARR value of all open opportunities expected to close within a defined window.
**Standard windows:** Current quarter, next quarter, rolling 90 days, rolling 180 days
**Include:** All deals not marked Closed Won or Closed Lost
**Exclude:** Stalled deals (> 45 days without activity) — flag separately as "at-risk pipeline"

### Pipeline Coverage
**Definition:** The ratio of total pipeline to quota for a given period.
**Formula:** Total pipeline value ÷ Quota
**Standard:** 3× is minimum; 4× is target for early-stage deals; 2× for near-term close
**Use:** Coverage check is mandatory before every forecast call

### Pipeline Velocity
**Definition:** The speed at which deals move through the pipeline, combining deal volume, win rate, deal value, and sales cycle length.
**Formula:** (Number of deals × Win rate × Average deal value) ÷ Average sales cycle length (days)
**Output:** Revenue generated per day from current pipeline
**Use:** Identify which variable most drives improvement — optimize the weakest link

### Average Sales Cycle
**Definition:** The average number of days from opportunity creation to Closed Won.
**Formula:** Sum of (Close date − Creation date) for all Closed Won deals ÷ Count of Closed Won deals
**Segment by:** ACV range, deal type, segment, rep, channel
**Note:** Measure separately for New Business vs. Renewal vs. Expansion

### Win Rate
**Definition:** The percentage of opportunities that reach Closed Won vs. all closed opportunities.
**Formula:** Closed Won count ÷ (Closed Won count + Closed Lost count) × 100
**Exclude:** Deals still open; deals cancelled before reaching a close stage
**Segment by:** Segment, rep, ACV range, lead source, competitor

### Stage Conversion Rate
**Definition:** The percentage of deals that advance from one stage to the next.
**Formula:** Deals reaching Stage N+1 ÷ Deals that entered Stage N × 100
**Use:** Identify which stage is losing the most deals — the biggest drop-off is the bottleneck

---

## Forecast Metrics

### Forecast Call
**Definition:** The RevOps-produced estimate of revenue that will close in the current quarter.
**Components:**
- **Commit:** Deals where the rep has committed to close; high confidence (>85%)
- **Best Case:** Commit + deals that could close with upside; medium confidence (50–85%)
- **Pipeline:** All open deals in the quarter regardless of confidence
- **RevOps Call:** The number RevOps is prepared to stand behind; typically between Commit and Best Case

### Forecast Accuracy
**Definition:** How close the forecast call was to actual results.
**Formula:** |Forecast − Actual| ÷ Actual × 100
**Measure:** At the time of the forecast (e.g., forecast at start of quarter vs. actual at close)
**Target:** Within 5% for quarterly forecast; within 10% is acceptable

### Forecast Coverage
**Definition:** Pipeline coverage at a specific point in the quarter.
**Use:** Coverage drops as the quarter progresses — monitor weekly to flag shortfalls early

---

## Acquisition Metrics

### CAC (Customer Acquisition Cost)
**Definition:** The fully-loaded cost to acquire one new customer.
**Formula:** (Total Sales + Marketing Spend in period) ÷ New customers acquired in period
**Include in spend:** Salaries, commissions, software, ads, events
**Period:** Typically measured over 12 months (LTM) to smooth seasonality
**Segment by:** Channel, segment, product line

### CAC Payback Period
**Definition:** The number of months to recover the cost of acquiring a customer.
**Formula:** CAC ÷ (ACV ÷ 12 × Gross Margin %)
**Good:** < 12 months (PLG/SMB) | < 18 months (mid-market) | < 24 months (enterprise)

### LTV (Customer Lifetime Value)
**Definition:** The total revenue expected from a customer over their lifetime.
**Formula (simple):** ACV ÷ Annual Churn Rate
**Formula (margin-adjusted):** (ACV × Gross Margin %) ÷ Annual Churn Rate
**LTV:CAC ratio target:** > 3× (invest more if lower; efficient if higher)

---

## Attribution Metrics

### Pipeline by Source
**Definition:** The total pipeline value attributed to each lead source.
**Attribution model:** Apply consistently — document the model in ATTRIBUTION.md
**Report cadence:** Monthly

### Revenue by Source
**Definition:** The total Closed Won revenue attributed to each lead source over a period.
**Note:** Attribution model choice materially changes this number — always state the model.

### Marketing Sourced Pipeline %
**Definition:** The percentage of total pipeline that has a marketing-sourced first touch.
**Formula:** Marketing-sourced pipeline ÷ Total pipeline × 100
**Standard:** > 40% for demand-gen-heavy GTM; varies by sales motion

### Time to First Touch → Opportunity
**Definition:** The average number of days from a prospect's first touch (any channel) to opportunity creation.
**Use:** Measures top-of-funnel efficiency; identifies nurture lag

---

## Data Quality Metrics

### CRM Data Quality Score
**Definition:** A composite score measuring the health and completeness of CRM data.
**Formula:** Average field completion rate across required fields, weighted by field importance
**Calculation:** (Fields complete ÷ Fields required) × 100 for each record; average across all records of that type
**Target:** > 85% overall | > 95% for Tier 1 accounts

### Duplicate Rate
**Definition:** The percentage of CRM records that are suspected duplicates.
**Formula:** (Suspected duplicate records ÷ Total records) × 100
**By object:** Calculate separately for Accounts, Contacts, and Deals
**Action threshold:** Accounts > 5% | Contacts > 8% | Deals > 2%

### Enrichment Coverage
**Definition:** The percentage of required enrichment fields that are populated.
**Formula:** (Populated enrichment fields ÷ Required enrichment fields) × 100
**Track by:** Account tier, object type, field

### Stale Record Rate
**Definition:** The percentage of CRM records that have not been updated in > 90 days.
**Formula:** (Records with last_modified_date > 90 days ago ÷ Total active records) × 100
**Warning threshold:** > 20% stale
