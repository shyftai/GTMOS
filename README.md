# GTMOS — The GTM Operating System

> Turn Claude Code into a full outbound campaign engine. Brief it. Build it. Ship it. Measure it.

GTMOS is a Claude Code plugin that runs your entire go-to-market workflow — from ICP definition to list building, copy writing, shipping sequences, handling replies, and reporting on results. It connects to your outbound stack via API, enforces quality at every step, and never ships anything that drifts from the brief.

**Built for:** agencies, growth teams, founders, and solo operators running B2B outbound.

---

## 60-second quick start

```
git clone https://github.com/shyftai/GTMOS.git
cd GTMOS
cp .env.example .env          # add your API keys
# open in Claude Code, then:
/gtm:onboard my-company       # full onboarding (14 blocks)
/gtm:onboard my-company --quick  # fast start (5 blocks)
```

That's it. Claude walks you through setup, creates your workspace, and you're ready to build campaigns.

---

## What it does

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

Every task is checked against five sources of truth before anything ships:

| File | What it controls |
|------|-----------------|
| **ICP.md** | Who you target (company level) |
| **PERSONA.md** | Who you target (human level) |
| **BRIEFING.md** | Campaign angle, offer, CTA |
| **TOV.md** | Brand voice, channel rules, banned phrases |
| **RULES.md** | List quality standards, copy quality standards, lead scoring |

If it drifts from the brief, it doesn't ship.

---

## How a campaign works

**1. Onboard** → `/gtm:onboard` walks through your offer, ICP, persona, voice, tools, and infrastructure. Have CRM data? Start with `/gtm:deep-dive` to build ICP from evidence

**2. Research** → `/gtm:research` maps ICP companies, market landscape, and buying signals

**3. Build a list** → `/gtm:list-brief` creates a sourcing brief, `/gtm:enrich` fills gaps via waterfall enrichment, `/gtm:validate-list` cleans, scores (0-100), and validates

**4. Write copy** → `/gtm:write` drafts a sequence using cold email best practices — peer voice, observation-led openers, interest-based CTAs, angle rotation per touch

**5. Ship** → `/gtm:ship` runs a pre-flight checklist (suppression, DNS, warmup, budget, holiday calendar) and pushes to your sending tool

**6. Manage** → `/gtm:replies` classifies and drafts responses, `/gtm:signals` triggers timely outreach, `/gtm:health` monitors performance

**7. Report** → `/gtm:report` generates client-facing reports, `/gtm:debrief` feeds learnings back into the system

---

## Campaign types

Pick a type when creating a campaign — defaults pre-fill automatically:

| Type | Touches | Best for |
|------|---------|----------|
| Cold outbound | 4 | First outreach to new ICP contacts |
| Signal-triggered | 2-3 | Timely outreach on funding, hiring, or news |
| Competitor displacement | 3-4 | Targeting users of a specific competitor |
| Event follow-up | 3 | Post-conference or webinar outreach |
| Product launch | 3 | Timed to a new feature or update |
| ABM | 3-4 per contact | Multi-threaded into high-value accounts |
| Re-engagement | 2 | Reviving contacts who went cold 60+ days ago |

---

## Supported tools

### Prospecting & enrichment
Apollo · Icypeas · Prospeo · Apify · StoreLeads · Opemart · Clay (optional orchestration)

### Email sequencing
Instantly · Lemlist · Smartlead

### LinkedIn
Crispy (MCP server — Claude Code controls LinkedIn directly, including Sales Navigator)

### CRM
Attio · HubSpot · Salesforce · Pipedrive

### Signals
Signalbase · Commonroom · Jungler.ai · Trigify · Sentrion.ai · Fantastic.jobs

### Lookalike discovery
Ocean.io (feed customers → get ranked lookalikes) · DiscoLike (AI-powered discovery across 60M+ domains)

