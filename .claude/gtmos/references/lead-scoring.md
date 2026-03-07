# Lead Scoring Model — GTMOS

Weighted scoring model for ranking leads beyond the basic 0-3 ICP rubric. Produces a 0-100 score per contact.

---

## Score components

| Component | Weight | Max points | What it measures |
|-----------|--------|------------|-----------------|
| Company fit | 30% | 30 | How well the company matches ICP |
| Persona fit | 25% | 25 | How well the person matches target persona |
| Signal strength | 20% | 20 | Presence and recency of buying signals |
| Data quality | 15% | 15 | Completeness and verification of contact data |
| Engagement | 10% | 10 | Prior engagement with your outreach or content |

**Total: 100 points**

---

## Company fit (0-30)

Score based on ICP.md criteria:

| Factor | Points | Criteria |
|--------|--------|----------|
| Industry match | 0-10 | 10 = exact match, 5 = adjacent, 0 = outside ICP |
| Company size | 0-8 | 8 = sweet spot range, 4 = edge of range, 0 = outside |
| Geography | 0-5 | 5 = target geo, 3 = adjacent market, 0 = excluded |
| Revenue/funding | 0-5 | 5 = ideal stage, 3 = close, 0 = wrong stage |
| Tech stack | 0-2 | 2 = uses complementary tools, 0 = unknown |

---

## Persona fit (0-25)

Score based on PERSONA.md criteria:

| Factor | Points | Criteria |
|--------|--------|----------|
| Title match | 0-10 | 10 = exact title, 7 = equivalent title, 3 = adjacent, 0 = wrong level |
| Department | 0-5 | 5 = target department, 2 = adjacent, 0 = wrong dept |
| Seniority | 0-5 | 5 = ideal level, 3 = one level off, 0 = wrong level |
| Decision authority | 0-5 | 5 = decision maker, 3 = influencer, 1 = user, 0 = no authority |

---

## Signal strength (0-20)

Score based on detected buying signals:

| Signal type | Points | Decay |
|-------------|--------|-------|
| Funding round (last 30 days) | 8 | -2 per month |
| Hiring for relevant role (last 30 days) | 6 | -2 per month |
| Job change (contact moved to new role) | 6 | -3 per month |
| Tech stack change | 5 | -1 per month |
| Company news (expansion, launch) | 4 | -2 per month |
| Social engagement (liked/commented on relevant content) | 3 | -1 per week |
| Event attendance | 3 | -1 per month |

**Rules:**
- Signals stack — multiple signals add together up to the 20-point cap
- Signals decay over time — recency matters
- No signal = 0 points (not a disqualifier, just lower priority)

---

## Data quality (0-15)

Score based on data completeness and verification:

| Factor | Points |
|--------|--------|
| Verified email (valid, not catch-all) | 5 |
| Catch-all email (unverified) | 2 |
| No email | 0 |
| LinkedIn URL present | 3 |
| Phone number present | 2 |
| Company website confirmed | 2 |
| All enrichment fields populated | 3 |
| Missing 1-2 enrichment fields | 1 |

---

## Engagement (0-10)

Score based on prior interaction (only applies to re-engagement or multi-campaign contacts):

| Factor | Points |
|--------|--------|
| Opened previous email | 2 |
| Clicked link in previous email | 4 |
| Visited website (if trackable) | 3 |
| Viewed LinkedIn profile back | 2 |
| Engaged with LinkedIn content | 3 |
| Replied to previous campaign (positive) | 10 |
| Replied to previous campaign (objection) | 5 |
| No prior engagement | 0 |

---

## Score tiers

| Tier | Score range | Action |
|------|-----------|--------|
| A — Hot | 80-100 | Priority outreach, personalized first touch, signal-triggered timing |
| B — Warm | 60-79 | Standard sequence, good personalization, include in A/B tests |
| C — Cool | 40-59 | Standard sequence, template personalization, batch send |
| D — Cold | 20-39 | Lower priority, consider holding for better signal or re-engagement later |
| F — Reject | 0-19 | Do not ship — remove from list or flag for manual review |

---

## How to use

1. During `/gtm:validate-list`, calculate lead_score for each contact
2. The basic `icp_score` (0-3) maps roughly: 3=A/B, 2=B/C, 1=C/D, 0=F
3. Lead score adds granularity within each ICP tier
4. Sort shipped lists by lead_score descending — best leads get outreach first
5. Use score tiers to decide personalization depth:
   - A leads: custom opening line referencing their specific signal
   - B leads: template with company-level personalization
   - C leads: template with industry-level personalization
6. Track which score tiers convert best — feed back into model weights

---

## Customization

**This is a default model.** Every workspace can override it.

During onboarding or at any time, the user can:
- Change component weights (e.g. make signals 40% instead of 20%)
- Add or remove scoring factors within any component
- Change point values for specific criteria
- Change score tier thresholds (e.g. make "Hot" start at 70 instead of 80)
- Add custom scoring factors specific to their business

To customize, add a `## Lead scoring overrides` section to the workspace's RULES.md. Any overrides there take precedence over this default model.

Example override in RULES.md:
```
## Lead scoring overrides
- Signal strength weight: 40% (instead of 20%)
- Company fit weight: 20% (instead of 30%)
- Add custom factor: "Uses Shopify" = +5 points under company fit
- Hot tier threshold: 70 (instead of 80)
- Ignore engagement component (all new contacts, no prior data)
```

If no overrides exist in the workspace RULES.md, use this default model as-is.
