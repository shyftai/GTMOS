---
name: gtm:status
description: Show workspace status and available commands
argument-hint: "[workspace-name]"
---
<objective>
Display the GTMOS banner, workspace status, and available commands.

Workspace: $ARGUMENTS (optional — if omitted, list all workspaces)
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display the GTMOS startup banner

2. If no workspace specified:
   - List all workspaces in workspaces/ with name, status, and active campaigns
   - Prompt: `>> Which workspace?`

3. If workspace specified:
   - Load workspace context
   - Display workspace header from ui-brand.md
   - Show loaded sources of truth: [x] for populated, [ ] for empty
   - Show active campaigns with status
   - Show tool connection status: [x] for key present, [ ] for missing
   - Show cost summary: total spent, budget remaining, alert status

4. Display available commands:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  GTMOS Commands

  Setup
    /gtm:onboard       Onboard a new workspace (full / --quick / deep-dive)
    /gtm:deep-dive     Data deep-dive — build ICP from CRM, campaigns, transcripts
    /gtm:research      Research ICP and market
    /gtm:new-campaign  Create a campaign with type selection
    /gtm:switch        Switch active workspace
    /gtm:status        Show this command list
    /gtm:dashboard     Smart dashboard — what needs attention now

  Build
    /gtm:list-brief    Create a list building brief
    /gtm:enrich        Waterfall enrichment (email, phone, people, company)
    /gtm:clean-list    Clean and normalize a raw list
    /gtm:validate-list Clean + score + validate a raw list
    /gtm:write         Draft an outbound sequence
    /gtm:validate-copy QA check copy against rules

  Ship
    /gtm:ship          Push approved list + sequence to sending tool

  Live Campaign
    /gtm:replies       Classify and handle replies
    /gtm:signals       Scan for signal-triggered outreach
    /gtm:sync          Pull data from connected tools
    /gtm:health        Run a campaign health check

  LinkedIn
    /gtm:linkedin-warm Pre-outreach LinkedIn engagement warming
    /gtm:account-based Multi-thread a target account

  Infrastructure
    /gtm:infra         Check sending infrastructure health
    /gtm:warmup        Check inbox warmup status
    /gtm:pipeline      View CRM pipeline and conversions
    /gtm:domain-recovery  Recover a damaged sending domain

  Review
    /gtm:brief-audit   Check briefing for gaps
    /gtm:stress-test   Challenge ICP assumptions
    /gtm:debrief       End-of-campaign performance review
    /gtm:report        Generate client-facing report
    /gtm:post-meeting  Post-meeting follow-up workflow
    /gtm:re-engage     Re-engagement campaign for cold leads
    /gtm:archive       Archive completed campaign or workspace

  Costs
    /gtm:costs         View spend by tool, campaign, workspace
    /gtm:costs --all   Agency-level spend across all workspaces

  Collaboration (optional — multi-user)
    /gtm:collab setup    Connect Supabase for team mode
    /gtm:collab status   Check collaboration connection
    /gtm:collab invite   Invite a team member
    /gtm:collab sync     Sync local files to Supabase

  Intelligence
    /gtm:auto-refine   Suggest ICP/persona/copy refinements from data
    /gtm:migrate       Tool migration playbook

  Feedback
    /gtm:feedback      Submit feedback, report a bug, or request a feature

  Swarm (optional — parallel agents)
    /gtm:swarm personalize   Personalize outreach at scale
    /gtm:swarm research      Research companies in parallel
    /gtm:swarm replies       Process reply batch in parallel
    /gtm:swarm validate      Validate large lists in parallel
    /gtm:swarm signals       Scan signals across full list

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
