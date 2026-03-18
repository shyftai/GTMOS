# REV:OS — CS Platform Integrations

Integration patterns, field mapping, and sync configuration for customer success platforms. Load before any CS health analysis or `/rev:customer` command.

---

## Platform Overview

| Platform | Best for | Key strengths | CRM sync |
|----------|----------|--------------|----------|
| Gainsight | Enterprise (500+ employees) | Health scoring, playbooks, journey orchestration | Native Salesforce; HubSpot via API |
| ChurnZero | Mid-market SaaS | Real-time health, ChurnScore, in-app engagement | Native HubSpot + SFDC |
| Totango | Mid-market to enterprise | SuccessBLOC templates, usage analytics | Native HubSpot + SFDC |
| Vitally | Mid-market SaaS | Clean UI, strong product analytics integration | Native HubSpot + SFDC |
| Planhat | Mid-market SaaS | Revenue-first, beautiful dashboards | Native HubSpot + SFDC |
| Intercom | PLG / product-led | In-app messaging, support, usage | HubSpot + SFDC via integration |
| Manual (no CS platform) | Early stage | Spreadsheet-based health in CUSTOMERS.md | Manual sync |

---

## Universal Field Mapping

Regardless of CS platform, REV:OS expects these fields to be available on CRM Account records after sync:

| Field | Source | Type | Description |
|-------|--------|------|-------------|
| Health Score | CS platform | Number (0–100) | Composite health score |
| Health Status | CS platform | Picklist | Green / Yellow / Red |
| Health Score Updated | CS platform | Date | When score was last recalculated |
| NPS Score | CS platform / survey | Number (-100 to 100) | Latest NPS |
| NPS Date | CS platform | Date | When NPS was last collected |
| Product DAU/MAU | Product analytics | Number | Daily/monthly active users |
| Last Login Date | Product analytics | Date | Most recent user login |
| Feature Adoption Score | CS platform | Number (0–100) | % of key features used |
| Support Tickets (open) | Helpdesk | Number | Open support tickets |
| Support Tickets (30d) | Helpdesk | Number | Tickets in last 30 days |
| CSM Owner | CS platform | User | Assigned CSM |
| Last CSM Activity | CS platform | Date | Last logged CSM touchpoint |
| Last QBR Date | CS platform | Date | When last QBR was held |
| Renewal Date | CS platform / CRM | Date | Contract renewal date |
| Renewal Status | CS platform | Picklist | On track / At risk / Renewing / Churned |
| Expansion Eligible | CS platform | Checkbox | Flagged for expansion motion |
| Time to Value (days) | CS platform | Number | Days from signup to first value milestone |

**Minimum viable set** (if platform only syncs some fields):
Health Status, NPS Score, Last Login Date, Renewal Date, CSM Owner — in that priority order.

---

## Platform-Specific Configuration

### Gainsight

**Sync to CRM:** Gainsight → Salesforce (native connector)

**Key objects to sync:**
- Company object → SFDC Account
- Scorecard metrics → SFDC custom fields
- Timeline activities → SFDC Activity (Tasks)
- CTA (Call to Action) status → SFDC custom field

**Gainsight health score → CRM:**
```
Gainsight C360 Score → CRM Health Score (numeric)
Gainsight Color (Red/Yellow/Green) → CRM Health Status (picklist)
```

**Common issues:**
- Gainsight company matching uses Gainsight Company Name → SFDC Account Name (fuzzy) — mismatches on legal name vs. trading name
- Timeline activities can flood SFDC activity log — configure filter to sync only CSM-logged activities, not automated touches
- Scorecard scores update on Gainsight schedule (often nightly) — 24h lag between real-world change and CRM visibility

**Fix for name mismatch:** Store Gainsight Company ID in SFDC Account custom field (`Gainsight_Company_ID__c`). Use this as the primary match key.

---

### ChurnZero

**Sync to CRM:** Native HubSpot and Salesforce connectors

**Key fields synced:**
- ChurnScore → CRM Health Score
- Account Status (Healthy/Neutral/At Risk) → CRM Health Status
- NPS → CRM NPS Score field
- Renewal Date → CRM Renewal Date

**ChurnZero events → CRM:**
Configure ChurnZero to push key events as CRM activities:
- Account went Red → Task created, CRM health status updated
- Renewal 90 days out → Task created, assigned to CSM
- NPS survey submitted → CRM NPS field updated

**Common issues:**
- ChurnScore is a proprietary algorithm — document what factors drive it in `CS-CONFIG.md`
- Multi-product accounts: ChurnZero tracks by subscription, CRM tracks by account — aggregate subscription scores to account level before syncing

---

### Vitally

**Sync to CRM:** Native HubSpot and Salesforce connectors

