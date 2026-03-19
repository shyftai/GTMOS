# /rev:onboard

Set up a new REV:OS workspace — or resume one in progress.

---

## Step 0: Workspace exists check

Before anything else, check if `workspaces/{any-name}/` already exists.

If found:

```
⚠ EXISTING WORKSPACE DETECTED

  Workspace: {name}
  Created:   {date from workspace.config.md}
  ARR:       {currency symbol}{value from REVENUE.md}
  Setup:     {X}% complete

  Options:
  [1] Continue setup — add missing files and configuration
  [2] Full restart — overwrite everything (⚠ destructive)
  [3] Exit — keep as-is, run /rev:dashboard to see current state
```

Select **Continue setup** if any workspace files are missing or still contain template placeholders.
Select **Full restart** only if the user explicitly confirms they want to overwrite.
Select **Exit** if the workspace is already healthy.

---

## Step 1: Triage

Three questions. This determines everything about how setup proceeds.

Ask as a single block:

```
Before we set up your workspace, I need to understand your situation.

1. What describes you best?
   [A] I just joined this company / new to this role
   [B] I'm taking over RevOps from someone else
   [C] Building RevOps from scratch — no real process exists yet
   [D] I have a specific problem I need to solve right now
   [E] I just migrated (or am migrating) to a new CRM

2. What's most urgent right now?
   [1] Forecast is off or unreliable
   [2] Pipeline is unclear or stalling
   [3] CRM data is messy
   [4] Customers are at risk or churning
   [5] Need reporting for a board or exec meeting
   [6] Setting up everything for the first time
   [7] CRM migration — moving to a new system

3. What CRM are you on, and is it configured for RevOps?
   CRM: [Salesforce / HubSpot / Pipedrive / Other]
   Status: [Already set up / Needs fields + pipelines / Just migrated / Starting fresh]
```

Route based on answers:

| Situation | Urgent problem | Path |
|-----------|---------------|------|
| A or B (new/taking over) | Any | → 🔍 Diagnostician |
| C (building from scratch) | 6 | → 🏗 Builder |
| D (specific problem) | 1–5 | → 🚨 Firefighter |
| E or CRM = just migrated | 7 | → 🔄 Migrator |
| D (specific problem) | 5 (board meeting) | → 🚨 Firefighter (fast path) |

---

## Path A: 🔍 Diagnostician
*"I just joined / taking over — I need to understand the business."*

The goal is a diagnostic picture first, workspace configuration second. You learn more by looking at the data than by asking questions.

### Step A1: Minimal intake (one block, 4 questions)

```
1. What's the company name and CRM?
2. What currency do you report in? (USD / EUR / GBP / other)
3. Roughly how many AEs, SDRs, CSMs, and RevOps people are there?
4. What do you think is the biggest problem — or do you not know yet?
```

Create the workspace directory and populate `workspace.config.md` with these answers. Leave all other files as templates for now.

### Step A2: Diagnostic run

Tell the user: *"Before we configure anything, let me look at what's actually in your CRM. This gives us a real baseline — not what someone thinks the numbers are."*

Run in sequence:
1. **Data quality snapshot** — field completion rates, duplicate estimate, source coverage
2. **Pipeline snapshot** — open deals by stage, total value, avg deal age, stall count
3. **Revenue snapshot** — ARR/MRR, MoM trend if visible, NRR estimate

Present findings:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DIAGNOSTIC — {Company} — {Date}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

What I found:

  CRM data quality:   {X}%  [{🟢 Good / 🟡 Fixable / 🔴 Needs work}]
  Source coverage:    {X}% of deals have lead source set
  Duplicate risk:     {Low / Medium / High} — ~{X} clusters estimated

  Pipeline:           {X} open deals · {currency}{X} value
  Avg deal age:       {X} days  [{🟢 Normal / 🟡 Slowing / 🔴 Stalled}]
  Stage coverage:     {X}× quota  [{🟢 / 🟡 / 🔴}]

  ARR:                {currency}{X}  MRR: {currency}{X}
  Health data:        {Available from CS platform / Not yet connected / Manual}

Top 3 things to fix first:
  1. {Most critical finding}
  2. {Second finding}
  3. {Third finding}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Step A3: Configure from what we found

Use diagnostic results to pre-fill workspace files — asking only for what the data can't tell us:

