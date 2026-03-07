# GTMOS — The GTM Operating System

GTMOS is a Claude Code plugin that turns Claude into a live GTM campaign intelligence layer. It connects directly to your outbound stack via API, pulls live campaign data on demand, and closes the loop between what you brief, what you ship, and what actually performs.

## Quick start

1. Clone this repo
2. Copy `.env.example` to `.env` and add your API keys
3. Open the repo in Claude Code
4. Run `/gtm:status` to see the system, or `/gtm:onboard <name>` to create your first workspace

## How it works

Every GTM task Claude touches gets checked against five sources of truth:

| File | Purpose |
|------|---------|
| **ICP.md** | Who we target at the company level |
| **PERSONA.md** | Who we target at the human level |
| **BRIEFING.md** | What this campaign is about |
| **TOV.md** | How we sound — full brand voice |
| **RULES.md** | List and copy quality standards |

Plus operational files per workspace:

| File | Purpose |
|------|---------|
| **TOOLS.md** | Connected tools and credit rules |
| **COSTS.md** | Spend tracking by tool, campaign, and budget alerts |
| **INFRASTRUCTURE.md** | Domains, DNS auth, mailboxes, warmup status |
| **SUPPRESSION.md** | Do-not-contact list, compliance, bounce management |
| **PIPELINE.md** | CRM pipeline stages, conversion tracking, attribution |
| **MULTICHANNEL.md** | Cross-channel orchestration and timing rules |
| **BOOKING.md** | Calendar links, landing pages, UTM parameters |
| **COMPETITORS.md** | Competitor positioning, win angles, mention log |

And per campaign:

| File | Purpose |
|------|---------|
| **AB-TESTS.md** | A/B test plans, results, and history |
| **PERSONALIZATION.md** | Merge field definitions and fallbacks |

Nothing ships if it drifts from the sources of truth. Every tool write is logged with cost.

## Repo structure

```
GTMOS/
├── CLAUDE.md             <- Points Claude to GTMOS.md on startup
├── GTMOS.md              <- Plugin entrypoint — all rules and behaviour
├── .env.example          <- API key template
├── _template/            <- Copy to onboard a new workspace
├── workspaces/           <- One folder per workspace (created by /gtm:onboard)
├── commands/             <- Workflow reference templates
├── .claude/commands/gtm/ <- Slash commands (/gtm:*)
├── .claude/gtmos/        <- UI brand reference and swarm architecture
└── global/               <- Cross-workspace standards
```

## Workspaces

Each workspace is fully isolated — its own ICP, persona, briefing, tone of voice, tools, costs, and approval chain. A workspace can represent:

- An agency client
- A market segment
- A product line
- A geography
- Any unit of GTM work that deserves its own context

## Commands

All commands use the `/gtm:` prefix.

### Setup
| Command | What it does |
|---------|-------------|
| `/gtm:onboard <name>` | Onboard a new workspace with structured intake |
| `/gtm:research <name>` | Research ICP companies and market landscape |
| `/gtm:new-campaign <ws> <name>` | Create a new campaign from template |
| `/gtm:switch <name>` | Switch active workspace and reload context |
| `/gtm:status` | Show workspace status and all commands |

### Build
| Command | What it does |
|---------|-------------|
| `/gtm:list-brief <ws> <campaign>` | Create a structured brief for list building |
| `/gtm:clean-list <ws> [file]` | Clean and normalize names, companies, emails, dedupe |
| `/gtm:validate-list <ws> [file]` | Clean + score + validate a raw prospect list |
| `/gtm:write <ws> [touches] [channel]` | Draft an outbound sequence |
| `/gtm:validate-copy <ws>` | QA check copy against all rules |
| `/gtm:ship <ws> <campaign>` | Push approved list + sequence to sending tool |

### Live Campaign
| Command | What it does |
|---------|-------------|
| `/gtm:replies <ws> [campaign]` | Classify and draft responses to replies |
| `/gtm:signals <ws> [campaign]` | Scan for signal-triggered outreach |
| `/gtm:sync <ws> [campaign]` | Pull latest data from connected tools |
| `/gtm:health <ws> <campaign>` | Full health check with pattern detection |

### LinkedIn
| Command | What it does |
|---------|-------------|
| `/gtm:linkedin-warm <ws>` | Pre-outreach LinkedIn engagement warming |
| `/gtm:account-based <ws>` | Multi-thread a high-value target account |

### Infrastructure
| Command | What it does |
|---------|-------------|
| `/gtm:infra <ws>` | Check sending infrastructure health and DNS |
| `/gtm:warmup <ws>` | Check inbox warmup status and readiness |
| `/gtm:pipeline <ws> [campaign]` | View CRM pipeline funnel and conversions |
| `/gtm:domain-recovery <ws>` | Recover a damaged sending domain |

