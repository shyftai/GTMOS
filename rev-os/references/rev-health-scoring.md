# REV:OS — Health Scoring

How to build, calibrate, and maintain a customer health score. Load before configuring `/rev:cs-health` or building a health score for the first time.

---

## What a health score is (and isn't)

A health score is a single number (0–100) that represents the probability a customer will renew and expand. It is:

- **Predictive** — it should correlate with actual churn and renewal outcomes
- **Actionable** — every drop should point to a specific CSM action
- **Dynamic** — it updates automatically as the underlying data changes

It is NOT:
- A measure of customer satisfaction alone (NPS is one input, not the score)
- A vanity metric ("our average health is 87%" means nothing if it doesn't predict churn)
- Static — a health score that never changes is broken

---

## The five signal categories

A robust health score combines signals across five categories. Weight each based on what actually predicts churn at your company — run a regression against historical churn data once you have 50+ churned accounts.

### 1. Product engagement (weight: 30–40%)

The strongest predictor of churn for most SaaS companies. Customers who don't use the product churn.

| Signal | What to measure | Healthy threshold |
|--------|----------------|------------------|
| Login frequency | DAU/MAU ratio | > 0.3 (30% of users active daily) |
| Core feature adoption | % of seats/users who used key feature in last 30d | > 60% |
| Breadth of feature use | % of licensed features used | > 50% |
| API call volume (if applicable) | Calls per day vs. prior period | Not declining > 20% MoM |
| Export / share / invite events | Collaboration actions | Present |

**Warning signals:**
- No login in > 14 days (any user on account)
- Core feature use dropped > 30% MoM
- Admin user hasn't logged in for > 30 days

### 2. Relationship and engagement (weight: 20–25%)

Measures how engaged the customer is with your team — not just the product.

| Signal | What to measure | Healthy threshold |
|--------|----------------|------------------|
| Last CSM activity | Days since last logged touchpoint | < 21 days |
| QBR cadence | Days since last QBR | < 90 days |
| Executive sponsor engaged | EBR or exec call in last 6 months | Yes |
| Champions identified | ≥ 2 contacts marked as champion | Yes |
| Response rate | Do they respond to CSM outreach? | > 50% |

**Warning signals:**
- No CSM activity in > 30 days
- QBR overdue > 30 days
- All champions have left the company (contact churn)
- CS emails going unanswered

### 3. Support and sentiment (weight: 15–20%)

Support signals are leading indicators. A sudden ticket spike often precedes churn.

| Signal | What to measure | Healthy threshold |
|--------|----------------|------------------|
| NPS score | Most recent NPS response | > 7 (Promoter) |
| NPS trend | Δ from prior NPS | Not declining > 2 points |
| Open tickets | Count of unresolved support tickets | < 3 |
| Ticket volume trend | Tickets this month vs. prior month | Not increasing > 50% |
| Critical/P1 tickets | Open P1 or escalated tickets | 0 |
| CSAT (if collected) | Post-ticket CSAT score | > 4/5 |

**Warning signals:**
- NPS drops below 7 (Neutral) — immediate outreach
- NPS drops below 0 (Detractor) — hard gate: CSM + manager call this week
- P1 or escalated ticket open > 5 days unresolved
- Ticket volume doubles MoM

### 4. Commercial health (weight: 15–20%)

Revenue signals that indicate risk or opportunity.

| Signal | What to measure | Healthy threshold |
|--------|----------------|------------------|
| Payment status | Any failed or overdue invoices | No failures |
| Contract days remaining | Days until renewal | > 60 days (< 60 = renewal motion activated) |
| ARR trend | Growing / stable / contracting | Stable or growing |
| Seats utilization | % of licensed seats with active users | > 70% |
| Expansion signals | At usage limit / feature limit | Flag for expansion |

**Warning signals:**
- Invoice payment failure (immediate flag)
- < 60 days to renewal without renewal conversation started
- Seats utilization < 40% — at risk of downsell
- ARR contracting quarter-over-quarter

### 5. Organizational stability (weight: 5–10%)

External signals about the customer's company that indicate risk.

| Signal | What to measure | Healthy threshold |
|--------|----------------|------------------|
| Champion still employed | Primary champion still at company | Yes |
| Economic buyer still employed | CFO/CRO/CEO still at company | Yes |
| Company headcount trend | Growing / stable / declining | Stable or growing |
| Funding status | Recent funding round | Not low on runway |
| News/PR signals | Layoffs, leadership change, acquisition | None negative |

**Warning signals:**
- Champion or economic buyer leaves the company — hardest churn signal
- Company announces layoffs > 10% of workforce
- Company acquired (new owner may consolidate tools)

---

## Scoring formula

### Simple weighted average (recommended for most teams)

```
Health Score =
  (Product engagement score × 0.35) +
  (Relationship score × 0.25) +
  (Support score × 0.20) +
  (Commercial score × 0.15) +
  (Org stability score × 0.05)
```

Each component is scored 0–100 independently, then weighted and summed.

**Document your weights in `CS-CONFIG.md`.** The weights above are starting defaults — calibrate against your actual churn data once you have 50+ data points.

### Component scoring

**Product engagement (0–100):**
```
100 = DAU/MAU > 0.4 AND core feature > 80% AND no decline
80  = DAU/MAU > 0.3 AND core feature > 60%
60  = DAU/MAU > 0.2 AND core feature > 40%
40  = DAU/MAU > 0.1 OR core feature > 20%
20  = Any login activity in last 30 days
0   = No login in last 30 days
```

**Relationship (0–100):**
```
100 = CSM activity < 14d AND QBR < 60d AND exec engaged AND ≥2 champions
80  = CSM activity < 21d AND QBR < 90d AND ≥1 champion
60  = CSM activity < 30d AND QBR < 120d
40  = CSM activity < 45d
20  = CSM activity < 60d
0   = No CSM activity in 60+ days
```

**Support (0–100):**
```
100 = NPS 9–10 AND 0 open tickets AND no P1s in 90d
80  = NPS 7–8 AND < 2 open tickets
60  = NPS 6–7 AND < 5 open tickets
40  = NPS 4–6 OR > 5 open tickets
20  = NPS < 4 OR open P1 ticket
0   = NPS < 0 (Detractor) OR escalated and unresolved
```

### Override rules (hard overrides regardless of score)

Some signals are so severe they override the composite score:

| Condition | Override |
|-----------|---------|
| Champion or economic buyer left company | Score capped at 40 (🟡) |
| Payment failure unresolved > 7 days | Score capped at 30 (🔴) |
| NPS Detractor (< 0) | Score capped at 35 (🔴) |
| No product login in > 30 days | Score capped at 25 (🔴) |
| Open P1 ticket > 7 days unresolved | Score capped at 40 (🟡) |

Override rules are documented in `CS-CONFIG.md`. They cannot be disabled — if the override fires, the CSM must address the root cause before the score can recover.

---

## Score → status mapping

| Score | Status | What it means | Required CSM action |
|-------|--------|--------------|---------------------|
| 75–100 | 🟢 Green | On track for renewal; expansion potential | Monthly check-in; QBR every 90 days |
| 50–74 | 🟡 Yellow | At risk — some signals declining | Increase touch frequency; identify root cause; 2-week recovery plan |
| 25–49 | 🔴 Red | High churn risk — intervention needed | Immediate CSM call; escalate to manager if no response in 48h; executive outreach |
| 0–24 | 🚨 Critical | Near-certain churn without intervention | CSM + VP CS + executive sponsor all engaged; recovery plan with exec |

---

## Health score calibration

**Calibrate your model by running this analysis quarterly:**

1. Pull all accounts that churned in the last 12 months
2. Look at their health scores 90, 60, 30, and 14 days before churn
3. Find the score threshold below which > 80% of churned accounts fell at 30 days out
4. That is your 🔴 Red threshold — set it in `CS-CONFIG.md`

**A well-calibrated model should:**
- Flag > 75% of churned accounts as 🔴 Red at 30 days before churn
- Have < 20% of renewed accounts reach 🔴 Red (minimize false positives)
- Show 🟢 Green accounts renewing at > 90% rate

If your model doesn't meet these thresholds, adjust weights or add/remove signals.

---

## Health score decay

Health scores should decay automatically when data isn't refreshed. Configure in `CS-CONFIG.md`:

| Signal type | Decay starts | Decay rate |
|-------------|-------------|-----------|
| Product usage | Not updated in 7 days | -5 points per day |
| NPS | Not updated in 90 days | -3 points per week after 90d |
| CSM activity | Not logged in 21 days | -3 points per week |
| Health score manually set | 30 days after manual override | Returns to calculated score |

**Why decay matters:** A health score frozen in time is worse than no score. If your integration breaks and data stops flowing, scores should degrade to reflect the uncertainty — not stay green indefinitely.

---

## Building a health score from scratch

For teams that don't have a CS platform yet. Run `/rev:onboard` first to set up the workspace, then:

**Week 1:**
1. Define your key activation event (the moment a customer first gets value)
2. List the top 5 reasons customers have churned historically
3. Map those reasons to measurable signals (usually product + engagement)
4. Define your scoring formula and document in `CS-CONFIG.md`

**Week 2:**
1. Export current customer list with available data
2. Score each customer manually against the formula
3. Populate `CUSTOMERS.md` with initial scores
4. Identify the top 10 accounts to call based on score

**Ongoing:**
1. Update scores weekly (manual) or connect data sources for automation
2. Calibrate model every quarter against actual churn outcomes
3. Graduate to a CS platform when manual updates take > 2 hours/week
