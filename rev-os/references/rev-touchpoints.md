# Touchpoint Tracking

How to define, record, and report on touchpoints across your revenue funnel. Load this file before any attribution analysis, win/loss review, or multi-touch reporting.

---

## What is a touchpoint?

A touchpoint is any meaningful interaction between your company and a prospect or customer that advances the relationship. Not every activity is a touchpoint — a bounce from your homepage is not a touchpoint; a demo request is.

**Touchpoints are the unit of attribution.** They answer: which interactions, from which channels, contributed to a deal closing?

---

## Touchpoint taxonomy

### Pre-opportunity touchpoints (before SQL)

| Touchpoint | Category | What it means | Track in CRM? |
|-----------|----------|---------------|--------------|
| First website visit (tracked) | Inbound | Prospect identified from web session | Yes — if form submitted |
| Content download | Inbound | Ebook, whitepaper, report download | Yes — form submission |
| Webinar registration | Inbound - Event | Prospect registered for a webinar | Yes |
| Webinar attendance | Inbound - Event | Prospect actually attended (higher intent) | Yes |
| Inbound demo request | Inbound | Prospect requested a demo | Yes — high intent |
| Product trial signup | PLG | Prospect started a free trial | Yes |
| Cold email reply | Outbound | Prospect replied to outbound sequence | Yes |
| LinkedIn connection + response | Outbound | Prospect engaged on LinkedIn | Yes |
| Cold call connected | Outbound | Live outbound call, prospect engaged | Yes |
| Referral introduction | Referral | Warm intro from customer or partner | Yes — source = Referral |
| Event meeting (conference) | Event | Met at industry conference | Yes |
| Partner referral | Partner | Referral from channel or integration partner | Yes — source = Partner |

### Opportunity touchpoints (SQL through close)

| Touchpoint | Stage association | What it means | Track in CRM? |
|-----------|------------------|---------------|--------------|
| Discovery call | Discovery | First formal qualification call | Yes — as Activity |
| Demo | Demo / Eval | Product demonstration delivered | Yes |
| Technical evaluation | Demo / Eval | Security review, API test, trial expansion | Yes |
| Executive meeting | Any | Meeting with economic buyer (VP+) | Yes — multi-thread signal |
| Proposal sent | Proposal | Formal proposal or pricing sent | Yes — auto-tracked on deal |
| Follow-up call | Any | Check-in call during evaluation | Yes |
| Reference call | Proposal / Negotiation | Prospect spoke with existing customer | Yes |
| Legal / security review | Negotiation | Infosec, DPA, contract review initiated | Yes |
| Contract sent | Negotiation | Contract delivered for signature | Yes |
| Negotiation call | Negotiation | Price or terms discussion | Yes |

### Post-close touchpoints (customers)

| Touchpoint | What it means | Track in? |
|-----------|---------------|----------|
| Kickoff call | Implementation started | CRM + CS platform |
| Onboarding milestone | Key setup step completed | CS platform |
| QBR | Quarterly business review delivered | CRM + CS platform |
| Executive check-in | Meeting with economic buyer | CRM |
| NPS survey response | Promoter / Passive / Detractor score received | CS platform |
| Support ticket (critical) | Severity 1/2 ticket opened | CS platform |
| Usage alert (spike or drop) | Significant usage change | CS platform |
| Renewal call | Renewal conversation initiated | CRM — renewal deal |
| Expansion pitch | Upsell or cross-sell conversation | CRM — expansion deal |

---

## Touchpoint weighting for attribution

Different attribution models assign revenue credit to touchpoints differently. Use the model defined in `ATTRIBUTION.md`. These weights inform the default multi-touch linear model:

| Touchpoint position | Linear weight | Time-decay weight | U-shaped weight |
|--------------------|--------------|-------------------|-----------------|
| First touch | 1× | 0.5× (oldest) | 2.5× |
| Middle touches | 1× | Increases toward close | 0.5× each |
| Last touch (demo request / SQL) | 1× | 2× (most recent pre-SQL) | 2.5× |
| Closed Won | Not a touchpoint | — | — |

> For most B2B SaaS companies, **U-shaped** (also called position-based) is the most accurate starting model: it gives heavy credit to the first touch (what found you) and the SQL conversion touch (what converted them), and distributes the rest evenly.

---

## How to track touchpoints in HubSpot

### Activity types to use

HubSpot logs touchpoints as **Activities** on the Contact and Deal timeline.

| Touchpoint | Activity type | How to log |
|-----------|--------------|------------|
| Inbound form submission | Form submission | Automatic via HubSpot forms |
| Email opened / clicked | Email | Automatic via HubSpot email tracking |
| Discovery call | Call | Log manually or via Gong integration |
| Demo | Meeting | Log via HubSpot Meetings or Gong |
| Proposal sent | Email or Note | Log manually with type "Proposal" |
| Executive meeting | Meeting | Log with contact = economic buyer |
| Reference call | Call or Note | Log manually |
| Any outbound email | Email | Automatic via Outreach/Salesloft integration |

### Touchpoint custom properties (Contact level)

Add these to the Contact object to enable first-touch and multi-touch attribution:

| Property | Type | How to populate |
|----------|------|----------------|
| First touch date | Date | Workflow: set on first form submission |
| First touch source | Text | Workflow: set from UTM source on first touch |
| First touch campaign | Text | Workflow: set from UTM campaign on first touch |
| Last touch before SQL | Text | Workflow: set when lifecycle moves to SQL |
| SQL conversion touchpoint | Text | Workflow: capture what activity triggered SQL |
| Total touchpoints (pre-SQL) | Number | Workflow: count form submissions + meetings + calls |

