# Changelog — GTMOS

All notable changes to this project are documented here.

---

## [Unreleased]

## [0.7.0] — 2026-03-07

### Added
- **Audience sync command** (`/gtm:audience-sync`) — push account/contact lists to LinkedIn Ads, Meta (Facebook/Instagram), and Google Ads as matched/custom audiences for ABM ad warming
- **LinkedIn Ads API** — DMP Segment creation, batch company streaming (up to 5,000/batch), contact streaming via SHA256 email, segment status monitoring
- **Meta Ads API** — custom audience creation, hashed contact upload (email, phone, name, location), batch up to 10,000 rows
- **Google Ads API** — Customer Match user list creation, OfflineUserDataJob workflow, hashed identifier upload
- **HubSpot ABM integration** — if HubSpot Marketing Hub Professional+ is active, use built-in Target Accounts, buying roles, account overview, and native LinkedIn Ads sync instead of direct API audience sync
- **ABM tiering** — Tier 1 (full, 1-10 accounts), Tier 2 (lite, 10-50), Tier 3 (programmatic, 50-200) with different resource allocation per tier
- **Optional ad warming strategy** — suggested timeline for audience warming before outreach (not required)
- Ad platform API keys in .env.example (LINKEDIN_ADS_TOKEN, META_ACCESS_TOKEN, GOOGLE_ADS_TOKEN, etc.)
- Ad platform sections in tool-links.md, tool-pricing.md, template TOOLS.md

### Changed
- ABM command (`/gtm:account-based`) fully rebuilt with: account qualification scoring, deep research phase (Crispy, Exa, Firecrawl, Apollo), buying committee mapping, audience warming integration, staggered timing rules, cross-reference coordination, account-level tracking
- ABM slash command now loads enrichment-waterfall.md, api-reference.md, and audience-sync.md for full context
- Onboarding Block 7 updated with ad platform tools and API keys

## [0.6.0] — 2026-03-07

### Added
- **Ocean.io** — lookalike company search. Feed best customer domains, get ranked matches with revenue, tech stack, headcount growth, web traffic. 0.2 credits/result
- **DiscoLike** — AI-powered lookalike discovery across 60M+ domains in 45 languages. $0.10/call + $2/1K records
- **Exa MCP** — semantic web search, company research, deep research agent. 1K free searches/mo. MCP tools: `web_search_exa`, `company_research_exa`, `deep_researcher_start`
- **Firecrawl MCP** — web scraping and structured data extraction. 500 free credits. MCP tools: `FIRECRAWL_SCRAPE_EXTRACT_DATA_LLM`, `FIRECRAWL_EXTRACT`
- **Apify + Sales Navigator** company scraping — bulk SN account extraction via API (~$0.50/1K companies, no-cookies actors available)
- Signal waterfall — cascading signal scan across 4 tiers: dedicated platforms (Signalbase, Commonroom, Jungler, Trigify), job monitors (Sentrion, Fantastic.jobs), web signals (Exa, Firecrawl, Crunchbase — free), LinkedIn (Crispy). Checks TOOLS.md + .env, skips missing tools
- Sync command rebuilt with real API endpoints: Instantly V2 analytics, Lemlist stats + activities, Smartlead analytics + lead-level stats, Crispy metrics, Attio/HubSpot pipeline queries, Apollo status updates
- Swipe file expanded: 8 examples covering all 7 campaign types (cold outbound, signal-triggered, competitor displacement, multi-channel LinkedIn, re-engagement, event follow-up, product launch, ABM multi-threaded)
- Research command rewritten with Exa, Firecrawl, Ocean.io, DiscoLike integration — includes competitor intelligence section and lookalike expansion step
- List-brief now includes sourcing plan with all discovery tools and lookalike sources
- Company discovery split into Phase 1 (discovery) and Phase 2 (volume enrichment via APIs)
- Onboarding now checks for all new tools (Ocean.io, DiscoLike, Exa, Firecrawl, Dropcontact, FindyMail, ZeroBounce, MillionVerifier, Scrubby, Sentrion, Fantastic.jobs, Fireflies)

### Changed
- Crispy repositioned as primary discovery engine for both people and company search
- Crispy field mappings updated with complete data from docs — all 4 endpoints (search_people, search_companies, get_profile, get_company_profile) with newly added fields
- Company enrichment waterfall reordered cheapest-first: Icypeas (0.5cr) → Prospeo (1cr, lifetime dedup) → Apollo (1 export credit)
- Instantly API migrated from V1 to V2 (Bearer auth, new endpoint structure)
- Lemlist API reference expanded with stats, activities, and export endpoints
- Smartlead API reference expanded with top-level analytics, lead-level stats, and rate calculation formulas
- Copy writing (`/gtm:write`) now loads snippet-library.md and swipe-file.md for reference
- Signal scan uses Trigger > Relevance > Value > Ask framework for draft messages

### Removed
- Hunter.io (only 25 free searches — insufficient volume for programmatic use)
- Duplicate Icypeas and Prospeo entries in tool-pricing.md

### Fixed
- Hunter.io remnant in enrichment waterfall API quick reference section

## [0.5.0] — 2026-03-07

