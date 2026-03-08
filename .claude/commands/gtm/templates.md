---
name: gtm:templates
description: Browse and manage saved sequence templates
argument-hint: "[--list | template-name]"
---
<objective>
Browse all saved sequence templates, compare performance, and pick one to use. Shows templates from saved campaigns and imports.

Options: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // TEMPLATES >>`
2. Scan global/templates/ for all .md files
3. Parse metadata from each template

## Template library
4. Display all templates:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  TEMPLATE LIBRARY — {n} templates                            ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  Proven (from campaigns with data)
    saas-cold-4touch        4-touch email    Reply: 4.8%   7 meetings
      Best for: VP Sales at Series B SaaS
    signal-funding-3touch   3-touch email    Reply: 8.5%   4 meetings
      Best for: Signal-triggered after funding round
    abm-multithread         5-touch multi    Reply: 6.2%   3 meetings
      Best for: Enterprise ABM with buying committee

  Imported (external)
    competitor-displace-v1  4-touch email    Quality: 7/10   No perf data
      Source: blog post — cold email teardown
    linkedin-warm-intro     3-touch LinkedIn Quality: 8/10   No perf data
      Source: manual import

  Built-in (GTM:OS defaults)
    cold-outbound           4-touch email    From: campaign-types.md
    signal-triggered        3-touch email    From: campaign-types.md
    competitor-displacement  4-touch email    From: campaign-types.md
    event-followup          3-touch email    From: campaign-types.md
    re-engagement           3-touch email    From: campaign-types.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Use: /gtm:use-template {ws} {template-name}
  >> Import: /gtm:import-template {file/URL/--paste}
  >> Save from campaign: /gtm:save-template {ws} {campaign}
```

## Template detail view
5. If a template name is passed, show full detail:
   - Complete metadata and performance history
   - All touches with subject lines and structure summary
   - Annotation comments
   - Which workspaces have used this template and their results
   - Relevant learnings that apply

6. Suggest best template for current context:
   - If an active campaign exists, recommend templates matching its type and persona
   - Sort by reply rate (proven templates first)
</process>
</content>