### Review
| Command | What it does |
|---------|-------------|
| `/gtm:brief-audit <ws>` | Check briefing for gaps before campaign start |
| `/gtm:stress-test <ws>` | Challenge ICP assumptions with edge cases |
| `/gtm:debrief <ws> <campaign>` | End-of-campaign debrief with forward-feed |
| `/gtm:report <ws> <campaign>` | Generate client-facing campaign report |
| `/gtm:post-meeting <ws>` | Post-meeting follow-up workflow |
| `/gtm:re-engage <ws>` | Re-engagement campaign for cold leads |
| `/gtm:archive <ws> [campaign]` | Archive completed campaign or workspace |
| `/gtm:costs <ws> [--all]` | View spend by tool, campaign, or agency-wide |

### Feedback
| Command | What it does |
|---------|-------------|
| `/gtm:feedback` | Submit feedback, report a bug, or request a feature |

### Swarm (optional — parallel agents)
| Command | What it does |
|---------|-------------|
| `/gtm:swarm personalize <ws>` | Personalize outreach for all leads in parallel |
| `/gtm:swarm research <ws>` | Research multiple companies in parallel |
| `/gtm:swarm replies <ws>` | Process reply batch in parallel |
| `/gtm:swarm validate <ws>` | Validate large lists in parallel batches |
| `/gtm:swarm signals <ws>` | Scan signals across full shipped list |

Swarm agents draft only — nothing is sent without human approval.

### Collaboration (optional — multi-user via Supabase)
| Command | What it does |
|---------|-------------|
| `/gtm:collab setup` | Connect Supabase and enable team mode |
| `/gtm:collab status` | Check collaboration connection and active users |
| `/gtm:collab invite` | Invite a team member to a workspace |
| `/gtm:collab sync` | Sync local markdown files to Supabase |

## Supported tools

| Tool | Direction | What it does |
|------|-----------|-------------|
| Apollo | Bidirectional | Prospecting, enrichment, lead database |
| Icypeas | Bidirectional | Email finding and verification |
| Prospeo | Bidirectional | Email finding from LinkedIn URLs |
| Apify | Bidirectional | Web scraping and data extraction |
| StoreLeads | Read-only | E-commerce store database |
| Opemart | Read-only | Small business / SMB data |
| HubSpot | Bidirectional | CRM, marketing, sequences |
| Lemlist | Bidirectional | Email sequencing + lead database |
| Instantly | Bidirectional | Email sequencing + lead database |
| Smartlead | Bidirectional | Email sequencing |
| Crispy | Bidirectional | LinkedIn outreach + Sales Navigator |
| Attio | Bidirectional | CRM |
| Signalbase | Read-only | Funding and hiring signals |
| Commonroom | Read-only | Community and intent signals |
| Jungler.ai | Read-only | Social signals and LinkedIn engagement tracking |
| Trigify | Read-only | Social selling signals and content interaction |

Additional tools (email verification, CRM enrichment, LinkedIn automation, automation) can be activated per workspace. See `_template/TOOLS.md` for the full list and `.claude/gtmos/references/tool-pricing.md` for pricing.

Reads are auto-approved. Writes follow credit rules per workspace. Every write is logged in COSTS.md.

## Cost tracking

Every workspace has a COSTS.md file that tracks:
- Per-tool pricing (cost per unit)
- Monthly and per-campaign budgets
- Alert thresholds (default 80%)
- Running totals by tool
- Full transaction log with dates, units, costs, and approver

Run `/gtm:costs --all` for an agency-level view across all workspaces.

## Collaboration (optional)

By default GTMOS runs in **solo mode** — all state lives in markdown files, no database needed.

For teams, enable **team mode** with Supabase:

1. Create a Supabase project
2. Run `supabase/migrations/001_initial_schema.sql` in the SQL editor
3. Add `SUPABASE_URL`, `SUPABASE_ANON_KEY`, and `SUPABASE_SERVICE_KEY` to `.env`
4. Run `/gtm:collab setup`

Team mode adds:
- Real-time suppression lists across operators (no accidental re-contact)
- Claim-based reply handling (no double-responses)
- Live cost tracking with budget enforcement
- Pipeline sync and conversion tracking
- Approval audit trail
- Activity feed

All context files (ICP, persona, briefing, copy) stay in Git. Only operational state syncs to Supabase. If Supabase is unreachable, GTMOS falls back to file-based mode automatically.

## Setup

1. Clone this repo
2. Copy `.env.example` to `.env` and add your API keys
3. Open in Claude Code
4. Run `/gtm:onboard <workspace-name>` — Claude runs the intake interview
5. Run `/gtm:research <workspace-name>` — Claude researches ICP and market
6. Run `/gtm:new-campaign <workspace> <campaign>` — create your first campaign
7. Run `/gtm:write <workspace>` — draft your first sequence

## What onboarding creates

Running `/gtm:onboard <name>` walks you through a structured intake (14 blocks) and generates a fully populated workspace with all source-of-truth files filled in. No example workspace needed — the onboarding process is the example.