### Added
- Waterfall enrichment system (`/gtm:enrich`) — cascading enrichment for email, phone, people, company, people search, company search
- Six waterfall types with tool priority order, cost tracking, and hit rate logging
- Enrichment plan display with estimated costs and budget check before execution
- Hit rate tracker in TOOLS.md — tracks source accuracy over time to optimize waterfall order
- Enrichment defaults in defaults.md — all waterfall orders overridable per workspace
- Validate-list now checks for enrichment gaps and suggests `/gtm:enrich` before scoring
- Fireflies.ai API integration for pulling meeting transcripts during deep-dive

### Changed
- Tool links cleaned up: `?ref=gtmos` referral tracking, displayed in branded boxes instead of bare URLs
- GTMOS.md updated with enrichment section

## [0.4.0] — 2026-03-07

### Added
- Data deep-dive command (`/gtm:deep-dive`) — build ICP from CRM data, outbound campaign analytics, and sales transcripts
- Slash command wrappers for: auto-refine, migrate, linkedin-warm, post-meeting, re-engage, domain-recovery, account-based
- Deep-dive path in `/gtm:onboard` — onboard from evidence instead of guesswork
- Health check now updates performance trends and suggests auto-refine when enough data exists
- Debrief now runs auto-refinement, updates win/loss log, saves winning copy to snippet library
- Re-engagement flagging in debrief for 60+ day old contacts
- MIT License
- Expanded .gitignore for workspace data safety (lists, replies, sync, performance, logs, transcripts)
- API reference for Apollo, Instantly, Lemlist, Smartlead, Icypeas, Prospeo, HubSpot, Attio, Apify, ZeroBounce
- CSV format spec with standard columns and import mappings from Apollo, Sales Navigator, Instantly, Lemlist
- Lead scoring model (0-100 weighted score) with customizable weights per workspace
- Campaign type templates: cold outbound, signal-triggered, competitor displacement, event follow-up, product launch, ABM, re-engagement
- Client-facing report templates: weekly pulse, monthly review, campaign final
- Quick start onboarding (5 blocks instead of 14) with `/gtm:onboard --quick`
- Slack notification system for critical events (positive replies, budget alerts, domain issues)
- Smart dashboard (`/gtm:dashboard`) — scans workspace state and surfaces what needs attention
- ICP auto-refinement (`/gtm:auto-refine`) — suggests ICP, persona, and copy changes based on campaign data
- Tool migration playbooks — step-by-step guides for switching between tools
- Tool setup guides — how to configure each tool to work with GTMOS
- Performance trending — weekly metrics tracking with pattern detection per campaign
- Copy swipe file — full anonymized sequence examples demonstrating GTMOS principles
- Centralized defaults reference — all overridable per workspace
- Smarter CLAUDE.md with pre-loaded reference index
- Changelog

## [0.3.0] — 2026-03-07

### Added
- Cold email writing skill woven throughout copy workflow (peer voice, observation-led openers, subject line rules, 10-point quality checklist)
- Global sending calendar with holidays for 20+ countries, per-contact blackout logic
- UTM-tagged tool links for referral tracking
- New commands: `/gtm:post-meeting`, `/gtm:account-based`, `/gtm:re-engage`, `/gtm:linkedin-warm`, `/gtm:domain-recovery`, `/gtm:feedback`
- Populated snippet library with openers, CTAs, follow-up angles, objection responses
- Jungler.ai and Trigify for social signal intelligence
- Win/loss insight log and pattern tracker in pipeline template
- Built-in feedback system (GitHub issues or local log)

### Changed
- Crispy description updated with Sales Navigator and MCP details
- Agency pricing corrected: €99/mo base + €29/mo/seat

## [0.2.0] — 2026-03-07

### Added
- Icypeas, Prospeo, StoreLeads, Opemart, Freckle, N8N, Supabase Edge Functions, Sentrion.ai, Fantastic.jobs
- Tool pricing reference with per-unit costs for all tools
- Orange brand color (ANSI 208) for banner and mode headers

### Changed
- Replaced Clay with Apify + HubSpot
- Removed enterprise tools (Lusha, RocketReach, LeadIQ, Clearbit, 6sense, Bombora)

## [0.1.0] — 2026-03-07

### Added
- Optional multi-user collaboration via Supabase (solo mode default)
- Supabase schema with 9 tables, RLS policies, triggers
- Booking link configuration per workspace
- List cleaning/normalization command
- Sending infrastructure template (domains, DNS, mailboxes, warmup)
- Compliance and suppression management
- CRM pipeline tracking with attribution
- Multi-channel orchestration (email + LinkedIn timing rules)
- Competitor intelligence tracking
- A/B testing framework
- Personalization variable management
- Pre-flight shipping checklist
- Infrastructure health audit
- Campaign reporting and archiving
- 26 slash commands with `/gtm:` prefix

### Removed
- Example workspace (replaced by onboarding flow)

## [0.0.1] — 2026-03-07

### Added
- Initial GTMOS framework
- Five sources of truth: ICP.md, PERSONA.md, BRIEFING.md, TOV.md, RULES.md
- Workspace isolation with template system
- Intake interview (14-block onboarding)
- List validation with ICP scoring
- Sequence writing with five-check validation
- Reply classification and handling
- Signal-triggered outreach
- Campaign health checks
- Swarm (parallel agent) support
- Cost tracking per tool and campaign
