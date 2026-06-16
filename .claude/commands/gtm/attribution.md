---
name: gtm:attribution
description: View ROI attribution across campaigns, channels, and touches
argument-hint: "<workspace-name> [campaign-name]"
---
<objective>
Connect pipeline revenue back to specific campaigns, channels, and touches. Show what's generating ROI and what isn't. If a campaign is specified, show single-campaign deep dive. If no campaign, show cross-campaign comparison for the workspace.

Workspace and optional campaign: $ARGUMENTS
</objective>

<execution_context>
@./commands/attribution.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
@./.claude/gtmos/references/attribution-ledger.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // ATTRIBUTION >>`
2. Load TOOLS.md — check which CRM (Attio or HubSpot) and sending tools (Instantly, Lemlist, Smartlead) are active
3. Load workspace.config.md — check which attribution model is selected (default: first touch)
4. Determine mode:
   - If campaign name provided: single-campaign attribution
   - If no campaign name: cross-campaign comparison for the workspace

**Single-campaign attribution:**
5. Load campaign performance/results.md, PIPELINE.md, COSTS.md, performance/attribution.md, and the touch ledger (attribution-ledger.md)
6. Pull data from CRM: deal values, stages, won/lost dates, associated contacts (by account). Split into **sourced** (opps this campaign originated — first qualified touch on the account) and **influenced** (opps where this campaign touched the account in-window but did not source) — report both, with influenced flagged as non-additive.
7. Pull data from sending tools: campaign metrics, touch-level reply data, reply classifications
8. Pull LinkedIn data from Crispy if active: acceptance rates, reply data per step
9. Calculate all attribution metrics using the workspace's chosen model:
   - Cost per reply, cost per meeting, cost per deal
   - Revenue per campaign, ROI
   - Time to meeting, time to close
   - Full funnel conversion rates (sent, reply, positive, meeting, proposal, won)
10. Identify best and worst performers across persona, channel, touch, signal, source
11. Display full attribution report in GTM:OS box format
12. Update performance/attribution.md with latest data

**Cross-campaign comparison:**
5. Load all campaign directories in the workspace
6. For each campaign, load performance/results.md, PIPELINE.md, COSTS.md, performance/attribution.md
6b. Load the touch ledger (attribution-ledger.md) and CRM opportunities, then compute the join: **sourced** pipeline/revenue per campaign (first qualified touch on the account — sums to the true total) and **influenced** pipeline per campaign (every campaign that touched the account in-window — non-additive, never summed to a total)
7. Aggregate metrics per campaign: contacts, cost, meetings, deals, sourced revenue, influenced revenue, ROI, cost/meeting
8. Display two rankings in GTM:OS box format — **Sourced $ (headline, sums to total)** and **Influenced $ (participation lens, flagged non-additive)**
9. Flag the top performer (highest sourced ROI) and underperformer (lowest sourced ROI or no sourced deals)

**Both modes:**
13. Suggest next actions:
    - Double down: increase volume on high-ROI campaigns, personas, signals
    - Adjust: modify or pause low-ROI campaigns
    - Test: suggest new experiments based on attribution gaps
14. If significant patterns found, suggest running `/gtm:auto-refine` to feed insights into ICP/persona updates

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Attribution complete.

  >> Next: /gtm:auto-refine {workspace}
     Also: /gtm:report {workspace} {campaign} final
     Also: /gtm:costs {workspace}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
