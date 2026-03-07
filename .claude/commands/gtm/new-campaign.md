---
name: gtm:new-campaign
description: Create a new campaign from template inside a workspace
argument-hint: "<workspace-name> <campaign-name>"
---
<objective>
Create a new campaign folder from _campaign-template inside a workspace. Fill campaign.config.md and run a briefing audit.

Workspace and campaign name: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/campaign-types.md
@./.claude/gtmos/references/defaults.md
@./.claude/gtmos/references/sending-calendar.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // NEW CAMPAIGN >>`
2. Parse workspace name and campaign name from $ARGUMENTS
3. Copy workspaces/{workspace}/campaigns/_campaign-template/ to workspaces/{workspace}/campaigns/{campaign-name}/
4. Ask campaign type:
   "What type of campaign? (cold outbound / signal-triggered / competitor displacement / event follow-up / product launch / ABM / re-engagement)"
   Pre-fill config defaults from campaign-types.md based on selection.
5. Ask for campaign config details (pre-filled values shown, user can override):
   - Channel: email / LinkedIn / multi-channel
   - Target list size
   - Target send date (check against sending-calendar.md for holiday conflicts)
   - Sequence length (pre-filled from campaign type)
   - Sending tool (Lemlist / Instantly / Smartlead / Crispy)
   - Which inboxes to assign (from INFRASTRUCTURE.md)
   - Send timing (days, time window, timezone handling)
   - Non-responder rule (nurture after N days / archive / manual)
5. Write answers into campaign.config.md
6. Set up PERSONALIZATION.md — ask which merge fields are available in the sending tool
6. Ask for campaign briefing — the offer, angle, proof points, CTA, constraints
   (Each campaign has its own BRIEFING.md — different campaigns can run different angles)
7. Write answers into the campaign's BRIEFING.md
8. Update workspace.config.md to add campaign to active campaigns list
9. Log campaign creation in logs/workspace-log.md
10. Display workspace header showing new campaign
11. Auto-run briefing audit — check BRIEFING.md for gaps before any copy work
10. Suggest next actions:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Next: /gtm:brief-audit {workspace}
     Also: /gtm:list-brief {workspace} {campaign}
     Also: /gtm:write {workspace}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
