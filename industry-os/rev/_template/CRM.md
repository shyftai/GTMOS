# CRM Configuration

The source of truth for your CRM setup, field mapping, and data standards for this workspace.

---

## CRM System

**Platform:** [Salesforce / HubSpot / Pipedrive / Other]
**Version / Edition:** [Enterprise / Professional / etc.]
**Primary admin:** [Name]
**Last reviewed:** [Date]

---

## Object Definitions

### What we count as an "Account"
[e.g., "A company record. Leads are converted to Contacts + Accounts. No standalone Lead records are used after the first week."]

### What we count as an "Opportunity / Deal"
[e.g., "An opportunity represents a potential new contract or expansion. Renewals are tracked as separate opportunities with Deal Type = Renewal."]

### What we count as a "Contact"
[e.g., "A person record. Always linked to an Account. No orphaned contacts."]

---

## Stage Definitions

Document every pipeline stage, what it means, and what must be true to advance.

| Stage | Definition | Advance criteria |
|-------|------------|-----------------|
| MQL | Marketing-qualified lead — meets ICP criteria | ICP score ≥ [X]; source recorded |
| SQL | Sales-qualified — discovery started | Discovery call booked or completed |
| Discovery | Actively qualifying — pain identified | Notes logged; next step set |
| Demo / Evaluation | Demo completed; evaluating solution | Demo done; decision-maker identified |
| Proposal | Proposal or pricing shared | Proposal sent; timeline discussed |
| Verbal / Legal | Verbal commitment received | Verbal yes; legal or MSA in progress |
| Closed Won | Contract signed | Signed agreement in CRM |
| Closed Lost | No purchase | Loss reason set; win/loss record created |

---

## Field Standards

### Required fields by object

**Account:** [List required fields per rev-data-standards.md — customize here]
**Contact:** [List required fields]
**Opportunity:** [List required fields]

### Custom fields we use

| Field Name | Object | Type | Values / Format |
|------------|--------|------|----------------|
| [Field name] | [Account/Contact/Deal] | [Text/Picklist/Number] | [Options or format] |
| Account Tier | Account | Picklist | Tier 1 / Tier 2 / Tier 3 |
| ICP Score | Account | Number | 0–100 |
| Enrichment Date | Account | Date | YYYY-MM-DD |
| Enrichment Source | Account | Text | [Provider name] |
| Deal Type | Opportunity | Picklist | New Business / Expansion / Renewal |
| Loss Reason | Opportunity | Picklist | Price / Competitor / No Decision / Timing / Product Gap |
| Win/Loss Record Created | Opportunity | Checkbox | True / False |

---

## Data Owners

| Object / Area | Owner | Backup |
|--------------|-------|--------|
| CRM administration | [Name] | [Name] |
| Account records | [Name] | [Name] |
| Contact enrichment | [Name] | [Name] |
| Pipeline data | [Name] | [Name] |
| Report library | [Name] | [Name] |

---

## Lead Routing Rules

| Criteria | Assigned to |
|----------|-------------|
| [e.g., Company size > 500 employees] | [Rep or pool] |
| [e.g., Company size 50–499 employees] | [Rep or pool] |
| [e.g., Company size < 50 employees] | [Rep or pool] |
| [e.g., Geography = EMEA] | [Rep or pool] |

---

## Integration Status

| System | Sync direction | Status | Last checked |
|--------|---------------|--------|-------------|
| Stripe | Stripe → CRM | [Active / Error / Not configured] | [Date] |
| [Sequencing tool] | CRM ↔ Tool | [Status] | [Date] |
| [Gong / Chorus] | Tool → CRM | [Status] | [Date] |
| [CS Platform] | CRM ↔ CS | [Status] | [Date] |

---

## Known Issues / Exceptions

[Document any known CRM data issues, exceptions to standards, or technical debt here.]

- [Issue description — date identified — owner — status]
