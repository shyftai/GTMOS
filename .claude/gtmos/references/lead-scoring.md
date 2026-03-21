# Lead Scoring Model — GTMOS

GTM:OS uses a **two-layer scoring model**: account score first, prospect score second.

## Two-layer model

```
Layer 1: Account score (0-100)
  → Score companies before researching people
  → Only proceed to Layer 2 for A/B-tier accounts (score ≥ 60)
  → F-tier accounts (< 20) are removed entirely

Layer 2: Prospect score (0-100)
  → Score individual contacts within approved accounts
  → Company fit component uses company_score directly (no re-scoring company)
  → Prospect score determines personalization depth and enrichment priority
```

**Default behaviour: company-first.** Override in `workspace.config.md`:
```
Scoring mode: company-first   ← default
Scoring mode: people-first  ← legacy, scores contacts directly without account pre-filter
```

When `people-first` is set, skip account scoring entirely and use the original 5-component model below.

---

## Account scoring (0-100)

Score companies before prospecting into them. Produces `company_score` column in lists.

**All scoring criteria come from ICP.md.** "Exact match", "sweet spot", "target market", "ideal stage" — these are defined by what's written in the workspace's ICP.md, not hardcoded values. Read ICP.md before scoring: if ICP.md says target industries are "SaaS, Fintech", then industry = "Healthcare" scores 0. If ICP.md says employee range is 50-200, then 201 employees scores at edge-of-range, not sweet spot. Never invent criteria.

| Component | Weight | Max points | What it measures |
|-----------|--------|------------|-----------------|
| Strategic fit | 35% | 35 | Firmographic match to ICP.md criteria |
| Timing signals | 30% | 30 | Account-level buying signals |
| Relationship depth | 20% | 20 | Existing pipeline coverage at this account |
| Data quality | 15% | 15 | Completeness of company-level data |

### Strategic fit (0-35)

Read each factor's target values directly from ICP.md before applying points:

| Factor | Points | Criteria |
|--------|--------|----------|
| Industry match | 0-12 | 12 = in ICP.md target industries, 6 = adjacent to a target industry, 0 = not listed |
| Company size | 0-10 | 10 = within ICP.md employee/revenue range, 5 = edge of range, 0 = outside |
| Geography | 0-7 | 7 = in ICP.md target geographies, 4 = adjacent market, 0 = in excluded list |
| Funding/revenue stage | 0-6 | 6 = matches ICP.md ideal stage, 3 = one stage off, 0 = wrong stage |

### Timing signals (0-30) — account-level only

These signals apply to the company, not an individual. See signal taxonomy below.

| Signal | Points | Decay |
|--------|--------|-------|
| Intent data hit (Bombora/G2/TechTarget) — in-market now | 15 | -3 per week |
| Funding round announced (< 30 days) | 10 | -3 per month |
| Hiring for roles relevant to your solution (< 30 days) | 8 | -2 per month |
| Technology change or stack expansion | 6 | -1 per month |
| Company expansion / new office / launch | 5 | -2 per month |

Cap: 30 points. Signals stack up to the cap.

### Relationship depth (0-20)

| Factor | Points |
|--------|--------|
| 3+ known contacts at this account | 10 |
| 2 known contacts | 6 |
| 1 known contact | 3 |
| No known contacts | 0 |
| Prior meeting or active opportunity | 8 |
| Prior email engagement (open/click) | 4 |

### Data quality (0-15)

| Factor | Points |
|--------|--------|
| Domain confirmed | 3 |
| Employee count verified | 3 |
| Industry confirmed | 3 |
| Funding/revenue data present | 3 |
| Tech stack data present | 3 |

### Account score tiers

| Tier | Score | Action |
|------|-------|--------|
| A — Priority | 80-100 | Full enrichment, multi-thread (find 3+ contacts), signal-triggered timing |
| B — Active | 60-79 | Standard enrichment, find 1-2 contacts |
| C — Monitor | 40-59 | Light enrichment only, hold until better signal |
| D — Deprioritise | 20-39 | Do not enrich — revisit if signal improves |
| F — Remove | 0-19 | Remove from list entirely |

**Credit gate:** enrichment only runs on A/B-tier accounts. C-tier and below are held until they move up.

---

## Signal taxonomy — account vs prospect

Every signal must be tagged as `account` or `prospect`. This determines which scoring layer it feeds.

