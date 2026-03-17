---
name: ecom:dashboard
description: Full four-panel performance view — Acquire / Convert / Retain / Finance — with benchmarks
argument-hint: "<workspace-name>"
---

<objective>
Display a complete performance dashboard across all three loops and finance. Surface where performance is above and below benchmark. Recommend the top 3 actions with the highest expected impact.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./references/ecom-benchmarks.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // DASHBOARD >>
{workspace name} — {date}
```

2. Load all workspace files: METRICS.md, CHANNELS.md, FLOWS.md, FINANCE.md, PRODUCTS.md, AUDIENCES.md, CALENDAR.md.

3. Display the four-panel dashboard:

```
┌─ ACQUIRE ────────────────────────────────────────────────────┐
│                                                              │
│  Paid channels:                                              │
│  Meta:   ${spend} spent  {ROAS}x ROAS  {vs target ±}        │
│  Google: ${spend} spent  {ROAS}x ROAS  {vs target ±}        │
│  Blended MER: {X}x  (target: {Y}x)                          │
│                                                              │
│  Email / SMS:                                                │
│  List: {X} subs ({Y%} active)  Growth: {+Z/wk}              │
│  Rev/email: ${X}  Open rate: {Y%}                            │
│                                                              │
│  Top campaign this month: {name} — ${revenue}               │
│  Upcoming: {next promo or launch from CALENDAR.md}           │
│                                                              │
└──────────────────────────────────────────────────────────────┘

┌─ CONVERT ────────────────────────────────────────────────────┐
│                                                              │
│  Site CVR: {X%}  (benchmark: 1.5–3.5%)  {status indicator}  │
│  AOV: ${X}  (vs target: ${Y})  {trend arrow}                 │
│  Cart abandonment: {X%}  (benchmark: 70–80%)                 │
│  Add to cart rate: {X%}  (benchmark: 8–12%)                  │
│                                                              │
│  Mobile CVR: {X%}  Desktop CVR: {Y%}  Gap: {Z%}             │
│  Top converting product: {name} — {CVR}x site avg            │
│                                                              │
└──────────────────────────────────────────────────────────────┘

┌─ RETAIN ─────────────────────────────────────────────────────┐
│                                                              │
│  Repeat purchase rate (90d): {X%}  (benchmark: 20–30%)       │
│  LTV (12mo): ${X}   LTV:CAC: {Y}:1  (target: > 3:1)         │
│  Email revenue %: {X%}  (benchmark: 25–40%)                  │
│                                                              │
│  Top flows this month:                                       │
│  {flow 1}: ${revenue}  ({rev/recipient})                     │
│  {flow 2}: ${revenue}  ({rev/recipient})                     │
│  {flow 3}: ${revenue}  ({rev/recipient})                     │
│                                                              │
│  Win-back queue: {X} contacts (90d+ no purchase)             │
│                                                              │
└──────────────────────────────────────────────────────────────┘

┌─ FINANCE ────────────────────────────────────────────────────┐
│                                                              │
│  Revenue (MTD): ${X}  Target: ${Y}  ({±Z%})                  │
│  Contribution margin: {X%}  Floor: {Y%}  {status}            │
│  MER: {X}x  (target: {Y}x)  Trend: {↑/↓/→}                  │
│                                                              │
│  Marketing budget (MTD):                                     │
│  Paid Social: ${spent} / ${budget}  ({X%} used)              │
│  Paid Search: ${spent} / ${budget}  ({X%} used)              │
│  Total: ${spent} / ${budget}  ({X%} used)                    │
│                                                              │
│  Inventory alerts: {any SKU projecting OOS}                  │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

4. Compare every metric against benchmarks in ecom-benchmarks.md. Use status indicators:
   - Above good benchmark: no flag
   - Between average and good: note as "watch"
   - Below average benchmark: flag with recommended action

5. Surface top 3 recommended actions — prioritized by expected revenue impact:
```
┌─ TOP ACTIONS ────────────────────────────────────────────────┐
│                                                              │
│  1. {action} — expected impact: {estimate}                   │
│     Command: {/ecom:command workspace}                       │
│                                                              │
│  2. {action} — expected impact: {estimate}                   │
│     Command: {/ecom:command workspace}                       │
│                                                              │
│  3. {action} — expected impact: {estimate}                   │
│     Command: {/ecom:command workspace}                       │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

</process>