### HubSpot workflows for touchpoint automation

1. **First touch capture** — Trigger: contact created or first form submission. Action: set `First touch date`, `First touch source` from UTM, `First touch campaign` from UTM. Run once per contact.

2. **SQL conversion capture** — Trigger: lifecycle stage changes to SQL. Action: set `Last touch before SQL` = most recent activity type; set `SQL conversion touchpoint`.

3. **Touchpoint counter** — Trigger: any form submission, meeting booked, or call logged. Action: increment `Total touchpoints (pre-SQL)` by 1. Requires HubSpot Operations Hub for calculated properties or use a workaround via incrementing workflow.

4. **Multi-thread score** — Trigger: meeting logged. Action: check if Contact.persona = Economic buyer. If yes, increment Deal.Multi_thread_score by 1.

---

## How to track touchpoints in Salesforce

### Activity model

Salesforce has two activity types: **Tasks** (one-way: email sent, call logged) and **Events** (calendar-based: meetings). Both associate to Contact and Opportunity.

| Touchpoint | Object type | How to log |
|-----------|------------|------------|
| Outbound email | Task | Auto-logged via Outreach/Salesloft |
| Cold call connected | Task | Log manually by SDR |
| Inbound form submission | Campaign Member | Web-to-Lead or Salesforce Forms |
| Discovery call | Event | Log via Gong integration or manually |
| Demo | Event | Log via Gong integration or manually |
| Executive meeting | Event | Log manually; set Contact = economic buyer |
| Proposal sent | Task (type = Proposal) | Log manually by AE |
| Reference call | Task (type = Reference) | Log manually by AE |

### Touchpoint custom fields (Contact / Lead level)

| Field | API name | Type | How to populate |
|-------|---------|------|----------------|
| First touch date | First_Touch_Date__c | Date | Flow: set on first Activity or Campaign Member |
| First touch source | First_Touch_Source__c | Text | Flow: set from UTM_Source__c on first touch |
| First touch campaign | First_Touch_Campaign__c | Text | Flow: set from UTM_Campaign__c on first touch |
| SQL conversion touchpoint | SQL_Conversion_Touch__c | Text | Flow: set when Lead Status = SQL |
| Total pre-SQL touchpoints | Total_Touchpoints__c | Number | Flow: increment on each Task/Event created |

### Salesforce Flows for touchpoint automation

1. **First touch capture** — Record-triggered on Contact creation or Campaign Member creation: if `First_Touch_Date__c` is null, set it + source + campaign from UTM fields.

2. **SQL conversion capture** — Record-triggered on Lead Status change to SQL or Opportunity creation from Lead: set `SQL_Conversion_Touch__c` = last Activity type.

3. **Multi-thread score update** — Record-triggered on Event creation: if associated Contact has Persona = Economic buyer, increment `Opportunity.Multi_Thread_Score__c`.

---

## How to track touchpoints in Pipedrive

Pipedrive's activity system is simpler but still sufficient:

| Touchpoint | Activity type | Notes |
|-----------|--------------|-------|
| Outbound email | Email | Auto-logged via linked email |
| Call | Call | Log manually or via Aircall integration |
| Demo | Meeting | Log via calendar integration |
| Proposal sent | Email (note: proposal) | Log with activity note |

Add custom deal fields for `First touch source` and `Total touchpoints` since Pipedrive lacks contact-level attribution properties. Use Zapier to populate from web form UTM data.

---

## Touchpoint analysis — what to look for

### Win/loss touchpoint patterns

Run this analysis monthly in `/rev:win-loss`:

- **Won deals**: average touchpoint count, most common pre-SQL touchpoints, average time between first touch and SQL
- **Lost deals**: where did engagement drop? What was the last touchpoint before going dark?
- **Source comparison**: which first-touch sources produce deals with the highest win rate? Lowest?

Key questions:
1. Do won deals have a higher multi-thread score? (More stakeholders engaged = higher win rate?)
2. Does attending a webinar vs. just registering predict higher SQL conversion?
3. Is there a touchpoint velocity threshold — deals that move too slowly or too quickly tend to lose?
4. Does an executive meeting in the first 30 days correlate with higher close rate?

### Touchpoint volume thresholds

Use as a starting benchmark — calibrate against your own closed deal data:

| Segment | Avg touchpoints to close | Flag if | Action |
|---------|------------------------|---------|--------|
| SMB | 5–10 | < 3 | Risk of insufficient qualification |
| Mid-market | 10–20 | < 7 | Risk of single-threaded deal |
| Enterprise | 20–40 | < 15 | Risk of insufficient stakeholder coverage |

### Multi-threading signal

A deal with only one engaged contact is at risk. Track `Multi_thread_score` on every deal:

| Score | Status | Risk |
|-------|--------|------|
| 1 | Single-threaded | High — champion could leave |
| 2 | Dual-threaded | Medium |
| 3+ | Multi-threaded | Low |

Flag all active deals at score = 1 in `/rev:signals` output.

---

## Attribution reporting standards

When producing attribution reports with `/rev:attribution`:

1. **Always state the model** — "This report uses linear multi-touch attribution. First touch and last touch are shown for comparison."
2. **Flag unattributed pipeline** — any deal without a lead source is excluded from attribution and counted separately as "Unattributed — $[X]K"
3. **Separate self-reported from tracked** — if your CRM has both UTM-captured source and rep-entered source, report them separately and flag conflicts
4. **Lookback window** — default is 90 days (configurable in `ATTRIBUTION.md`). State the window on every report.
5. **Minimum N** — do not draw channel conclusions from fewer than 10 deals. Flag small-N channels explicitly.
