---
name: gtm:save-template
description: Save a proven sequence as a reusable template
argument-hint: "<workspace-name> <campaign-name> [template-name]"
---
<objective>
Save a campaign's approved sequence as a reusable template. Strips workspace-specific details, preserves structure, timing, and winning copy patterns. Includes performance data so future users know what works.

Workspace, campaign, and optional template name: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // SAVE TEMPLATE >>`
2. Load the campaign's approved sequence from copy/approved/
3. Load campaign.config.md for campaign type, channel, touch count, timing
4. Load performance data — reply rate, meeting rate, A/B test winners
5. Load LEARNINGS.md for relevant copy/persona learnings from this campaign

## Template creation
6. Create template by:
   - Generalizing company-specific references → placeholders: [YOUR PRODUCT], [PAIN POINT], [PROOF POINT], [COMPETITOR]
   - Keeping personalization variables as-is ({{first_name}}, {{company}}, etc.)
   - Preserving subject lines, structure, CTA patterns, and timing
   - Adding annotation comments explaining why each element works
   - Including A/B test winners inline (marked as "winning variant")

7. Attach performance metadata:
```
## Template metadata
- **Name:** {template-name}
- **Type:** {campaign type}
- **Channel:** {email / LinkedIn / multi-channel}
- **Touches:** {n}
- **Timing:** {spacing between touches}
- **Source campaign:** {workspace} / {campaign}
- **Performance:** Reply rate {pct}%, {n} meetings from {n} contacts
- **Best for:** {persona / segment description}
- **Key insight:** {what made this sequence work}
- **Created:** {date}
```

8. Display preview:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  SAVE TEMPLATE — {template-name}                             ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                              ┃
┃  Type: {campaign type}     Channel: {channel}                ┃
┃  Touches: {n}              Reply rate: {pct}%                ┃
┃                                                              ┃
┃  Touch 1: "{subject line}"                                   ┃
┃    [Observation-led opener → pain point → soft CTA]          ┃
┃  Touch 2: "{subject line}"                                   ┃
┃    [New angle → social proof → interest CTA]                 ┃
┃  ...                                                         ┃
┃                                                              ┃
┃  Includes: {n} annotation comments, A/B winners marked       ┃
┃                                                              ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  >> Save? (y/n)
```

9. On approval:
   - Create global/templates/ directory if it doesn't exist
   - Save to global/templates/{template-name}.md
   - Log in LEARNINGS.md: "Template saved: {name} — {pct}% reply rate on {persona}"

10. Display confirmation:
```
  Saved to: global/templates/{template-name}.md

  >> Use it: /gtm:use-template {ws} {template-name}
  >> Browse: /gtm:templates
```
</process>
</content>
