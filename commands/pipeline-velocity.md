# Pipeline Velocity — Command Reference

## What is pipeline velocity

Pipeline velocity measures how quickly deals progress from first touch to close. It quantifies the speed of your sales pipeline by tracking how long deals spend in each stage, identifying bottlenecks where deals stall, and surfacing actionable fixes to accelerate conversion.

A healthy pipeline moves deals through stages at a predictable cadence. When velocity slows, revenue slips. Tracking velocity lets you catch slowdowns early and intervene before deals die.

---

## Velocity metrics

### Core timing metrics

| Metric | Definition | Benchmark |
|--------|-----------|-----------|
| **Time to first reply** | Days from first send to first positive reply | 3-7 days |
| **Time to meeting** | Days from first send to meeting booked | 7-21 days |
| **Time to proposal** | Days from meeting to proposal sent | 3-14 days |
| **Time to close** | Days from first send to closed-won | Varies by deal size |
| **Stage duration** | Average days spent in each pipeline stage | Stage-dependent |
| **Stall rate** | % of deals sitting in a stage longer than 2x the average for that stage | <15% healthy, >30% critical |

### Pipeline velocity formula

```
Pipeline Velocity = (# Deals x Avg Deal Value x Win Rate) / Avg Sales Cycle Length (days)
```

This produces a daily revenue velocity number. Higher is better. Track week-over-week to detect improvements or regressions.

---

## Stage-by-stage tracking

Track duration and stall rates for every stage transition in the pipeline.

| Stage | Avg days | Median days | Stall threshold (2x avg) | Deals stalling | Action |
|-------|----------|-------------|--------------------------|----------------|--------|
| Contacted -> Replied | — | — | — | — | If stalling: A/B test copy, adjust persona targeting, check send timing |
| Replied -> Meeting | — | — | — | — | If stalling: improve follow-up cadence, strengthen CTA |
| Meeting -> Qualified | — | — | — | — | If stalling: tighten ICP qualification, deepen discovery |
| Qualified -> Proposal | — | — | — | — | If stalling: streamline proposal process, pre-build templates |
| Proposal -> Negotiation | — | — | — | — | If stalling: address pricing objections, multi-thread contacts |
| Negotiation -> Won/Lost | — | — | — | — | If stalling: improve champion enablement, add urgency levers |
| **Full cycle (first touch -> won)** | — | — | — | — | Overall pipeline health indicator |

---

## Bottleneck detection

### Bottleneck threshold

If **>30% of deals stall** at any single stage (sitting longer than 2x the average duration for that stage), flag it as a bottleneck. This is the critical threshold that demands immediate action.

### Common bottlenecks and fixes

**Contacted -> Reply stall**
- Root causes: copy is not resonating, targeting the wrong persona, sending at bad times
- Fixes: A/B test subject lines and opening angles, adjust persona targeting in PERSONA.md, test different send windows
- Diagnostic: check reply rates by persona, by angle, by send day

**Reply -> Meeting stall**
- Root causes: weak call-to-action, no urgency in follow-up, too many steps to book
- Fixes: improve follow-up cadence (faster, more value-driven), use direct calendar links, add social proof in follow-up
- Diagnostic: check meeting-book rate by reply type, follow-up touch number

**Meeting -> Qualified stall**
- Root causes: wrong ICP fit slipping through, discovery calls not deep enough, no clear next step set
- Fixes: tighten qualification criteria in ICP.md, build a stronger discovery framework, always end meetings with a committed next step
- Diagnostic: check qualification rate by company signal, by persona

**Proposal -> Won stall**
- Root causes: pricing misalignment, competitor pressure, weak champion, no urgency
- Fixes: improve proposal with ROI framing, multi-thread into other stakeholders, add deadline-based incentives
- Diagnostic: check win rate by deal size, by competitor, by number of stakeholders engaged

---

## Velocity trends

Track pipeline velocity week-over-week to detect improvements or regressions.

| Week | Avg cycle (days) | Deals in pipeline | Stall rate | Velocity score |
|------|-----------------|-------------------|------------|---------------|
| | | | | |

What to watch for:
- **Velocity score declining** for 2+ consecutive weeks -> investigate which stage is slowing
- **Stall rate increasing** -> check if a specific campaign or persona is the source
- **Avg cycle lengthening** -> compare to deal size trends (larger deals naturally take longer)
- **Deals in pipeline dropping** without corresponding wins -> top-of-funnel problem

---

## Display

Render the pipeline velocity dashboard using the GTM:OS box style.

```
+------------------------------------------------------------------+
|  PIPELINE VELOCITY DASHBOARD                                      |
+------------------------------------------------------------------+
|                                                                    |
|  VELOCITY SCORE: _____ / day                                      |
|  Formula: (__ deals x $__k avg x __% win rate) / __ day cycle    |
|                                                                    |
+------------------------------------------------------------------+
|  STAGE DURATIONS                           STALL RATES            |
|  Contacted -> Reply:    __ days avg        __% stalling           |
|  Reply -> Meeting:      __ days avg        __% stalling           |
|  Meeting -> Qualified:  __ days avg        __% stalling           |
|  Qualified -> Proposal: __ days avg        __% stalling           |
|  Proposal -> Negotiation: __ days avg      __% stalling           |
|  Negotiation -> Won:    __ days avg        __% stalling           |
|                                                                    |
|  Full cycle:            __ days avg                                |
+------------------------------------------------------------------+
|  BOTTLENECK FLAGS                                                  |
|  [!] Stage with >30% stall rate flagged here                      |
|  [!] Suggested action displayed                                   |
+------------------------------------------------------------------+
|  STALLED DEALS                                                     |
|  Deal / Company / Stage / Days in stage / Action                  |
|  ________________________________________________                |
|  ________________________________________________                |
+------------------------------------------------------------------+
|  TREND (last 4 weeks)                                             |
|  Wk1: ___  Wk2: ___  Wk3: ___  Wk4: ___                        |
+------------------------------------------------------------------+
```

---

## Data sources

Pipeline velocity pulls data from:

| Source | Data pulled | Used for |
|--------|-----------|----------|
| CRM (Attio/HubSpot) | Deal stage timestamps, deal values, win/loss status | Stage duration calculations, velocity formula inputs |
| Sending tools (Instantly/Lemlist/Smartlead) | First send timestamp, reply timestamps | Time to first reply, first touch date |
| Campaign logs (CAMPAIGN.md) | Campaign-level metadata, send dates | Attribution, filtering by campaign |
| PIPELINE.md | Deal tracking table, stage definitions | Current pipeline state, stage transition history |
| BENCHMARKS.md | Industry benchmarks for stage durations | Comparison and threshold calibration |
