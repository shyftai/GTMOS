---
name: ecom:health
description: Full health check across all three loops — Acquire, Convert, Retain — plus finance
argument-hint: "<workspace-name>"
---

<objective>
Run a comprehensive health check across all three operational loops and finance. Score each area against benchmarks. Produce a health score, key findings, and the top 3 highest-impact actions. Log to health-log.md and update LEARNINGS.md with strategic findings.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./references/ecom-benchmarks.md
@./references/ecom-metrics.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // HEALTH CHECK >>
{workspace name} — {date}
```

2. Load all workspace files: METRICS.md, CHANNELS.md, FLOWS.md, FINANCE.md, PRODUCTS.md, AUDIENCES.md, CALENDAR.md, LEARNINGS.md, ROADMAP.md.

3. Run checks for each loop:

---

**ACQUIRE HEALTH:**

| Check | Value | Benchmark | Score |
|-------|-------|-----------|-------|
| Blended MER | {X}x | > 3x | G/Y/R |
| Meta ROAS | {X}x | > 2.5x | G/Y/R |
| Google ROAS | {X}x | > 3x | G/Y/R |
| CAC trend | {rising/flat/falling} | Flat or falling | G/Y/R |
| Email list growth | {X%/mo} | 3–5%/mo | G/Y/R |
| Budget utilization | {X%} | 85–100% | G/Y/R |
| Creative age | {X weeks} | < 4 weeks | G/Y/R |
| Campaigns planned (next 30d) | {count} | > 0 | G/Y/R |

Scoring:
- Green: meets "good" benchmark
- Yellow: between average and good
- Red: below average or missing entirely

---

**CONVERT HEALTH:**

| Check | Value | Benchmark | Score |
|-------|-------|-----------|-------|
| Site CVR | {X%} | 1.5–3.5% | G/Y/R |
| Cart abandonment rate | {X%} | 70–80% | G/Y/R |
| AOV vs. target | {±X%} | Within 10% | G/Y/R |
| Add to cart rate | {X%} | 8–12% | G/Y/R |
| Mobile CVR gap | {X% below desktop} | < 40% gap | G/Y/R |
| LCP mobile | {X}s | < 2.5s | G/Y/R |

---

**RETAIN HEALTH:**

| Check | Value | Benchmark | Score |
|-------|-------|-----------|-------|
| 90d repeat purchase rate | {X%} | 20–30% | G/Y/R |
| LTV:CAC | {X}:1 | > 3:1 | G/Y/R |
| Email revenue % | {X%} | 25–40% | G/Y/R |
| Welcome Series rev/recipient | ${X} | > $0.50 | G/Y/R |
| Abandoned Cart rev/recipient | ${X} | > $2.00 | G/Y/R |
| Post-Purchase rev/recipient | ${X} | > $0.40 | G/Y/R |
| Win-back flow active | Yes/No | Yes | G/Y/R |
| Win-back queue size | {X} contacts | < 10% of list | G/Y/R |

---

**FINANCE HEALTH:**

| Check | Value | Benchmark | Score |
|-------|-------|-----------|-------|
| Contribution margin | {X%} | > floor in FINANCE.md | G/Y/R |
| MER trend (3-month) | {improving/flat/declining} | Stable or improving | G/Y/R |
| Budget pacing | {under/on/over} | On pace | G/Y/R |
| Inventory health | {months of stock} | 2–4 months | G/Y/R |
| OOS SKUs | {count} | 0 (with active campaigns) | G/Y/R |

---

4. Calculate health score for each loop:
- All checks Green = Loop is Healthy
- 1–2 checks Yellow = Loop needs attention
- Any check Red = Loop has issues
- Majority Red = Loop is underperforming

5. Display health summary:
```
┌─ ECOMMERCE HEALTH ─── {date} ─────────────────────────────────┐
│                                                               │
│  Acquire:  {Green / Yellow / Red}                             │
│  Convert:  {Green / Yellow / Red}                             │
│  Retain:   {Green / Yellow / Red}                             │
│  Finance:  {Green / Yellow / Red}                             │
│                                                               │
│  Key findings:                                                │
│  {RED finding 1} — loop: {loop}, metric: {metric}            │
│  {RED finding 2}                                              │
│  {YELLOW finding 1}                                           │
│                                                               │
│  Top 3 actions (by revenue impact):                           │
│  1. {action} — {loop} — expected impact: {estimate}          │
│     Command: {/ecom:command workspace}                        │
│                                                               │
│  2. {action} — {loop}                                         │
│     Command: {/ecom:command workspace}                        │
│                                                               │
│  3. {action} — {loop}                                         │
│     Command: {/ecom:command workspace}                        │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

6. Write to `logs/health-log.md`:
```
{date} Health check
Acquire: {score}  Convert: {score}  Retain: {score}  Finance: {score}
Key findings: {brief summary}
Actions taken: {to be filled after acting}
```

7. Update LEARNINGS.md if the health check reveals a pattern worth persisting:
   - e.g. "Meta ROAS systematically underperforms during [month] — reduce budget, increase email push"
   - e.g. "Cart abandonment always spikes after promotional email — investigate checkout experience"

8. Update ROADMAP.md if health check findings require strategic action:
   - Add initiative to the planned or backlog section
   - Flag any ROADMAP.md target that is now at risk based on current health scores

</process>
