# Delivery Standards

Quality standards, approval workflows, revision policy, and SLAs. Load before running the delivery quality gate or generating any client-facing output.

---

## Quality standards by output type

### Email copy (outbound sequences)

Check against `../../.claude/gtmos/references/cold-email-skill.md` principles, then verify:

- Word count matches persona limit (Founder: 75–100 words, CMO: 100–125 words, VP Marketing: 90–110 words)
- Subject line: < 8 words, no clickbait, no question marks in first subject
- Opening line: not about us — about them (signal, result, or relevant context)
- One CTA only — no multiple asks
- No banned phrases: "I wanted to reach out", "I hope this email finds you well", "touching base", "circling back", "synergy", "leverage", "game-changer"
- Merge fields: every merge field verified against actual data — no [FIRST_NAME] placeholders in final copy
- Suppression check complete
- Sending domain authenticated (SPF, DKIM, DMARC)

### Ad creative briefs

- Headline: primary option plus 2 alternatives
- Primary text: within platform character limits (Facebook/Instagram: 125 chars for preview; LinkedIn: 150 chars)
- CTA: one clear action, platform-appropriate button text
- Visual direction: specific enough that a designer can execute without a call
- Format specs: sizes and aspect ratios specified for all required placements
- Compliance: no prohibited claims, no misleading comparisons, no restricted content categories
- Brand: colors, fonts, and logo usage match client brand guidelines

### SEO content

- Target keyword: primary keyword in H1, first 100 words, and at least one H2
- Word count: matches intent (informational: 1,200–2,500 words; comparison: 800–1,500 words; local: 600–1,000 words)
- Heading structure: H1 → H2 → H3, no skipped levels
- Meta description: 150–160 characters, includes primary keyword, has a call to action
- Internal links: minimum 2–3 links to relevant existing pages
- Image alt text: all images have descriptive alt text
- No keyword stuffing: keyword density < 2%
- Readability: Flesch reading ease > 50 for B2B content

### Paid media strategy documents

- Audience targeting: segments defined with specific parameters (age, geo, interests, job titles, etc.)
- Budget allocation: justified across campaigns and channels with expected CPL/ROAS rationale
- Bid strategy: bidding approach specified with target CPA or ROAS inputs
- Exclusions: brand exclusions, audience exclusions, and placement exclusions documented
- Negative keywords (search): list provided and reviewed against search term history
- Attribution model: specified and agreed with client in CLIENT-BRIEF.md

### Client reports (weekly / monthly)

- Data accuracy: every number cross-referenced against platform source before including
- Narrative matches data: if performance is down, the narrative does not spin it as positive
- Recommendations: every report must include at least one specific, actionable recommendation
- Period comparison: current period vs. prior period (and vs. same period last year if relevant)
- Goal tracking: every metric shown alongside its target from CLIENT-BRIEF.md
- Format: matches what was agreed in CLIENT-BRIEF.md (Google Slides / Doc / email)
- Sent by: within 3 business days of period close

### Proposals and pitches

- Service line fit: every service referenced exists in SERVICE-LINES.md
- Proof points: minimum 2 case studies from CASE-STUDIES.md relevant to this prospect's industry or goal
- Pricing: pulled from PRICING.md — no custom pricing without account manager approval
- Scope: inclusions and exclusions explicitly stated
- No scope creep promises: do not offer deliverables outside of the agreed service lines
- ROI projection: if included, must be labeled "projection based on [benchmark source]" — not a guarantee

---

## Standard approval workflow

1. **Specialist completes deliverable** — the person doing the work finishes it
2. **Internal QA** — checked against the brief and SOW by the specialist themselves
3. **Account manager review** — reviews for client fit, tone, and communication appropriateness
4. **Send to client** — "Here is [deliverable]. Please review and let us know your feedback by [date]."
5. **Client feedback received** — log revision requests in `clients/{client}/DELIVERABLES.md`
6. **Revisions completed** — within the agreed rounds in SOW.md
7. **Client approval confirmed** — verbal or written sign-off recorded
8. **Mark Done** — update status in DELIVERABLES.md, file the final version

---

## Revision policy

- **Standard:** 2 rounds of revisions included in all retainer and project engagements
- **Round 1:** major changes — strategy, direction, structure, messaging, positioning
- **Round 2:** minor edits — copy tweaks, visual adjustments, formatting changes
- **Round 3+:** billed at hourly rate, must be agreed in writing before work begins
- **Scope change rule:** if the brief changes significantly between rounds, that is a new brief — not a revision round. Flag it and discuss before proceeding
- **Revision request window:** client must submit feedback within 5 business days of delivery. After that, the revision clock resets and a new round is counted
- **Do not absorb scope creep as revisions** — if the client is asking for something that was not in the original brief, name it and price it

---

## Delivery SLAs

| Output type | SLA from brief confirmation |
|-------------|----------------------------|
| Campaign email sequence (first draft) | 3 business days |
| Ad creative brief | 2 business days |
| Ad creative (design) | 3 business days |
| SEO article (first draft) | 3 business days |
| Monthly performance report | 3 business days after month close |
| QBR presentation deck | 3 business days before QBR date |
| Paid media strategy document | 4 business days |
| Proposal / pitch deck | 3 business days from brief |
| SOW | 2 business days from service agreement |

SLA clock starts when: brief is confirmed complete (all required fields present), all client assets are received, and relevant access (ad accounts, CRM, analytics) is granted.

---

## Blocking inputs

Work cannot start without these. Do not begin a deliverable if any of the following are unresolved:

- **Brand assets:** logo files, brand guidelines, color hex codes, approved fonts
- **Platform access:** ad account, CRM, Google Analytics, email platform, social accounts
- **Goal confirmation:** goals and KPIs signed off in CLIENT-BRIEF.md
- **SOW signed:** no work begins on project or retainer without a signed SOW
- **Approval contact confirmed:** at least one named client contact who can approve deliverables

If a blocking input is missing, flag it immediately as a Blocked status in DELIVERABLES.md. Do not start work and then blame the client for delays.
