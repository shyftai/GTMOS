# /rev:onboard

Set up a new REV:OS workspace through structured intake — creates all workspace files from _template/ and populates them with the user's answers.

## When to use

- First time setting up REV:OS for a company
- Migrating from another RevOps setup
- Starting fresh after a major CRM migration

---

## What to do

### Step 0: Workspace exists check

Before starting intake, check if `workspaces/{any-name}/` already exists.

If a workspace is found:

```
⚠ EXISTING WORKSPACE DETECTED

  Workspace: {name}
  Created:   {date from workspace.config.md}
  ARR:       ${value from REVENUE.md}

  Running /rev:onboard will overwrite all workspace files.
  Are you sure? [yes — overwrite / no — keep existing / migrate — update specific files]
```

If the user selects **migrate**, ask which files they want to update and proceed with only those files. Do not touch the others.

If the user selects **no**, abort and suggest `/rev:health` or `/rev:dashboard` instead.

Only proceed with full onboard if the user selects **yes** or no workspace exists.

### Step 1: Welcome and scope

Tell the user:

> "I'll set up your REV:OS workspace in about 15 minutes. I'll ask for your company and CRM basics, then revenue and pipeline config, then data and integration status. You can skip anything you don't have yet — we'll fill it in as we go."

Ask for the workspace name: what should we call this workspace? (Usually the company name.)

### Step 2: Company and CRM basics

Ask in one block:

1. **Company name** — and what industry are you in?
2. **CRM system** — Salesforce or HubSpot? What edition?
3. **Company stage** — Series A / B / C+ / bootstrapped / public?
4. **Team** — who's in RevOps? Who do you serve (AEs, SDRs, CS)?

### Step 3: Revenue basics

Ask in one block:

5. **Current ARR** — what's your ARR today? (Approximate is fine)
6. **MRR definition** — what counts as MRR? Any exclusions (trials, professional services, one-time fees)?
7. **Billing system** — Stripe? Chargebee? Other?
8. **Revenue targets** — what's the ARR target for this year? This quarter's quota?

### Step 4: Pipeline configuration

Ask in one block:

9. **Pipeline stages** — what are your deal stages from SQL to Closed?
10. **Win rate** — do you know your current win rate? (Rough estimate is fine)
11. **Average sales cycle** — how long does a typical deal take?
12. **Average ACV** — what's a typical deal size?

### Step 5: Customer success setup

Ask in one block:

13. **CS platform** — do you use a CS platform? (Gainsight / ChurnZero / Vitally / Planhat / Totango / None yet)
14. **Customer count** — how many active customers do you have?
15. **Health scoring** — do you have a health score in place? If so, what signals does it use?
16. **Product analytics** — is your product analytics tool (Segment, Amplitude, etc.) connected to your CS platform?
17. **Biggest retention concern** — what's the current state of churn / NRR?

### Step 6: Data and integrations

Ask in one block:

18. **Data quality** — on a scale of 1–10, how would you rate your CRM data quality?
19. **Biggest data problems** — what's the messiest thing in your CRM right now?
20. **Connected tools** — which tools are integrated with your CRM? (Gong, Stripe, sequencing tool, CS platform)
21. **Attribution** — do you track lead source in your CRM? What attribution model do you use?

### Step 7: Create workspace files

1. Create workspace directory: `workspaces/{workspace-name}/`
2. Copy all files from `_template/` into the new workspace directory
3. Populate each file with answers from the intake
4. Create `logs/` directory with `auto-log.md` and `workspace-log.md`

Seed `logs/auto-log.md` with the audit log header:

```markdown
# Auto Mode Audit Log — {Workspace Name}

All auto-approved actions are logged here. Format per entry:

---
timestamp: [YYYY-MM-DD HH:MM]
action: [what was done]
tool: [tool used]
input: [what triggered it]
output: [result]
cost: [$X or N/A]
files_changed: [list]
gate_skipped: [none]
---
```

Pre-fill based on answers:
- `CRM.md` — system, edition, stage definitions (standard template + user's stages)
- `REVENUE.md` — ARR, MRR definition, targets
- `PIPELINE.md` — stages, quota, velocity targets (use rev-benchmarks.md defaults for missing fields)
- `DATA-QUALITY.md` — initial score based on user's self-assessment; known issues from intake
- `STRIPE.md` — integration status, MRR definition
- `FORECAST.md` — methodology (default: weighted pipeline), quota from intake
- `CUSTOMERS.md` — customer registry (empty, with instructions to populate via CS platform export)
- `CS-CONFIG.md` — CS platform, health score weights (defaults from rev-health-scoring.md), CRM field mapping
- `TEAM.md` — names and roles from intake
- `INTEGRATIONS.md` — connected tools from intake (including CS platform status)
- `workspace.config.md` — workspace name, mode (interactive), fiscal year

### Step 8: Display summary

Show the completed workspace setup:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
WORKSPACE CREATED: [Workspace Name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  CRM:         [System] ([Edition])
  ARR:         $[X]M  |  Target: $[X]M
  Quarter:     Q[X] [Year]  |  Quota: $[X]M
  Team:        [X] RevOps  |  [X] AEs

  Files created: [X]
  Integration status: [X] connected / [X] pending

  Next steps:
  1. Review CRM.md — confirm stage definitions
  2. Run /rev:health — baseline your data quality
  3. Run /rev:stripe — verify Stripe reconciliation
  4. Run /rev:cs-health — baseline customer health (if CS platform connected)
  5. Run /rev:today — start your first daily briefing
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
