---
name: gtm:portfolio
description: Multi-workspace dashboard — all clients at a glance
argument-hint: "[--details | --report]"
---
<objective>
Show all workspaces in one view. Built for agencies and teams managing multiple clients. Surface what needs attention across the portfolio, cross-workspace learnings, and aggregate metrics.

Options: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/BENCHMARKS.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // PORTFOLIO >>`
2. Scan workspaces/ folder for all workspace directories
3. For each workspace, load: workspace.config.md, COSTS.md, PIPELINE.md, ROADMAP.md, LEARNINGS.md, and active campaign performance data

## Portfolio overview
4. Display the portfolio dashboard:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  PORTFOLIO — {n} workspaces                                  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  {workspace-1} — {client name}
    Role: {role}   Status: active
    Campaigns: 2 active, 1 planned
    Reply rate: 4.2% (▲ above benchmark)   Meetings: 7
    Spend: $340 of $500   ████████░░  68%
    !! 3 unhandled replies

  {workspace-2} — {client name}
    Role: {role}   Status: active
    Campaigns: 1 active
    Reply rate: 1.8% (▼ below benchmark)   Meetings: 1
    Spend: $120 of $300   ████░░░░░░  40%
    !! Health check overdue (12 days)

  {workspace-3} — {client name}
    Role: {role}   Status: paused
    Campaigns: 0 active
    Last activity: 2026-02-15

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Portfolio totals
    Active campaigns: {n}     Total contacts shipped: {n}
    Avg reply rate: {pct}%    Total meetings: {n}
    Total spend: ${n}         Pipeline value: ${n}
```

## Needs attention (cross-workspace)
5. Aggregate and prioritize actions across all workspaces:
```
  Needs attention (across all clients)
    !! {ws-1}: 3 positive replies waiting
    !! {ws-2}: Reply rate below benchmark — run health check
    !! {ws-2}: Health check overdue
    >> {ws-1}: "Q2 Expansion" campaign starts in 4 days
    >> {ws-3}: Workspace paused 21 days — re-engage or archive?
    .. {ws-1}: 5 open to-dos in roadmap
```

## Cross-workspace learnings
6. If --details flag, surface patterns that work across clients:
```
  Cross-workspace learnings
    "Question subject lines outperform statements" — confirmed in 3/4 workspaces
    "Tuesday 9am local time" — best send time in 2/4 workspaces
    "Series B companies" — high reply rate in 2 workspaces (different industries)

  These patterns could be applied to: {workspace-3}, {workspace-4}
```

7. Recommend next action:
```
  >> Start here: /gtm:replies {ws-1}
     Then: /gtm:health {ws-2} {campaign}
```

## --report
8. If --report flag, generate a cross-client summary report suitable for agency leadership:
   - Revenue and pipeline per client
   - Campaign performance comparison
   - Resource allocation (spend per client vs results)
   - Recommendations per client
</process>
</content>
