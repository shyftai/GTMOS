---
name: gtm:visitor-id
description: Review website visitor identification data and route high-intent visitors to campaigns
argument-hint: "<workspace-name> [--setup | --scan | --enrich]"
---
<objective>
Pull website visitor identification data, cross-reference against ICP, score visitors, and route high-intent matches into signal-triggered campaigns. Setup mode configures the visitor ID tool connection.

Workspace and options: $ARGUMENTS
</objective>

<execution_context>
@./commands/visitor-id.md
@./commands/signal-scan.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/enrichment-waterfall.md
@./.claude/gtmos/references/lead-scoring.md
@./.claude/gtmos/references/api-reference.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // VISITOR ID >>`
2. Load TOOLS.md — check which visitor ID tool is active (Snitcher, RB2B, Warmly, Leadinfo)
3. Load ICP.md, PERSONA.md, SUPPRESSION.md
4. If `--setup`:
   - Walk through visitor ID tool configuration
   - Add to TOOLS.md, set up integration/API key
   - Configure ICP filters and high-intent page definitions
5. If `--scan` or default:
   - Pull recent identified visitors from the active tool
   - Filter against ICP — company size, industry, geography
   - Check against suppression list and active campaigns
   - Score each visitor using page intent scoring + lead scoring model
   - Display results in GTM:OS visitor signal box
   - For company-only matches, suggest enrichment to find contacts
   - For person-level matches, verify email and score
6. If `--enrich`:
   - Take company-level visitor matches that need contacts
   - Run persona-based enrichment waterfall to find the right person
   - Score enriched contacts
   - Route high-scoring contacts to signal-triggered campaign
7. Display next actions:
   - High-intent visitors ready for outreach
   - Visitors needing enrichment
   - Suggest `/gtm:write` for signal-triggered sequence if none exists
</process>
