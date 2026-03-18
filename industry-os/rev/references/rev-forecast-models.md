# REV:OS — Forecast Models

Forecast methodologies, their strengths, weaknesses, and when to use each. Load before running `/rev:forecast` or producing any forecast output.

---

## The Four Forecast Methods

Use at least two methods in combination. Cross-reference to identify outliers and build confidence in the call.

---

### Method 1: Weighted Pipeline (Bottom-Up)

**What it is:** Assign a close probability % to each deal stage, multiply each deal's value by that probability, sum to get the expected revenue.

**Formula:** Σ (Deal Value × Stage Probability %) for all open deals in the quarter

**Standard stage probabilities (override in FORECAST.md if you have company-specific data):**

| Stage | Default probability |
|-------|-------------------|
| SQL / Discovery | 10% |
| Demo / Evaluation | 25% |
| Proposal sent | 40% |
| Verbal close / Legal | 75% |
| Commit (rep-submitted) | 85% |
| Closed Won | 100% |

**Strengths:**
- Simple and transparent — anyone can recalculate
- Directly tied to CRM pipeline; updates when reps update their deals
- Identifies which deals are driving the number

**Weaknesses:**
- Only as good as the stage probabilities — if reps sandbag, probabilities are wrong
- Doesn't account for deal quality within a stage
- Incentivizes reps to pad pipeline to show coverage

**Best for:** Weekly pipeline reviews; communicating forecast to sales team

---

### Method 2: Rep-Submitted Commit (Bottom-Up)

**What it is:** Each rep submits a commit number — the revenue they are prepared to guarantee will close this quarter. RevOps aggregates and applies a judgment discount or premium.

**Formula:** Σ (Rep Commit) ± RevOps Adjustment

**Process:**
1. Reps submit commit by end of Week 1 of the quarter (and update weekly)
2. RevOps reviews each rep's commit vs. their pipeline, deal health, and historical accuracy
3. RevOps applies a judgment factor per rep: adjust up or down based on rep reliability score
4. RevOps produces a "RevOps Call" — the number they're prepared to defend to leadership

**Rep reliability scoring (track in FORECAST.md):**
- Reliable: historically commits within 10% of actual → use commit as-is
- Optimistic: historically commits 15–25% high → discount commit by 15%
- Conservative: historically commits 10–20% low → add 10% to commit

