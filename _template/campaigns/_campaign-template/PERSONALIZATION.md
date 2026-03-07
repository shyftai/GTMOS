# Personalization Variables — [Campaign Name]

## Available merge fields
These are the variables the sending tool can resolve. Only use these in copy.

### Standard fields (available in all tools)
| Variable | Source | Example |
|----------|--------|---------|
| {{first_name}} | Contact record | Sarah |
| {{last_name}} | Contact record | Chen |
| {{company}} | Contact record | Acme Corp |
| {{job_title}} | Contact record | VP of RevOps |

### Enrichment fields (available if enriched via Clay/Apollo)
| Variable | Source | Example |
|----------|--------|---------|
| {{industry}} | Enrichment | SaaS |
| {{company_size}} | Enrichment | 200 employees |
| {{location}} | Enrichment | San Francisco, CA |
| {{technology}} | Enrichment | Uses HubSpot |

### Signal fields (available if signal data attached)
| Variable | Source | Example |
|----------|--------|---------|
| {{signal}} | Signal data | Recently raised Series B |
| {{signal_date}} | Signal data | March 2026 |

### Custom fields (campaign-specific)
| Variable | Source | Example |
|----------|--------|---------|
| {{custom_1}} | Manual / Clay | |
| {{custom_2}} | Manual / Clay | |

---

## Fallback values
If a merge field is empty, use these defaults. Never send an email with unresolved {{variables}}.

| Variable | Fallback | Notes |
|----------|----------|-------|
| {{first_name}} | there | "Hey there" instead of "Hey {{first_name}}" |
| {{company}} | your team | "how your team handles..." |
| {{job_title}} | (skip the line) | Rephrase to avoid blank |

---

## Personalization rules
1. Every touch must work even if only standard fields are available
2. Signal fields are bonus — never make them required for the sequence to make sense
3. Test every variable resolves in the sending tool before shipping
4. If a field has >10% empty rate, set a fallback or rewrite the line
5. Never use more than 3 personalization variables in a single email — it feels automated
