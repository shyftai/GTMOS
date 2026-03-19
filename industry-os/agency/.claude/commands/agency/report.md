---
name: agency:report
description: Generate a client-facing report — weekly update, monthly report, or QBR deck outline
argument-hint: "<workspace-name> <client-name> [weekly|monthly|qbr]"
---

<objective>
Produce a complete, accurate client-facing report. Every report must: match the format agreed in CLIENT-BRIEF.md, cross-reference data against source before including it, include at least one actionable recommendation, and be delivered within the SLA in delivery-standards.md.
</objective>

<execution_context>
@./AGENCYOS.md
@./references/client-reporting.md
@./references/delivery-standards.md
@./_template/clients/_client-template/CLIENT-BRIEF.md
@./_template/clients/_client-template/RESULTS.md
</execution_context>

<process>

1. Display header:
```
<< AGENCY:OS // REPORT >>
Client: {client-name}
```

2. Load `clients/{client-name}/CLIENT-BRIEF.md`, `clients/{client-name}/RESULTS.md`, `clients/{client-name}/SOW.md`.

3. Load `references/client-reporting.md` for templates.

4. If report type not specified in $ARGUMENTS, ask:
   "What type of report?"
   - **Weekly update** — async, Slack or email format (5–10 min to produce)
   - **Monthly report** — full performance report (30–45 min to produce)
   - **QBR deck** — quarterly business review outline (run `/agency:qbr-prep` for full prep)

---

**WEEKLY UPDATE**

5a. Ask in one block:
    - What were the top 3 activities completed this week?
    - Key metrics this week (pull from CLIENT-BRIEF.md success metrics — fill in actuals)
    - Any blockers or items you need from the client?
    - What is the plan for next week?

6a. Generate weekly update using the template from client-reporting.md:

```
── Weekly Update · {Client} · w/c {date} ───────────────────────

Spend this week:         ${X}  (budget: ${Y})
[Key metric 1]:          {actual} vs {target}
[Key metric 2]:          {actual} vs {target}

This week:
· {Activity 1}
· {Activity 2}
· {Activity 3}

Next week:
· {Plan 1}
· {Plan 2}

Needs from you:
· {Request 1 — be specific with deadline}
· {None if nothing needed}

─────────────────────────────────────────────────────────────────
```

7a. Quality gate:
    - Every metric shown has a target to compare against (from CLIENT-BRIEF.md)
    - No metric included without a source (do not guess)
    - At least one "needs from you" or "next week" item — the report must move things forward
    - Tone matches TOV.md

8a. Write to `clients/{client-name}/RESULTS.md` monthly snapshot section.

---

**MONTHLY REPORT**

5b. Ask in one block:
    - Reporting period (month and year)
    - Key metrics for the period (fill in actuals from client data)
    - What worked this month?
    - What did not work, and why?
    - What is the focus for next month?
    - Any budget variances to explain?

6b. Generate the monthly report structure from client-reporting.md:

**Section 1 — Executive summary (half page)**
One paragraph: what happened this month, headline result, and what it means for next month. Written for the executive sponsor, not the day-to-day contact.

**Section 2 — Results vs. targets**
Table: Metric | Target | Actual | Status (🟢/🟡/🔴)
Pull targets from CLIENT-BRIEF.md. Fill actuals from inputs.
Do not spin negative results — if a metric missed, say so and explain why.

**Section 3 — Channel breakdown**
For each active channel: spend, key metric, performance summary (1–2 sentences), what changed this month.

**Section 4 — Top wins**
2–3 specific, concrete wins with numbers. Not vague ("we improved performance") — specific ("CPL dropped from $82 to $61 in week 3 after audience exclusion change").

**Section 5 — Learnings and optimisations**
What did we learn? What did we change? Why? This section builds trust — it shows the agency is thinking, not just executing.

**Section 6 — Next month focus**
3–5 priorities for the coming month. Each should be specific and tied to a metric or deliverable.

**Section 7 — Budget reconciliation**
Spend this month vs. budget. Any variances explained. Running spend vs. annual/quarterly budget if applicable.

7b. Quality gate (from delivery-standards.md):
    - Every number cross-referenced against platform source before including
    - Narrative matches data — if performance is down, the narrative does not spin it as positive
    - At least one specific, actionable recommendation
    - Period comparison included (vs. prior month, and vs. same period last year if > 12 months of history)
    - Every metric shown alongside its target from CLIENT-BRIEF.md
    - Format matches what was agreed in CLIENT-BRIEF.md

8b. Update `clients/{client-name}/RESULTS.md` with this month's snapshot.
    Log to `logs/workspace-log.md`: date, client, report type, period.

---

**QBR DECK**

5c. This is handled by `/agency:qbr-prep`. Run:
    `/agency:qbr-prep {workspace} {client-name}`

---

9. After report is generated, ask: "Would you like to draft the send message to the client?"

If yes, draft:
"Hi {contact name},

Here is the {weekly update / monthly report} for {period}. {One sentence headline from the executive summary or top win}.

{Link or attachment}

Let me know if you have any questions.

{Account manager name}"

10. Show the send message and ask for approval (interactive mode) or auto-approve draft with outbound gate before sending (auto mode).

</process>
