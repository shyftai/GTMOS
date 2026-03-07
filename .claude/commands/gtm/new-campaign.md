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
</execution_context>

<process>
1. Display mode header: `<< GTMOS // NEW CAMPAIGN >>`
2. Parse workspace name and campaign name from $ARGUMENTS
3. Copy workspaces/{workspace}/campaigns/_campaign-template/ to workspaces/{workspace}/campaigns/{campaign-name}/
4. Ask for campaign config details:
   - Channel: email / LinkedIn / multi-channel
   - Target list size
   - Target send date
   - Sequence length (e.g. 4-touch over 14 days)
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
