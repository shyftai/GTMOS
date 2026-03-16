# Agency Buying Signals

Buying signals for agency new business. Load before prospecting or before setting up a signal-triggered campaign.

Use the urgency rating to prioritise response speed. High-urgency signals decay within days.

---

## Signal table

| Signal | What it means | How to detect | Urgency | Timing window | Best angle |
|--------|--------------|----------------|---------|--------------|------------|
| New CMO hired | Clean slate. New leader audits everything including agencies. | LinkedIn job change / Sales Navigator | High | First 90 days — peak is first 30 | "New leader usually means an agency audit — we've helped a few marketing leaders in that window" |
| New VP Marketing hired | Day-to-day buyer, also auditing vendors | LinkedIn job change | High | First 60 days | "New VP usually takes stock of what's working — happy to share what others at your stage are doing" |
| Series A/B announced | Capital unlocked. Board pressure to show growth. Budget now exists. | Crunchbase / Apollo / TechCrunch / LinkedIn | High | First 7 days after announcement | "Capital means the board wants growth faster — we've built that engine for [n] companies after their raise" |
| Growth equity / Series C+ | Scale-up mode. Need marketing machine. | Crunchbase / LinkedIn | High | First 14 days | "Series C usually means go-to-market needs to scale fast — here's what that looks like" |
| 3+ marketing job postings | Team is stretched or being built for the first time | LinkedIn Jobs / Apollo | Medium | Ongoing while posting is live | "Your team is hiring — usually means execution capacity is the constraint. We extend teams like yours." |
| Marketing Manager job posting | In-house team exists but overwhelmed | LinkedIn Jobs | Medium | While posting is live | "Hiring a marketing manager is a 90-day process — we can cover the gap today" |
| Demand Gen / Growth posting | They know they need demand gen but don't have it yet | LinkedIn Jobs | Medium | While posting is live | "You're building demand gen — we've run it for [n] companies at your stage while the hire came on board" |
| Product launch announced | Need campaign support, distribution, demand gen | Company blog / LinkedIn / PR | High | 2–4 weeks before and after launch | "Product launch → need distribution. We've run [n] launches in the last 12 months." |
| New market / geography expansion | Need local market expertise and new demand gen | Company news / LinkedIn | Medium | First 30 days of announcement | "Expanding to [market] is a different playbook — happy to share what's worked for others" |
| Company rebranding | New brand needs demand gen and campaign support to activate it | Website changes / LinkedIn | Medium | Within 30 days | "Rebrand without campaigns is a tree falling in a forest — here's how to get it seen" |
| Quiet period — no marketing activity | Budget freeze, team issues, or strategic gap | Check ad libraries (Meta/Google) / No LinkedIn posts 60+ days / No new content | Low | Evergreen | "Noticed [company] has been quiet on marketing — sometimes that signals a gap. Happy to share what we're seeing from others in your space." |
| Competitor agency posted negative review | Client unhappy, shopping around | G2 / Clutch / LinkedIn | Medium | First 14 days | "Not all agencies work the same way — here's what's different about how we operate" |
| RFP or agency review posted | Actively in market for agency | LinkedIn / RFP databases / industry boards | High | Immediately | "You're already running an agency review — here's our answer to the brief" |
| Marketing Director left (no replacement yet) | Leadership gap, execution vacuum | LinkedIn job change + posting | Medium | First 30 days | "Leadership transition in marketing is a common moment to bring in outside execution — we cover the gap while you hire" |
| Key hire in new function (e.g. first Sales Director) | Go-to-market alignment needed | LinkedIn | Medium | First 30 days | "First sales director + existing marketing = time to align the pipeline engine" |
| Hiring "agency manager" or "partnership manager" | They manage an agency but it may not be working | LinkedIn Jobs | Medium | While posting is live | "Managing an agency is a full-time job when it shouldn't be — here's how the relationship should feel" |
| Significant content drop (viral post, press hit) | Moment of momentum — they need to capitalise | LinkedIn / news monitoring | High | First 7 days | "That [post/article/mention] generated serious traction — here's how to turn that into pipeline" |

---

## Signal detection methods

### LinkedIn (highest signal quality)

- LinkedIn Sales Navigator: set alerts for job changes (CMO/VP Marketing) at target companies
- LinkedIn Jobs: search for marketing roles at ICP-matching companies weekly
- Company page monitoring: watch for new announcements, product posts, event posts
- Crispy MCP: run job change scans on a target list

### Funding signals

- Crunchbase: set email alerts for funding rounds in target sectors/geographies
- Apollo company search: filter by last funded date
- Exa: search for recent funding news in target verticals
- Google Alerts: "[sector] funding [round type]" — set up once, runs passively

### Activity signals

- Meta Ad Library: search by company domain — no ads running = quiet period signal
- SEMrush/Ahrefs: traffic trend changes (external tool, not via API)
- LinkedIn company page: last content posted date (use Firecrawl or manual check)
- Company blog: date of last post (Firecrawl scrape)

### Review and RFP signals

- G2/Clutch: monitor competitor reviews for negative mentions
- LinkedIn: search "[competitor agency name] replacement" or "agency review" in your target industry

---

## Signal scoring

Combine signals to prioritise outreach. Multiple signals = higher priority.

| Signals present | Priority | Action |
|----------------|----------|--------|
| New leader hire + funding | Immediate (24h) | Personal, research-led first touch |
| Funding only | Same week | Fast sequence from template |
| New leader only | Same week | Sequence timed to first 30 days |
| 3+ marketing postings | This week | Standard cold outbound |
| Product launch approaching | Same week | Launch-angle sequence |
| Single weak signal (quiet period) | This month | Standard cold outbound |
| No signals — ICP match only | This month | Standard cold outbound, lowest priority batch |

---

## Signal decay rates

| Signal | Window | After window |
|--------|--------|-------------|
| New hire (CMO/VP) | 90 days | Still contactable, but lose the timing angle |
| Funding announced | 14 days | Still contactable, but lose the "just announced" angle |
| Product launch | 30 days | Still contactable, but lose urgency angle |
| Job posting | While live | Once filled, signal expires |
| Negative competitor review | 30 days | Opportunity may be resolved |

---

## Integration with GTM:OS signals

Agency-specific signals extend the GTM:OS signal types from `../../.claude/gtmos/references/`. Use the GTM:OS signal infrastructure to detect and route these signals — AGENCY:OS adds the interpretation and angle layer.

When running `/gtm:signals` in an agency workspace, apply the buying signal interpretations above to classify signal relevance and urgency.
