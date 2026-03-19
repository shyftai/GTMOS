---
name: agency:dashboard
description: Agency-wide dashboard — health across all three loops, finance snapshot, and top recommended actions
argument-hint: "<workspace-name>"
---

<objective>
Display a complete agency-wide view: Win loop pipeline health, Deliver loop deliverable status, Retain loop client health, and a finance snapshot. Surface the three most important actions the agency should take.
</objective>

<execution_context>
@./AGENCYOS.md
@./references/agency-benchmarks.md
</execution_context>

<process>

1. Display header:
```
<< AGENCY:OS // DASHBOARD >>
```

2. Load all workspace files.

3. Compute and display the WIN loop panel:

```
┌─ WIN ──────────────────────────────────────────────────────────┐
│                                                                │
│  Pipeline by stage:                                            │
│  Prospect:        {count} deals · ${value}                     │
│  Qualified:       {count} deals · ${value}                     │
│  Proposal sent:   {count} deals · ${value}                     │
│  Negotiating:     {count} deals · ${value}                     │
│  Total pipeline:  {count} deals · ${total value}               │
│                                                                │
│  New deals this month: {count}                                 │
│  Deals closed this month: {count won} won · {count lost} lost  │
│  Open proposals > 5 days with no response: {count}            │
│  Stale deals (no activity > 14 days): {count}                  │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

4. Compute and display the DELIVER loop panel:

```
┌─ DELIVER ──────────────────────────────────────────────────────┐
│                                                                │
│  Active deliverables:                                          │
│  In Progress:        {count}                                   │
│  In Review:          {count}                                   │
│  Pending Approval:   {count}  (avg {X} days waiting)           │
│  Blocked:            {count}  ← needs attention                │
│                                                                │
│  Due this week: {count}                                        │
│  Overdue: {count} 🔴                                           │
│                                                                │
│  Team utilization: {X%}                                        │
│  {Name}: {X%} · {Name}: {X%} · {Name}: {X%}                   │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

5. Compute and display the RETAIN loop panel:

```
┌─ RETAIN ───────────────────────────────────────────────────────┐
│                                                                │
│  Client health:                                                │
│  🟢 Green: {count}   🟡 Yellow: {count}   🔴 Red: {count}     │
│                                                                │
│  Renewals due in < 60 days: {count}                            │
│  {list: Client — contract end date}                            │
│                                                                │
│  QBRs overdue (> 90 days since last): {count}                  │
│  {list: Client — last QBR date}                                │
│                                                                │
│  Upsell opportunities (Green clients not in upsell): {count}  │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

6. Compute and display the FINANCE panel:

```
┌─ FINANCE ──────────────────────────────────────────────────────┐
│                                                                │
│  MRR this month: ${X}   vs last month: ${Y} ({±Z%})           │
│  Outstanding invoices: ${X} total                              │
│  Overdue > 7 days: {count} invoices · ${value}                 │
│  Overdue > 30 days: {count} invoices · ${value} ← pause work  │
│                                                                │
│  Revenue concentration:                                        │
│  Largest client: {name} = {X%} of MRR {🔴 if > 25%}          │
│                                                                │
│  Tools spend this month: ${X} (COSTS.md)                       │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

7. Surface the top 3 recommended actions based on what is most urgent:

```
┌─ TOP ACTIONS ──────────────────────────────────────────────────┐
│                                                                │
│  1. {most urgent finding and specific command to address it}   │
│  2. {second finding}                                           │
│  3. {third finding}                                            │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

Prioritize by: Red health clients > overdue invoices > overdue deliverables > renewals within 30 days > stale pipeline deals > QBRs overdue.

8. Ask: "What do you want to dig into?"

</process>
