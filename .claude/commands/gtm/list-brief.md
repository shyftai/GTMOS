---
name: gtm:list-brief
description: Create a structured brief for list building
argument-hint: "<workspace-name> <campaign-name>"
---
<objective>
Build a structured list brief from ICP.md and campaign config — ready to hand to a VA or input into Apollo/Crispy/Exa.

Workspace and campaign: $ARGUMENTS
</objective>

<execution_context>
@./commands/build-list-brief.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/enrichment-waterfall.md
@./.claude/gtmos/references/lead-sources.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // LIST BUILD >>`
2. Load workspace context — ICP.md, campaign.config.md
3. Check context/research/list-seeds-*.md for existing research seeds
4. Display workspace header
5. Output structured brief: filter criteria, required fields, enrichment fields, signals, exclusion rules
6. Include sourcing plan — pick the source playbook(s) from `lead-sources.md` that match the campaign type, and name the tools for each:
   - **Title-first** (broad cold outbound) — Crispy/Sales Navigator, Apollo, Prospeo; paginate all results, max records per call
   - **Domain-first** (you already have target domains) — resolve decision-makers per domain, cap per-domain count
   - **Local SMB via Google Maps** (restaurants, clinics, trades) — scrape by category + city, then enrich email
   - **Lookalike expansion** (you have winning customers) — Ocean.io / DiscoLike / Exa, then filter matches against ICP.md
   - **Competitor-post engagers** (displacement) — pull engagers from competitor LinkedIn posts via Crispy, qualify against PERSONA.md, tag as a prospect-scoped signal
   - **Directory / list extraction** (niche segments) — Firecrawl/Exa structured extraction from award lists, conference/exhibitor pages, directories
7. Format as copy-paste ready
8. Show the sourcing path — what to do with this brief:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  List brief ready. Next — source the list:

  Option A — Source directly (AI does it):
    /gtm:enrich {workspace} company-search  ← find matching companies
    /gtm:enrich {workspace} people-search   ← find matching contacts

  Option B — Source manually (you or a VA):
    Use the filters above in Apollo, Sales Nav, or Crispy
    Export as CSV, then:
    /gtm:validate-list {workspace} {file-path}

  After sourcing, always run:
    /gtm:enrich {workspace} email           ← fill email gaps
    /gtm:validate-list {workspace}          ← score and validate

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
