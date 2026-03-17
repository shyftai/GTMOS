# ECOMMERCE:OS

An ecommerce operating system for DTC founders, heads of ecommerce, and performance marketing managers. ECOMMERCE:OS covers the full brand growth lifecycle across three loops: Acquire, Convert, Retain.

---

## Who it's for

- DTC founders running a direct-to-consumer brand (Shopify, WooCommerce, custom)
- Heads of ecommerce managing paid channels, email, and retention
- Performance marketing managers running paid acquisition campaigns
- Brand operators scaling from $500K to $20M+ in annual revenue

---

## The three-loop model

### Acquire
Get new customers through paid ads (Meta, Google, TikTok), email list growth, influencer and affiliate programs, SEO, and organic social. Plan and execute product launches and promotions.

### Convert
Turn traffic into buyers. Audit product pages, checkout flow, and site experience for CRO wins. Improve offer structure, reduce cart abandonment, and set up attribution correctly.

### Retain
Maximize lifetime value. Build and optimize lifecycle email and SMS flows (welcome, abandoned cart, post-purchase, win-back). Analyze repeat purchase rates, loyalty programs, and subscription products.

---

## Quick start

### First time setup
```
/ecom:onboard
```
Creates your workspace and populates all brand files through a structured 9-block intake.

### Daily
```
/ecom:today {workspace}
```
Daily briefing across all three loops — revenue status, active alerts, urgent actions.

### Weekly
```
/ecom:dashboard {workspace}
/ecom:health {workspace}
```

---

## Commands

| Command | What it does |
|---------|-------------|
| `/ecom:today` | Daily briefing — revenue, alerts, actions |
| `/ecom:dashboard` | Full Acquire / Convert / Retain / Finance view |
| `/ecom:onboard` | First-time brand setup (9-block intake) |
| `/ecom:campaign` | Create a paid, email, or SMS acquisition campaign |
| `/ecom:launch` | Full product launch workflow (4-week plan) |
| `/ecom:flow` | Build or optimize an email/SMS automation flow |
| `/ecom:promo` | Plan a promotion or sale event |
| `/ecom:audit` | Channel audit — paid, email, or site CRO |
| `/ecom:report` | Weekly or monthly performance report |
| `/ecom:signals` | Scan for market trends and competitor moves |
| `/ecom:retention` | Retention analysis and win-back campaign |
| `/ecom:forecast` | Revenue and inventory forecast |
| `/ecom:health` | Full health check across all three loops |

---

## File structure

```
industry-os/ecommerce/
├── ECOMMERCEOS.md          Core system definition and rules
├── CLAUDE.md               Startup instructions
├── README.md               This file
├── _template/              Workspace scaffolding — copied on /ecom:onboard
│   ├── BRAND.md            Brand identity, voice, positioning
│   ├── PRODUCTS.md         Product catalog, pricing, margins, stock
│   ├── CHANNELS.md         Active marketing channels + performance
│   ├── AUDIENCES.md        Customer segments
│   ├── CALENDAR.md         Promo and launch calendar
│   ├── METRICS.md          Live KPIs and performance
│   ├── FLOWS.md            Active email/SMS automation flows
│   ├── FINANCE.md          P&L, contribution margin, cash position
│   ├── COMPETITORS.md      Competitive landscape
│   ├── LEARNINGS.md        Persistent learnings
│   ├── ROADMAP.md          Growth roadmap
│   ├── TOOLS.md            Tech stack
│   ├── SUPPRESSION.md      Email/SMS suppression list
│   ├── COSTS.md            Budget and spend tracking
│   ├── SCRAPE-JOURNAL.md   API audit trail
│   ├── workspace.config.md Execution mode and brand config
│   └── logs/
│       ├── auto-log.md     Auto mode decision log
│       └── workspace-log.md General activity log
├── references/
│   ├── ecom-channels.md    Channel strategy and best practices
│   ├── ecom-metrics.md     KPI definitions and benchmarks
│   ├── ecom-calendar.md    Promotional calendar and key dates
│   ├── email-flows.md      Standard lifecycle flow library
│   ├── cro-playbook.md     Conversion rate optimization tactics
│   ├── product-launch.md   Product launch framework
│   ├── attribution-guide.md Attribution models and setup
│   └── ecom-benchmarks.md  Industry benchmarks by vertical
└── .claude/commands/ecom/  Command definitions
    ├── today.md
    ├── dashboard.md
    ├── onboard.md
    ├── campaign.md
    ├── launch.md
    ├── flow.md
    ├── promo.md
    ├── audit.md
    ├── report.md
    ├── signals.md
    ├── retention.md
    ├── forecast.md
    └── health.md
```

---

## How it works

ECOMMERCE:OS is a standalone system. Workspaces live at `workspaces/{brand-name}/` and contain all brand-specific files. The template folder provides the scaffolding — `/ecom:onboard` copies it and populates it through a guided intake.

Two execution modes are available:
- **Interactive** (default) — approval required before campaigns, sends, promos, and flow activations
- **Auto** — auto-approves drafting, research, and analysis; hard gates always require approval

Hard gates protect against the most common ecommerce errors: launching campaigns for out-of-stock products, running promotions below margin floor, sending email without suppression checks, and launching paid ads without UTM tracking.

---

## Part of the Industry OS family

ECOMMERCE:OS is built on the same core architecture as AGENCY:OS. It is a standalone system — GTM:OS tools are optional. See `industry-os/_shared/OS-TEMPLATE.md` for the full industry OS specification.
