# REV:OS — RevOps Integrations

The common RevOps tech stack — tool categories, primary use cases, integration patterns, and known issues. Load when recommending tooling, configuring a new workspace, or debugging a data sync problem.

---

## CRM Systems

### Salesforce
**Best for:** Enterprise and mid-market B2B; complex sales processes; large GTM teams
**Primary RevOps use:** Source of truth for pipeline, accounts, contacts, opportunities, and activity
**Key objects:** Account, Contact, Lead, Opportunity, Activity (Task/Event), Custom objects
**Common RevOps pain points:**
- Data entry compliance without enforcement rules
- Lead-to-account matching (native is weak — use dedupe tools)
- Reporting requires custom reports or BI layer; native reports are limited
- Cost of customization and admin overhead

**Integration notes:**
- Use Salesforce API v55+ for data operations
- Bulk API for large-scale reads/writes (> 2,000 records)
- Real-time events via Salesforce Platform Events or Change Data Capture
- Rate limits: 100,000 API calls per 24 hours (varies by edition)

### HubSpot
**Best for:** SMB and early-stage mid-market; marketing-heavy GTM; teams that want fast setup
**Primary RevOps use:** CRM, marketing automation, and pipeline management in one platform
**Key objects:** Contact, Company, Deal, Ticket, Activity
**Common RevOps pain points:**
- Reporting limited without Operations Hub (additional cost)
- Data model is simpler — can be a limitation for complex processes
- Less flexible than Salesforce for customization
- Deduplication tools are basic in standard tier

**Integration notes:**
- REST API for most operations; Webhooks for event-based triggers
- Private Apps (API keys) for authentication
- Rate limits: 100 requests per 10 seconds per token
- HubSpot Operations Hub adds programmable automation and data sync

---

## Revenue Intelligence / Conversation Intelligence

### Gong
**Use:** Call recording, transcript analysis, deal inspection
**RevOps value:** Win/loss analysis from call data; rep coaching signals; competitor mention tracking; deal risk scoring
**Integration:** Gong → CRM sync pushes call summaries and key moments to opportunity records
**Common setup:** Connect Gong to Salesforce/HubSpot; configure Deals/Opportunities sync

### Chorus (ZoomInfo)
**Use:** Same as Gong — call recording and intelligence
**RevOps value:** Conversation analysis; deal signals; rep performance analytics

### Common issue: Call ↔ Deal mapping
- Calls not attached to the right opportunity = intelligence data is lost
- Fix: enforce opportunity-linked invites in calendar; use meeting ID as link key

---

## Billing and Subscription Management

### Stripe
**Use:** Payment processing, subscription management, invoicing
**RevOps value:** Source of truth for MRR, subscription changes, churn events
**Key data:** Customer object, Subscription object, Invoice object, Payment Intent
**Integration pattern:**
  - Stripe webhooks → event stream → CRM sync (via Zapier, Workato, or custom)
  - Stripe customer ID stored in CRM account record (required for reconciliation)
  - Map Stripe products/prices to CRM product catalog

**Webhook events to monitor:**
- `customer.subscription.created` — new subscription
- `customer.subscription.updated` — plan change, seat change
- `customer.subscription.deleted` — cancellation
- `invoice.paid` — successful payment
- `invoice.payment_failed` — payment failure (churn risk signal)

### Chargebee / Recurly
**Use:** Alternative subscription management platforms (same RevOps use as Stripe)
**Integration pattern:** Same webhook-based approach as Stripe

---

## Forecast and Pipeline Management

### Clari
**Use:** AI-powered forecast management, pipeline inspection, deal risk scoring
**RevOps value:** Automated forecast call; deal-level signals; CRM sync for activity data
**Integration:** Clari reads from Salesforce/HubSpot; writes forecast data back to CRM

### Aviso
**Use:** AI forecast and revenue intelligence
**RevOps value:** Forecast accuracy improvement; deal risk signals; win probability scoring

### Boostup
**Use:** Revenue intelligence and forecasting
**RevOps value:** Pipeline analytics, forecast modeling, rep performance

**Common issue with all forecast tools:**
- Garbage in, garbage out — if CRM data quality is poor, AI forecast is worse than human judgment
- Fix data quality first before relying on AI forecast tools

---

## Data Enrichment

Load `../../.claude/gtmos/references/enrichment-waterfall.md` for the full enrichment waterfall logic.

### Apollo.io
**Use:** B2B contact and account data, email finding, verification
**RevOps value:** Enriching CRM contacts with email, phone, title, LinkedIn; account firmographics
**Rate limits:** Depends on plan; typically 50,000 exports/month on growth plan
**Credit model:** Each contact export = 1 credit; account enrichment = 1 credit

