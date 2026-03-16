# New Business Pipeline — [Agency Name]

Tracks all new business opportunities from first contact to close. Updated by Claude after every pipeline-moving action.

---

## Summary

| Stage | Count | Est. Value |
|-------|-------|------------|
| 1 — Identified | | |
| 2 — Contacted | | |
| 3 — Replied | | |
| 4 — Call Booked | | |
| 5 — Proposal Sent | | |
| 6 — Negotiation | | |
| 7 — Closed Won | | |
| 7 — Closed Lost | | |
| **Total active** | | |

**Weighted pipeline value:** $[total]
**This month closed won:** $[MRR]

---

## Pipeline by stage

### Stage 1 — Identified

Prospects matching ICP that have not yet been contacted.

| Company | Industry | Size | Signal | ICP Score | Added | Owner |
|---------|----------|------|--------|-----------|-------|-------|
| | | | | | | |

### Stage 2 — Contacted

First touch sent. Awaiting reply.

| Company | Contact | Title | First touch | Sequence | Days since | Owner |
|---------|---------|-------|-------------|----------|------------|-------|
| | | | | | | |

### Stage 3 — Replied

Prospect has replied. Positive, objection, or rescheduling.

| Company | Contact | Reply type | Date | Next action | Due | Owner |
|---------|---------|------------|------|-------------|-----|-------|
| | | | | | | |

### Stage 4 — Call Booked

Discovery or intro call scheduled.

| Company | Contact | Call date | Time | Format | Prep notes | Owner |
|---------|---------|-----------|------|--------|------------|-------|
| | | | | | | |

### Stage 5 — Proposal Sent

Proposal or scope document sent to prospect.

| Company | Contact | Proposal date | Value | Services | Follow-up due | Owner |
|---------|---------|---------------|-------|----------|---------------|-------|
| | | | | | | |

### Stage 6 — Negotiation

Verbal yes, working through terms, pricing, or contract.

| Company | Contact | Est. value | Sticking point | Decision maker | Close date | Owner |
|---------|---------|------------|----------------|----------------|------------|-------|
| | | | | | | |

### Stage 7 — Closed Won

Deal signed. Trigger `/agency:client-onboard`.

| Company | Services | MRR | Start date | Account lead | Onboard status |
|---------|----------|-----|------------|--------------|----------------|
| | | | | | |

### Stage 7 — Closed Lost

| Company | Stage lost | Reason | Competitor won? | Win-back eligible | Date |
|---------|------------|--------|-----------------|-------------------|------|
| | | | | | |

---

## Pipeline rules

- Deals in the same stage for **30+ days**: flag for follow-up review
- Proposals sent with **no reply in 7 days**: trigger follow-up sequence
- Closed Won: trigger `/agency:client-onboard` within 24 hours
- Closed Lost: tag reason, log competitor (if known), set win-back reminder if eligible
- Duplicate company found across stages: flag for review — do not double-contact

---

## Stage definitions

| Stage | Definition | Expected duration |
|-------|-----------|------------------|
| 1 Identified | ICP match confirmed, not yet contacted | 1–14 days |
| 2 Contacted | At least one touch sent | 5–14 days |
| 3 Replied | Any reply received — classify before advancing | 1–7 days |
| 4 Call Booked | Call scheduled, not yet completed | 1–14 days |
| 5 Proposal Sent | Formal scope and pricing sent | 7–21 days |
| 6 Negotiation | Active discussion on terms | 7–21 days |
| 7 Close | Won or lost, deal resolved | — |

---

## Renewal pipeline

Track client renewals as separate pipeline entries to avoid mixing with new business.

| Client | Current MRR | Renewal date | Days remaining | Proposed tier | Status | Owner |
|--------|-------------|--------------|----------------|---------------|--------|-------|
| | | | | | | |

---

## Learnings log

Short notes on patterns across won/lost deals. Update after every Closed Won and Closed Lost.

| Date | Outcome | Pattern / learning |
|------|---------|-------------------|
| | Won | |
| | Lost | |