**Key fields synced:**
- Health Score → CRM Health Score
- Health Rating → CRM Health Status
- Last Seen (most recent user activity) → CRM Last Login Date
- Traits (product usage metrics) → CRM custom fields

**Vitally → CRM workflow:**
1. Connect Vitally to product analytics (Segment, Amplitude, Mixpanel, or direct API)
2. Map product events to Vitally traits (DAU, feature flags, API calls)
3. Configure health score formula in Vitally — document in `CS-CONFIG.md`
4. Set up Vitally → CRM sync for health fields

**Common issues:**
- Vitally health score requires product analytics integration to be meaningful — without usage data, it's just manual CSM input
- Traits are company-level aggregates of user-level data — make sure product user emails match CRM contact emails for correct rollup

---

### Planhat

**Sync to CRM:** Native HubSpot and Salesforce connectors

**Planhat-specific:**
- Revenue module in Planhat can become a secondary MRR source — reconcile against Stripe, not Planhat, as the billing source of truth
- Planhat "Enduser" = product user; maps to CRM Contact
- Planhat "Company" = account; maps to CRM Account

**Common issues:**
- If Planhat revenue module is used, it may conflict with Stripe-sourced MRR in CRM — set a clear hierarchy: Stripe is always truth for MRR; Planhat is truth for health and CS activities

---

### Totango

**Sync to CRM:** Native HubSpot and Salesforce via Totango integrations

**Key objects:**
- Account → CRM Account (health, attributes)
- Touchpoints → CRM Activity
- Campaigns (SuccessBLOCs) → CRM Tasks

**Common issues:**
- Totango segment data (customer journey stage) doesn't always map cleanly to CRM pipeline stages — document the mapping in `CS-CONFIG.md`

---

### No CS Platform (Manual Scoring)

For teams without a dedicated CS platform. Use `CUSTOMERS.md` as the health registry.

**Manual health scoring cadence:**
- CSMs update CUSTOMERS.md weekly with health status (🟢/🟡/🔴)
- NPS collected via survey tool (Typeform, Delighted, Medallia) — import results monthly
- Product usage from direct database query or BI export — import weekly or monthly
- Health score formula defined in `rev-health-scoring.md` — CSMs self-score against criteria

**Upgrade trigger:** When manual scoring takes > 2 hours/week or team has > 30 active accounts, evaluate a CS platform.

---

## Product Analytics Integration

CS health scores require product usage data. Common sources:

| Source | Data available | Connect to CS platform via |
|--------|---------------|---------------------------|
| Segment | Event stream, user traits | Native Gainsight/ChurnZero/Vitally connector |
| Amplitude | Feature adoption, retention | Amplitude → CS platform via API or Zapier |
| Mixpanel | Event-based usage | Mixpanel → CS platform via API |
| Intercom | In-app activity, support | Native ChurnZero/Vitally connector |
| Heap | Auto-captured events | Heap → CS platform via webhook |
| Direct DB | Raw usage tables | Custom ETL → CS platform API |

**Minimum product events for a meaningful health score:**
1. Login event (user + timestamp + account)
2. Key feature used (define "key feature" per product — the activation event)
3. API call volume (if applicable)
4. Export / share / invite events (collaboration signals)

---

## Data Flow Architecture

```
Product Analytics ──────────────────────────────┐
(Segment / Amplitude / Heap)                     │
                                                 ▼
Helpdesk ──────────────────────────────→ CS Platform
(Zendesk / Intercom)                    (Gainsight /
                                         ChurnZero /
Survey tool ───────────────────────────→  Vitally /
(Typeform / Delighted / Medallia)         Planhat)
                                                 │
Billing ────────────────────────────────────────┐│
(Stripe → CRM)                                  ▼▼
                                         CRM (single source)
                                                 │
                                         REV:OS reads
```

**Rule:** REV:OS reads from CRM only. CS platform syncs to CRM. REV:OS never reads directly from the CS platform. This keeps CRM as the single source of truth.

---

## Common Integration Issues

| Issue | Cause | Fix |
|-------|-------|-----|
| Health score stale in CRM | CS platform sync runs nightly; CRM shows yesterday's score | Add "Health Score Updated" date field; flag if > 48h stale |
| Account not found in CS platform | Company created in CRM after initial CS platform import | Trigger CS platform account creation on CRM account create (webhook) |
| Health score and renewal date conflict | CS platform shows renewing; CRM shows at-risk | CS platform is truth for health; CRM contract field is truth for renewal date |
| Duplicate accounts between CRM and CS platform | Different naming conventions | Use domain as the match key; store CS platform ID in CRM |
| Product usage data missing from health score | Product analytics not connected to CS platform | Connect product analytics first; health score without usage data is meaningless |
| NPS response tied to contact, not account | Survey tool collects by individual | Roll up contact-level NPS to account-level in CS platform before CRM sync |
