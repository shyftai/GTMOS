# CSV Format Spec — GTMOS Standard

All lists in GTMOS follow this standard format. When importing from external tools, map their columns to these. When exporting, use these exact column names.

---

## Standard columns

### Required (list will not validate without these)
| Column | Type | Description | Example |
|--------|------|-------------|---------|
| `first_name` | string | Title case, cleaned | `John` |
| `last_name` | string | Title case, cleaned | `O'Brien` |
| `email` | string | Lowercase, trimmed | `john@acme.com` |
| `company` | string | Cleaned, no legal suffixes | `Acme` |
| `title` | string | Standardized job title | `VP of Sales` |
| `linkedin_url` | string | Full LinkedIn profile URL | `https://linkedin.com/in/johndoe` |
| `website` | string | Company domain, no protocol | `acme.com` |

### Enrichment (populate where available)
| Column | Type | Description | Example |
|--------|------|-------------|---------|
| `company_size` | string | Employee range | `51-200` |
| `industry` | string | Standardized label | `SaaS` |
| `hq_location` | string | City, State/Country | `San Francisco, CA` |
| `country` | string | ISO 2-letter code | `US` |
| `phone` | string | Direct phone | `+1-555-123-4567` |
| `revenue` | string | Revenue range | `$10M-$50M` |
| `funding_stage` | string | Last known round | `Series B` |
| `tech_stack` | string | Comma-separated tools | `Salesforce, Outreach, Gong` |

### Signal fields (from Signalbase, Commonroom, Jungler, Trigify, etc.)
| Column | Type | Description | Example |
|--------|------|-------------|---------|
| `signal_type` | string | Type of signal detected | `funding` |
| `signal_detail` | string | Signal description | `Raised $20M Series B` |
| `signal_date` | date | When signal was detected | `2024-03-01` |
| `signal_source` | string | Which tool found it | `Signalbase` |

### GTMOS scoring (added by validate-list)
| Column | Type | Description | Values |
|--------|------|-------------|--------|
| `icp_score` | integer | ICP fit score | `0-3` |
| `lead_score` | float | Weighted lead score | `0-100` |
| `rejection_reason` | string | Why rejected (if score 0) | `Personal email domain` |
| `review_flag` | string | Flag for manual review | `catch-all email` |

### Campaign tracking (added by ship)
| Column | Type | Description | Example |
|--------|------|-------------|---------|
| `campaign` | string | Campaign name | `q1-enterprise-push` |
| `shipped_date` | date | When list was shipped | `2024-03-15` |
| `sending_tool` | string | Which tool it was pushed to | `Instantly` |
| `sequence_status` | string | Current status | `active` |

---

## Import mappings

### From Apollo export
| Apollo column | GTMOS column |
|--------------|-------------|
| `First Name` | `first_name` |
| `Last Name` | `last_name` |
| `Email` | `email` |
| `Company` | `company` |
| `Title` | `title` |
| `LinkedIn Url` | `linkedin_url` |
| `Website` | `website` |
| `# Employees` | `company_size` |
| `Industry` | `industry` |
| `City` | part of `hq_location` |
| `State` | part of `hq_location` |
| `Country` | `country` |

### From LinkedIn Sales Navigator export
| Sales Nav column | GTMOS column |
|-----------------|-------------|
| `First Name` | `first_name` |
| `Last Name` | `last_name` |
| `Email` (if available) | `email` |
| `Company Name` | `company` |
| `Current Job Title` | `title` |
| `Profile URL` | `linkedin_url` |
| `Company Website` | `website` |
| `Company Headcount` | `company_size` |
| `Industry` | `industry` |
| `Location` | `hq_location` |

### From Instantly export
| Instantly column | GTMOS column |
|-----------------|-------------|
| `email` | `email` |
| `first_name` | `first_name` |
| `last_name` | `last_name` |
| `company_name` | `company` |
| `status` | `sequence_status` |

### From Lemlist export
| Lemlist column | GTMOS column |
|---------------|-------------|
| `firstName` | `first_name` |
| `lastName` | `last_name` |
| `email` | `email` |
| `companyName` | `company` |
| `linkedinUrl` | `linkedin_url` |

---

## Rules

- Always use lowercase column names with underscores (snake_case)
- UTF-8 encoding, comma-delimited, double-quote escaping
- Dates in ISO 8601 format: `YYYY-MM-DD`
- Empty fields are empty strings, not "N/A" or "null"
- Deduplicate on `email` — one row per unique email address
- When merging lists, GTMOS columns take precedence over tool-specific columns
- Save raw imports to `lists/raw/`, cleaned to `lists/cleaned/`, validated to `lists/validated/`, shipped to `lists/shipped/`
