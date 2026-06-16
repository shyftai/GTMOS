# Weekly Operating Rhythm — GTMOS

Having the commands doesn't help if you don't run them on a schedule. What separates a hobbyist from a top-1% operator isn't tooling — it's consistency. This is the cadence. Loaded by `/gtm:rhythm`; surfaced in the "This week" section of `/gtm:today` and on `/gtm:dashboard`.

This is a **playbook**, not an automation. Put the cadence on the calendar you actually look at; GTM:OS surfaces what's due but does not silently send on your behalf.

---

## The cadence

| Cadence | Task | Primary command |
|---------|------|-----------------|
| Every Monday | Deliverability audit (last 7 days) | `/gtm:health` + `/gtm:inbox-health` |
| Every Wednesday | Positive-reply sweep | `/gtm:reply-score` → `/gtm:replies` |
| Every Friday | Campaign retrospectives (21-day marks) | `/gtm:reply-score`, `/gtm:debrief` |
| Every other Monday | Inbox rotation | `/gtm:inbox-health` |
| Monthly (1st) | Spam-placement test | `/gtm:inbox-health` (spam test) |
| Quarterly (first Mon) | Experiment review | `/gtm:experiment` |

---

## Monday — deliverability audit (~15 min)

Run `/gtm:health {ws} {campaign}` and `/gtm:inbox-health {ws}` over the last 7 days. Review:
- Fleet reply rate ≥1% (the 1% rule)
- Flagged campaigns (low reply) and inboxes (high bounce / warmup blocked)

Action: any campaign under the 1% rule → triage with `/gtm:domain-recovery` or pause. Bounce rate >2% → pause the offending campaign immediately, then diagnose. All clean → log and move on.

## Wednesday — positive-reply sweep (30-60 min)

Run `/gtm:reply-score` on every campaign active in the last 7 days. Review `positive_interested`, `positive_soft`, `positive_referral`, and any `negative_hostile`. Action:
- Respond to every `positive_interested` reply within minutes — don't batch these; a reply that feels fast converts far better. Draft via `/gtm:replies`.
- Referrals: reach the referred person within 24h, name the referrer.
- Hostile: acknowledge, suppress, investigate the targeting that produced it.

If you're seeing >50 positive replies/week, hand off to a dedicated closer (`/gtm:handoff`) — do it Wednesday morning so they can work replies that afternoon.

## Friday — retrospectives (~20 min per campaign)

For each campaign hitting its 21-day mark this week: run `/gtm:reply-score`, compare to prior baselines, and decide keep / iterate / kill.
- Winner (positive reply rate ≥2× baseline) → keep, consider scaling (`/gtm:clone-campaign` to more inboxes)
- Middling (near baseline) → iterate; plan the next variant Monday via `/gtm:experiment`
- Loser (<50% of baseline) → kill it; document why

Always log the decision and reasoning to `LEARNINGS.md` and the campaign's `performance/` folder. Over a quarter these become the input to the experiment review — without the history you can't learn across campaigns. `/gtm:debrief` automates most of this.

## Every other Monday — inbox rotation (~30 min)

Run `/gtm:inbox-health {ws} --all`. Retire inboxes with bad reputation or warmup blocks; promote insurance inboxes to active. If the insurance pool drops below ~5 spare inboxes, start a new domain/inbox purchase cycle now — it takes ~2 weeks from purchase to sendable, so start early (`/gtm:infra`).

## Monthly — spam-placement test (~25 min)

Run a seed/spam-placement test on the highest-volume active campaign (`/gtm:inbox-health` spam test, or a seed-list send). Target ≥85% inbox placement.
- ≥90% → keep going
- 80-90% → yellow: fix the highest-frequency trigger next week (start with `/gtm:spam-check`)
- <80% → red: pause, run `/gtm:domain-recovery`, fix before sending more

## Quarterly — experiment review (~90 min)

Read the quarter's experiment plans and debriefs. Identify which campaigns, list sources, and copy angles produced the best positive reply rate; which ICP archetypes converted best. Output a one-page retrospective into the workspace (top 3 / bottom 3 / 3-5 hypotheses for next quarter) and adjust `ICP.md` / `PERSONA.md` if the data points to a better segment. Feed the hypotheses into `/gtm:experiment`.

---

## What to skip

- Don't check the sending tool every day — the Wednesday sweep catches what matters.
- Don't react to daily reply-rate noise — wait for 7-day averages.
- Daily pokes at the stack are a procrastination pattern, not a performance pattern.

If you haven't shipped a campaign yet, ignore this rhythm — come back after your first campaign hits the 7-day mark.