### Clearbit (now Breyta / HubSpot)
**Use:** Account-level firmographics, tech stack, funding data
**RevOps value:** Enrich CRM accounts; website visitor enrichment; ICP scoring inputs

### ZoomInfo
**Use:** B2B contact data, intent data, technographics
**RevOps value:** Large-scale enrichment; contact database; buying intent signals
**Note:** High cost; evaluate ROI carefully; often used by enterprise RevOps teams

### Clay
**Use:** Enrichment waterfall automation; multi-source enrichment; workflow automation
**RevOps value:** Automate enrichment pipeline; cascade across multiple providers; AI rows for custom enrichment
**Note:** See `../../.claude/gtmos/references/clay-ecosystem.md` for full Clay integration map

---

## Data Integration and Sync

### Workato
**Use:** Enterprise integration platform; bi-directional sync; workflow automation
**RevOps value:** CRM ↔ Billing sync; CRM ↔ CS platform sync; automated enrichment workflows
**Best for:** Complex integrations with conditional logic; enterprise compliance requirements

### Zapier
**Use:** Lightweight automation; event-based triggers; simple CRM sync
**RevOps value:** Quick integrations between tools; webhook-to-CRM flows
**Best for:** SMB RevOps; simple triggers; 1-directional syncs

### Fivetran / Airbyte
**Use:** Data pipeline to data warehouse; CDC (Change Data Capture)
**RevOps value:** Load CRM, billing, and product data to warehouse (Snowflake, BigQuery, Redshift) for BI
**Best for:** Teams with a data warehouse and BI layer

### Census / Hightouch (Reverse ETL)
**Use:** Push enriched/modeled data from warehouse back to CRM or other tools
**RevOps value:** Write calculated scores, segments, and enrichment back to CRM from data warehouse
**Best for:** RevOps teams with a data engineer or analyst using dbt/SQL

---

## Customer Success Platforms

### Gainsight
**Use:** Customer health scoring, playbooks, renewals management
**RevOps value:** Health score feeds; renewal tracking; expansion opportunity identification
**Integration:** Gainsight → CRM sync for health scores and renewal dates; product usage data in

### Totango / ChurnZero / Planhat
**Use:** CS engagement platform; health scoring; automated playbooks
**RevOps value:** Churn signals; renewal risk flags; product usage scoring

---

## RevOps Tech Stack by Company Stage

### Early stage (< $5M ARR, < 30 employees)
**Minimum viable stack:**
- CRM: HubSpot Starter/Professional
- Billing: Stripe
- Enrichment: Apollo (basic plan)
- Reporting: HubSpot native reports + Google Sheets

### Growth stage ($5M–$30M ARR, 30–150 employees)
**Recommended stack:**
- CRM: HubSpot Professional or Salesforce Essentials/Professional
- Billing: Stripe + Chargebee for complex billing
- Enrichment: Apollo + Clay
- Sequencing: Apollo Sequences or Outreach
- Reporting: HubSpot/SFDC + Looker or Metabase
- Forecast: Manual process + spreadsheet model or Clari

### Scale stage ($30M+ ARR, 150+ employees)
**Full stack:**
- CRM: Salesforce Enterprise
- Billing: Stripe + Chargebee
- Enrichment: ZoomInfo + Clearbit + Clay
- Revenue intelligence: Gong + Clari
- CS platform: Gainsight or ChurnZero
- Integration: Workato or MuleSoft
- Data warehouse: Snowflake or BigQuery
- BI: Looker or Tableau
- Reverse ETL: Census or Hightouch

---

## Common Integration Issues

| Issue | Cause | Fix |
|-------|-------|-----|
| CRM vs. Stripe ARR mismatch | Stripe customer not linked to CRM account; manual ARR entries in CRM | Store Stripe customer ID in CRM; reconcile monthly via script |
| Duplicate accounts created by integration | No dedup check before account create | Add dedup lookup step in sync logic before creating new records |
| Contact created without account link | Integration creates contacts without company lookup | Enforce account lookup on contact create; reject if no match |
| Gong calls not attached to opportunities | Missing opportunity ID in meeting invite | Enforce opp-linked invites; add Gong-SFDC matching rule by domain |
| Lead source lost on conversion | CRM default overwrites lead source on conversion | Preserve original lead source field during lead-to-contact convert |
| Enrichment overwrites manual fields | Enrichment writes to all fields regardless of existing data | Build overwrite logic: only write to empty fields unless data is stale |
