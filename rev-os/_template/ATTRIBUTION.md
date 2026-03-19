# Attribution

Attribution model configuration, source taxonomy, and pipeline/revenue attribution reporting.

---

## Attribution Model

**Primary model:** [First touch / Last touch / Linear / Time-decay / Data-driven]
**Secondary model:** [Model used for comparison]
**Rationale:** [Why this model was chosen — e.g., "Linear because we have a long nurture cycle with multiple meaningful touches"]

**Model last reviewed:** [Date]

---

## Source Taxonomy

All contacts and deals must have a lead source from this list. Add new sources here before using in CRM.

| Category | Source Value | Definition |
|----------|-------------|-----------|
| Outbound | Outbound - Email | Cold email sequence |
| Outbound | Outbound - LinkedIn | LinkedIn outreach (cold) |
| Outbound | Outbound - Cold Call | Cold calling |
| Inbound | Inbound - Content / SEO | Organic search or blog |
| Inbound | Inbound - Paid (SEM) | Google / Bing paid search |
| Inbound | Inbound - Paid (Social) | LinkedIn, Meta, YouTube ads |
| Inbound | Inbound - Event | Conference, webinar, virtual event |
| Inbound | Inbound - Referral | Customer or partner referral |
| Inbound | Inbound - Partner | Co-sell or reseller partner |
| Inbound | Inbound - Product / PLG | Sign-up from product or free trial |
| Inbound | Inbound - Direct | Website contact, source unknown |
| Other | Import | List import (flag for compliance) |

**Unknown / NULL source:** Flag immediately — source must be set on every record.

---

## UTM Standards

Required UTM parameters for all paid and partner campaigns:

| Parameter | Required | Format | Example |
|-----------|----------|--------|---------|
| utm_source | Yes | Lowercase, hyphenated | `google`, `linkedin`, `partner-name` |
| utm_medium | Yes | Lowercase | `cpc`, `email`, `social`, `organic` |
| utm_campaign | Yes | Lowercase, hyphenated | `q1-2025-revops-ebook` |
| utm_content | No | Variant or creative name | `cta-button-v2` |
| utm_term | No | Keyword (paid only) | `revops-software` |

---

## Pipeline Attribution (Current Quarter)

**Period:** Q[X] [Year] | **Model:** [Attribution model]

| Source | Deals | Pipeline value | % of total pipeline |
|--------|-------|---------------|---------------------|
| Outbound - Email | [X] | $[X]K | [X]% |
| Inbound - Content | [X] | $[X]K | [X]% |
| Inbound - Paid (SEM) | [X] | $[X]K | [X]% |
| Inbound - Referral | [X] | $[X]K | [X]% |
| Partner | [X] | $[X]K | [X]% |
| **Total** | **[X]** | **$[X]M** | **100%** |

---

## Revenue Attribution (Last 12 Months)

| Source | Deals closed | Revenue | Win rate | Avg ACV |
|--------|-------------|---------|---------|---------|
| Outbound - Email | [X] | $[X]K | [X]% | $[X]K |
| Inbound - Content | [X] | $[X]K | [X]% | $[X]K |
| Inbound - Referral | [X] | $[X]K | [X]% | $[X]K |
| **Total** | **[X]** | **$[X]M** | — | — |

---

## Attribution Gaps

| Gap | % of pipeline affected | Impact | Action |
|----|----------------------|--------|--------|
| Deals with no lead source | [X]% | High | [Action] |
| Contacts with UTM not stored | [X]% | Medium | [Action] |
| Partner-sourced deals miscategorized | [X]% | Medium | [Action] |
