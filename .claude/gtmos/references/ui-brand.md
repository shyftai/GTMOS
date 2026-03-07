<ui_patterns>

Visual patterns for user-facing GTMOS output. All commands @-reference this file.

## Brand Color

GTMOS brand color is **orange** (ANSI 208).
- Use `\033[38;5;208m` to set orange text, `\033[0m` to reset
- Apply orange to: the GTMOS block-letter banner, mode headers (`<< GTMOS // MODE >>`), section titles in dashboards
- Use white/default for: body text, data values, box borders
- If terminal doesn't support color, display everything in plain white
- Never use blue, green, or red as brand colors — those are reserved for status indicators

## Startup Banner

Display once when GTMOS loads. Render the block letters in orange.

```
 ██████╗ ████████╗███╗   ███╗ ██████╗ ███████╗
██╔════╝ ╚══██╔══╝████╗ ████║██╔═══██╗██╔════╝
██║  ███╗   ██║   ██╔████╔██║██║   ██║███████╗
██║   ██║   ██║   ██║╚██╔╝██║██║   ██║╚════██║
╚██████╔╝   ██║   ██║ ╚═╝ ██║╚██████╔╝███████║
 ╚═════╝    ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚══════╝
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  T H E   G T M   O P E R A T I N G   S Y S T E M
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Mode Headers

Use for workflow transitions. GTMOS uses angle brackets, not GSD's arrows.

```
<< GTMOS // {MODE NAME} >>
```

**Mode names (uppercase, rendered in orange):**
- `ONBOARDING`
- `RESEARCH`
- `LIST CLEAN`
- `LIST BUILD`
- `COPY LAB`
- `SHIP`
- `REPLY DESK`
- `SIGNAL SCAN`
- `DATA SYNC`
- `HEALTH CHECK`
- `INFRASTRUCTURE CHECK`
- `WARMUP STATUS`
- `PIPELINE`
- `DEBRIEF`
- `REPORT`
- `AUDIT`
- `STRESS TEST`
- `COSTS`
- `ARCHIVE`
- `SWARM`
- `COLLABORATION SETUP`
- `POST-MEETING`
- `ACCOUNT-BASED`
- `RE-ENGAGE`
- `LINKEDIN WARMING`
- `DOMAIN RECOVERY`
- `FEEDBACK`
- `DASHBOARD`
- `AUTO-REFINE`
- `MIGRATION`

---

## System Flow Diagram

Show below the banner on startup. Includes swarm and pipeline.

```
  ┌─────────────────────────────────────────────┐
  │  ICP ─── PERSONA ─── BRIEFING ─── TOV      │
  │                  │                          │
  │              RULES.md                       │
  │                  │                          │
  │     ┌────────────┼────────────┐             │
  │     ▼            ▼            ▼             │
  │   LISTS        COPY       SIGNALS          │
  │     │            │            │             │
  │     ▼            ▼            ▼             │
  │  VALIDATE ── APPROVE ──── SHIP             │
  │                  │            │             │
  │              SYNC DATA    ◈ SWARM          │
  │                  │        (optional)        │
  │          HEALTH CHECK                      │
  │                  │                          │
  │          REPORT + IMPROVE                  │
  │                  │                          │
  │              PIPELINE ──── CRM             │
  └─────────────────────────────────────────────┘
```

---

## Workspace Header

Show after loading a workspace. Always displayed before any task.

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  WORKSPACE: {Name}                                         ┃
┃  CAMPAIGN:  {Active campaign}                              ┃
┃  STATUS:    {active/paused}         TOOLS: {tool list}     ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

---

## Approval Gates

When human decision is needed. Uses double borders.

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  APPROVAL REQUIRED                                         ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

{What is being approved}

>> Approve / Edit / Reject
```

---

## Credit Check

Before any tool write operation.

```
  ┌ CREDIT CHECK ─────────────────────────────────┐
  │ Tool:   {tool name}                            │
  │ Action: {what will happen}                     │
  │ Cost:   {record count or credit estimate}      │
  │ Rule:   {confirm-before-every-use / auto / ..} │
  └────────────────────────────────────────────────┘
  >> Proceed? (y/n)
```

---

## Five-Check Validation

Run before every output. Compact inline format.

```
  ── FIVE CHECKS ──────────────────────────────────
  [x] ICP fit       [x] Persona fit    [x] Briefing fit
  [x] Voice fit     [x] Quality fit
  ─────────────────────────────────────────────────
```

If a check fails:
```
  ── FIVE CHECKS ──────────────────────────────────
  [x] ICP fit       [x] Persona fit    [ ] Briefing fit
  [x] Voice fit     [x] Quality fit
  ─────────────────────────────────────────────────
  !! Briefing: CTA missing — BRIEFING.md has no primary CTA defined
```

---

## Status Symbols

```
[x]  Passed / Complete
[ ]  Failed / Missing
[~]  Borderline / Needs review
>>   Action prompt — waiting for human input
!!   Warning or flag
--   Skipped / Not applicable
```

---

## Health Check Dashboard

