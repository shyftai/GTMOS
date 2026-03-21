# Learnings — [Workspace Name]

This file accumulates intelligence from every campaign, deep dive, debrief, and reply analysis. Each insight is tagged with its source and confidence level. The more campaigns you run, the smarter this gets.

**Updated by:** `/gtm:debrief`, `/gtm:deep-dive`, `/gtm:auto-refine`, `/gtm:replies`, `/gtm:health`, `/gtm:post-meeting`

---

## Entry schema

Every learning entry must include these fields:

| Field | Required | Description |
|-------|----------|-------------|
| `date` | Yes | ISO date when the insight was logged (YYYY-MM-DD) |
| `campaign` | Yes | Campaign name or "cross-campaign" |
| `type` | Yes | icp / persona / copy / channel / signal / objection / anti |
| `signal` | Yes | The specific observation or data point (what you saw) |
| `context` | Yes | What was happening when this signal was observed |
| `result` | Yes | What happened as a result (metric, outcome, or pattern) |
| `source` | Yes | Where the data came from (debrief, reply analysis, A/B test, etc.) |
| `confidence` | Yes | High (50+ data points), Medium (10–49), Low (1–9) |
| `do_not_repeat` | Anti only | Explicit rule: what to avoid and in what context |

**When updating this file:** always append new entries — never overwrite existing ones. Tag source as `{source type} — {campaign} — {date}` in the Source column.

---

## Wins

Meeting bookings with full context — the highest-signal data in this file. Logged automatically by `/gtm:post-meeting`.

<!-- Format (one entry per booked meeting):
### Meeting booked — {contact} @ {company} — {date}
**Campaign:** {campaign}
**Touch:** {touch number} of {total}
**Subject:** {subject line}
**Opening:** {opening line}
**Persona:** {persona type}
**Angle:** {campaign angle}
**Their reply:** "{verbatim reply snippet}"
**Why it worked:** {user interpretation}
-->

---

## ICP learnings

| # | Insight | Source | Confidence | Date |
|---|---------|--------|------------|------|
| — | — | — | — | — |

<!-- Example:
| 1 | Series B companies reply at 3.8x the rate of seed-stage | Q1 Cold Outbound debrief | High (14/17 meetings) | 2026-03-15 |
| 2 | 50-200 employees is the sweet spot — smaller teams don't have budget | Q1 + Q2 campaigns | High (consistent) | 2026-04-01 |
-->

---

## Persona learnings

| # | Insight | Source | Confidence | Date |
|---|---------|--------|------------|------|
| — | — | — | — | — |

<!-- Example:
| 1 | VPs respond to peer-voice tone, Directors prefer data-led openers | A/B test #3 | Medium (62 sends) | 2026-03-20 |
| 2 | Founders ghost after Touch 2 — shorten sequence to 3 touches for founder persona | Q1 debrief | High (3 campaigns) | 2026-04-01 |
-->

---

## Copy learnings

| # | Insight | Source | Confidence | Date |
|---|---------|--------|------------|------|
| — | — | — | — | — |

<!-- Example:
| 1 | Question subject lines outperform statement subject lines by 40% | A/B test #1 | High (200+ sends) | 2026-03-12 |
| 2 | CTA "worth a conversation?" beats "open to a call?" by 25% | A/B test #5 | Medium (80 sends) | 2026-03-25 |
| 3 | Observation-led openers get 2x replies vs. compliment openers | Q1 + Q2 debrief | High | 2026-04-01 |
-->

---

## Channel learnings

| # | Insight | Source | Confidence | Date |
|---|---------|--------|------------|------|
| — | — | — | — | — |

<!-- Example:
| 1 | LinkedIn connection + email within 48h gets 60% higher reply rate than email alone | Multi-channel Q1 | Medium | 2026-03-18 |
| 2 | Email Touch 1 on Tuesday 9am local time outperforms all other slots | Sending time analysis | High (4 campaigns) | 2026-04-05 |
-->

---

## Signal learnings

| # | Insight | Source | Confidence | Date |
|---|---------|--------|------------|------|
| — | — | — | — | — |

<!-- Example:
| 1 | Job posts for "revenue ops" = 4x higher meeting rate than generic hiring signals | Signal-triggered campaign | High | 2026-03-22 |
| 2 | Funding signals lose value after 30 days — must act within 2 weeks | Q2 signal campaign | Medium | 2026-04-10 |
-->

---

## Objection patterns

| # | Objection | Best response | Win rate | Source | Date |
|---|-----------|--------------|----------|--------|------|
| — | — | — | — | — | — |

<!-- Example:
| 1 | "We already use [Competitor]" | Acknowledge + contrast on [differentiator] | 35% continue conversation | Reply analysis Q1 | 2026-03-15 |
| 2 | "Not the right time" | Offer to reconnect in Q+1, add to re-engage list | 20% book later | Reply analysis Q1-Q2 | 2026-04-01 |
-->

---

## Anti-learnings (what doesn't work)

| # | What we tried | Why it failed | Don't repeat | Date |
|---|--------------|--------------|-------------|------|
| — | — | — | — | — |

<!-- Example:
| 1 | 6-touch sequence for SMB segment | Drop-off after Touch 3, zero replies on Touch 5-6 | Cap SMB sequences at 4 touches | 2026-03-20 |
| 2 | Targeting CTOs at enterprise companies | Never respond to cold outbound — need warm intro or ABM | Don't cold email enterprise CTOs | 2026-04-05 |
-->
