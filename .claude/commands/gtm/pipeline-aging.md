---
name: gtm:pipeline-aging
description: Pipeline aging alert — flag stale opportunities and prioritize actions
argument-hint: "<workspace-name>"
---
<objective>
Active pipeline aging alert. Query CRM for open opportunities, flag deals that are overdue, inactive, or missing next steps, score them by urgency, and surface a prioritized action list. Replaces the passive Evening Brief with a structured, scored alert system.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
@./.claude/gtmos/references/BENCHMARKS.md
@./.claude/gtmos/references/notifications.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // PIPELINE AGING ALERT >>`

2. **Load workspace context** — read PIPELINE.md for existing deal data and stage definitions.

3. **Pull open opportunities from CRM** — query Salesforce (or the configured CRM) for all open opportunities owned by the current user. Required fields: Name, StageName, Amount, CloseDate, NextStep, LastActivityDate, Account.Name.

4. **Apply aging criteria** — flag every opportunity matching ANY of:
   - **Past close date** — CloseDate is before today
   - **No activity in 7+ days** — LastActivityDate is more than 7 days ago (or null)
   - **Empty NextStep** — NextStep field is null or blank

5. **Score each flagged opportunity** — calculate a priority score:
   - +10 per criterion hit (max 30 for all three)
   - +1 per $10k in deal Amount
   - +2 per day past CloseDate (if overdue)
   - +1 per day since last activity beyond 7 days

6. **Sort and tier** — group flagged opportunities into:
   - **CRITICAL** — 3/3 criteria hit
   - **HIGH** — 2/3 criteria hit
   - **MEDIUM** — 1/3 criteria hit
   Within each tier, sort by score descending.

7. **Display the alert dashboard** — render using GTM:OS box style from ui-brand.md:

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  PIPELINE AGING ALERT — {Workspace} — {date}                ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  Summary: {flagged} of {total} open opps need attention

  [!] {n} past close date  |  {n} inactive 7d+  |  {n} missing NextStep

  CRITICAL — 3/3 criteria ({n})
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  1. {Opp Name} ({Account}) — {Stage} — {Amount}
     Score: {score}  |  CloseDate 15d overdue + No activity in 22d + NextStep empty
     >> Triage immediately — update close date, log activity, set next step

  HIGH — 2/3 criteria ({n})
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  1. {Opp Name} ({Account}) — {Stage} — {Amount}
     Score: {score}  |  CloseDate 5d overdue + No activity in 10d
     >> Update CloseDate to a realistic date and set a concrete NextStep

  MEDIUM — 1/3 criteria ({n})
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  1. {Opp Name} ({Account}) — {Stage} — {Amount}
     Score: {score}  |  NextStep is empty
     >> Add a NextStep — what is the next action to advance this deal?
```

8. **Suggest next actions** — for each flagged opportunity, provide a concrete, actionable recommendation:
   - 3/3 criteria: "Triage immediately — update close date, log activity, set next step"
   - Past close > 30d: "Evaluate if viable — consider Closed Lost"
   - Past close: "Update CloseDate to a realistic date"
   - Inactive > 14d: "Re-engage — schedule a call or send a check-in"
   - Empty NextStep: "Add a NextStep — define the next concrete action"

9. **Send Slack notification** (if enabled) — check COLLABORATION.md for slack_enabled. If true, send a summary DM to the workspace owner:
   ```
   Pipeline Aging Alert — {date}: {n} of {total} opps need attention. {critical} critical, {high} high, {medium} medium. Run /gtm:pipeline-aging {ws} for details.
   ```

10. **Update PIPELINE.md** — append or update the aging alert section with today's scan results and flagged opportunity count.

11. **Show Next Up block:**
```
## Next Up

**pipeline-velocity** — check deal velocity and stall patterns

`/gtm:pipeline-velocity {workspace}`
```
</process>
