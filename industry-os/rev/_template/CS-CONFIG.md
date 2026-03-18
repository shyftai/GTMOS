# CS Platform Configuration

CS tool setup, field mapping, health score formula, and sync configuration for this workspace. Load before any CS health analysis.

---

## CS Platform

**Platform:** [Gainsight / ChurnZero / Vitally / Planhat / Totango / Intercom / Manual]
**Version / Plan:** [Enterprise / Professional / etc.]
**Primary admin:** [Name]
**Connected to CRM:** [Yes — via native connector / Yes — via Zapier / No — manual sync]
**Last sync check:** [Date]

---

## Health Score Configuration

**Score range:** 0–100
**Status thresholds:**
- 🟢 Green: [75]–100
- 🟡 Yellow: [50]–74
- 🔴 Red: [25]–49
- 🚨 Critical: 0–[24]

**Component weights (must sum to 100%):**

| Component | Weight | Data source |
|-----------|--------|------------|
| Product engagement | [35]% | [Product analytics tool] |
| Relationship & engagement | [25]% | [CS platform] |
| Support & sentiment | [20]% | [Helpdesk + NPS tool] |
| Commercial health | [15]% | [Stripe / CRM] |
| Org stability | [5]% | [Enrichment / LinkedIn] |
| **Total** | **100%** | |

**Override rules (hard overrides — cannot be disabled):**

| Condition | Score cap |
|-----------|---------|
| Champion or economic buyer left | 40 |
| Payment failure > 7 days unresolved | 30 |
| NPS Detractor (< 0) | 35 |
| No product login > 30 days | 25 |
| Open P1 ticket > 7 days | 40 |
| [Custom override] | [X] |

**Score decay rules:**

| Signal | Decay starts | Rate |
|--------|-------------|------|
| Product usage data | Not updated in 7 days | -5/day |
| NPS | Not updated in 90 days | -3/week after 90d |
| CSM activity | Not logged in 21 days | -3/week |

**Last calibrated:** [Date]
**Calibration result:** [X]% of churned accounts caught at 🔴 30 days before churn

---

## CRM Field Mapping

Fields synced from CS platform to CRM Account record.

| CRM Field (API name) | CS Platform Field | Sync frequency |
|---------------------|------------------|---------------|
| Health_Score__c | [Platform field name] | Nightly |
| Health_Status__c | [Platform field name] | Nightly |
| Health_Score_Updated__c | [Platform field name] | Nightly |
| NPS_Score__c | [Platform field name] | On survey completion |
| NPS_Date__c | [Platform field name] | On survey completion |
| Last_Login_Date__c | [Platform field name] | Nightly |
| DAU_MAU_Ratio__c | [Platform field name] | Nightly |
| Feature_Adoption_Score__c | [Platform field name] | Nightly |
| Open_Support_Tickets__c | [Platform field name] | Daily |
| CSM_Owner__c | [Platform field name] | On change |
| Last_CSM_Activity__c | [Platform field name] | On log |
| Last_QBR_Date__c | [Platform field name] | On log |
| Renewal_Date__c | [CS platform / CRM contract field] | On change |
| Renewal_Status__c | [Platform field name] | Nightly |
| Expansion_Eligible__c | [Platform field name] | Nightly |

---

## Product Analytics Integration

**Product analytics tool:** [Segment / Amplitude / Mixpanel / Heap / Direct API / None]
**Connection:** [Direct integration / Webhook / Manual import]
**Key events tracked:**

| Event | What it measures | Mapped to |
|-------|----------------|----------|
| [login] | User session start | Last Login Date, DAU |
| [feature_used] | Core feature activation | Feature Adoption Score |
| [api_call] | API usage volume | Engagement signal |
| [export / share / invite] | Collaboration activity | Engagement signal |
| [upgrade_prompt_shown] | Hitting plan limits | Expansion signal |

**Key activation event (first value moment):**
> [Define the specific event that signals a customer has gotten first value from your product. This is used to calculate Time to Value.]

---

## Account Matching

**How CS platform accounts match to CRM accounts:**

Primary key: [Domain / CRM Account ID in CS platform metadata / Company name]
Secondary key: [Company name fuzzy match]

**Accounts in CS platform not matched to CRM:** [X] — [Resolution plan]
**Accounts in CRM not in CS platform:** [X] — [Resolution plan]

---

## Alerting Configuration

| Trigger | Alert goes to | Channel | Action required |
|---------|--------------|---------|----------------|
| Account goes 🔴 Red | CSM + CS manager | [Slack channel] | Contact within 48h |
| Account goes 🚨 Critical | CSM + VP CS | [Slack channel] | Contact within 24h |
| NPS Detractor submitted | CSM + CS manager | [Slack channel] | Call within 24h |
| No login > 30 days | CSM | [Slack / Email] | Outreach within 48h |
| Renewal < 60 days without conversation | CSM + CS manager | [Slack channel] | Start renewal motion |
| Payment failure | RevOps + Finance | [Slack channel] | Resolve within 7 days |

---

## Known Issues / Limitations

[Document any known issues with the CS platform integration, scoring exceptions, or data quality gaps.]

- [Issue — date identified — owner — status]
