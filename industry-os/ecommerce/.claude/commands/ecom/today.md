---
name: ecom:today
description: Daily briefing — revenue status, acquire/convert/retain alerts, and finance flags
argument-hint: "<workspace-name>"
---

<objective>
Give the brand operator a clear picture of what needs their attention today across all three loops: Acquire, Convert, Retain. Surface the most urgent items and recommend first actions.
</objective>

<execution_context>
@./ECOMMERCEOS.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // TODAY >>
{date}
```

2. Load workspace files: METRICS.md, CALENDAR.md, FLOWS.md, CHANNELS.md, PRODUCTS.md, FINANCE.md, LEARNINGS.md, SCRAPE-JOURNAL.md.

   Note: before suggesting any signal scans or competitor research today, check SCRAPE-JOURNAL.md — skip any scan that was run within the last 7 days and reuse cached results instead.

3. Load LEARNINGS.md — scan for any lesson relevant to what is on today's agenda. If one is found, surface it as a brief note.

4. Display the daily briefing:

```
┌─ TODAY ─── {date} ────────────────────────────────────────────┐
│                                                               │
│  Revenue (MTD):  ${X} / ${target}  ({±Z%})                    │
│  Orders (MTD):   {count}  AOV: ${X}  ROAS: {Y}x              │
│                                                               │
│  ── Acquire ───────────────────────────────────────────────  │
│  {any channel ROAS below cut threshold — name channel + gap}  │
│  {any paid campaigns active for OOS products}                 │
│  {any promos or launches starting within 48 hours}            │
│  {any paid budgets over daily cap}                            │
│                                                               │
│  ── Convert ───────────────────────────────────────────────  │
│  {CVR change vs. prior 7 days — flag if drop > 10%}          │
│  {cart abandonment rate — flag if above 80%}                  │
│  {AOV trend — vs. prior 7 days}                               │
│                                                               │
│  ── Retain ────────────────────────────────────────────────  │
│  {any flows paused, erroring, or not receiving traffic}       │
│  {email sends scheduled today — name and recipient count}    │
│  {unsubscribe rate spike — flag if > 0.4% on recent send}    │
│  {win-back queue size — contacts 90d+ no purchase}            │
│                                                               │
│  ── Finance ───────────────────────────────────────────────  │
│  {marketing spend MTD vs. budget — % used}                    │
│  {any channel pacing over or under budget by > 15%}           │
│  {contribution margin vs. floor — flag if close}              │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

5. If a relevant LEARNINGS.md entry applies to today's work, surface it:
```
  Relevant learning: [{date}] {one-line summary}
  Apply: {when/how to use it today}
```

6. Ask: "What do you want to work on first?"

7. Based on what is most urgent, suggest the most relevant commands:
- ROAS below cut threshold → `/ecom:audit {workspace} paid`
- OOS product in active campaign → fix in PRODUCTS.md, then `/ecom:campaign {workspace}` to rebuild
- Promo launching in 48h → `/ecom:promo {workspace}` to review and confirm
- Flow paused or erroring → `/ecom:flow {workspace}`
- Win-back queue large → `/ecom:retention {workspace}`
- Revenue tracking behind target → `/ecom:dashboard {workspace}` for full view

</process>
