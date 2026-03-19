---
name: agency:today
description: Daily briefing — deliverables due today, client alerts, pipeline status, and finance flags
argument-hint: "<workspace-name>"
---

<objective>
Give the agency operator a clear picture of what needs their attention today across all three loops: Win, Deliver, Retain. Surface the most urgent items and recommend first actions.
</objective>

<execution_context>
@./AGENCYOS.md
</execution_context>

<process>

1. Display header:
```
<< AGENCY:OS // TODAY >>
{date}
```

2. Load DELIVERABLES.md, CLIENTS.md, PIPELINE.md, FINANCE.md, TEAM.md.

3. Load LEARNINGS.md — scan for any lesson relevant to what is on today's agenda. If one is found, surface it as a brief note.

4. Display the daily briefing:

```
┌─ TODAY ─── {date} ────────────────────────────────────────────┐
│                                                               │
│  Deliverables due today:                                      │
│  {list from DELIVERABLES.md where due = today}                │
│  {if none: "No deliverables due today."}                      │
│                                                               │
│  Deliverables due this week (not yet done):                   │
│  {list with client name, deliverable name, due date}          │
│                                                               │
│  Client alerts:                                               │
│  🔴 {Red health clients — action needed today}                │
│  🟡 {Yellow health clients — check-in recommended}            │
│  📅 {Renewals within 60 days — list client and contract end}  │
│  ⏰ {QBRs overdue — client hasn't had one in > 90 days}       │
│                                                               │
│  New business:                                                │
│  {pipeline deals with no activity in > 7 days}               │
│  {deals in "Call Booked" stage — call prep may be needed}     │
│  {open proposals > 5 days with no client response}            │
│                                                               │
│  Finance:                                                     │
│  {invoices due this week}                                     │
│  {invoices overdue > 7 days — follow-up needed}               │
│  {clients with work paused due to non-payment}                │
│                                                               │
│  Capacity:                                                     │
│  {any team member > 80% utilization — flag by name}           │
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
- Deliverable overdue → `/agency:deliver {workspace} {client}`
- Red health client → `/agency:qbr-prep {workspace} {client}` or `/agency:retainer-renewal {workspace} {client}`
- Renewal within 60 days → `/agency:retainer-renewal {workspace} {client}`
- Stale pipeline deal → `/agency:pitch {workspace} {prospect}`
- Invoice overdue → `/agency:invoice {workspace} {client}`
- Call booked → `/agency:pitch {workspace} {prospect}` to prep

</process>
