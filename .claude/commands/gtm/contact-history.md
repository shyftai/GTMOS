---
name: gtm:contact
description: View full contact history — every touchpoint, campaign, signal, and interaction
argument-hint: "<workspace-name> <email-or-name>"
---
<objective>
Pull and display the complete history of a contact across all campaigns, channels, signals, and CRM data. See everything that's happened with this person in one view.

Workspace and contact: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
@./.claude/gtmos/references/attribution-ledger.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // CONTACT HISTORY >>`
2. Parse contact identifier from $ARGUMENTS — email address, full name, or LinkedIn URL

## Data collection
3. Search across all workspace data sources for this contact:

**Local workspace data:**
- Touch ledger (`logs/touch-ledger.csv` — see attribution-ledger.md) — every touch with campaign_id; derive `source_campaign`, `last_contacted_at`, `last_outcome`, `eligible_again_at`
- All campaign lists (lists/validated/, lists/shipped/) — which campaigns included them
- Reply logs (replies/) — any replies from this contact
- Suppression list — are they suppressed?
- PIPELINE.md — are they in a deal? what stage?

**CRM data (if connected):**
- Pull contact record from Attio/HubSpot/Salesforce/Pipedrive
- Deal history, stage, value, owner
- Notes, activities, last contact date
- Tags, lists, lifecycle stage

**Sending tool data (if connected):**
- Pull from Instantly/Lemlist/Smartlead
- Campaign enrollment history
- Open/click/reply/bounce events with timestamps
- Current status (active, replied, bounced, unsubscribed)

**LinkedIn data (if Crispy connected):**
- Connection status
- Message history
- Profile data (title, company, location)

**Enrichment data:**
- Last enrichment date and source
- Email verification status and date
- Phone number (if found)
- Company data

**Signal history:**
- Website visits (if visitor ID connected) — pages, dates, intent score
- Signals that triggered outreach (funding, hiring, job change)

4. Display the unified contact view:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  CONTACT — {Full Name}                                       ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                              ┃
┃  {Title} at {Company}                                        ┃
┃  {Email}                  {Phone}                            ┃
┃  {LinkedIn URL}           {Location}                         ┃
┃                                                              ┃
┃  Company: {size} employees · {industry} · {funding stage}    ┃
┃  ICP score: {score}/100   Persona match: {persona name}      ┃
┃                                                              ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                              ┃
┃  Timeline                                                    ┃
┃                                                              ┃
┃  {date}  Signal: Company raised Series B (Signalbase)        ┃
┃  {date}  Added to "Q1 Cold Outbound" campaign                ┃
┃  {date}  Email Touch 1 sent — opened                         ┃
┃  {date}  Email Touch 2 sent — no open                        ┃
┃  {date}  Website visit: pricing page (intent +20)            ┃
┃  {date}  Email Touch 3 sent — replied (positive)             ┃
┃  {date}  Reply handled — meeting booked                      ┃
┃  {date}  LinkedIn connection request sent (Crispy)           ┃
┃  {date}  LinkedIn connection accepted                        ┃
┃  {date}  CRM: Moved to "Discovery" stage                     ┃
┃  {date}  CRM: Moved to "Proposal" stage                      ┃
┃                                                              ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                              ┃
┃  Status                                                      ┃
┃  Campaign: Q1 Cold Outbound — replied (positive)             ┃
┃  CRM: Proposal stage — $12,000 — @sarah                     ┃
┃  Suppressed: no                                              ┃
┃  Last contact: {date} ({n} days ago)                         ┃
┃  Email verified: {date} ({fresh / stale >90 days})           ┃
┃                                                              ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

5. If contact has been in multiple campaigns, show cross-campaign summary:
```
  Campaign history:
    Q4 Product Launch   Nov 2025   No reply (4 touches)
    Q1 Cold Outbound    Mar 2026   Positive reply → meeting
```

6. Flag risks — eligibility is `eligible_again_at` from the touch ledger (`last_contacted_at` + the cooldown for `last_outcome`; see attribution-ledger.md):
   - "Sourced by {source_campaign}; last touched {date} — eligible to re-approach {eligible_again_at}"
   - "Email verified 120 days ago — re-verify before next outreach"
   - "Contact replied negatively in {campaign} — check before re-contacting"
   - "Suppressed — do not contact"

7. Suggest next action based on current status:
```
  >> Next: Follow up on proposal — check CRM for updates
     Also: /gtm:replies {ws} — if pending reply
```
</process>
</content>