### Research & scraping
Exa (MCP — semantic search, company research, deep research) · Firecrawl (MCP — web scraping, structured extraction)

### Meeting transcripts
Fireflies.ai (pull sales call transcripts via API for data deep-dives)

### Email finding & verification
Dropcontact · FindyMail · ZeroBounce · MillionVerifier · Scrubby

Reads are auto-approved. Writes follow credit rules per workspace. Every write is logged in COSTS.md with date, units, cost, and approver.

---

## Smart defaults, full control

GTMOS ships with sensible defaults for everything:

- **Copy:** 2-4 word lowercase subjects, 75-word first touch, interest-based CTAs, banned spam words
- **Sending:** 40 emails/inbox/day, 14-day warmup minimum, holiday blackouts for 20+ countries
- **Scoring:** weighted 0-100 lead scoring (company fit, persona, signals, data quality, engagement)
- **Compliance:** suppression checks before every send, unsubscribe on every email, hard bounce auto-removal

**Every default is overridable per workspace.** Add a `## Lead scoring overrides` section to RULES.md, change copy rules in TOV.md, adjust sending limits in INFRASTRUCTURE.md. If you don't override, the defaults just work.

---

## All commands

### Setup
| Command | What it does |
|---------|-------------|
| `/gtm:onboard <name>` | Onboard a new workspace (full, `--quick`, or deep-dive) |
| `/gtm:deep-dive <name>` | Build ICP from CRM data, campaigns, and transcripts |
| `/gtm:research <name>` | Research ICP companies and market |
| `/gtm:new-campaign <ws> <name>` | Create a campaign with type selection |
| `/gtm:switch <name>` | Switch active workspace |
| `/gtm:status` | Show workspace status and commands |
| `/gtm:dashboard <ws>` | Smart dashboard — what needs attention now |

### Build
| Command | What it does |
|---------|-------------|
| `/gtm:list-brief <ws> <campaign>` | Create a list building brief |
| `/gtm:enrich <ws> <type> [file]` | Waterfall enrichment (email, phone, people, company) |
| `/gtm:clean-list <ws> [file]` | Clean and normalize a raw list |
| `/gtm:validate-list <ws> [file]` | Clean + score (0-100) + validate |
| `/gtm:write <ws> [touches] [channel]` | Draft an outbound sequence |
| `/gtm:validate-copy <ws>` | QA check copy against all rules |
| `/gtm:ship <ws> <campaign>` | Push to sending tool with pre-flight checks |

### Live campaign
| Command | What it does |
|---------|-------------|
| `/gtm:replies <ws>` | Classify and draft responses to replies |
| `/gtm:signals <ws>` | Scan for signal-triggered outreach |
| `/gtm:sync <ws>` | Pull latest data from connected tools |
| `/gtm:health <ws> <campaign>` | Full health check with pattern detection |
| `/gtm:linkedin-warm <ws>` | Pre-outreach LinkedIn warming |
| `/gtm:account-based <ws>` | Multi-thread a target account |

### Infrastructure
| Command | What it does |
|---------|-------------|
| `/gtm:infra <ws>` | Check sending infrastructure and DNS |
| `/gtm:warmup <ws>` | Check inbox warmup status |
| `/gtm:pipeline <ws>` | View CRM pipeline and conversions |
| `/gtm:domain-recovery <ws>` | Recover a damaged sending domain |

### Review
| Command | What it does |
|---------|-------------|
| `/gtm:brief-audit <ws>` | Check briefing for gaps |
| `/gtm:stress-test <ws>` | Challenge ICP assumptions |
| `/gtm:debrief <ws> <campaign>` | End-of-campaign review with forward-feed |
| `/gtm:report <ws> <campaign>` | Client-facing report (weekly/monthly/final) |
| `/gtm:post-meeting <ws>` | Post-meeting follow-up workflow |
| `/gtm:re-engage <ws>` | Re-engagement campaign for cold leads |
| `/gtm:archive <ws>` | Archive completed campaign or workspace |
| `/gtm:costs <ws> [--all]` | View spend by tool, campaign, or agency-wide |
| `/gtm:auto-refine <ws>` | Suggest ICP/persona/copy refinements from data |
| `/gtm:migrate <ws>` | Tool migration playbook |
| `/gtm:feedback` | Report a bug or request a feature |

