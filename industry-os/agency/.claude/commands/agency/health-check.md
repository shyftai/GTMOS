---
name: agency:health-check
description: Full agency health check across Win, Deliver, and Retain loops — surfaces risks and recommends actions
argument-hint: "<workspace-name>"
---

<objective>
Run a comprehensive health audit across all three operational loops. Surface risks before they become crises. Output a prioritised action list and, where warranted, update ROADMAP.md with strategic findings.
</objective>

<execution_context>
@./AGENCYOS.md
@./references/agency-benchmarks.md
@./references/capacity-planning.md
@./references/financial-model.md
</execution_context>

<process>

1. Display header:
```
<< AGENCY:OS // HEALTH CHECK >>
Running full agency health audit...
```

2. Load all workspace and client files. Load agency-benchmarks.md, capacity-planning.md, financial-model.md.

---

**WIN loop health checks:**

- **Pipeline fill rate:** is there > 3 months of revenue runway in the pipeline at the current close rate? (Pipeline value / avg deal size * avg close rate = months of runway). Flag if < 2 months.
- **Deal velocity:** average days per pipeline stage vs. benchmarks. Flag any stage with average > 21 days.
- **Source diversity:** how many distinct channels are generating pipeline (outbound, referral, inbound, network)? Flag if only one source.
- **Signal coverage:** are buying signals being actively monitored? Check SCRAPE-JOURNAL.md for recent signal-gathering activity.
- **Stale deals:** any deals with no activity > 14 days? Flag by name.
- **Open proposals > 7 days:** flag any proposals sent without response.

---

**DELIVER loop health checks:**

- **SLA compliance:** what % of deliverables in the last 30 days were delivered on or before the due date? Flag if < 80%.
- **Revision rounds:** average revision rounds per deliverable in the last 30 days. Flag if > 2 (scope definition or brief quality problem).
- **Approval wait time:** average days waiting for client approval. Flag if > 5 business days.
- **Blocked deliverables:** any currently blocked? Flag each one with how long it has been blocked.
- **Overdue deliverables:** any past due date? Flag each one.
- **Team utilization:** is anyone > 80%? Flag by name.

---

**RETAIN loop health checks:**

- **Client health distribution:** count Green / Yellow / Red from CLIENTS.md. Flag if > 20% are Yellow or Red.
- **Churn risk:** any contracts ending in < 60 days without a renewal already initiated? Flag each one.
- **QBR coverage:** any retainer clients without a QBR in the last 90 days? Flag each one with last QBR date.
- **Upsell coverage:** any Green health clients who have been on the same retainer for > 6 months with no upsell conversation started? Flag as an opportunity.
- **MRR trend:** is MRR growing, flat, or declining vs. last 3 months? Flag if flat or declining.
- **Client concentration:** any single client > 25% of MRR? Flag with percentage.

---

**Finance health checks:**

- **Outstanding invoices > 30 days:** flag each one — work should be paused.
- **Outstanding invoices > 7 days:** flag each one — reminder needed.
- **MRR trend:** compare current MRR to 3 months ago. Growing / flat / declining.
- **Tools spend:** is tools budget > 5% of MRR? Flag if so.
- **Gross margin estimate:** if trackable from FINANCE.md, compare to 55–65% benchmark.

---

3. Display health score summary:

```
┌─ AGENCY HEALTH ───────────────────────────────────────────────┐
│                                                               │
│  Win:     🟢 Healthy / 🟡 Needs attention / 🔴 At risk       │
│  Deliver: 🟢 Healthy / 🟡 Needs attention / 🔴 At risk       │
│  Retain:  🟢 Healthy / 🟡 Needs attention / 🔴 At risk       │
│  Finance: 🟢 Healthy / 🟡 Needs attention / 🔴 At risk       │
│                                                               │
│  Key findings:                                                │
│  {list each flagged item with loop, finding, and severity}    │
│                                                               │
│  Top 3 actions:                                               │
│  1. {most urgent — specific action + command}                 │
│  2. {second}                                                  │
│  3. {third}                                                   │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

Health score logic:
- 🟢 Green: no flags, or only minor observations
- 🟡 Yellow: 1–2 flags that need attention within 2 weeks
- 🔴 Red: any critical flag (overdue invoice > 30d, Red health client, SLA < 70%, MRR declining 2+ months, pipeline runway < 1 month)

4. Log health check results to `logs/health-log.md`:
```
## {date} Health Check
Win: {status} | Deliver: {status} | Retain: {status} | Finance: {status}
Key findings: {list}
Actions recommended: {list}
```

5. If findings have strategic implications, update ROADMAP.md:
   - Pattern of scope creep → add "Improve brief process" to Active Initiatives
   - Pipeline runway < 2 months → escalate MRR target in Current Quarter
   - Team consistently > 80% → add hiring initiative
   - Revenue concentration > 25% → add "Diversify client base" to Active Initiatives

6. Ask: "Do you want to act on any of these findings now?" Suggest the most relevant command for the top finding.

</process>
