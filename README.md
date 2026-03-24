# GTM:OS — The GTM Operating System

> Turn Claude Code into a full outbound campaign engine. Brief it. Build it. Ship it. Measure it.

GTM:OS is a Claude Code plugin that runs your entire go-to-market workflow — from ICP definition to list building, copy writing, shipping sequences, handling replies, and reporting on results. It connects to your outbound stack via API, enforces quality at every step, and never ships anything that drifts from the brief.

**Built for:** GTM engineers, SDRs, AEs, RevOps teams, agencies, and founders running B2B outbound.

---

## Install

### Prerequisites
You need [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed:
```
npm install -g @anthropic-ai/claude-code
```

### Get started
```
git clone https://github.com/shyftai/GTMOS.git
cd GTMOS
claude
```

That's it. GTM:OS boots automatically — shows the banner, scans your connected tools, and asks which workspace to load. No config files to edit, no build step.

> **Note:** After cloning, restart Claude Code (`/exit` then relaunch) for slash commands to become available. Claude Code loads commands at session start, so a freshly cloned repo's commands won't appear until the next session.

### Connect your tools
GTM:OS works with your existing tools. Two ways to connect:

**MCP servers (recommended)** — Claude can use these tools directly with full capabilities:
- [Crispy](https://crispy.sh?ref=gtmos) — LinkedIn automation (78 tools)
- [Exa](https://exa.ai?ref=gtmos) — semantic web search and company research
- [Firecrawl](https://firecrawl.dev?ref=gtmos) — web scraping and data extraction

Add MCP servers to your Claude Code settings — GTM:OS detects them automatically on boot.

**API keys** — add to `.env` for tools that connect via API:
```
cp .env.example .env
# add your keys (Apollo, Instantly, Attio, etc.)
```

You don't need all tools to start. GTM:OS works with whatever you have and tells you what's missing.

### First run
When GTM:OS boots, run:
```
/gtm:onboard my-company
```
It asks your role (SDR, GTM Engineer, Head of Sales, Founder, or Agency), walks you through setup, and creates your workspace. Then you're ready to build campaigns.

---

## Legal & Compliance

GTM:OS is a tool — not a compliance solution. You are responsible for how you use it.

- [Legal Disclaimer](LEGAL-DISCLAIMER.md) — warranty, liability, and indemnification terms
- [Acceptable Use Policy](ACCEPTABLE-USE.md) — what responsible use looks like
- [LICENSE](LICENSE) — MIT License

GTM:OS includes built-in compliance helpers (suppression lists, regulation detection, consent tracking, hard gates before shipping) but these do not guarantee legal compliance. Consult legal counsel for your jurisdiction.

---

## What it looks like

When you open GTM:OS in Claude Code, this is what you see.

### Boot sequence
```
 ██████╗ ████████╗███╗   ███╗ ██╗  ██████╗ ███████╗
██╔════╝ ╚══██╔══╝████╗ ████║ ╚═╝ ██╔═══██╗██╔════╝
██║  ███╗   ██║   ██╔████╔██║     ██║   ██║███████╗
██║   ██║   ██║   ██║╚██╔╝██║ ██╗ ██║   ██║╚════██║
╚██████╔╝   ██║   ██║ ╚═╝ ██║ ╚═╝ ╚██████╔╝███████║
 ╚═════╝    ╚═╝   ╚═╝     ╚═╝     ╚═════╝ ╚══════╝
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  G T M : O S                             v1.2.0
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Brief it. Build it. Ship it. Measure it.

  ┌─ SYSTEM ──────────────────────────────────────┐
  │                                                │
  │  Workspaces:  acme-corp, startup-x             │
  │  Mode:        solo                             │
  │                                                │
  │  MCP servers:                                  │
  │  [x] Crispy (LinkedIn)    [x] Exa (search)     │
  │  [x] Firecrawl (scraping) [ ] Slack            │
  │                                                │
  │  API keys:                                     │
  │  [x] Apollo          [x] Instantly             │
  │  [x] Attio           [ ] Lemlist               │
  │                                                │
  │  3 MCP servers · 3 API keys · 2 missing        │
  │                                                │
  └────────────────────────────────────────────────┘

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

  ┌─ COMMANDS ────────────────────────────────────┐
  │                                                │
  │  Setup      /gtm:onboard · /gtm:research      │
  │  Build      /gtm:list-brief · /gtm:enrich     │
  │             /gtm:write · /gtm:validate-list    │
  │  Ship       /gtm:ship · /gtm:ab-test          │
  │  Manage     /gtm:replies · /gtm:signals        │
  │             /gtm:health · /gtm:sync            │
  │  Report     /gtm:report · /gtm:debrief         │
  │  More       /gtm:status for all commands       │
  │                                                │
  └────────────────────────────────────────────────┘

  >> Which workspace are we loading?
```

### Workspace loaded
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  WORKSPACE: Acme Corp                                      ┃
┃  CAMPAIGN:  Q1 Cold Outbound                               ┃
┃  STATUS:    active         TOOLS: Apollo, Instantly, Attio  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

### Quality gates — every piece of copy, every list is checked
```
  ── FIVE CHECKS ──────────────────────────────────
  [x] ICP fit       [x] Persona fit    [x] Briefing fit
  [x] Voice fit     [x] Quality fit
  ─────────────────────────────────────────────────
```

### Launch check before shipping
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  LAUNCH CHECK — Q1 Cold Outbound                  ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                   ┃
┃  List                                             ┃
┃  [x] Validated list — 247 contacts                ┃
┃  [x] Suppression list checked — 0 matches         ┃
┃  [x] All emails verified                          ┃
┃                                                   ┃
┃  Copy                                             ┃
┃  [x] 4-touch sequence approved                    ┃
┃  [x] Five-check validation passed                 ┃
┃  [x] Unsubscribe link present                     ┃
┃                                                   ┃
┃  Infrastructure                                   ┃
┃  [x] 3 inboxes warmed and live                    ┃
┃  [x] DNS auth complete on all domains             ┃
┃  [x] Daily volume within limits                   ┃
┃                                                   ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

### Nothing ships without your approval
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  APPROVE TO SHIP?                                 ┃
┃  247 contacts, 4-touch sequence via Instantly.     ┃
┃                                                   ┃
┃  >> approve / reject / edit                       ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

### Health monitoring
```
  ┌─ CAMPAIGN HEALTH ─────────────────────────────┐
  │                                                │
  │  Deliverability   [GREEN]  Bounce: 1.2%        │
  │  Engagement       [GREEN]  Reply: 6.8%         │
  │  Pipeline         [GREEN]  5 meetings booked   │
  │  Persona fit      [AMBER]  "VP" outperforms    │
  │                                                │
  │  Overall: ON TRACK                             │
  └────────────────────────────────────────────────┘
```

### Credit tracking — every API call is logged before it runs
```
  ┌ CREDIT CHECK ─────────────────────────────────┐
  │ Tool:   Apollo                                 │
  │ Action: Enrich 247 contacts (email + company)  │
  │ Cost:   247 credits (~$12.35)                  │
  │ Rule:   confirm-before-every-use               │
  └────────────────────────────────────────────────┘
  >> Proceed? (y/n)
```

### Reply handling
```
  ┌─ REPLY ───────────────────────────────────────┐
  │ From:     Sarah Chen, VP Sales at TechCorp     │
  │ Channel:  email                                │
  │ Type:     POSITIVE                             │
  │                                                │
  │ "This is timely — we're actually looking at    │
  │  this right now. Can you send more info?"      │
  │                                                │
  │ Drafted response:                              │
  │ "Great timing, Sarah. Here's a quick overview  │
  │  of how we've helped similar teams..."         │
  │                                                │
  │ Actions:                                       │
  │   - Attio: move to Interested                  │
  │   - Sequence: pause                            │
  └────────────────────────────────────────────────┘
  >> Approve / Edit / Skip
```

### List validation with scoring
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

### After every workflow — clear next steps
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Shipped. 247 contacts, 4 touches via Instantly.

  >> Next: /gtm:health acme q1-cold
     Also: /gtm:replies acme
     Also: /gtm:signals acme

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## How it works

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

## The campaign lifecycle

**1. Onboard** → `/gtm:onboard` walks through your offer, ICP, persona, voice, tools, and infrastructure. Have CRM data? Start with `/gtm:deep-dive` to build ICP from evidence.

**2. Research** → `/gtm:research` maps ICP companies, market landscape, and buying signals using Exa, Firecrawl, Ocean.io, and DiscoLike.

**3. Build a list** → `/gtm:list-brief` creates a sourcing brief, `/gtm:enrich` fills gaps via waterfall enrichment across Apollo, Icypeas, Prospeo, and more. `/gtm:validate-list` cleans, scores (0-100), and validates.

**4. Write copy** → `/gtm:write` drafts a sequence using cold email best practices — peer voice, observation-led openers, interest-based CTAs, angle rotation per touch. `/gtm:write-multilang` writes natively in 12 languages.

**5. Ship** → `/gtm:ship` runs a launch check (suppression, DNS, warmup, budget, holiday calendar, compliance) and pushes to Instantly, Lemlist, or Smartlead.

**6. Manage** → `/gtm:replies` classifies and drafts responses, `/gtm:signals` triggers timely outreach, `/gtm:health` monitors performance, `/gtm:ab-test` runs A/B tests with statistical significance tracking.

**7. Report** → `/gtm:report` generates client-facing reports, `/gtm:debrief` feeds learnings back into the system, `/gtm:attribution` connects pipeline revenue to campaigns.

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

GTM:OS connects to 70+ tools across the outbound stack. Use what you have — skip what you don't. Every tool is optional.

### Prospecting & enrichment
| Tool | What it does | Pricing |
|------|-------------|---------|
| **Apollo** | 275M+ contact database, email/phone enrichment, lead search | Free tier (10K credits/mo), paid from $49/mo |
| **ZoomInfo** | Enterprise B2B database — 260M+ contacts, intent data, org charts, tech stack | Enterprise pricing |
| **Cognism** | GDPR-compliant B2B data, phone-verified numbers, strong EU/UK coverage | Enterprise pricing |
| **Lusha** | B2B contact data, LinkedIn extension, direct dials | From $37/mo/seat |
| **Kaspr** | LinkedIn phone number enrichment, European coverage, GDPR-compliant | From €30/mo |
| **Hunter.io** | Lightweight email finder — domain search, email verification, bulk enrichment | Free 25/mo, paid from $34/mo |
| **Icypeas** | Email finder + verifier, domain search, bulk enrichment | From $39/mo (1K credits) |
| **Prospeo** | Email finder from LinkedIn URLs, email verifier, domain search | From $39/mo (1K credits) |
| **Datagma** | Enrichment waterfall provider — email, phone, LinkedIn, company data | Credit-based |
| **Dropcontact** | B2B email enrichment, GDPR-compliant, no database | From $24/mo |
| **FindyMail** | Email finder + verifier, Sales Navigator scraping | From $49/mo |
| **Apify** | Web scraping platform — LinkedIn, Google Maps, any website | Free $5/mo usage, paid from $49/mo |

### Email verification
| Tool | What it does | Pricing |
|------|-------------|---------|
| **ZeroBounce** | Email verification, bounce detection, abuse detection | 100 free/mo, bulk from $0.004/email |
| **MillionVerifier** | Bulk email verification, high accuracy | From $0.001/email |
| **Bouncer** | Email verification + list hygiene, EU-focused, GDPR-compliant | From $0.007/email |
| **NeverBounce** | Real-time email verification, bulk cleaning | 1K free, from $0.003/email |
| **Scrubby** | Catch-all email verification (the ones others mark "risky") | ~$0.02/email |

### Email sequencing
| Tool | What it does | Pricing |
|------|-------------|---------|
| **Instantly** | Unlimited email accounts, unlimited warmup, A/B testing | From $30/mo |
| **Smartlead** | Unlimited email accounts, sender rotation, webhooks | From $39/mo |
| **Email Bison** | Cold email sending with unlimited inboxes and built-in warmup | Subscription-based |

### Multi-channel sequencing
| Tool | What it does | Pricing |
|------|-------------|---------|
| **Lemlist** | Email + LinkedIn + calls in one sequence builder, 450M+ lead database | From $32/mo/seat |
| **La Growth Machine** | Email + LinkedIn + Twitter in one sequence, strong API | From €60/mo/seat |

### LinkedIn
| Tool | What it does | Pricing |
|------|-------------|---------|
| **Crispy** | MCP server — Claude Code controls LinkedIn directly. Connection requests, messaging, Sales Navigator search + extract. 78 tools. | From EUR19/mo/seat |
| **HeyReach** | LinkedIn outreach at scale — multiple accounts, agency mode, API | From $79/mo |
| **PhantomBuster** | LinkedIn + web scraping automation — 100+ phantoms for any task | Free 2h/day, from $56/mo |

### CRM
| Tool | What it does | Pricing |
|------|-------------|---------|
| **Attio** | Modern CRM with API-first design, unlimited contacts | From $29/mo/seat |
| **HubSpot** | Full marketing + sales platform, free CRM tier | Free CRM, paid from $15/mo |
| **Salesforce** | Enterprise CRM with extensive API | From $25/mo/user |
| **Pipedrive** | Sales-focused CRM, simple pipeline management | From $14/mo/seat |

### Revenue intelligence
| Tool | What it does | Pricing |
|------|-------------|---------|
| **Gong** | Conversation intelligence — records calls, scores deals, surfaces coaching insights, forecasting | Enterprise pricing |
| **Fireflies.ai** | Meeting recording + transcription, pull transcripts via API for deep-dives | From $10/mo/seat |

### Signal intelligence
| Tool | What it does | Pricing |
|------|-------------|---------|
| **UserGems** | Tracks when champions change jobs — your warmest signal for outreach | Subscription-based |
| **Keyplay** | AI-powered ICP account scoring — rank your entire TAM by fit | Subscription-based |
| **Signalbase** | Funding, hiring, job change, tech install signals | Subscription-based |
| **Commonroom** | Community activity, social engagement, intent signals | Subscription-based |
| **Jungler.ai** | LinkedIn activity monitoring, social selling signals | Subscription-based |
| **Trigify** | Competitor content engagement, topic-based social signals | Subscription-based |
| **Sentrion.ai** | Job post monitoring — hiring signals as buying triggers | Subscription-based |
| **Fantastic.jobs** | Job post aggregation and structured hiring data | Subscription-based |

### Lookalike discovery
| Tool | What it does | Pricing |
|------|-------------|---------|
| **Ocean.io** | Feed best customers → get ranked lookalike companies with firmographics | Credit-based, 0.2cr/result |
| **DiscoLike** | AI discovery across 60M+ domains in 45 languages, semantic website analysis | $0.10/call + $2/1K records |

### Research & scraping
| Tool | What it does | Pricing |
|------|-------------|---------|
| **Exa** | MCP server — semantic web search, company research, deep research agent | 1K free/mo, $0.007/search |
| **Firecrawl** | MCP server — web scraping, structured data extraction, website crawling | 500 free credits, from $16/mo |

### Website visitor identification
| Tool | What it does | Pricing |
|------|-------------|---------|
| **Snitcher** | IP-to-company identification, behavioral tracking, page intent signals, API available | From $49/mo |
| **RB2B** | Person-level visitor ID (US) — name, title, LinkedIn, email. Company-level globally | Free plan, paid for volume |
| **Warmly** | Company + person identification, AI chat/email agents, intent orchestration | Enterprise — contact sales |
| **Leadinfo** | Company-level visitor identification, 70+ integrations, EU-focused | From EUR69/mo |

### Ad platforms (optional ABM audience sync)
| Tool | What it does | Pricing |
|------|-------------|---------|
| **LinkedIn Ads** | Push company/contact lists as matched audiences for ABM ad warming | API free, ad spend separate |
| **Meta Ads** | Custom audiences on Facebook/Instagram from contact lists | API free, ad spend separate |
| **Google Ads** | Customer Match for search, display, YouTube, Gmail targeting | API free, ad spend separate |

### Lead databases
| Tool | What it does | Pricing |
|------|-------------|---------|
| **StoreLeads** | E-commerce store database (Shopify, WooCommerce, etc.) | Subscription-based |
| **Openmart** | Small business and SMB data with contact info | Subscription-based |

### CRM enrichment
| Tool | What it does | Pricing |
|------|-------------|---------|
| **Freckle** | Auto-enriches CRM contacts with firmographics, tech stack, funding | Subscription-based |
| **Surfe** | Push LinkedIn contacts directly to CRM — HubSpot, Salesforce, Pipedrive, Attio | From $23/mo/seat |

### Automation & integration
| Tool | What it does | Pricing |
|------|-------------|---------|
| **N8N** | Self-hosted workflow automation (free), or cloud | Free self-hosted, cloud from $20/mo |
| **Zapier** | Task-based automation between tools | Free 100 tasks/mo, from $19.99/mo |
| **Make** | Operation-based workflow automation | Free 1K ops/mo, from $9/mo |
| **Supabase** | Team mode backend — shared state, edge functions | Free tier, Pro $25/mo |

### Scheduling
| Tool | What it does | Pricing |
|------|-------------|---------|
| **Calendly** | Meeting scheduling with calendar sync | Free 1 event type, from $10/mo |
| **Cal.com** | Open-source scheduling, self-hosted option | Free self-hosted, from $12/mo |

> Every tool is optional. Use what you have. GTM:OS reads tool availability from your `.env` and `TOOLS.md`, then adapts its workflows accordingly. Writes follow credit rules per workspace, and every write is logged in COSTS.md.
>
> **Any tool with an API works.** The list above is the curated default set — not a hard limit. Add any tool to your `TOOLS.md`, drop the API key in `.env`, and GTM:OS will use it.

---

## Key features

### Waterfall enrichment
Cascading enrichment across multiple tools — email, phone, people, company. Cheapest sources first, skip tools you don't have, track hit rates to optimize order over time.

### A/B testing
Set up, track, and resolve A/B tests on subject lines, openers, CTAs, body copy, and send times. Statistical significance rules (50+ sends with >20% diff, or 100+ with >10%). Winners auto-feed into snippet library and campaign defaults.

### Multi-language copy
Write sequences natively in 12 languages (French, German, Dutch, Spanish, Italian, Portuguese, Swedish, Danish, Norwegian, Finnish, Polish, and more). Per-language formality defaults, word limit adjustments, cultural norms. Not translation — native writing.

### ROI attribution
Connect pipeline revenue to campaigns, channels, touches, personas, and signals. Four models: first touch, last touch, linear, time decay. Cost per reply, meeting, and deal.

### ABM multi-threading
Reach 2-4 people at one company with role-appropriate messaging and coordinated timing. Buying committee mapping, staggered sends, cross-reference coordination. Optional ad warming via LinkedIn/Meta/Google Ads or HubSpot ABM.

### Data hygiene
Monitor contact data freshness, re-verify emails older than 90 days, detect job changes via Apollo and Crispy, flag cold data, auto-suppress hard bounces. Data freshness score target: >80%.

### Pipeline velocity
Track stage durations, detect bottlenecks (>30% stall rate), stalled deal alerts with suggested actions. Velocity formula and week-over-week trend tracking.

### Website visitor identification
Identify companies (and people) visiting your website, cross-reference against ICP, and route high-intent visitors into signal-triggered campaigns. Supports Snitcher, RB2B, Warmly, and Leadinfo. Page intent scoring (pricing page = high, blog = low). Website visits sit at Tier 1 in the signal priority waterfall.

### Daily briefing
`/gtm:today` scans everything and tells you what to do right now. Positive replies waiting? Ship a campaign? Signals to act on? Prioritized by urgency, adapted to your role.

### Contact history
`/gtm:contact` shows every touchpoint with a person — campaigns they've been in, emails sent, replies, website visits, LinkedIn interactions, CRM deal stage. One unified timeline.

### Competitor monitoring
`/gtm:watch-competitors` actively tracks competitor pricing pages, messaging, hiring patterns, and news using Exa and Firecrawl. Surfaces actionable signals — "Competitor X raised prices 61%" → triggers a displacement campaign suggestion.

### Inbox health
`/gtm:inbox-health` monitors deliverability proactively — bounce rates per inbox, warmup status, domain reputation, DNS issues. Catches problems before they hurt campaigns.

### Sequence templates
Save proven sequences as reusable templates (`/gtm:save-template`), browse the library (`/gtm:templates`), adapt them for new campaigns (`/gtm:use-template`), or import templates from files, URLs, or paste (`/gtm:import-template`). Templates carry performance data so you know what works.

### Agency portfolio
`/gtm:portfolio` shows all workspaces at a glance — campaign status, reply rates, spend, and what needs attention across all clients. Cross-workspace learnings surface patterns that work everywhere.

### Meeting prep & handoff
`/gtm:prep-meeting` generates a complete briefing sheet before a booked call — contact research, company intel, talking points, objection prep, discovery questions. `/gtm:handoff` creates a structured SDR → AE context transfer so prospects never repeat themselves.

### Per-contact personalization
`/gtm:personalize` researches each contact individually and generates custom opening lines — LinkedIn activity, company news, job posts, website observations. Not merge fields. Real, researched insights at scale. Quality-rated per contact (★★★★★ to ★★☆☆☆).

### Nurture track
`/gtm:nurture` manages warm leads on a timer. "Not now, maybe Q3" gets tracked with a follow-up date, trigger to watch, and warmth level. Auto-scans replies for nurture candidates. Cross-references with signal scan — when a nurtured contact's trigger fires, you know immediately.

### Pipeline forecasting
`/gtm:forecast` predicts revenue based on weighted pipeline, active campaign conversion rates, and planned campaigns. Best/expected/worst case scenarios. Velocity-adjusted close dates. Risk flags for stalled deals and declining reply rates.

### Warm intro detection
`/gtm:warm-intro` checks for mutual LinkedIn connections before cold outreach. Scans entire lists, categorizes contacts into warm intro / warm reference / cold tiers, and drafts intro requests. Warm intros convert 5-10x better.

### Campaign cloning
Clone a successful campaign's structure, config, briefing, and A/B winners for a new segment or market. Cross-workspace cloning for agencies.

### Compliance (optional)
Toggle privacy regulations on/off per workspace: CAN-SPAM, GDPR, CASL, CCPA/CPRA, PECR, LGPD, Australian Spam Act. Auto-detect from target geography or ignore entirely. All OFF by default.

### Parallel processing (Swarm)
Spin up parallel agents for personalization, research, reply handling, list validation, and signal scanning at scale.

---

## Smart defaults, full control

GTM:OS ships with sensible defaults for everything:

- **Copy:** 2-4 word lowercase subjects, 75-word first touch, interest-based CTAs, banned spam words
- **Sending:** 40 emails/inbox/day, 14-day warmup minimum, holiday blackouts for 20+ countries
- **Scoring:** weighted 0-100 lead scoring (company fit, persona, signals, data quality, engagement)
- **Compliance:** optional regulation toggles, suppression checks, unsubscribe on every email, bounce auto-removal

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
| `/gtm:clone-campaign <ws> <src> <new>` | Clone a successful campaign for a new segment |
| `/gtm:switch <name>` | Switch active workspace |
| `/gtm:status` | Show workspace status and commands |
| `/gtm:dashboard <ws>` | Smart dashboard — what needs attention now |
| `/gtm:today <ws>` | Daily action briefing — what to do right now |
| `/gtm:portfolio` | Multi-workspace dashboard for agencies |
| `/gtm:compliance <ws>` | Configure privacy regulation toggles (optional) |

### Build
| Command | What it does |
|---------|-------------|
| `/gtm:list-brief <ws> <campaign>` | Create a list building brief |
| `/gtm:enrich <ws> <type> [file]` | Waterfall enrichment (email, phone, people, company) |
| `/gtm:clean-list <ws> [file]` | Clean and normalize a raw list |
| `/gtm:validate-list <ws> [file]` | Clean + score (0-100) + validate |
| `/gtm:write <ws> [touches] [channel]` | Draft an outbound sequence |
| `/gtm:write-multilang <ws> <lang>` | Write sequence in a non-English language |
| `/gtm:templates` | Browse saved sequence templates |
| `/gtm:use-template <ws> <name>` | Create a sequence from a template |
| `/gtm:save-template <ws> <campaign>` | Save a proven sequence as a reusable template |
| `/gtm:import-template <file/URL/--paste>` | Import a sequence template from external source |
| `/gtm:personalize <ws> <campaign>` | Generate per-contact personalization lines at scale |
| `/gtm:warm-intro <ws> [campaign]` | Find mutual connections for warm introductions |
| `/gtm:validate-copy <ws>` | QA check copy against all rules |
| `/gtm:ship <ws> <campaign>` | Push to sending tool with launch check |

### Live campaign
| Command | What it does |
|---------|-------------|
| `/gtm:replies <ws>` | Classify and draft responses to replies |
| `/gtm:signals <ws>` | Scan for signal-triggered outreach |
| `/gtm:sync <ws>` | Pull latest data from connected tools |
| `/gtm:health <ws> <campaign>` | Full health check with pattern detection |
| `/gtm:linkedin-warm <ws>` | Pre-outreach LinkedIn warming |
| `/gtm:account-based <ws>` | Multi-thread a target account (ABM) |
| `/gtm:audience-sync <ws>` | Push lists to LinkedIn/Meta/Google Ads |
| `/gtm:ab-test <ws> <campaign>` | Set up, check, or resolve an A/B test |
| `/gtm:data-hygiene <ws>` | Check data freshness, detect job changes |
| `/gtm:pipeline-velocity <ws>` | Track deal velocity and detect bottlenecks |
| `/gtm:visitor-id <ws>` | Scan website visitors, match to ICP, route to campaigns |
| `/gtm:contact <ws> <email>` | View full contact history across all campaigns and channels |
| `/gtm:watch-competitors <ws>` | Monitor competitor pricing, messaging, hiring, and news |
| `/gtm:nurture <ws>` | Manage warm leads on a timer — track "not now" replies with follow-up dates |
| `/gtm:prep-meeting <ws> <contact>` | Generate meeting briefing with research and talking points |
| `/gtm:handoff <ws> <contact>` | SDR → AE handoff with full context transfer |
| `/gtm:forecast <ws>` | Pipeline forecast with weighted deals and campaign projections |

### Infrastructure
| Command | What it does |
|---------|-------------|
| `/gtm:infra <ws>` | Check sending infrastructure and DNS |
| `/gtm:warmup <ws>` | Check inbox warmup status |
| `/gtm:pipeline <ws>` | View CRM pipeline and conversions |
| `/gtm:domain-recovery <ws>` | Recover a damaged sending domain |
| `/gtm:inbox-health <ws>` | Monitor inbox/domain health, warmup, bounce rates |

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
| `/gtm:attribution <ws> [campaign]` | View ROI attribution across campaigns |
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

By default GTM:OS runs in **solo mode** — all state lives in markdown, no database needed.

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

MIT — Built by [Shyft AI](https://shyft.ai)
