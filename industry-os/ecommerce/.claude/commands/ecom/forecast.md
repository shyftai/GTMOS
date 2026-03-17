---
name: ecom:forecast
description: Revenue and inventory forecast for the next 30, 60, or 90 days
argument-hint: "<workspace-name> [30|60|90]"
---

<objective>
Build a forward-looking revenue and inventory forecast. Apply seasonal adjustments from CALENDAR.md and planned campaign impact from CALENDAR.md and CHANNELS.md. Flag inventory risks. Update ROADMAP.md if the forecast signals a target miss.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./references/ecom-metrics.md
@./references/ecom-calendar.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // FORECAST >>
{workspace name} — {date}
```

2. Load METRICS.md, PRODUCTS.md, FINANCE.md, CALENDAR.md, CHANNELS.md.

3. Ask: Forecast period — 30, 60, or 90 days?

4. Build revenue forecast:

**Baseline:**
- Trailing 30d revenue: ${X}
- Daily run rate: ${X/day}
- Extrapolated to forecast period: ${X × days}

**Channel contribution (from CHANNELS.md):**
- Email contribution: based on current email revenue % from METRICS.md
- Paid contribution: ROAS × current daily spend rate
- Organic and other: remaining revenue

**Seasonal adjustments (apply multipliers from ecom-calendar.md):**
- Identify key events in the forecast window from CALENDAR.md
- Apply multipliers:
  - BFCM window: 3–5x daily run rate
  - Major holidays (Mother's Day, Valentine's): 1.5–2x
  - Quiet periods (January post-BFCM): 0.7–0.9x
  - No major event: 1.0x (baseline)

**Planned campaign impact (from CALENDAR.md):**
- For each planned promo or launch in the window: apply estimated revenue lift
- Use LEARNINGS.md prior promo results to calibrate lift estimates
- Conservative: 10% lift for email promo, 20% for site-wide sale, 50%+ for BFCM

**Sensitivity scenarios:**
- Low case: baseline × 0.85 (underperformance on paid, no unexpected wins)
- Base case: baseline + seasonal + planned campaign impact
- High case: base case × 1.15 (campaign outperformance, viral moment)

5. Build inventory forecast:

For each active SKU in PRODUCTS.md:
- Current units: {X}
- Trailing 30d velocity: {Y units/day}
- Forecast period velocity (with seasonal adjustment): {Z units/day}
- Projected units sold in period: Z × forecast days
- Remaining units after period: Current − projected sold
- Projected stockout date (if velocity exceeds stock): flag if < reorder lead time

Flag: any SKU projecting OOS before the forecast window end — especially any SKU featured in a planned campaign

6. Display forecast:

```
┌─ FORECAST ─── {period} ──────────────────────────────────────┐
│                                                              │
│  Revenue forecast:                                           │
│  Low case:   ${X}   Base case:  ${Y}   High case:  ${Z}      │
│                                                              │
│  By channel:                                                 │
│  Email: ${X}  Paid: ${Y}  Organic/other: ${Z}               │
│                                                              │
│  Key events in window:                                       │
│  {event name} — {date} — estimated lift: {X%}               │
│                                                              │
│  vs. Revenue target: ${target}  —  {On track / Behind / Ahead}│
│                                                              │
│  Inventory:                                                  │
│  {SKU A}: {X} units — projects to {Y} remaining — {status}   │
│  {SKU B}: REORDER NOW — projects OOS in {Z} days             │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

7. If forecast base case is below ROADMAP.md revenue target:
   - Flag the gap: "${X} gap to target"
   - Suggest specific actions to close the gap:
     - Increase paid spend (if ROAS is healthy)
     - Add a promotional event to CALENDAR.md
     - Accelerate a planned launch

8. Update ROADMAP.md:
   - If forecast signals a miss: add a note to the current quarter section
   - If forecast is strong: note the confidence level

9. Log forecast to `logs/workspace-log.md`.

10. Suggest follow-up:
- OOS risk → update PRODUCTS.md and review reorder
- Revenue gap → `/ecom:promo {workspace}` to add a promotional event
- Ahead of target → `/ecom:signals {workspace}` to find additional scaling opportunities

</process>
