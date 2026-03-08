# Website Visitor Identification

## Purpose
Identify companies and people visiting your website, cross-reference against ICP, and route high-fit visitors into signal-triggered outreach campaigns.

Website visitor identification is a signal source — like hiring signals or funding signals, a website visit indicates buying intent. GTM:OS treats visitor data as an input to the signal scan workflow.

---

## Supported tools

### Snitcher
- **Level:** Company + user (when email known)
- **How it works:** IP-to-company matching against proprietary business network database
- **Data returned:** Company name, industry, size, location, pages visited, session behavior
- **Behavioral signals:** Pricing page visits, documentation reads, feature comparisons, high-intent pages
- **Integrations:** HubSpot, Salesforce, Pipedrive, Attio, Zoho, Dynamics, Slack, Teams, Zapier, webhooks
- **API:** Yes — real-time IP-to-company API ("Powered by Snitcher")
- **Pricing:** From $49/mo based on unique companies identified. 14-day free trial
- **Best for:** Teams wanting affordable company-level ID with good CRM integrations (including Attio)

### RB2B
- **Level:** Person-level (US only) + company-level (global via Demandbase)
- **How it works:** 1st/3rd party cookies, device IDs, IP addresses. Matches against permissioned publisher network
- **Data returned:** Full name, job title, LinkedIn URL, verified business email, company data
- **Match rate:** 70-80% of US website traffic (person-level)
- **Integrations:** HubSpot, Salesforce, Slack, Teams, webhooks, Zapier
- **API:** Webhooks + Zapier (no direct REST API)
- **Pricing:** Free plan available (limited). Paid plans for higher volume
- **Limitation:** Person-level ID is US-only. Company-level works globally
- **Best for:** US-focused teams wanting person-level identification with LinkedIn URLs

### Warmly
- **Level:** Company (65% match) + person (15% match)
- **How it works:** IP de-anonymization + waterfall across 20+ data providers
- **Data returned:** Company firmographics, contact details, intent signals, engagement data
- **Extra features:** AI chat agents, AI email agents, autonomous outreach
- **Integrations:** HubSpot, Salesforce (other CRMs via Zapier)
- **API:** Platform-based (not a simple API — more of a full orchestration platform)
- **Pricing:** Enterprise pricing — contact sales
- **Best for:** Teams wanting a full-stack visitor identification + AI outreach platform

### Leadinfo
- **Level:** Company-level only
- **How it works:** IP-to-company matching
- **Data returned:** Company name, industry, size, decision-makers, contact details
- **Integrations:** 70+ integrations (HubSpot, Salesforce, Pipedrive, Slack, Teams, Zapier)
- **API:** No API available — integrations only
- **Pricing:** From EUR69/mo based on unique companies identified. 14-day free trial
- **Best for:** EU-focused teams wanting simple company-level identification with many integrations

---

## How visitor ID fits into GTM:OS

### As a signal source
Website visits are buying signals. A prospect visiting your pricing page has higher intent than a cold contact. GTM:OS treats visitor data the same way it treats hiring signals, funding signals, or job change signals — as triggers for timely outreach.

### Signal priority
In the signal waterfall (used by `/gtm:signals`), website visitor data sits at **Tier 1** — highest priority:

1. **Tier 1 — Direct intent:** Website visits (pricing page, demo page, comparison pages)
2. **Tier 2 — Dedicated platforms:** Signalbase, Commonroom
3. **Tier 3 — Job monitors:** Sentrion, Fantastic.jobs
4. **Tier 4 — Web signals:** Exa, Firecrawl, Crunchbase
5. **Tier 5 — Social signals:** Jungler, Trigify, Crispy

### Workflow

```
Website visit detected
        │
        ▼
  ICP match check
  (company fits ICP.md?)
        │
    ┌───┴───┐
    No      Yes
    │       │
  Archive   ▼
         Enrich visitor
         (find contacts if company-only)
              │
              ▼
         Score lead (0-100)
              │
          ┌───┴───┐
         <70     ≥70
          │       │
        Queue    ▼
        for    Route to campaign
        later  (signal-triggered sequence)
```

---

## Setup during onboarding

During `/gtm:onboard`, Block 7 (Tools):

1. Ask: "Do you have website visitor identification? (Snitcher, RB2B, Warmly, Leadinfo, or other)"
2. If yes:
   - Record tool in TOOLS.md under `## Website visitor identification`
   - Add API key to .env (if applicable)
   - Configure webhook/integration to push identified visitors
   - Set up ICP filter rules (which visitors to route vs. ignore)
3. If no:
   - Mention as optional enhancement: "Website visitor ID tools like Snitcher ($49/mo) can identify companies visiting your site and feed them into signal-triggered campaigns"
   - Skip — not required

---

## Signal scan integration

When `/gtm:signals` runs, check for website visitor data:

1. Pull recent visitors from the visitor ID tool (via API, webhook data, or CRM sync)
2. Filter against ICP.md — company size, industry, geography
3. Check against SUPPRESSION.md — skip suppressed contacts
4. Check against active campaign lists — skip contacts already in a sequence
5. For company-level matches without contacts:
   - Run enrichment waterfall to find the right persona at that company
   - Score the enriched contact
6. For person-level matches (RB2B, Warmly):
   - Verify email via verification waterfall
   - Score immediately
7. Display identified visitors in the GTM:OS signal scan output:

```
┌─ WEBSITE VISITORS ──────────────────────────────┐
│                                                  │
│  Source: {Snitcher / RB2B / Warmly / Leadinfo}   │
│  Period: last 7 days                             │
│  Visitors identified: {n}                        │
│  ICP matches: {n}                                │
│                                                  │
│  High-intent visitors:                           │
│  1. {Company} — visited pricing page 3x          │
│     Contact: {name}, {title}                     │
│     Score: 85 — ready for outreach               │
│                                                  │
│  2. {Company} — viewed case study + features     │
│     Contact: needs enrichment                    │
│     Action: /gtm:enrich to find contact          │
│                                                  │
│  3. {Company} — visited comparison page           │
│     Contact: {name}, {title}                     │
│     Score: 72 — queue for signal-triggered        │
│                                                  │
└──────────────────────────────────────────────────┘
```

---

## Page intent scoring

Not all page visits are equal. Score visitor intent by page type:

| Page type | Intent level | Score boost |
|-----------|-------------|-------------|
| Pricing page | Very high | +20 |
| Demo / book a call | Very high | +25 |
| Comparison / vs pages | High | +15 |
| Case studies | High | +15 |
| Product / features | Medium | +10 |
| Blog / content | Low | +5 |
| Homepage only | Minimal | +0 |
| Careers page | None (hiring, not buying) | -10 |

Multiple high-intent page visits in a session = compound signal. A visitor who reads a case study, checks pricing, and visits the demo page is a hot lead.

---

## Recommended sequences for website visitors

Use the **signal-triggered** campaign type (2-3 touches):

**Touch 1 — Same day or next day:**
Reference their interest area without revealing you tracked them. Use an observation-led opener related to the page topic they viewed.

Example (they visited pricing):
> "Noticed {company} is in the market for {your category}. Quick question — are you evaluating tools now or still mapping requirements?"

**Touch 2 — 3 days later:**
Add proof point related to their interest area. Case study or metric relevant to their industry.

**Touch 3 — 5 days later (if needed):**
Breakup touch. Zero pressure.

**Never say:** "I saw you visited our website" — this feels invasive and damages trust.
