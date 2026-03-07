# Changelog — GTMOS

All notable changes to this project are documented here.

---

## [Unreleased]

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
