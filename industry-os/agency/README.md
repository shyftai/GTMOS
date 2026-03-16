# AGENCY:OS

**Win clients. Retain them. Grow them.**

AGENCY:OS is the first vertical industry OS built on top of GTM:OS. It extends the GTM:OS execution engine with agency-specific context for marketing, creative, and digital agencies doing new business development and client retention.

---

## What it does

| Layer | What it adds |
|-------|-------------|
| **New business** | Pre-configured ICP, buyer personas, and buying signals for agency services |
| **Outreach** | 7 campaign types specific to agency selling |
| **Pitch** | Proposal generation with service line and case study matching |
| **Retention** | QBR prep, retainer renewal, upsell, and referral activation workflows |
| **Portfolio** | Live view of clients, health, MRR, and pipeline in one dashboard |

---

## Architecture

```
GTM:OS (execution engine)
    └── AGENCY:OS (context layer)
            ├── Agency ICP + Personas
            ├── Service Lines + Case Studies
            ├── Client Roster + Health
            ├── New Business Pipeline
            └── Retention Workflows
```

GTM:OS handles all execution: list building, enrichment, copy writing, campaign management, and sending. AGENCY:OS provides the agency-specific intelligence layer on top.

---

## Quick start

1. Copy `_template/` to your workspace folder (e.g. `workspaces/my-agency/`)
2. Fill in `SERVICE-LINES.md` with your actual service catalog
3. Fill in `CASE-STUDIES.md` with real results
4. Fill in `CLIENTS.md` with active client roster
5. Customize `ICP.md` for your specific sweet spot
6. Run `/agency:new-business` to launch your first campaign

---

## Commands

| Command | What it does |
|---------|-------------|
| `/agency:new-business` | Launch a new business development campaign |
| `/agency:pitch` | Generate a pitch or proposal for a prospect |
| `/agency:retainer-renewal` | Run the renewal workflow for an existing client |
| `/agency:upsell` | Identify and pitch an upsell to an existing client |
| `/agency:qbr-prep` | Prepare a quarterly business review |
| `/agency:referral` | Run referral activation with green-health clients |
| `/agency:client-onboard` | Onboard a new client after contract signed |
| `/agency:portfolio` | Portfolio dashboard: clients, pipeline, alerts |

All GTM:OS commands (`/gtm:*`) are also available — for enrichment, list building, copy, and sending.

---

## Who it's for

Marketing, creative, and digital agencies that:
- Are actively doing new business development
- Have at least one retainer client to manage
- Want to systematize outbound, retention, and growth in one place

---

## File structure

```
industry-os/agency/
├── AGENCYOS.md              Core system definition
├── CLAUDE.md                Startup instructions for Claude
├── README.md                This file
├── _template/               Workspace scaffolding — copy to start
│   ├── ICP.md               Pre-filled for agency new business
│   ├── PERSONA.md           CMO, VP Marketing, Founder personas
│   ├── TOV.md               Agency tone of voice
│   ├── RULES.md             Agency-specific rules
│   ├── TOOLS.md             Agency tech stack defaults
│   ├── SERVICE-LINES.md     Service catalog
│   ├── CASE-STUDIES.md      Proof points library
│   ├── PRICING.md           Service packages
│   ├── CLIENTS.md           Active client roster + health
│   ├── PIPELINE.md          New business pipeline
│   ├── COMPETITORS.md       Competing agencies
│   ├── COSTS.md             Budget tracking
│   ├── SUPPRESSION.md       Suppression list
│   ├── INFRASTRUCTURE.md    Sending infrastructure
│   ├── SCRAPE-JOURNAL.md    API call audit trail
│   └── workspace.config.md  Execution mode config
├── references/              Reference files for Claude
│   ├── agency-campaigns.md  7 agency campaign types
│   ├── agency-personas.md   Deep persona profiles
│   ├── agency-signals.md    Buying signals + urgency ratings
│   ├── agency-objections.md Objection handling playbook
│   ├── agency-benchmarks.md Agency industry benchmarks
│   ├── pitch-frameworks.md  Pitch and proposal frameworks
│   ├── retainer-workflows.md QBR, renewal, upsell workflows
│   └── client-reporting.md  Client report templates
└── .claude/commands/agency/ Command definitions
    ├── new-business.md
    ├── pitch.md
    ├── retainer-renewal.md
    ├── upsell.md
    ├── qbr-prep.md
    ├── referral.md
    ├── client-onboard.md
    └── portfolio.md
```

---

## Building your own industry OS

See `industry-os/_shared/OS-TEMPLATE.md` for the template used to create AGENCY:OS. Copy it to build the next vertical.