| Signal | Type | Feeds |
|--------|------|-------|
| Funding round | account | Account score — Timing signals |
| Hiring for relevant role | account | Account score — Timing signals |
| Tech stack change | account | Account score — Timing signals |
| Company expansion / news | account | Account score — Timing signals |
| Intent data (Bombora/G2) | account | Account score — Timing signals |
| Job change (contact moved to new company) | prospect | Prospect score — Signal strength |
| LinkedIn activity (liked/commented) | prospect | Prospect score — Signal strength |
| Event attendance (individual speaker/attendee) | prospect | Prospect score — Signal strength |
| Profile view (viewed your LinkedIn) | prospect | Prospect score — Engagement |

When logging signals in `context/research/signal-angles.md`, always include `scope: account` or `scope: prospect`.

---

## ICP ceiling rule

A contact's prospect score is hard-capped based on their company's ICP fit:

| icp_score | Max prospect score | Max tier |
|-----------|-------------------|---------|
| 3 | 100 | A |
| 2 | 79 | B |
| 1 | 59 | C |
| 0 | — | Rejected — do not score |

This prevents a contact with great signals and data at a marginal ICP company from outranking a solid ICP fit with fewer signals.

---

## Re-scoring triggers

Scores are recomputed automatically when:
- **After enrichment** — new company or contact data changes any factor
- **After signal detected** — signal strength component updates
- **After job change detected** — contact's prospect score re-evaluated; new company gets a fresh account score check
- **After reply** — engagement component updates (positive reply → +10, negative → score flagged for review)
- **After 30 days** — signal decay recalculates; account and prospect scores may drop if signals have aged out

---

## Prospect score components

Applies only to contacts at A/B-tier accounts (in company-first mode). The company fit component uses the pre-computed `company_score` directly.

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

**In company-first mode:** replace this component with `company_score × 0.30`. The account has already been scored — no need to re-score company factors at the prospect level.

**In people-first mode:** score based on ICP.md criteria:

| Factor | Points | Criteria |
|--------|--------|----------|
| Industry match | 0-10 | 10 = exact match, 5 = adjacent, 0 = outside ICP |
| Company size | 0-8 | 8 = sweet spot range, 4 = edge of range, 0 = outside |
| Geography | 0-5 | 5 = target geo, 3 = adjacent market, 0 = excluded |
| Revenue/funding | 0-5 | 5 = ideal stage, 3 = close, 0 = wrong stage |
| Tech stack | 0-2 | 2 = uses complementary tools, 0 = unknown |

---

## Persona fit (0-25)

**All scoring criteria come from PERSONA.md.** Read PERSONA.md before scoring: target titles, departments, seniority levels, and decision authority definitions are all defined there. "Exact title" means the contact's title appears in (or closely matches) PERSONA.md's target titles list. "Target department" means their department matches what PERSONA.md specifies. Never invent persona criteria.

| Factor | Points | Criteria |
|--------|--------|----------|
| Title match | 0-10 | 10 = in PERSONA.md target titles, 7 = equivalent role, 3 = adjacent function, 0 = outside persona |
| Department | 0-5 | 5 = in PERSONA.md target departments, 2 = adjacent, 0 = wrong department |
| Seniority | 0-5 | 5 = meets PERSONA.md minimum seniority, 3 = one level below, 0 = too junior or too senior |
| Decision authority | 0-5 | 5 = decision maker (as defined in PERSONA.md), 3 = influencer, 1 = user/champion, 0 = no authority |

---

## Signal strength (0-20) — prospect-level only

Score based on **prospect-scoped signals** (see signal taxonomy above). Account-level signals (funding, hiring, tech stack) are captured in the account score — do not double-count them here.

| Signal type | Points | Decay |
|-------------|--------|-------|
| Job change — contact moved to new company in your ICP | 8 | -3 per month |
| Social engagement (liked/commented on relevant content) | 5 | -1 per week |
| Event attendance (individual speaker or attendee) | 4 | -1 per month |
| LinkedIn profile view (viewed your profile) | 3 | -1 per week |

**Rules:**
- Signals stack — multiple signals add together up to the 20-point cap
- Signals decay over time — recency matters
- No signal = 0 points (not a disqualifier, just lower priority)
- In company-first mode, account signals are already reflected in the company fit component via company_score — only prospect-scoped signals count here

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
