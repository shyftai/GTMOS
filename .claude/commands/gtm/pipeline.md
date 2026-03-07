---
name: gtm:pipeline
description: View CRM pipeline status, conversion metrics, and attribution
argument-hint: "<workspace-name> [campaign]"
---
<objective>
Display the CRM pipeline funnel, conversion rates, and revenue attribution for a workspace or specific campaign.

Workspace and optional campaign: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/BENCHMARKS.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // PIPELINE >>`
2. Load workspace PIPELINE.md
3. Load BENCHMARKS.md for comparison
4. If campaign specified, filter to that campaign's data
5. Display pipeline funnel visualization:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  PIPELINE — {workspace}                    ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                            ┃
┃  Shipped        ████████████████████  250   ┃
┃  Contacted      ████████████████████  250   ┃
┃  Replied        ██                    11    ┃
┃  Positive       █                     6     ┃
┃  Meeting        █                     4     ┃
┃  Qualified      █                     3     ┃
┃  Proposal       █                     2     ┃
┃  Won            ░                     0     ┃
┃                                            ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```
6. Show conversion rates with benchmark comparison:
   - Green: above benchmark average
   - Yellow: at benchmark average
   - Red: below benchmark average
7. Show revenue attribution if deals exist
8. Show lost deal analysis if any closed-lost
9. Flag any stage with unusual drop-off
10. Suggest next actions:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Next: /gtm:health {workspace} {campaign}
     Also: /gtm:debrief {workspace} {campaign}
     Also: /gtm:sync {workspace}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
