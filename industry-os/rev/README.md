# REV:OS — Revenue Operations System

**Clean your data. Understand your pipeline. Retain your customers.**

REV:OS is a complete revenue operations system built on top of GTM:OS. It covers everything needed to run RevOps at a B2B company — from CRM hygiene and Stripe reconciliation to pipeline velocity, win/loss analysis, 360-degree customer health, and board-ready revenue reporting.

---

## What REV:OS does

**Clean** — keeps your revenue data trustworthy
- CRM health audits: field completion, enrichment gaps, stale records
- Duplicate detection and resolution for accounts, contacts, and deals
- Stripe ↔ CRM reconciliation with ARR/MRR alignment
- Enrichment waterfall with cache management and cost tracking

**Analyze** — makes your pipeline and revenue visible
- Pipeline velocity: stage conversion, deal age, bottleneck identification
- Win/loss analysis: structured capture, pattern recognition, competitive themes
- Multi-touch attribution: pipeline and revenue by source and channel
- Cohort analysis: retention, expansion, and churn by segment and channel

**Forecast** — builds revenue predictability
- Weighted pipeline, rep commit, and historical run-rate models
- Coverage checks and scenario modeling (commit / most likely / upside)
- Forecast accuracy tracking over time
- Board-ready revenue reports with Stripe-verified numbers

**Retain** — builds a 360-degree view of every customer
- Customer health monitoring: composite scores from CS platform, product usage, support, NPS, and commercial signals
- Renewal pipeline: every upcoming renewal tracked with risk assessment and motion timeline
- Expansion pipeline: usage signals, seat limits, and NPS data surface the right accounts to pitch
- Churn risk triage: at-risk accounts ranked by ARR, root causes identified, intervention plans built
- Customer 360: full account view combining contract, health, product, relationship, and commercial data in one place

---

## Commands

| Command | What it does |
|---------|-------------|
| `/rev:today` | Daily action briefing |
| `/rev:dashboard` | Full RevOps dashboard |
| `/rev:onboard` | Set up a new workspace |
| `/rev:health` | Full CRM data quality audit |
| `/rev:dedupe` | Find and resolve duplicate records |
| `/rev:enrich` | Enrich CRM records with firmographic and contact data |
| `/rev:stripe` | Reconcile Stripe billing data with CRM |
| `/rev:pipeline` | Pipeline velocity and stage conversion analysis |
| `/rev:forecast` | Build and update the revenue forecast |
| `/rev:win-loss` | Win/loss pattern analysis |
| `/rev:attribution` | Multi-touch attribution reporting |
| `/rev:cohort` | Cohort retention and expansion analysis |
| `/rev:signals` | Scan for time-sensitive RevOps signals |
| `/rev:report` | Generate weekly, monthly, QBR, or board reports |
| `/rev:customer [account]` | Full 360-degree view of a specific customer |
| `/rev:cs-health` | Fleet-level customer health dashboard |
| `/rev:renewal` | Renewal pipeline management |
| `/rev:expansion` | Surface and prioritize expansion opportunities |
| `/rev:churn-risk` | Identify and triage at-risk accounts |
| `/rev:migrate` | Move from one CRM to another — audit, field mapping, execution, validation |

---

## Quick start

1. Open Claude Code in `industry-os/rev/`
2. Run `/rev:onboard` — 15-minute setup (includes CS platform config)
3. Run `/rev:health` — baseline your data quality
4. Run `/rev:cs-health` — baseline your customer health fleet
5. Run `/rev:today` — your first daily briefing

## CS platform support

REV:OS works with all major CS platforms: **Gainsight**, **ChurnZero**, **Vitally**, **Planhat**, **Totango**, and **Intercom**. For teams without a dedicated CS platform, REV:OS includes a manual health scoring system using `CUSTOMERS.md` — no tool required to get started.

Health scores combine five signal categories: product engagement, relationship, support and sentiment, commercial health, and organizational stability. Scores are calibrated against your actual churn history and include override rules for severe signals (no login 30+ days, NPS Detractor, payment failure).

---

## What REV:OS is not

REV:OS is **not** a CRM. It works alongside your CRM (Salesforce, HubSpot) and billing system (Stripe), making sense of the data they contain without replacing them.

REV:OS is **not** a BI tool. It produces analysis and reports; your BI layer (Looker, Metabase, Sheets) handles visualization and self-serve dashboards.

REV:OS is **not** a sales tool. It doesn't run sequences or manage outbound campaigns — that's GTM:OS.

---

## Part of GTM:OS

REV:OS is built on the GTM:OS platform. It inherits:
- Enrichment waterfall and caching rules
- Compliance framework (GDPR, CASL, CAN-SPAM)
- API reference and tool integrations
- Visual formatting standards

---

*REV:OS v1.0.0 — by Shyft AI*
