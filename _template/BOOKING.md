# Booking & Links — [Workspace Name]

## Calendar / booking links
Used in CTAs across all campaigns. Claude inserts the correct link based on CTA type.

| Link type | URL | Owner | Notes |
|-----------|-----|-------|-------|
| Primary booking | | | Main calendar link for meetings |
| Fallback booking | | | Backup if primary is full |
| Group call | | | For multi-stakeholder meetings |

## Landing pages
Campaign-specific or general pages referenced in outreach.

| Page | URL | Used in | Notes |
|------|-----|---------|-------|
| Main website | | Signature | |
| Case study | | Touch 3 value-add | |
| Product demo | | CTA fallback | |
| | | | |

## UTM parameters
Append to all links for attribution tracking.

| Parameter | Value |
|-----------|-------|
| utm_source | {sending-tool} |
| utm_medium | email / linkedin |
| utm_campaign | {campaign-name} |
| utm_content | touch-{n} |

## Link rules
- Always use the booking link from this file — never invent or assume a URL
- Always append UTM parameters to landing page links
- Never use URL shorteners (spam trigger)
- Check all links are live before shipping
- Update this file when links change — it's the single source of truth for all URLs
