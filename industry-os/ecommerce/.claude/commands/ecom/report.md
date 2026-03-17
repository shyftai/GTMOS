---
name: ecom:report
description: Weekly or monthly performance report across all channels and loops
argument-hint: "<workspace-name> [weekly|monthly] [period]"
---

<objective>
Generate a structured performance report for the specified period. Every metric must have a source. Narrative must match data. Update METRICS.md and LEARNINGS.md after every report.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./references/ecom-metrics.md
@./references/ecom-benchmarks.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // REPORT >>
{workspace name} — {period}
```

2. Ask: Report type — weekly or monthly?
3. Ask: Which period? (e.g. "Week of Mar 10" or "February 2026")

4. Load METRICS.md, CHANNELS.md, FLOWS.md, FINANCE.md, CALENDAR.md.

---

**WEEKLY REPORT:**

Structure:

```
┌─ WEEKLY REPORT ─── {week of date} ────────────────────────────┐
│                                                               │
│  Revenue: ${X}  (vs prior week: {±Y%})  (MTD: ${Z})          │
│  Orders: {count}  AOV: ${X}                                   │
│  ROAS (blended): {X}x  (vs prior week: {±Y%})                 │
│                                                               │
│  Acquire:                                                     │
│  Meta: ${spend}  {ROAS}x ROAS  (vs last week: {±Y%})         │
│  Google: ${spend}  {ROAS}x ROAS  (vs last week: {±Y%})       │
│  New customers: {count}  CAC: ${X}                            │
│  Email list: {+X this week}  ({Y} total active)               │
│                                                               │
│  Convert:                                                     │
│  CVR: {X%}  AOV: ${Y}  Abandonment: {Z%}                     │
│                                                               │
│  Retain:                                                      │
│  Email campaigns: {count sent}  Open: {X%}  Rev: ${Y}         │
│  Top flow: {name} — ${revenue}                                │
│                                                               │
│  Finance:                                                     │
│  Marketing spend: ${X} / ${budget} this week                  │
│  Contribution margin: {X%} (floor: {Y%})                      │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

Top 3 wins this week:
1. {win — what happened and why it matters}
2. {win}
3. {win}

Top 3 issues or watch items:
1. {issue — what's underperforming and proposed response}
2. {issue}
3. {issue}

Next week priorities:
1. {specific action with expected impact}
2. {specific action}
3. {specific action}

---

**MONTHLY REPORT:**

Structure:

**Executive summary (1 paragraph):** Revenue vs. target, primary win, primary challenge, one strategic call-out.

**Revenue:**
- Monthly revenue vs. target: ${X} / ${Y} ({±Z%})
- Revenue breakdown by channel: Email {X%}, Paid {Y%}, Organic {Z%}
- YoY comparison (if prior year data available)
- Revenue trend: 3-month chart (text table)

**Acquire:**
- New customers acquired: {count} vs. target
- CAC: ${X} vs. target ${Y}
- ROAS by channel vs. target and benchmark
- Email list growth: {+X this month} ({Y} total, {Z%} active)
- Best performing campaign and why

**Convert:**
- CVR vs. prior month and benchmark
- AOV vs. prior month and target
- Cart abandonment rate trend
- Top converting product

**Retain:**
- Repeat purchase rate (90d): {X%} vs. benchmark
- Email revenue % of total: {X%} vs. 25–40% benchmark
- Flow performance: each flow revenue and trend
- Win-back queue size
- Churn signal (if any new patterns)

**Finance:**
- Contribution margin: {X%} vs. floor {Y%}
- MER: {X}x vs. target {Y}x — trend (3-month)
- Total marketing spend vs. budget
- Channel efficiency: which channels are over/under-performing budget?

**Learnings — what to test next:**
- 2–3 hypotheses based on this month's data
- Each with: observation, hypothesis, test recommendation

**Priorities for next month:**
- Top 3 initiatives with owner and expected impact

---

5. Quality gate before presenting:
   - [ ] Every number has a source (METRICS.md, CHANNELS.md, FLOWS.md, or FINANCE.md)
   - [ ] Narrative matches data — no contradictions
   - [ ] At least one recommendation per section
   - [ ] Wins and issues are specific, not generic

6. After report is approved:
   - Update METRICS.md with the period's performance snapshot (weekly or monthly log)
   - Update LEARNINGS.md with any insights from this period that should persist
   - For monthly: update ROADMAP.md if the data signals a target miss or new opportunity

7. Log report generation to `logs/workspace-log.md`.

</process>
