---
name: gtm:dashboard
description: Smart dashboard — shows what needs attention right now
argument-hint: "<workspace-name>"
---
<objective>
Analyze the full state of a workspace and surface what needs attention. Prioritize actions, flag issues, and recommend the next step.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/BENCHMARKS.md
@./.claude/gtmos/references/sending-calendar.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // DASHBOARD >>`
2. Load full workspace context — all files
3. Scan and assess each area:

## Workspace scan

**Sources of truth:**
- Check ICP.md, PERSONA.md, TOV.md, RULES.md — are they populated or still templates?
- Flag any that are incomplete

**Active campaigns:**
- List all campaigns with status (draft / active / paused / complete)
- For active campaigns: days running, contacts shipped, current reply rate

**Pending actions:**
Check for items that need human attention:
- Unhandled replies (replies/ folder has unprocessed files)
- Lists waiting for validation (lists/raw/ has files not in lists/validated/)
- Copy waiting for approval (copy/drafts/ has files not in copy/approved/)
- Budget alerts (COSTS.md spend approaching threshold)
- Infrastructure issues (INFRASTRUCTURE.md has red flags)
- Warmup not ready (inboxes not yet at go-live criteria)
- Missing API keys (TOOLS.md has active tools with no .env key)
- Holiday conflicts (upcoming send dates fall on target geography holidays)
- Re-engagement eligible (contacts from completed campaigns past 60-day window)
- Win/loss patterns (PIPELINE.md has enough data to suggest ICP refinements)

4. Display the dashboard:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  DASHBOARD — {Workspace}                                    ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  Campaigns
    {campaign-1}   ACTIVE   Day 8    Reply: 4.2%    3 meetings
    {campaign-2}   DRAFT    —        —              —

  Needs attention
    !! 4 unhandled replies — /gtm:replies {ws}
    !! Budget at 82% — /gtm:costs {ws}
    !! 12 contacts eligible for re-engagement — /gtm:re-engage {ws}

  Looking good
    [x] Infrastructure healthy
    [x] All inboxes warmed
    [x] Suppression list current
    [x] No holiday conflicts this week

  Spend
    ${spent} of ${budget}   ████████░░  {pct}%

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Recommended: /gtm:replies {ws}
     Also: /gtm:health {ws} {campaign}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

5. Prioritize the "Recommended" action by urgency:
   - Unhandled replies > budget alerts > infrastructure issues > re-engagement > everything else
   - If nothing needs attention: "All clear. Next scheduled action: {what and when}"

6. If win/loss data has patterns worth surfacing, add a suggestion block:
```
  ┌─ SUGGESTION ──────────────────────────────────┐
  │ Based on 12 closed deals:                      │
  │ Series B companies close 3x faster.            │
  │ Consider adding "Series B" as a signal in      │
  │ ICP.md.                                        │
  │                                                │
  │ >> Apply this change? (y/n)                    │
  └────────────────────────────────────────────────┘
```
</process>
