---
name: agency:client-onboard
description: Onboard a new client after contract is signed
argument-hint: "<workspace-name> <client-name>"
---
<objective>
Onboard a newly signed client: collect details, add to CLIENTS.md, generate onboarding checklist, draft kickoff agenda, and move PIPELINE.md entry.

Workspace and client name: $ARGUMENTS
</objective>

<execution_context>
@./references/retainer-workflows.md
@./../../.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< AGENCY:OS // CLIENT ONBOARD >>`

2. Load workspace files:
   - `SERVICE-LINES.md` — to confirm services being delivered
   - `CLIENTS.md` — to add the new client
   - `TOOLS.md` — to determine access requirements
   - `PIPELINE.md` — to move from Closed Won to active

3. Collect client details (ask in blocks):

   **Block 1: Company**
   - Company name
   - Industry / vertical
   - Company size (employees)
   - Website

   **Block 2: Services and contract**
   - Services being delivered (confirm against SERVICE-LINES.md)
   - Monthly retainer (MRR)
   - Contract start date
   - Contract end date / renewal date
   - Contract length

   **Block 3: Contacts**
   - Primary contact: name, title, email, LinkedIn, preferred comms channel
   - Secondary contact (if any): name, title, email
   - Who is the budget holder / final decision maker?
   - Who will be day-to-day?

   **Block 4: Goals and success metrics**
   - What are their primary goals for this engagement?
   - How will we measure success? (agreed metrics)
   - What does "great" look like at 90 days?
   - What are their current benchmarks / baseline numbers?

   **Block 5: Access requirements**
   - Ad accounts needed: Google / Meta / LinkedIn (confirm which platforms)
   - CRM access needed: HubSpot / Salesforce / other
   - Analytics access: GA4 / Looker Studio / other
   - Social media accounts
   - Website CMS (if content work)
   - Email platform: HubSpot / Klaviyo / ActiveCampaign / other
   - Any other tools used in scope

   **Block 6: Existing state**
   - What have they tried before?
   - What's currently running (if anything)?
   - What's broken or underperforming?
   - Any constraints or sensitivities to know about?

4. Add client to CLIENTS.md:
   Create full client profile with:
   - All details from blocks 1–6
   - Health: Green (starting assumption)
   - Next QBR date: contract start + 90 days
   - Account lead: [from workspace]
   - Notes: any onboarding context

5. Add all primary contacts to SUPPRESSION.md:
   Mark as "active client — suppress from new business outreach"

6. Generate onboarding checklist:

   ```
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   ONBOARDING CHECKLIST — {client name}
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

   WEEK 1: KICKOFF AND ACCESS
   [ ] Kickoff call completed
   [ ] All ad account access granted
   [ ] Analytics access granted
   [ ] CRM access granted
   [ ] Brand assets received (logo, fonts, colours, brand guide)
   [ ] Historical data access granted (last 3–6 months of reports)
   [ ] Slack channel or comms channel set up
   [ ] Weekly update cadence confirmed
   [ ] Contract countersigned

   WEEK 2: AUDIT AND ALIGNMENT
   [ ] Existing state audit completed (all active channels)
   [ ] Strategy alignment call completed
   [ ] First 30/60/90 day plan shared and agreed
   [ ] KPIs and targets confirmed and documented
   [ ] Tools and tracking verified (pixels, GA4 events, UTMs)

   WEEK 3: FIRST DELIVERABLES
   [ ] First campaign / deliverable in review
   [ ] Reporting dashboard set up
   [ ] First weekly update sent

   WEEK 4: FIRST RESULTS CHECK
   [ ] First 30-day check-in call
   [ ] Results vs. week 1 baseline reviewed
   [ ] Any early optimisations flagged
   [ ] Health status updated in CLIENTS.md

   MONTH 3: FIRST QBR
   [ ] QBR scheduled (90 days from start date: {date})
   [ ] Run /agency:qbr-prep before the call
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   ```

7. Draft kickoff call agenda (45–60 minutes):

   ```
   KICKOFF CALL — {client name} — {date}

   Objective: align on goals, confirm access, set expectations for the first 30 days.

   Agenda:

   [0–10 min] Introductions
   - Agency team: names and roles
   - Client team: names and roles
   - How we work: communication style, cadence, ownership

   [10–25 min] Goals and success metrics
   - What does success look like at 90 days?
   - What are the 3 metrics we'll be measured on?
   - What's the current baseline for each?

   [25–35 min] Current state review
   - What's working (don't break it)
   - What's not working (our first priorities)
   - Any constraints or history to know about

   [35–45 min] First 30 days plan
   - What we'll audit in week 1–2
   - What we'll launch in week 3
   - What we'll report at week 4

   [45–55 min] Access and logistics
   - Confirm access list (track against checklist)
   - Communication channels and cadence
   - Who to contact for what

   [55–60 min] Questions
   ```

8. Set 90-day QBR reminder:
   "First QBR: {start date + 90 days}. Set calendar reminder and run `/agency:qbr-prep` before that date."

9. Update PIPELINE.md:
   Move this client from "Stage 7 — Closed Won" to active:
   - Add to CLIENTS.md (done above)
   - Update PIPELINE.md: mark Closed Won entry with "Onboarded — [date]"

10. Suggest next steps:
    ```
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      >> Complete kickoff call → start onboarding checklist
         Week 4: update CLIENTS.md health status after first results check
         Day 90: /agency:qbr-prep {workspace} {client}
         Anytime: /agency:portfolio {workspace} — see all clients

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ```
</process>