```
  ┌─ CAMPAIGN HEALTH ─────────────────────────────┐
  │                                                │
  │  Deliverability   [GREEN]  Bounce: 2.1%        │
  │  Engagement       [AMBER]  Reply: 4.2%         │
  │  Pipeline         [GREEN]  3 meetings booked   │
  │  Persona fit      [AMBER]  "Head of" 2x avg    │
  │                                                │
  │  Overall: ON TRACK                             │
  └────────────────────────────────────────────────┘
```

---

## Suggestion Block

When proposing changes to source-of-truth files.

```
  ┌─ SUGGESTION ──────────────────────────────────┐
  │ File:    {ICP.md / PERSONA.md / ...}           │
  │ Section: {section name}                        │
  │ Reason:  {data-backed reason}                  │
  │                                                │
  │ Current: {existing text}                       │
  │ Proposed: {new text}                           │
  │                                                │
  └────────────────────────────────────────────────┘
  >> Apply this change? (y/n)
```

---

## Reply Classification

```
  ┌─ REPLY ───────────────────────────────────────┐
  │ From:     {name}, {title} at {company}         │
  │ Channel:  {email / LinkedIn}                   │
  │ Type:     {POSITIVE / NEGATIVE / OBJECTION ..} │
  │                                                │
  │ "{reply text preview...}"                      │
  │                                                │
  │ Drafted response:                              │
  │ "{response preview...}"                        │
  │                                                │
  │ Actions:                                       │
  │   - Attio: move to {stage}                     │
  │   - Sequence: {pause / remove}                 │
  └────────────────────────────────────────────────┘
  >> Approve / Edit / Skip
```

---

## List Validation Summary

```
  ┌─ LIST VALIDATION ─────────────────────────────┐
  │ Records reviewed:  300                         │
  │                                                │
  │   Score 3 (ship):     87  ████████░░░░  29%    │
  │   Score 2 (good):    125  ██████████░░  42%    │
  │   Score 1 (review):   38  ████░░░░░░░░  13%    │
  │   Score 0 (reject):   50  █████░░░░░░░  17%    │
  │                                                │
  │ Top rejection reasons:                         │
  │   1. Wrong industry (30)                       │
  │   2. Company too small (12)                    │
  │   3. Personal email (8)                        │
  └────────────────────────────────────────────────┘
```

---

## Next Action Block

Always at end of a completed workflow.

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Next: {suggested next command}
     Also: {alternative command}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Cost Dashboard

Single workspace:
```
  ┌─ COST DASHBOARD ─────────────────────────────┐
  │ Workspace: {name}                              │
  │ Period:    {start} — {end}                     │
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

Budget warning (inline, when threshold crossed):
```
  !! Budget alert: 83% of campaign budget used ($208 of $250)
```

Agency-level overview (--all):
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
  └────────────────────────────────────────────────┘
```

Status: `[x]` under threshold, `[!]` above threshold, `[!!]` over budget

---

## Swarm Display

Spawning indicator:
```
  << GTMOS // SWARM >>

  Spawning 4 agents...
    [~] Agent 1: leads 1-10
    [~] Agent 2: leads 11-20
    [~] Agent 3: leads 21-30
    [~] Agent 4: leads 31-38
```

Progress updates as agents complete:
```
    [x] Agent 1: leads 1-10    — 10 drafts, 0 flags
    [x] Agent 2: leads 11-20   — 9 drafts, 1 flag
    [x] Agent 3: leads 21-30   — 10 drafts, 0 flags
    [~] Agent 4: leads 31-38
```

Swarm results summary:
```
  ┌─ SWARM RESULTS ───────────────────────────────┐
  │                                                │
  │  Agents spawned:  4                            │
  │  Leads processed: 38                           │
  │  Drafts ready:    35                           │
  │  Flagged:         3 (need manual review)       │
  │  Errors:          0                            │
  │                                                │
  └────────────────────────────────────────────────┘

  >> Options:
     1. Review all 38 drafts one by one
     2. Approve all clean drafts, review flagged only
     3. Export all drafts for offline review
```

---

## Tool Link Display

When showing tool links, always use a box. Never show raw URLs in paragraphs.

```
  ┌─ TOOL ───────────────────────────────────────┐
  │                                               │
  │  {Tool Name}                                  │
  │  {One-line description}                       │
  │  Plan required: {plan} ({price})              │
  │                                               │
  │  https://{domain}?ref=gtmos                   │
  │                                               │
  └───────────────────────────────────────────────┘
```

For multiple missing tools during onboarding:
```
  ┌─ MISSING TOOLS ──────────────────────────────┐
  │                                               │
  │  [ ] {Tool} — {category}                      │
  │      https://{domain}?ref=gtmos               │
  │                                               │
  │  [ ] {Tool} — {category}                      │
  │      https://{domain}?ref=gtmos               │
  │                                               │
  │  Add keys to .env, then re-run /gtm:status   │
  │                                               │
  └───────────────────────────────────────────────┘
```

---

## Anti-Patterns — What GTMOS never does

- Never use `GSD ►` prefix — that is GSD's brand
- Never use `╔═══╗` double-line boxes — that is GSD's checkpoint style
- Never use random emoji (no rockets, sparkles, stars)
- Never use `◆ ○` status dots — GTMOS uses `[x] [ ] [~]`
- Never vary box widths within the same output
- Never skip the five-check validation display on copy or list output
- Never show tool links as bare URLs in paragraphs — always use the tool link box

</ui_patterns>