```
Based on what I found, I need a few things the data doesn't show:

1. What's this quarter's new ARR quota? (Total, and by rep if you know it)
2. What does your forecast call look like right now — Commit / Most likely / Upside?
3. Do you have a CS platform? If yes, which one?
```

Populate all workspace files. Move to Step A4.

### Step A4: First week plan (Diagnostician)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
YOUR FIRST WEEK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TODAY       /rev:health  — full data audit with fix priorities
            /rev:pipeline — map velocity and spot the biggest bottleneck

DAY 2       Fix top data issues from /rev:health
            /rev:forecast — build your first forecast call

DAY 3       Share forecast with CRO for calibration
            /rev:cs-health — baseline customer health fleet

DAY 5       /rev:signals — scan for anything time-sensitive
            Begin fixing attribution gaps

DAY 7       /rev:dashboard — your first complete RevOps view
            Share with leadership: "Here's what I found and what I'm fixing"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Path B: 🚨 Firefighter
*"I have a specific problem that needs solving right now."*

Skip full setup. Get to the relevant command immediately. Configure workspace in the background as you work.

### Step B1: Route to the right command

| Urgent problem | Go here first | Configure while running |
|---------------|--------------|------------------------|
| Forecast is off | `/rev:forecast` | FORECAST.md, PIPELINE.md |
| Pipeline is unclear | `/rev:pipeline` | PIPELINE.md, CRM.md |
| CRM data is messy | `/rev:health` | DATA-QUALITY.md |
| Customers at risk | `/rev:cs-health` | CUSTOMERS.md, CS-CONFIG.md |
| Board meeting prep | `/rev:report` | REVENUE.md, FORECAST.md |

Tell the user:

> "Let's get you to [{command}] right now — that's what will solve [{problem}] fastest. I'll collect workspace configuration as we work so you don't have to set up everything upfront."

Ask only the minimum needed to run the target command:

```
To run {command}, I need:
1. {Minimum question 1 — e.g. "What's your current ARR and this quarter's quota?"}
2. {Minimum question 2}
```

Create partial workspace with just the files needed for the target command.

After the first command completes, offer to continue setup:

> "That's your {problem} addressed. Want to take 10 minutes to complete the workspace setup so REV:OS has full context next session? Or run `/rev:onboard continue` later when you have time."

### Step B2: `/rev:onboard continue`

Resumes setup for Firefighter workspaces with partial configuration.

Check `workspace.config.md` for `setup_progress` field. Show what's done and what's missing:

```
SETUP PROGRESS — {Workspace Name}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ workspace.config.md
✅ PIPELINE.md
✅ FORECAST.md
░░ REVENUE.md         — needs ARR definition and targets
░░ DATA-QUALITY.md    — needs field standards and enrichment config
░░ CUSTOMERS.md       — needs CS platform export
░░ CS-CONFIG.md       — needs health score weights
░░ TEAM.md            — needs rep roster and quotas
░░ ATTRIBUTION.md     — needs attribution model and UTM standards
░░ STRIPE.md          — needs Stripe plan mapping

Ask one block to cover the remaining gaps.
```

---

## Path C: 🏗 Builder
*"Building RevOps from scratch — no real process exists yet."*

CRM setup first. Workspace configuration second. You can't fill in workspace files if the CRM doesn't have the right fields yet.

### Step C1: CRM setup check

```
Before we configure your workspace, let's make sure your CRM is ready for RevOps.

Does your CRM have:
  [ ] Custom fields for Account tier, Health score, Renewal date
  [ ] Deal fields for Forecast category, Loss reason, Deal type, Next step
  [ ] Contact fields for Lead source, UTM parameters, Persona
  [ ] Pipeline stages with defined probabilities and exit criteria
  [ ] Lead source required on all contacts and deals

How many of these are in place? (All / Some / None)
```

If **None** or **Some**: Load `references/rev-crm-setup.md` and walk through CRM configuration first. Do not proceed to workspace setup until the CRM readiness checklist is at least 70% complete.

If **All**: Proceed directly to Step C2.

### Step C2: Full structured intake

Run the complete intake in five blocks. Do not skip blocks — for a Builder, complete configuration upfront prevents constant context gaps.

**Block 1 — Identity (one block):**
```
1. Company name and industry
2. CRM system and edition
3. Currency and locale (USD / EUR / GBP / other)
4. Company stage (Seed / A / B / C+ / public)
5. Fiscal year start month
```

