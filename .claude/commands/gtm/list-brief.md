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
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // LIST BUILD >>`
2. Load workspace context — ICP.md, campaign.config.md
3. Check context/research/list-seeds-*.md for existing research seeds
4. Display workspace header
5. Output structured brief: filter criteria, required fields, enrichment fields, signals, exclusion rules
6. Include sourcing plan — which tools to use for discovery:
   - Crispy/Sales Navigator filters (primary discovery)
   - Apollo people search (free, 275M+ contacts)
   - Exa semantic search (find similar companies by meaning)
   - Ocean.io / DiscoLike (lookalike discovery — feed best customers, get ranked matches)
   - Firecrawl (extract company lists from directories, award lists, conference sites)
   - Crunchbase/Diffbot (free company search)
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