### Parallel processing (optional)
| Command | What it does |
|---------|-------------|
| `/gtm:swarm personalize <ws>` | Personalize outreach at scale |
| `/gtm:swarm research <ws>` | Research companies in parallel |
| `/gtm:swarm replies <ws>` | Process reply batches in parallel |
| `/gtm:swarm validate <ws>` | Validate large lists in parallel |
| `/gtm:swarm signals <ws>` | Scan signals across full list |

### Team mode (optional)
| Command | What it does |
|---------|-------------|
| `/gtm:collab setup` | Connect Supabase for multi-user |
| `/gtm:collab status` | Check connection and active users |
| `/gtm:collab invite` | Invite a team member |
| `/gtm:collab sync` | Sync local files to Supabase |

---

## Workspaces

Each workspace is fully isolated — its own ICP, persona, briefing, voice, tools, costs, and pipeline. A workspace can be:

- An agency client
- A market segment
- A product line
- A geography
- Any unit of GTM that deserves its own context

---

## Notifications (optional)

Connect Slack to get real-time alerts:
- Positive reply received
- Meeting booked
- Budget threshold crossed
- Domain health red flag

Configure in COLLABORATION.md. Works via Slack MCP.

---

## Team mode (optional)

By default GTMOS runs in **solo mode** — all state lives in markdown, no database needed.

For teams, enable **team mode** with Supabase:

1. Create a Supabase project
2. Run `supabase/migrations/001_initial_schema.sql`
3. Add keys to `.env`
4. Run `/gtm:collab setup`

Adds: shared suppression lists, claim-based reply handling, live cost tracking, pipeline sync, approval audit trail, activity feed. Falls back to files automatically if Supabase is unreachable.

---

## Repo structure

```
GTMOS/
├── CLAUDE.md                  <- Entrypoint for Claude Code
├── GTMOS.md                   <- All rules and behaviour
├── CHANGELOG.md               <- Version history
├── .env.example               <- API key template
├── _template/                 <- Workspace template (copied on onboard)
├── workspaces/                <- One folder per workspace
├── commands/                  <- Workflow reference docs
├── global/                    <- Cross-workspace standards
│   ├── RULES-GLOBAL.md        <- Global quality rules
│   ├── snippet-library.md     <- Reusable copy fragments
│   ├── swipe-file.md          <- Full sequence examples
│   └── feedback-log.md        <- Feedback tracking
├── .claude/
│   ├── commands/gtm/          <- Slash commands (/gtm:*)
│   └── gtmos/references/      <- System references
│       ├── api-reference.md   <- API endpoints for all tools
│       ├── benchmarks.md      <- Industry performance benchmarks
│       ├── campaign-types.md  <- Campaign type templates
│       ├── cold-email-skill.md <- Copy writing principles
│       ├── csv-format.md      <- Standard list format
│       ├── defaults.md        <- All overridable defaults
│       ├── lead-scoring.md    <- Weighted scoring model
│       ├── notifications.md   <- Slack alert configuration
│       ├── report-template.md <- Client report formats
│       ├── sending-calendar.md <- Holiday blackouts (20+ countries)
│       ├── tool-links.md      <- Tool website links
│       ├── tool-pricing.md    <- Per-unit pricing for all tools
│       └── tool-setup-guides.md <- Tool configuration guides
└── supabase/                  <- Team mode schema (optional)
```

---

## Feedback

Found a bug? Want a feature? Run `/gtm:feedback` inside Claude Code, or open an issue on this repo.

---

## License

MIT