**Strengths:**
- Captures rep judgment and deal nuance that stage probabilities miss
- Creates accountability — reps own their number
- Aggregation can surface outliers (one rep's commit looks very high vs. their pipeline)

**Weaknesses:**
- Dependent on rep honesty and CRM hygiene
- New reps have no reliability score baseline
- Doesn't capture late-breaking deals well

**Best for:** Quarterly forecast call; communicating to CRO and CFO

---

### Method 3: Historical Run Rate (Top-Down)

**What it is:** Project the current quarter's revenue based on historical win rates, deal volume, and pipeline at a comparable point in prior quarters.

**Formula:** (Average closed deals per quarter × Average ACV) × Historical win rate adjustment

**More granular version:**
1. For each open deal in the quarter, find similar deals from prior quarters (same stage, same ACV range, same lead source)
2. Calculate the historical win rate for that cohort
3. Apply that rate to the current deal pool
4. Sum to produce a revenue estimate

**Strengths:**
- Not subject to rep bias — based on historical outcomes
- Works well when pipeline is large enough for statistical reliability
- Useful for sanity-checking bottom-up forecast

**Weaknesses:**
- Backward-looking — doesn't account for current market conditions or product changes
- Requires clean historical CRM data (unreliable if data quality was poor)
- Less actionable for deal-level management

**Best for:** Sanity-checking; early-quarter forecast when individual deals are uncertain

---

### Method 4: Goal-Based / Top-Down (Quota Decomposition)

**What it is:** Start with the revenue target and work backwards to determine what pipeline and activity are needed to hit the number.

**Formula:**
- Required closed revenue = Quota
- Required pipeline = Quota ÷ Win rate × Coverage multiple
- Required new deals created = (Required pipeline − Existing pipeline) ÷ Average ACV

**Use in two directions:**
1. **Forecast:** Assess whether current pipeline is sufficient to hit quota given win rate
2. **Planning:** Determine how much pipeline generation is needed to hit the number

**Strengths:**
- Creates clear connection between pipeline generation and revenue goals
- Forces honest conversation about coverage gaps early
- Useful for quota planning and territory sizing

**Weaknesses:**
- Tells you what you need, not what you'll get — not a true forecast
- Win rate assumption drives everything — must be accurate

**Best for:** Quarterly planning; pipeline coverage checks; SDR/marketing pipeline generation targets

---

## Forecast Cadence

### Weekly (during quarter)

**Every Monday:**
1. Collect rep commit updates from CRM
2. Run weighted pipeline from CRM data
3. Compare: rep commits vs. weighted pipeline vs. last week's call
4. Identify material changes: deals that moved in, moved out, or changed stage
5. Produce a RevOps Call with commentary on what changed and why
6. Flag pipeline gaps: if coverage < 2.5× remaining quota, escalate

**Output:** Forecast Update memo (1 page) — see `rev-reporting.md` for template

### Monthly

**On first Monday of the month:**
1. Full pipeline health review (all stages, all reps)
2. Update historical win rate data for accuracy model
3. Review enrichment decay on active deals
4. Produce Monthly Revenue Report — see `rev-reporting.md`

### Quarterly

**During last month of quarter:**
- Week 10: Identify all deals at risk of not closing; escalate
- Week 11: Final forecast call; identify bridge plan if below target
- Week 12: Board-ready forecast; communicate to exec and finance

**Post-quarter (within 2 weeks of close):**
- Actual vs. forecast variance analysis
- Document forecast misses and why in LEARNINGS.md
- Update rep reliability scores
- Produce Quarterly Revenue Report

---

## Forecast Accuracy Framework

### Tracking forecast accuracy over time

For every forecast call, record in FORECAST.md:
- Date of forecast
- Quarter
- Week of quarter (1–13)
- Forecast amount (RevOps Call)
- Method used
- Actual result (filled in at quarter close)
- Variance %
- Primary cause of miss (if > 10%)

### Common causes of forecast miss

| Cause | Frequency | Fix |
|-------|-----------|-----|
| Close date slippage | 45% of misses | Require close date justification; don't accept "end of quarter" |
| Deal lost in final stage | 20% of misses | Improve proposal → close conversion; deal inspection |
| Late-quarter deal creation not captured | 15% of misses | Build upside model for late-breaking deals |
| Inaccurate rep commit | 15% of misses | Apply rep reliability discount; improve commit process |
| Comp plan incentive distortion | 5% of misses | Review comp plan alignment with RevOps |

### Forecast confidence indicators

Use these to adjust RevOps Call up or down:

**Positive adjustments (add to forecast):**
- Deal has > 3 contacts engaged (multi-threaded = lower churn risk at signature)
- Mutual action plan agreed and documented
- Legal/procurement already engaged
- Economic buyer attended final presentation
- Deal has been through a price negotiation (signals real buying intent)

**Negative adjustments (reduce from forecast):**
- Only 1 contact engaged (single-threaded)
- No activity logged in past 10 days
- Close date unchanged for > 21 days
- Competitor mentioned in recent call notes
- No next step scheduled
- Deal stage advanced without completing stage criteria

---

## Forecast Scenarios

Always present three scenarios with the forecast:

| Scenario | Definition | Use |
|----------|------------|-----|
| Commit | What RevOps is prepared to guarantee | Conservative floor; use for planning |
| Most Likely | Most probable outcome | Primary number for internal use |
| Upside | If all identified upside closes | Ceiling; use for resource planning |

**Scenario presentation format:**
```
Quarter: Q[X] [Year]
Week: [X] of 13

Commit:       $[X]M   ([X]% of quota)
Most Likely:  $[X]M   ([X]% of quota)
Upside:       $[X]M   ([X]% of quota)

vs. last week: [+/-$X] ([reason])

Key risks:
1. [Deal name] — [risk]
2. [Deal name] — [risk]

Key upside:
1. [Deal name] — [upside scenario]
```
