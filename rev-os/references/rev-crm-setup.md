# CRM Setup Guide

Step-by-step configuration for getting your CRM ready for REV:OS. Follow this before running `/rev:onboard` if your CRM is new, recently migrated, or hasn't been configured for RevOps.

Load this file when a user asks how to set up their CRM, reports data quality issues that seem structural, or is migrating from another system.

---

## Which CRM are you using?

- [HubSpot](#hubspot) — most common for Series A–C SaaS
- [Salesforce](#salesforce) — common for Series B+ and enterprise
- [Pipedrive](#pipedrive) — common for SMB and early-stage
- [Other CRMs](#other-crms) — field mapping principles that apply anywhere

---

## HubSpot

### Before you start

You need: HubSpot Sales Hub (Starter or above for pipeline reporting; Professional for forecasting and custom reports).

REV:OS works best with **Sales Hub Professional** or above. Starter is acceptable but limits forecast tooling and custom property automation.

---

### Step 1: Object setup

HubSpot's four primary objects for RevOps: **Contacts**, **Companies**, **Deals**, **Tickets**.

#### Required custom properties — Companies

| Property name | Type | Why |
|--------------|------|-----|
| Account tier | Dropdown (Tier 1 / Tier 2 / Tier 3) | Enrichment prioritization, health score weighting |
| ICP fit score | Number (0–100) | Lead scoring and routing |
| ARR (current) | Number | Revenue tracking for existing customers |
| Contract renewal date | Date | Renewal pipeline management |
| CS owner | Contact owner / text | CS assignment for health scoring |
| Health score | Number (0–100) | Composite customer health — updated by CS platform or manually |
| Health status | Dropdown (🟢 Green / 🟡 Yellow / 🔴 Red / 🚨 Critical) | Segment view in dashboards |
| Enrichment source | Text | Track which provider enriched this record |
| Enrichment date | Date | Cache freshness check |
| Product tier | Dropdown (Starter / Pro / Enterprise / Custom) | Expansion signal tracking |

#### Required custom properties — Contacts

| Property name | Type | Why |
|--------------|------|-----|
| Lead source detail | Text | Supplement HubSpot's built-in `Lead Source` |
| UTM source | Text | Store on first touch |
| UTM medium | Text | Store on first touch |
| UTM campaign | Text | Store on first touch |
| SDR owner | Contact owner | SDR assignment |
| First meeting date | Date | Cycle time calculation |
| Persona | Dropdown (Economic buyer / Champion / Influencer / End user / Blocker) | Multi-threading |
| Suppressed | Checkbox | Do-not-contact flag |
| Enrichment source | Text | Provider tracking |
| Enrichment date | Date | Cache freshness |

#### Required custom properties — Deals

| Property name | Type | Why |
|--------------|------|-----|
| Deal type | Dropdown (New logo / Upsell / Cross-sell / Renewal) | Revenue waterfall segmentation |
| Close quarter | Text (e.g., Q2 2025) | Quarterly reporting |
| Loss reason | Dropdown | Win/loss analysis |
| Competitor | Text | Competitive intelligence |
| ACV (annual) | Number | Annualized deal value for ARR tracking |
| Forecast category | Dropdown (Commit / Most likely / Upside / Omit) | Forecast modeling |
| Next step | Text | Deal hygiene — required on all active deals |
| Next step date | Date | Stall detection — flag if > 14 days past |
| Multi-thread score | Number (1–5) | Count of engaged stakeholders |
| Win/loss recorded | Checkbox | Ensure every closed deal has a record |

---

### Step 2: Pipeline and stages

Create one pipeline per revenue motion. Most companies start with one; add separate pipelines for renewals and expansions if volume warrants.

#### New business pipeline (standard stages)

| Stage name | Probability | Definition | Exit criteria |
|-----------|-------------|-----------|---------------|
| SQL | 10% | Sales-qualified, meeting booked | Discovery call completed |
| Discovery | 20% | Active qualification in progress | MEDDIC/BANT partially complete |
| Demo / Eval | 40% | Product demonstrated, evaluating | Decision criteria confirmed |
| Proposal | 60% | Proposal or quote sent | Verbal interest confirmed |
| Verbal / Legal | 80% | Verbal yes, contract in review | Contract sent |
| Closed Won | 100% | Signed contract received | — |
| Closed Lost | 0% | Deal ended without purchase | Loss reason required |

> Customize stage names to match what your team actually says. The probabilities above are REV:OS defaults from `rev-defaults.md` — override in `PIPELINE.md` once calibrated against your own win data.

#### Renewal pipeline (if managing separately)

| Stage | Probability | Definition |
|-------|-------------|-----------|
| Renewal identified | 50% | Renewal date < 90 days, no outreach started |
| Outreach started | 60% | First renewal conversation initiated |
| In negotiation | 75% | Terms being discussed |
| Contract sent | 90% | Renewal contract out for signature |
| Renewed | 100% | Signed |
| Churned | 0% | Customer did not renew |

---

### Step 3: Lifecycle stages

HubSpot's built-in lifecycle stages (do not add custom ones — map to these):

```
Subscriber → Lead → Marketing Qualified Lead (MQL) → Sales Qualified Lead (SQL)
→ Opportunity → Customer → Evangelist
```

**Set lifecycle stage automatically** using HubSpot workflows:
- Contact form submission → **Lead**
- Lead score threshold crossed (if using lead scoring) → **MQL**
- Deal created and associated → **SQL**
- Deal moved to Discovery or later → **Opportunity**
- Deal Closed Won → **Customer**

> Never manually move lifecycle stages backward. If a deal is lost, the contact stays at the stage they reached — do not reset to Lead.

---

### Step 4: Required integrations

#### Stripe → HubSpot
- Use: [HubSpot's native Stripe integration](https://ecosystem.hubspot.com/marketplace/apps/finance/stripe) or a middleware like Zapier / Make
- Sync: subscription ARR, MRR, plan name, billing status → Company object
- Required mapped fields: `MRR`, `Subscription status`, `Plan name`, `Next billing date`
- Reconcile weekly — check `STRIPE.md` for variance tolerance (< 1%)

#### Gong / Chorus → HubSpot
- Use: Gong's native HubSpot integration
- Sync: call recordings, deal risk scores, next steps from calls → Deal activity timeline
- Set deal stage to auto-update based on Gong deal stage recommendations (optional)

#### CS platform → HubSpot
- **Gainsight**: Gainsight Connect syncs health scores and CTAs to HubSpot Company properties
- **ChurnZero**: ChurnZero → HubSpot integration via native connector or Zapier
- **Vitally**: Webhook-based sync to HubSpot custom properties
- At minimum, sync: `Health score`, `Health status`, `Last login date`, `Product usage score`

#### Sequencing tool → HubSpot
- **Outreach / Salesloft**: Use native HubSpot integration; log all email activity to Contact timeline
- Map sequence enrollment to a Contact custom property for attribution tracking

---

### Step 5: Dashboards to build

Build these five dashboards and pin them to your RevOps team home screen:

1. **Pipeline overview** — deals by stage, total pipeline value, avg age per stage
2. **Forecast tracker** — deals by forecast category vs. quota, weekly delta
3. **Data quality** — % of Company and Contact records with required fields complete
4. **Revenue metrics** — new MRR, expansion MRR, churn MRR, net MRR by month
5. **Customer health** — companies by health status (🟢/🟡/🔴/🚨), at-risk ARR, renewals < 90 days

---

### Step 6: Workflows to configure

| Workflow | Trigger | Action |
|----------|---------|--------|
| Deal stall alert | Deal last modified > 14 days, stage not Closed | Notify deal owner + RevOps via Slack |
| Win/loss required | Deal moved to Closed Won or Closed Lost | Create task for rep: "Complete win/loss record within 14 days" |
| Renewal created | Contract renewal date < 90 days, no renewal deal exists | Create renewal deal in renewal pipeline |
| Health score alert | Health status changes to 🔴 or 🚨 | Notify CS owner + VP CS via Slack |
| Enrichment decay | Enrichment date > 30 days on Tier 1 company | Flag record for re-enrichment |
| New logo customer | Deal Closed Won, Deal type = New logo | Move contact lifecycle to Customer; notify CS for handoff |

---

### Step 7: Reporting setup

Standard REV:OS reports to create in HubSpot:

- **Win rate by source** — Closed Won % by Lead Source (built-in filtered deal report)
- **Stage conversion funnel** — Deal count and value flowing through each stage by month
- **Rep attainment** — Closed Won value vs. quota by deal owner (requires quota tracking in HubSpot or spreadsheet)
- **NRR / GRR** — New + Expansion MRR vs. Contraction + Churn MRR by month (custom report)
- **Deal velocity** — Average time in each stage, by segment and rep

> HubSpot's native reporting covers most of these. The NRR/GRR report often needs a custom calculation or Stripe integration output — use `REVENUE.md` as your authoritative source.

---

## Salesforce

### Before you start

You need: Salesforce Sales Cloud (Professional, Enterprise, or Unlimited). REV:OS works best with **Enterprise** or **Unlimited** for custom objects, flows, and advanced reporting.

---

### Step 1: Object and field setup

#### Required custom fields — Account

| Field name (API) | Type | Why |
|-----------------|------|-----|
| Account_Tier__c | Picklist (Tier 1 / Tier 2 / Tier 3) | Enrichment prioritization |
| ICP_Fit_Score__c | Number | Lead scoring |
| ARR_Current__c | Currency | Revenue tracking |
| Renewal_Date__c | Date | Renewal pipeline |
| Health_Score__c | Number (0–100) | CS health score |
| Health_Status__c | Picklist (Green / Yellow / Red / Critical) | Dashboard segmentation |
| CS_Owner__c | Lookup (User) | CS assignment |
| Enrichment_Source__c | Text | Provider tracking |
| Enrichment_Date__c | Date | Cache freshness |
| Product_Tier__c | Picklist | Expansion signal |

#### Required custom fields — Contact

| Field name (API) | Type | Why |
|-----------------|------|-----|
| Persona__c | Picklist (Economic buyer / Champion / Influencer / End user / Blocker) | Multi-threading |
| UTM_Source__c | Text | Attribution — capture on web form |
| UTM_Medium__c | Text | Attribution |
| UTM_Campaign__c | Text | Attribution |
| First_Meeting_Date__c | Date | Sales cycle calculation |
| Suppressed__c | Checkbox | Do-not-contact |
| Enrichment_Source__c | Text | Provider tracking |
| Enrichment_Date__c | Date | Cache freshness |

#### Required custom fields — Opportunity

| Field name (API) | Type | Why |
|-----------------|------|-----|
| Deal_Type__c | Picklist (New logo / Upsell / Cross-sell / Renewal) | Revenue waterfall |
| Forecast_Category__c | Picklist (Commit / Most Likely / Upside / Omit) | Forecast modeling (use Salesforce native if available) |
| Loss_Reason__c | Picklist | Win/loss analysis |
| Competitor__c | Text | Competitive intel |
| ACV__c | Currency | Annualized value |
| Next_Step__c | Text (required) | Deal hygiene |
| Next_Step_Date__c | Date | Stall detection |
| Multi_Thread_Score__c | Number | Engaged stakeholders |
| Win_Loss_Recorded__c | Checkbox | Completion tracking |

---

### Step 2: Opportunity stages

| Stage | Probability | Definition | Exit criteria |
|-------|-------------|-----------|---------------|
| SQL | 10% | Qualified, meeting booked | Discovery call completed |
| Discovery | 20% | Actively qualifying | MEDDIC partially complete |
| Demo / Eval | 40% | Demonstrated, evaluating | Decision criteria confirmed |
| Proposal | 60% | Proposal sent | Verbal interest received |
| Negotiation / Legal | 80% | Contract in review | Contract sent |
| Closed Won | 100% | Signed | — |
| Closed Lost | 0% | Not purchased | Loss_Reason__c required |

Set **Validation Rules** to enforce:
- `Next_Step__c` and `Next_Step_Date__c` required when Stage ∈ {Discovery, Demo/Eval, Proposal, Negotiation}
- `Loss_Reason__c` required when Stage = Closed Lost
- `Win_Loss_Recorded__c` required within 14 days of close (use Process Builder or Flow to create reminder Task)

---

### Step 3: Lead → Contact/Account conversion

Set these conversion defaults:
- **Lead Source** carries to Contact and Opportunity on conversion — never lose it
- **UTM fields** copy from Lead to Contact on conversion via conversion mapping
- **Account matching**: convert to existing Account if domain matches — do not create duplicate Accounts

Configure the Lead conversion mapping under `Setup → Lead Settings → Lead Conversion`:
- Map `Lead Source` → `Contact.LeadSource` + `Opportunity.LeadSource`
- Map `UTM_Source__c` → `Contact.UTM_Source__c`
- Map `UTM_Campaign__c` → `Contact.UTM_Campaign__c`

---

### Step 4: Required integrations

#### Stripe → Salesforce
- Use: [Stripe Billing Connector for Salesforce](https://stripe.com/docs/stripe-apps/salesforce) or a middleware (Zapier, Make, Workato)
- Sync: subscription object → Account; map MRR, plan, status, next billing date
- Required: create a `Stripe_Subscription__c` custom object or use Account fields

#### Gong → Salesforce
- Use: Gong native Salesforce integration
- Sync: call recordings + AI risk flags → Opportunity activity timeline
- Map Gong deal stage → Opportunity Stage where possible

#### CS platform → Salesforce
- **Gainsight**: native Salesforce-native (runs inside SFDC); health scores update Account fields directly
- **ChurnZero**: connector syncs health score and segment to Account
- **Vitally**: Salesforce package available; maps to Account and custom objects

#### Marketing automation → Salesforce
- **HubSpot + Salesforce**: bidirectional sync via native connector; map Lead Source, campaign membership
- **Marketo**: Marketo–Salesforce sync; ensure UTM parameters pass through program membership

---

### Step 5: Flows to build

| Flow | Type | Trigger | Action |
|------|------|---------|--------|
| Deal stall alert | Record-triggered | Opportunity last modified > 14 days, stage not Closed | Send Slack / email to owner + RevOps |
| Win/loss task | Record-triggered | Opportunity stage changes to Closed Won / Lost | Create Task: "Complete win/loss record" due 14 days |
| Renewal pipeline creation | Scheduled | Account.Renewal_Date__c < 90 days, no renewal Opportunity exists | Create Opportunity (type = Renewal) |
| Customer health alert | Record-triggered | Account.Health_Status__c changes to Red or Critical | Notify CS owner + VP CS |
| New customer CS handoff | Record-triggered | Opportunity Closed Won, Deal_Type__c = New logo | Create Task for CS: "Complete onboarding handoff" |
| Enrichment decay flag | Scheduled (daily) | Account.Enrichment_Date__c > 30 days AND Account_Tier__c = Tier 1 | Add to enrichment queue (update flag field) |

---

### Step 6: Reports and dashboards

Create a **RevOps** report folder. Standard reports:

- **Pipeline by stage** — Opportunity report grouped by Stage; columns: Count, Amount, Avg Age
- **Rep attainment** — Opportunities Closed Won this quarter vs. quota by Owner (quota requires custom Quota__c object or manual input)
- **Win rate by source** — Opportunities grouped by Lead Source; Win % calculated field
- **Deal velocity** — Average days in each stage; requires a custom Stage History report or Salesforce Einstein Activity Capture data
- **ARR waterfall** — New + Expansion − Contraction − Churn; typically built in Sheets from Stripe data, surfaced in REVENUE.md

Build a **RevOps Command Center** dashboard with:
1. Pipeline funnel (current quarter)
2. Forecast vs. quota (commit / most likely / upside)
3. Data quality score (requires formula fields or custom report)
4. Customer health distribution (🟢/🟡/🔴/🚨)
5. Renewal pipeline (next 90 days)

---

## Pipedrive

### Before you start

You need: Pipedrive Professional or above for revenue forecasting and custom reporting. Essential is acceptable for basic pipeline tracking.

---

### Step 1: Pipeline and stages

Pipedrive organizes deals in **Pipelines → Stages**. Create:

**New business pipeline:**
| Stage | Probability | Definition |
|-------|-------------|-----------|
| SQL | 10% | Qualified, meeting scheduled |
| Discovery | 25% | Active conversation |
| Demo | 40% | Demo completed |
| Proposal | 60% | Proposal sent |
| Negotiation | 80% | Contract stage |
| Won | 100% | Closed won |

**Renewal pipeline** (if tracking separately):
| Stage | Probability |
|-------|-------------|
| Identified | 50% |
| Outreach started | 65% |
| In discussion | 80% |
| Contract sent | 90% |

---

### Step 2: Custom fields

Pipedrive allows custom fields per object. Create:

**Deal custom fields:**
- Deal type (Dropdown: New logo / Upsell / Cross-sell / Renewal)
- Forecast category (Dropdown: Commit / Most likely / Upside / Omit)
- Loss reason (Dropdown — required on lost deals)
- ACV (Monetary)
- Next step (Text)
- Next step date (Date)
- Multi-thread score (Numeric)

**Organization (Company) custom fields:**
- Account tier (Dropdown: Tier 1 / Tier 2 / Tier 3)
- ARR current (Monetary)
- Renewal date (Date)
- Health score (Numeric)
- Health status (Dropdown: Green / Yellow / Red / Critical)
- CS owner (Text)

**Person (Contact) custom fields:**
- Persona (Dropdown: Economic buyer / Champion / Influencer / End user)
- UTM source (Text)
- UTM medium (Text)
- UTM campaign (Text)

---

### Step 3: Required integrations

#### Stripe → Pipedrive
- Use: Zapier or Make (no native Stripe–Pipedrive connector)
- Trigger: Stripe subscription created / updated → Update Organization fields (ARR, MRR, plan)
- Sync frequency: real-time via webhook

#### Gong → Pipedrive
- Use: Zapier (Gong → Pipedrive activity log)
- Log call outcomes and next steps to Deal notes

#### Enrichment → Pipedrive
- Use: Clay or Apollo → Pipedrive via native integration or Zapier
- Map enriched fields to custom Organization and Person fields

---

### Step 4: Automations

Pipedrive's built-in automations (Workflow Automations):

| Automation | Trigger | Action |
|-----------|---------|--------|
| Deal stall alert | Deal not updated > 14 days | Email notification to owner |
| Win/loss task | Deal marked won or lost | Create activity: "Complete win/loss record" |
| Renewal creation | Organization renewal date < 90 days | Create deal in renewal pipeline |

---

### Step 5: Reports

Pipedrive's built-in reports cover:
- Pipeline conversion (stage-by-stage funnel)
- Revenue forecast (weighted pipeline)
- Win rate by source, team, product

For NRR / ARR waterfall, export Pipedrive data + Stripe data to Google Sheets — Pipedrive is not designed for subscription revenue analytics. Use `REVENUE.md` as your authoritative ARR tracker.

---

## Other CRMs

If using a CRM not listed above (Close, Zoho, Freshsales, Monday CRM, etc.), apply these universal setup principles:

### Universal field requirements

Every CRM must have these fields before REV:OS can operate:

| Object | Fields required |
|--------|----------------|
| Company / Account | Account tier, ARR, Renewal date, Health score, Health status, Enrichment date |
| Contact / Person | Lead source, UTM source/medium/campaign, Persona, Suppressed flag |
| Deal / Opportunity | Deal type, Forecast category, Loss reason, ACV, Next step, Next step date |

### Universal pipeline principles

1. **Probability maps to stage** — every stage must have a defined close probability
2. **Exit criteria are documented** — you must know what moves a deal to the next stage
3. **Loss reason is required on close** — no closed-lost without a reason
4. **Source is never lost** — lead source must carry from first touch through to closed deal

### Data migration checklist

If migrating from another CRM:

- [ ] Map all old field names to new field names before import
- [ ] Validate lead source data — reclassify "Other" and NULL sources before import
- [ ] De-duplicate before migration — do not import existing duplicates into the new CRM
- [ ] Test import on 50 records before full migration
- [ ] Verify relationship links (Contact → Account → Deal) after import
- [ ] Run `/rev:health` immediately after migration to baseline data quality

---

## CRM readiness checklist

Before running `/rev:onboard`, confirm:

- [ ] All required custom fields created (Accounts, Contacts, Deals)
- [ ] Pipeline stages defined with probabilities and exit criteria
- [ ] Lifecycle stages / lead statuses configured
- [ ] Stripe connected and syncing MRR to Account records
- [ ] CS platform connected and syncing health scores to Account records (or manual health scoring configured)
- [ ] Gong / call recording tool connected and logging to Deal timeline
- [ ] Sequencing tool (Outreach / Salesloft / Instantly) connected and logging email activity
- [ ] UTM tracking active — web forms capturing and storing UTM parameters to Contact
- [ ] Lead source required on all new Contacts and Deals
- [ ] Win/loss workflow / task automation configured
- [ ] Enrichment decay automation configured

If any item is unchecked, REV:OS will flag it during `/rev:health` and recommend resolution. It is safe to run `/rev:onboard` with items unchecked — but data quality scores will reflect the gaps.
