---
name: agency:capacity
description: Check team utilization, plan capacity for new work, and rebalance workload
argument-hint: "<workspace-name>"
---

<objective>
Give the agency operator a clear view of team utilization across all active clients and deliverables. Help them decide whether to take on new work, flag anyone at risk of burnout, and rebalance workload if needed.
</objective>

<execution_context>
@./AGENCYOS.md
@./references/capacity-planning.md
</execution_context>

<process>

1. Display header:
```
<< AGENCY:OS // CAPACITY >>
```

2. Load TEAM.md, DELIVERABLES.md, CLIENTS.md. Load capacity-planning.md.

3. Calculate utilization for each team member:
   - Available hours per week (from TEAM.md capacity column)
   - Allocated hours (from current deliverable assignments in DELIVERABLES.md)
   - Utilization % = allocated / available

4. Display capacity panel:

```
┌─ TEAM CAPACITY ───────────────────────────────────────────────┐
│                                                               │
│  {Name} [{Role}]                                              │
│  [{bar: filled = utilized, empty = available}] {X%}           │
│  {X} hrs allocated · {Y} hrs available                        │
│  Clients: {list of assigned clients}                          │
│  {status: Healthy / ⚠️ High load / 🔴 At risk}                │
│                                                               │
│  {repeat for each team member}                                │
│                                                               │
│  ── Agency total ───────────────────────────────────────── │
│  Total capacity: {X} hrs/week                                 │
│  Total allocated: {Y} hrs/week                                │
│  Agency utilization: {Z%}                                     │
│  Available for new work: {N} hrs/week                         │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

Utilization bar format: `[========--]` where each `=` represents ~10%.

5. Apply flags from capacity-planning.md:
   - > 80%: "⚠️ High load — do not add new client commitments for this person"
   - > 90%: "🔴 At risk — quality and delivery SLAs will suffer"
   - < 50%: "⬇️ Underutilized — check pipeline and new business urgency"

6. Flag structural risks:
   - Any single client consuming > 40% of one person's time: name it ("Bus factor risk: {name} is {X%} on {client}")
   - Any deliverable SLA misses in the last 2 weeks: connect to utilization data
   - Agency utilization > 80% for stated period: hiring trigger check

7. Ask: "What do you want to do?"
   A. Check if the team can take on a new client
   B. Rebalance workload between team members
   C. Plan capacity for an upcoming project
   D. Update team capacity in TEAM.md

---

**Option A — Can we take on a new client?**

Ask: What services would this new client need, and what is the estimated monthly hours?

Check:
- Is there an Account Manager with > 20% headroom?
- Is there specialist capacity in the required service lines?
- Is the onboarding buffer (5 hrs/week for 4 weeks) available?

If yes: "Yes — the team has capacity. Confirm with {name} before committing."
If no: "Not without risk. {name} is at {X%}. Consider hiring or completing {deliverable} first before taking on new work."

---

**Option B — Rebalance workload:**

Show current allocation per person. Ask which deliverables or clients could be reassigned.

For each proposed move: confirm the team member receiving the work has capacity and the right skills.

Update TEAM.md current assignments and DELIVERABLES.md owner fields.

---

**Option C — Plan for an upcoming project:**

Ask: project name, client, estimated hours per week, duration, service line.

Show whether current capacity can absorb it, and if so, who would own it.

If capacity is insufficient: show when it would free up, or flag that a freelancer or new hire is needed.

---

**Option D — Update TEAM.md:**

Ask what has changed (new team member, changed hours, role change). Update TEAM.md.

</process>
