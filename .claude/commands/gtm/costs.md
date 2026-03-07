---
name: gtm:costs
description: View spend breakdown by tool, campaign, and workspace
argument-hint: "<workspace-name> [campaign-name] [--all]"
---
<objective>
Display cost tracking dashboard — spend by tool, by campaign, budget status, and recent transactions.

Workspace: $ARGUMENTS

Flags:
- No campaign specified: show workspace-level totals across all campaigns
- Campaign specified: show that campaign's spend only
- `--all`: show spend across ALL workspaces (agency-level view)
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>

## Single workspace view (default)

1. Display mode header: `<< GTM:OS // COSTS >>`
2. Load COSTS.md from the workspace
3. Display cost dashboard:

```
  ┌─ COST DASHBOARD ─────────────────────────────┐
  │ Workspace: {name}                              │
  │ Period:    {earliest tx} — {latest tx}         │
  │                                                │
  │ Budget                                         │
  │   Monthly:     ${budget}                       │
  │   Spent:       ${total}    ████████░░  {pct}%  │
  │   Remaining:   ${remaining}                    │
  │                                                │
  │ By tool                                        │
  │   Apollo:      ${amount}   ({units} contacts)  │
  │   Apify:       ${amount}   ({units} CUs)        │
  │   Lemlist:     ${amount}   ({units} emails)    │
  │   Attio:       $0.00       (free)              │
  │                                                │
  │ By campaign                                    │
  │   {campaign-1}: ${amount}  of ${budget}        │
  │   {campaign-2}: ${amount}  of ${budget}        │
  │                                                │
  └────────────────────────────────────────────────┘
```

4. If spend is above alert threshold, display warning:
```
  !! Budget alert: {pct}% of {monthly/campaign} budget used
```

5. Show last 5 transactions from the transaction log

## Campaign-specific view

Same as above but filtered to one campaign's transactions only.

## All-workspaces view (--all flag)

1. Load COSTS.md from every workspace in workspaces/
2. Display agency-level summary:

```
  ┌─ AGENCY COST OVERVIEW ───────────────────────┐
  │                                                │
  │ Workspace           Spent     Budget   Status  │
  │ ─────────────────────────────────────────────  │
  │ {workspace-1}       ${amt}    ${bud}   [x]     │
  │ {workspace-2}       ${amt}    ${bud}   [!]     │
  │ {workspace-3}       ${amt}    ${bud}   [x]     │
  │                                                │
  │ Total across all:   ${total}                   │
  │                                                │
  │ Top spend by tool (all workspaces)             │
  │   1. {tool}: ${amount}                         │
  │   2. {tool}: ${amount}                         │
  │   3. {tool}: ${amount}                         │
  │                                                │
  └────────────────────────────────────────────────┘
```

Status: [x] = under 80%, [!] = above alert threshold, [!!] = over budget

</process>