**Block 2 — Revenue and targets (one block):**
```
6. Current ARR (approximate)
7. This year's ARR target
8. This quarter's new ARR quota (total)
9. MRR definition — what's included and excluded
10. Billing system (Stripe / Chargebee / other)
```

**Block 3 — Sales team (one block):**
```
11. Number of AEs, their names, and individual quotas
12. Number of SDRs and meeting/pipeline targets
13. Pipeline stages from SQL to Closed Won
14. Average ACV and average sales cycle
15. Current win rate (estimate)
```

**Block 4 — Customer success (one block):**
```
16. Number of active customers
17. CS platform (Gainsight / ChurnZero / Vitally / Planhat / Totango / None)
18. Current NRR (estimate — or "don't know yet")
19. Biggest retention concern right now
20. Product analytics tool (Amplitude / Mixpanel / Segment / None)
```

**Block 5 — Data and attribution (one block):**
```
21. Self-rated data quality (1–10)
22. Biggest known data problem
23. Attribution model in use (first touch / last touch / multi-touch / none)
24. Tools connected to CRM (Gong / Stripe / sequencing tool / CS platform / other)
25. Lead source tracked on contacts and deals? (Yes / No / Partially)
```

Populate all workspace files from these answers. Move to Step C3.

### Step C3: First week plan (Builder)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
YOUR FIRST WEEK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TODAY       /rev:health  — baseline data quality (expect 🔴 — that's normal)
            Fix the top 3 issues it surfaces

DAY 2       /rev:stripe  — connect Stripe and verify ARR
            /rev:pipeline — first pipeline velocity view

DAY 3       /rev:quota   — set rep quotas and coverage targets
            /rev:forecast — first forecast call (will be rough — that's fine)

DAY 5       /rev:cs-health — score your customer fleet
            Flag any 🔴 accounts immediately

DAY 7       /rev:dashboard — your first full RevOps view
            Run /rev:signals — catch anything time-sensitive

WEEK 2+     /rev:attribution — set up UTM tracking and source taxonomy
            /rev:win-loss — start capturing win/loss data
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Path D: 🔄 Migrator
*"Just migrated or migrating to a new CRM."*

Stop onboard. Route to the right phase of `/rev:migrate`.

Tell the user:

> "CRM migrations need their own workflow — `/rev:migrate` is built specifically for this. It audits your data before or after the move, generates your field mapping, validates everything arrived correctly, and walks you through reconnecting integrations in the right order."
>
> "Run `/rev:migrate` and come back to finish workspace setup once the migration is stable. If you're mid-migration and things are messy, `/rev:migrate` has a recovery mode for that too."

Do not create workspace files yet — data in the new CRM may still be incomplete or broken. Wait until `/rev:migrate` Phase 3 validation is complete.

---

## Workspace creation (all paths except D)

Once intake is complete (whichever path), create the workspace:

**1. Create directories:**
```
workspaces/{workspace-name}/
workspaces/{workspace-name}/logs/
```

**2. Copy templates and populate:**
All files from `_template/` → workspace directory, populated with intake answers.

Currency: replace all `$` placeholders with the configured currency symbol throughout all files.

Forecast methodology: auto-select based on team size:
- 1–3 AEs → bottom-up rep commit
- 4–10 AEs → weighted pipeline + rep commit
- 10+ AEs → weighted pipeline + territory model + rep commit

**3. Seed logs/auto-log.md:**
```markdown
# Auto Mode Audit Log — {Workspace Name}

---
timestamp: [YYYY-MM-DD HH:MM]
action: Workspace created via /rev:onboard — {path name}
tool: none
input: /rev:onboard
output: {X} workspace files created
cost: N/A
files_changed: [list all created files]
gate_skipped: none
---
```

**4. Write setup progress to workspace.config.md:**
Add a `setup_progress` section listing each file and whether it's configured or still needs data. This drives the setup tracker in the startup header.

---

## Completion summary (all paths)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
WORKSPACE READY — {Workspace Name}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  CRM:         {System} · {Edition}
  ARR:         {currency}{X}  |  Target: {currency}{X}
  Quarter:     Q{X} {Year}  |  Quota: {currency}{X}
  Team:        {X} RevOps · {X} AEs · {X} SDRs · {X} CSMs
  Currency:    {code} ({symbol})

  Setup:       [{'█' × (complete/total * 10)}{'░' × remaining}] {X}%

  Files ready:    {X}
  Files pending:  {X} — run /rev:onboard continue to finish

  Your path: {path name}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
{first week plan for the path taken}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
