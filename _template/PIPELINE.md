# CRM Pipeline — [Workspace Name]

## Pipeline stages

Define every stage a contact moves through from first outreach to closed-won/lost.

| Stage | Definition | Entry trigger | Exit trigger | Owner |
|-------|-----------|---------------|-------------|-------|
| Prospect | In validated list, not yet contacted | List validation passed | First touch sent |  |
| Contacted | First outreach sent | Sequence started | Reply received or sequence completed |  |
| Replied — Positive | Interested reply received | Positive reply classification | Meeting booked or disqualified |  |
| Replied — Negative | Not interested | Negative reply classification | Moved to closed-lost |  |
| Replied — Objection | Pushback, needs handling | Objection reply classification | Objection resolved or disqualified |  |
| Meeting Booked | Call or demo scheduled | Calendar invite confirmed | Meeting completed |  |
| Qualified | Meets buying criteria after meeting | Discovery call completed | Proposal sent or disqualified |  |
| Proposal Sent | Pricing or proposal delivered | Proposal email sent | Verbal yes/no or follow-up |  |
| Negotiation | Terms being discussed | Counter-proposal or questions | Agreement or walk-away |  |
| Closed — Won | Deal signed | Contract signed or PO received | n/a |  |
| Closed — Lost | Deal lost at any stage | Explicit no or 30-day stale | n/a |  |

---

## Attribution model

### First touch attribution
Every deal traces back to the campaign and touch that generated the first reply.

| Field | Source |
|-------|--------|
| First touch campaign | Campaign folder name |
| First touch date | Date of first email/LinkedIn send |
| First touch channel | Email / LinkedIn |
| Reply date | Date positive reply received |
| Reply touch number | Which touch in the sequence generated the reply |

### Multi-touch tracking
If a contact was reached across multiple campaigns, log all touchpoints:

| Contact | Campaign 1 | Campaign 2 | Campaign that converted | Touch that converted |
|---------|-----------|-----------|------------------------|---------------------|
| | | | | |

---

## Conversion tracking

### Funnel metrics
Track conversion rates between each stage per campaign.

| Metric | Formula | Target | Current |
|--------|---------|--------|---------|
| List → Contacted | Contacted / Shipped list | 100% | |
| Contacted → Reply | Replies / Contacted | 3-5% | |
| Reply → Positive | Positive replies / Total replies | 40-60% | |
| Positive → Meeting | Meetings / Positive replies | 60-80% | |
| Meeting → Qualified | Qualified / Meetings | 50-70% | |
| Qualified → Proposal | Proposals / Qualified | 70-90% | |
| Proposal → Won | Won / Proposals | 20-40% | |
| **Full funnel** | Won / Shipped list | 0.5-2% | |

### Revenue attribution
| Campaign | Contacts shipped | Meetings booked | Deals won | Revenue | Cost (from COSTS.md) | ROI |
|----------|-----------------|-----------------|-----------|---------|---------------------|-----|
| | | | | | | |

---

## CRM sync rules

### What gets pushed to CRM (Attio)
- New contacts from validated lists → create contact record
- Campaign tag → add to contact
- Reply classification → update contact status field
- Meeting booked → create deal, set stage
- Stage changes → update deal stage
- Unsubscribe → set do-not-contact flag

### What gets pulled from CRM
- Deal stage changes (manual updates by sales team)
- Won/lost outcomes for attribution
- Contact ownership changes
- Notes from sales calls (for copy iteration)

### Sync frequency
- After every list ship: push contacts
- After every reply classification: push status update
- Before every health check: pull deal stage updates
- Weekly: full reconciliation pull

---

## Pipeline velocity

Track how long deals spend in each stage. Updated during `/gtm:sync` and `/gtm:pipeline-velocity`.

### Stage durations

| Stage transition | Avg days | Median days | Stall threshold | Deals currently stalling |
|-----------------|----------|-------------|-----------------|-------------------------|
| Contacted -> Reply | — | — | — | — |
| Reply -> Meeting | — | — | — | — |
| Meeting -> Qualified | — | — | — | — |
| Qualified -> Proposal | — | — | — | — |
| Proposal -> Negotiation | — | — | — | — |
| Negotiation -> Won/Lost | — | — | — | — |
| **Full cycle (first touch -> won)** | — | — | — | — |

### Velocity trend

| Week | Avg cycle (days) | Deals in pipeline | Stall rate | Velocity score |
|------|-----------------|-------------------|------------|---------------|
| | | | | |

### Stalled deals

| Deal | Company | Current stage | Days in stage | Stall threshold | Suggested action |
|------|---------|--------------|---------------|-----------------|-----------------|
| | | | | | |

---

## Lost deal analysis

Track why deals are lost to improve targeting and copy.

| Reason | Count | % of losses | Action |
|--------|-------|-------------|--------|
| Wrong timing | | | Adjust signal triggers |
| Budget | | | Refine company size in ICP |
| Using competitor | | | Update objection map |
| No pain | | | Tighten ICP signals |
| Champion left | | | Add job change signal |
| Went dark | | | Review sequence timing |

---

## Win/loss insight log

After every closed deal (won or lost), log what worked or didn't. These insights compound across campaigns and feed back into ICP, copy, and objection handling.

### Wins
| Date | Company | Campaign | What worked | Winning touch | Winning angle | Time to close |
|------|---------|----------|-------------|---------------|---------------|---------------|
| | | | | | | |

### Losses
| Date | Company | Campaign | Why it died | Stage lost at | Competitor involved | Lesson |
|------|---------|----------|-------------|---------------|--------------------|---------|
| | | | | | | |

### Pattern tracker
Review this quarterly. Look for patterns that should change ICP, persona, or copy.

| Pattern | Evidence | Action taken | Date |
|---------|----------|-------------|------|
| e.g. "Series B companies close 2x faster" | 4/6 wins were post-Series B | Added Series B signal to ICP.md | |
| e.g. "VP Ops converts better than VP Sales" | 70% of meetings from VP Ops | Updated PERSONA.md primary persona | |
| e.g. "'quick thought' subject line outperforms" | 8% reply rate vs 3% average | Added to snippet-library.md | |
