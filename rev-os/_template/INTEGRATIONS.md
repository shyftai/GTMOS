# Integrations

Tool stack and data flow configuration. Document every tool that touches revenue data. Update when adding or removing integrations.

---

## Tech Stack

| Category | Tool | Plan/Tier | Status | Primary user |
|----------|------|-----------|--------|-------------|
| CRM | [Salesforce / HubSpot] | [Edition] | Active | [Name] |
| Billing | Stripe | [Plan] | Active | [Name] |
| Revenue intelligence | [Gong / Chorus] | [Plan] | [Active / Not configured] | [Name] |
| Forecast | [Clari / Aviso / Manual] | [Plan] | [Active / Not configured] | [Name] |
| Sequencing | [Apollo / Outreach / Lemlist] | [Plan] | [Active / Not configured] | [Name] |
| Enrichment | [Apollo / Clearbit / ZoomInfo] | [Plan] | [Active / Not configured] | [Name] |
| CS platform | [Gainsight / ChurnZero] | [Plan] | [Active / Not configured] | [Name] |
| Integration middleware | [Zapier / Workato / Custom] | [Plan] | [Active / Not configured] | [Name] |
| Data warehouse | [Snowflake / BigQuery / None] | [Plan] | [Active / Not configured] | [Name] |
| BI / Dashboards | [Looker / Metabase / Sheets] | [Plan] | [Active / Not configured] | [Name] |

---

## Data Flow Map

```
Stripe ──────────────────────────────────────────→ CRM (Accounts + ARR field)
                                                      │
Apollo / Clearbit ────── Enrichment ─────────────→ CRM (Contacts + Accounts)
                                                      │
Outreach / Apollo ────── Sequences ──────────────→ CRM (Activity)
                                                      │
Gong / Chorus ───────── Call data ───────────────→ CRM (Opportunity notes)
                                                      │
Gainsight / ChurnZero ── CS health ──────────────→ CRM (Account health score)
                                                      │
                                           CRM ──→ Data Warehouse ──→ BI / Reports
```

---

## Integration Details

### Stripe ↔ CRM

**Sync method:** [Zapier / Workato / Custom webhook / Native connector]
**Events synced:**
- [ ] New subscription created → CRM account updated (ARR field)
- [ ] Subscription upgraded → CRM account updated (Expansion)
- [ ] Subscription downgraded → CRM account updated (Contraction)
- [ ] Subscription cancelled → CRM account updated (Churned); deal created
- [ ] Payment failed → CRM activity logged; at-risk flag set

**Sync status:** [Active / Degraded / Error]
**Last successful sync:** [Date]
**Known issues:** [Description or "None"]

---

### Enrichment Integration

**Provider:** [Apollo / Clearbit / ZoomInfo]
**Sync method:** [API / Native integration / Manual export]
**Objects enriched:** [Accounts / Contacts / Both]
**Fields written:** [List fields enriched]
**Frequency:** [On creation / Nightly / Weekly / Manual]
**Known issues:** [Description or "None"]

---

### Revenue Intelligence (Gong / Chorus)

**Sync method:** Native CRM connector
**Data flowing to CRM:**
- [ ] Call recordings linked to opportunities
- [ ] Call summaries synced to opportunity notes
- [ ] Next steps from calls logged as tasks
- [ ] Competitor mentions flagged on opportunities

**Known issues:** [Description or "None"]

---

## Integration Issues Log

| Date | Integration | Issue | Impact | Status | Resolved |
|------|------------|-------|--------|--------|---------|
| [Date] | Stripe → CRM | [Issue] | [High/Med/Low] | [Open/Resolved] | [Date or —] |
| [Date] | [Integration] | [Issue] | [Impact] | [Status] | [Date or —] |
