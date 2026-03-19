# CRM Migration Reference

Field mapping tables, migration tool recommendations, and what survives each CRM-to-CRM path. Load this file whenever `/rev:migrate` is running.

---

## Migration paths

- [Salesforce → HubSpot](#salesforce--hubspot) — most common downscale / outbound pivot
- [HubSpot → Salesforce](#hubspot--salesforce) — most common scale-up
- [Pipedrive → HubSpot](#pipedrive--hubspot) — most common SMB growth path
- [Pipedrive → Salesforce](#pipedrive--salesforce) — less common; usually skips to HubSpot first
- [HubSpot → Pipedrive](#hubspot--pipedrive) — rare; usually cost-driven
- [Universal field mapping](#universal-field-mapping) — applies to any CRM pair

---

## Salesforce → HubSpot

**Why companies make this move:** Salesforce is too expensive or complex for their current stage; pivoting to outbound-led growth where HubSpot is the center; CS platform moving to HubSpot.

**Difficulty:** Medium. HubSpot has a native Salesforce import but it requires careful field mapping setup.

### Migration tool

**HubSpot's native Salesforce import** (recommended):
- Go to HubSpot → Settings → Integrations → Salesforce
- Use the "Import from Salesforce" wizard
- Maps standard objects automatically; custom fields require manual mapping
- Cost: included in HubSpot Sales Hub Professional+

**Alternative for complex setups:** Trujay, Migrate.io, or Windsor.ai (paid; ~$500–$2,000 depending on volume)

### Field mapping — Salesforce → HubSpot

#### Account → Company

| Salesforce field | HubSpot property | Transform needed |
|-----------------|-----------------|-----------------|
| Name | Company name | None |
| Website | Website URL | None |
| Industry | Industry | Remap picklist values if different |
| NumberOfEmployees | Number of employees | None |
| BillingCountry | Country/Region | None |
| BillingCity | City | None |
| Phone | Phone number | None |
| Account_Tier__c | Account tier (custom) | Create custom property first |
| ARR_Current__c | ARR current (custom) | Create custom property first |
| Renewal_Date__c | Contract renewal date (custom) | Create custom property first |
| Health_Score__c | Health score (custom) | Create custom property first |
| Health_Status__c | Health status (custom) | Remap: Green→🟢, Red→🔴 |
| Enrichment_Source__c | Enrichment source (custom) | Create custom property first |
| Enrichment_Date__c | Enrichment date (custom) | Create custom property first |
| OwnerId | HubSpot owner | Map SFDC user email → HubSpot user |
| CreatedDate | Create date | Preserved automatically |

#### Contact → Contact

| Salesforce field | HubSpot property | Transform needed |
|-----------------|-----------------|-----------------|
| FirstName | First name | None |
| LastName | Last name | None |
| Email | Email | None |
| Phone | Phone number | None |
| Title | Job title | None |
| LeadSource | Original source / Lead source detail | Remap values (see source mapping below) |
| AccountId | Associated company | Auto-linked if company imported first |
| UTM_Source__c | UTM source (custom) | Create custom property first |
| UTM_Medium__c | UTM medium (custom) | Create custom property first |
| UTM_Campaign__c | UTM campaign (custom) | Create custom property first |
| Persona__c | Persona (custom) | Create custom property first |
| Suppressed__c | GDPR opt-out / Marketing contact status | Map to HubSpot subscription status |
| OwnerId | HubSpot owner | Map SFDC user email → HubSpot user |

#### Opportunity → Deal

| Salesforce field | HubSpot property | Transform needed |
|-----------------|-----------------|-----------------|
| Name | Deal name | None |
| Amount | Amount | None |
| CloseDate | Close date | None |
| StageName | Deal stage | Remap stage names (see stage mapping) |
| Probability | — | Driven by stage in HubSpot; not a separate field |
| LeadSource | Original source | Remap values |
| AccountId | Associated company | Auto-linked if company imported first |
| OwnerId | Deal owner | Map SFDC user email → HubSpot user |
| Deal_Type__c | Deal type (custom) | Create custom property first |
| Forecast_Category__c | Forecast category (custom) | Create custom property first |
| Loss_Reason__c | Loss reason (custom) | Create custom property first |
| ACV__c | ACV (custom) | Create custom property first |
| Next_Step__c | Next step (custom) | Create custom property first |

### Stage name mapping — Salesforce → HubSpot

| Salesforce stage | HubSpot stage | Notes |
|-----------------|--------------|-------|
| SQL | SQL | Match exactly |
| Discovery | Discovery | Match exactly |
| Demo/Evaluation | Demo / Eval | Slight rename |
| Proposal/Price Quote | Proposal | Slight rename |
| Negotiation/Review | Verbal / Legal | Rename |
| Closed Won | Closed Won | Match exactly |
| Closed Lost | Closed Lost | Match exactly |

If your Salesforce stages are custom, map each one manually and document in `MIGRATION.md`.

### Lead source mapping — Salesforce → HubSpot

| Salesforce Lead Source | HubSpot Original Source | Notes |
|-----------------------|------------------------|-------|
| Web | Organic Search | If SEO traffic; else Direct Traffic |
| Phone Inquiry | Direct Traffic | |
| Cold Call | — | Map to custom "Lead source detail" field |
| Purchased List | — | Map to custom field; flag for compliance |
| Partner | Other | Map to custom "Lead source detail" = Partner |
| Referral | — | Map to custom field |
| Event | Offline Sources | |
| Email Campaign | Email Marketing | |
| Social Media | Social Media | |
| Other | Other | |
| NULL / blank | Other | Flag for cleanup post-migration |

### What survives Salesforce → HubSpot

| Data | Survives? | Notes |
|------|-----------|-------|
| Contacts, Companies, Deals | ✅ Yes | With field mapping |
| Custom field values | ✅ Yes | If custom properties created first in HubSpot |
| Lead source | ✅ Yes | With value remapping |
| UTM fields | ✅ Yes | If stored as custom fields |
| Deal stage (current) | ✅ Yes | With stage name remapping |
| Open tasks | ⚠ Partial | Migrate as HubSpot Tasks; assignee mapping required |
| Activity notes | ⚠ Partial | Export as CSV; import as timeline notes |
| Email history | ❌ No | Stays in Gmail/Outlook; will re-sync via HubSpot email integration |
| Chatter / feed posts | ❌ No | Export and archive externally |
| Salesforce Reports | ❌ No | Rebuild in HubSpot |
| Salesforce Flows | ❌ No | Rebuild as HubSpot Workflows |
| Attachments / Files | ❌ No | Download and re-upload manually |
| Deal stage history | ❌ No | Current stage only; history lost unless using a stage history export |

---

## HubSpot → Salesforce

**Why companies make this move:** Scaling past 50 employees; enterprise deals requiring Salesforce-native integrations; board/investor requirement; complex territory management.

**Difficulty:** Hard. No native HubSpot-to-Salesforce import. Requires CSV export and Salesforce Data Loader, or a migration tool.

### Migration tool

**Recommended:** Salesforce Data Loader (free, included with Salesforce) + manual CSV preparation

**For complex setups / high volume:** Trujay ($800–$2,500) or Informatica Cloud Data Integration

**Process:**
1. Export each HubSpot object as CSV (Contacts, Companies, Deals)
2. Clean and transform CSV to match Salesforce field requirements
3. Create custom fields in Salesforce first (see `rev-crm-setup.md`)
4. Use Data Loader to import: Accounts first → Contacts → Opportunities

### Field mapping — HubSpot → Salesforce

#### Company → Account

| HubSpot property | Salesforce field | Transform needed |
|-----------------|-----------------|-----------------|
| Company name | Name | None |
| Website URL | Website | None |
| Industry | Industry | Remap picklist values |
| Number of employees | NumberOfEmployees | None |
| Country/Region | BillingCountry | None |
| City | BillingCity | None |
| Phone number | Phone | None |
| Account tier (custom) | Account_Tier__c | Create custom field first |
| ARR current (custom) | ARR_Current__c | Create custom field first |
| Contract renewal date (custom) | Renewal_Date__c | Create custom field first |
| Health score (custom) | Health_Score__c | Create custom field first |
| Health status (custom) | Health_Status__c | Remap: 🟢→Green etc. |
| HubSpot owner | OwnerId | Map HubSpot user email → Salesforce user ID |
| HubSpot Company ID | — | Store in external ID field for dedup matching |

#### Contact → Contact

| HubSpot property | Salesforce field | Transform needed |
|-----------------|-----------------|-----------------|
| First name | FirstName | None |
| Last name | LastName | None |
| Email | Email | None |
| Job title | Title | None |
| Phone number | Phone | None |
| Original source | LeadSource | Remap values (see source mapping) |
| Associated company | AccountId | Lookup by Account Name or external ID |
| UTM source | UTM_Source__c | Create custom field first |
| UTM medium | UTM_Medium__c | Create custom field first |
| UTM campaign | UTM_Campaign__c | Create custom field first |
| Persona | Persona__c | Create custom field first |
| Marketing contact status | Suppressed__c | Map opted-out → True |

#### Deal → Opportunity

| HubSpot property | Salesforce field | Transform needed |
|-----------------|-----------------|-----------------|
| Deal name | Name | None |
| Amount | Amount | None |
| Close date | CloseDate | None |
| Deal stage | StageName | Remap stage names |
| Original source | LeadSource | Remap values |
| Deal owner | OwnerId | Map HubSpot user email → Salesforce user ID |
| Associated company | AccountId | Lookup by Account Name |
| Deal type (custom) | Deal_Type__c | Create custom field first |
| Forecast category (custom) | Forecast_Category__c | Create custom field first |
| Loss reason (custom) | Loss_Reason__c | Create custom field first |
| ACV (custom) | ACV__c | Create custom field first |

### HubSpot lifecycle stage → Salesforce lead status / opportunity stage

| HubSpot lifecycle | Salesforce equivalent |
|------------------|----------------------|
| Subscriber | Lead (Status = New) |
| Lead | Lead (Status = Open) |
| MQL | Lead (Status = MQL) |
| SQL | Lead (Status = SQL) or convert to Contact + Opportunity |
| Opportunity | Opportunity created; Contact associated to Account |
| Customer | Account Type = Customer |
| Evangelist | Account flag / tag |

> **Important:** HubSpot manages lifecycle at the Contact level. Salesforce splits Leads and Contacts. All HubSpot Contacts at SQL+ should be converted to Contacts (not Leads) in Salesforce. HubSpot Contacts at MQL or below can import as Salesforce Leads.

### What survives HubSpot → Salesforce

| Data | Survives? | Notes |
|------|-----------|-------|
| Contacts, Companies, Deals | ✅ Yes | Via CSV + Data Loader |
| Custom field values | ✅ Yes | If custom fields created in Salesforce first |
| Lead source / original source | ✅ Yes | With value remapping |
| UTM fields | ✅ Yes | If stored as custom properties |
| Deal stage (current) | ✅ Yes | With stage name remapping |
| HubSpot timeline activities | ⚠ Partial | Export as notes; import as Salesforce Tasks |
| Form submissions | ⚠ Partial | Visible as HubSpot timeline; doesn't transfer natively |
| Email history | ❌ No | Re-syncs via Gmail/Outlook → Salesforce integration |
| HubSpot Workflows | ❌ No | Rebuild as Salesforce Flows |
| HubSpot Reports | ❌ No | Rebuild in Salesforce |
| HubSpot Lists | ❌ No | Recreate as Salesforce Reports or Campaign membership |
| HubSpot Marketing emails | ❌ No | Marketing history stays in HubSpot Marketing Hub |
| Attachments | ❌ No | Download and re-upload |

---

## Pipedrive → HubSpot

**Why companies make this move:** Outgrowing Pipedrive's reporting; adding marketing automation; CS team joining and wanting HubSpot.

**Difficulty:** Easy. HubSpot has a native Pipedrive import tool.

### Migration tool

**HubSpot's native Pipedrive import:**
- Settings → Integrations → Import → Import from Pipedrive
- Handles Persons, Organizations, Deals automatically
- Custom fields require manual mapping

### Field mapping — Pipedrive → HubSpot

#### Organization → Company

| Pipedrive field | HubSpot property | Notes |
|----------------|-----------------|-------|
| Name | Company name | None |
| Address | Address fields | Split into street, city, country |
| Phone | Phone number | None |
| Website | Website URL | None |
| Custom: Account tier | Account tier | Create HubSpot custom property first |
| Custom: ARR | ARR current | Create HubSpot custom property first |
| Custom: Renewal date | Contract renewal date | Create HubSpot custom property first |
| Owner | HubSpot owner | Map by email |

#### Person → Contact

| Pipedrive field | HubSpot property | Notes |
|----------------|-----------------|-------|
| Name (split) | First name / Last name | Split on first space |
| Email | Email | None |
| Phone | Phone number | None |
| Job title | Job title | None |
| Organization | Associated company | Auto-link if org imported first |
| Custom: UTM source | UTM source | Create HubSpot property first |
| Custom: Persona | Persona | Create HubSpot property first |
| Owner | HubSpot owner | Map by email |

#### Deal → Deal

| Pipedrive field | HubSpot property | Notes |
|----------------|-----------------|-------|
| Title | Deal name | None |
| Value | Amount | None |
| Expected close date | Close date | None |
| Stage | Deal stage | Remap stage names |
| Status (Won/Lost) | Deal stage (Closed Won/Lost) | Map |
| Lost reason | Loss reason | Create HubSpot custom property first |
| Owner | Deal owner | Map by email |
| Custom: Deal type | Deal type | Create HubSpot property first |
| Custom: Forecast category | Forecast category | Create HubSpot property first |

### What survives Pipedrive → HubSpot

| Data | Survives? | Notes |
|------|-----------|-------|
| Organizations, Persons, Deals | ✅ Yes | Via native HubSpot importer |
| Custom field values | ✅ Yes | With manual mapping |
| Deal stage (current) | ✅ Yes | With remapping |
| Notes | ⚠ Partial | Export as CSV; import as timeline notes |
| Activities (calls, emails logged) | ⚠ Partial | Export as CSV; import as HubSpot tasks |
| Pipedrive automations | ❌ No | Rebuild as HubSpot Workflows |
| Email history | ❌ No | Re-syncs via Gmail/Outlook integration |
| Attached files | ❌ No | Download and re-upload |

---

## Pipedrive → Salesforce

**Why:** Unusual path. Usually Pipedrive → HubSpot → Salesforce. If going direct, likely enterprise requirement.

**Difficulty:** Hard. No native connector. Use CSV + Salesforce Data Loader.

Follow the same approach as HubSpot → Salesforce (CSV export + Data Loader) with these Pipedrive-specific notes:

- Pipedrive uses "Persons" and "Organizations" — map to Salesforce Contacts and Accounts
- Pipedrive deal values may be in multiple currencies — convert to primary currency before import
- Pipedrive custom fields export as columns in CSV — map each to Salesforce custom field API name

---

## HubSpot → Pipedrive

**Why:** Cost reduction; simplifying for a small team. Rare.

**Difficulty:** Medium. No native importer. Use CSV export from HubSpot + Pipedrive CSV import.

**Note:** Pipedrive has fewer standard fields. Much of your HubSpot marketing data (forms, email history, workflow enrollment) does not transfer. This migration involves a deliberate reduction in data richness — make sure the team understands what they're giving up.

---

## Universal field mapping

These field equivalents apply across all CRM pairs:

| Concept | Salesforce | HubSpot | Pipedrive |
|---------|-----------|---------|-----------|
| Company record | Account | Company | Organization |
| Person record | Contact | Contact | Person |
| Prospecting record | Lead | Contact (lifecycle: Lead) | Person (Deal: Incoming) |
| Revenue record | Opportunity | Deal | Deal |
| Stage probability | Opportunity.Probability | Deal stage probability (set per stage) | Deal stage probability |
| Primary revenue | Amount | Amount | Value |
| Annual revenue | AnnualRevenue (Account) | Annual revenue (Company) | Custom field |
| Lead source | LeadSource (Contact/Opp) | Original source (Contact) | Custom field |
| Account type | Type (Account) | Type (Company custom) | Custom field |
| Record owner | OwnerId (lookup) | HubSpot owner | Owner |
| Created date | CreatedDate | Create date | Add time |
| Last modified | LastModifiedDate | Last modified date | Update time |
| Stage history | OpportunityHistory (related list) | Deal stage history (timeline) | — (not native) |
| Activity: call | Task (type = Call) | Call (activity) | Activity (type = Call) |
| Activity: email | Task (type = Email) | Email (activity) | Activity (type = Email) |
| Activity: meeting | Event | Meeting (activity) | Activity (type = Meeting) |
| Note | Note (related) | Note (timeline) | Note |
| File attachment | ContentDocument | Attachment | File |
| Automation | Flow / Process Builder | Workflow | Automation |
| Report | Report | Report | Insights |
| Dashboard | Dashboard | Dashboard | Insights |

---

## Source / lead source value mapping

Standardize lead source values before any migration. Map everything to REV:OS standard taxonomy (from `ATTRIBUTION.md`):

| Common raw value | REV:OS standard | Notes |
|-----------------|----------------|-------|
| Web, Website, Organic | Inbound - Content / SEO | If from search or blog |
| Google, Bing, SEM, PPC | Inbound - Paid (SEM) | |
| LinkedIn, Facebook, Social | Inbound - Paid (Social) | |
| Event, Conference, Tradeshow | Inbound - Event | |
| Referral, Word of mouth, WOM | Inbound - Referral | |
| Partner, Reseller, Channel | Inbound - Partner | |
| Cold email, Outbound email, Sequence | Outbound - Email | |
| Cold call, Phone | Outbound - Cold Call | |
| LinkedIn outreach (manual) | Outbound - LinkedIn | |
| Trial, Free tier, PLG, Product | Inbound - Product / PLG | |
| Direct, Unknown, blank, NULL | Inbound - Direct | Flag for cleanup |
| Purchased list, Import | Import | Flag for compliance review |
| Other | Inbound - Direct | Unless a specific source can be recovered |

Document any source values that don't map cleanly in `MIGRATION.md`. Do not discard source data — store the original value in a "Source (original)" custom field during migration.

---

## Migration timing guidance

| Company size | Data volume | Expected migration time | Recommended approach |
|-------------|------------|------------------------|---------------------|
| < 5K records | Small | 1–2 days | Native importer or CSV |
| 5K–50K records | Medium | 1–2 weeks (with cleanup) | Native importer + field prep |
| 50K–200K records | Large | 3–6 weeks | Migration tool (Trujay, Migrate.io) |
| 200K+ records | Enterprise | 6–12 weeks | Professional migration service |

Add 2–4 weeks to any estimate if:
- Data quality is poor (< 70% score) — cleanup extends the timeline
- Multiple integrations to reconnect
- Team is actively using the CRM during migration (parallel running)
- Custom objects exist in source CRM (not just standard objects)

---

## Post-migration monitoring schedule

After migration completes, run these checks on a fixed schedule:

| Week | Check | Command |
|------|-------|---------|
| Week 1 | Record count + attribution continuity | `/rev:health` |
| Week 2 | Data quality full audit | `/rev:health` |
| Week 3 | Stripe reconciliation | `/rev:stripe` |
| Week 4 | First pipeline review | `/rev:pipeline` |
| Month 2 | Attribution report (verify source data intact) | `/rev:attribution` |
| Month 3 | Full dashboard (first clean quarter in new CRM) | `/rev:dashboard` |

Add a LEARNINGS.md entry after the migration is stable — what went well, what you'd do differently, what data was lost.
