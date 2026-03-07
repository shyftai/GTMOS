# Campaign Type Templates — GTMOS

Pre-built starting points for common campaign types. When creating a new campaign with `/gtm:new-campaign`, suggest the best-fit type and pre-fill the config.

---

## Cold Outbound (default)

The standard cold email sequence to net-new contacts.

| Setting | Default |
|---------|---------|
| Channel | email |
| Touches | 4 |
| Duration | 14 days |
| Interval | 3-4 days between touches |
| Send window | 8-11 AM recipient timezone |
| List source | Apollo, Icypeas, Prospeo, Sales Navigator |

**Sequence structure:**
1. Observation-led cold open (Observation > Problem > Proof > Ask)
2. Different angle — new pain point or social proof
3. Value add — benchmark, insight, or case study (no ask)
4. Breakup — honest, zero pressure

**Best for:** First outreach to a new ICP segment.

---

## Signal-Triggered

Outreach driven by a specific buying signal (funding, hiring, job change, news).

| Setting | Default |
|---------|---------|
| Channel | email |
| Touches | 2-3 |
| Duration | 7-10 days |
| Interval | 3 days |
| Send window | Within 5 days of signal detection |
| List source | Signalbase, Commonroom, Jungler, Trigify + enrichment via Apollo/Prospeo |

**Sequence structure:**
1. Signal-led open (Trigger > Relevance > Value > Ask)
2. Follow-up with a different angle tied to the same signal
3. Optional soft breakup

**Best for:** Timely outreach when a signal creates urgency.

---

## Competitor Displacement

Targeting contacts known to use a specific competitor.

| Setting | Default |
|---------|---------|
| Channel | email or multi-channel |
| Touches | 3-4 |
| Duration | 14 days |
| Interval | 4 days |
| List source | Apollo (tech stack filter), Apify (review scraping), manual research |

**Sequence structure:**
1. Acknowledge their current tool — open with a known limitation or gap
2. Social proof from a company that switched
3. Value add — comparison data or migration case study
4. Breakup

**Rules:**
- Never disparage the competitor — acknowledge, then differentiate
- Load COMPETITORS.md for approved positioning and win angles
- Reference specific gaps, not generic "we're better"

**Best for:** Targeting users of a specific competing product.

---

## Event Follow-Up

Post-event outreach to attendees, speakers, or exhibitors.

| Setting | Default |
|---------|---------|
| Channel | email + LinkedIn |
| Touches | 3 |
| Duration | 10 days |
| Interval | 3 days |
| Send window | Start 1-2 days after event ends |
| List source | Event attendee list, badge scans, LinkedIn event page |

**Sequence structure:**
1. Reference the event + a specific session, talk, or shared experience
2. Value add — share a takeaway or insight related to the event theme
3. Soft close — connect the event topic to your offer

**Rules:**
- First touch must reference the specific event — generic follow-ups feel spammy
- Send within 5 days of event — relevance decays fast
- If you met them in person, say so

**Best for:** Conferences, webinars, meetups, trade shows.

---

## Product Launch

Outreach timed to a new feature, product, or major update.

| Setting | Default |
|---------|---------|
| Channel | email |
| Touches | 3 |
| Duration | 10 days |
| Interval | 3-4 days |
| List source | Existing prospects (re-engagement eligible) + new ICP contacts |

**Sequence structure:**
1. Pattern > Insight > Bridge > Ask — lead with the problem the new product solves
2. Social proof or early adopter results
3. Low-friction CTA — demo, walkthrough, or early access

**Rules:**
- Don't lead with "we just launched" — lead with the problem it solves
- Existing prospects get a different version than net-new contacts
- Can combine with re-engagement for contacts who went cold

**Best for:** New feature announcement, major update, new product line.

---

## ABM (Account-Based)

Multi-threaded outreach to a high-value target account.

| Setting | Default |
|---------|---------|
| Channel | multi-channel (email + LinkedIn) |
| Touches | 3-4 per contact |
| Duration | 21 days |
| Contacts per account | 2-4 |
| List source | Manual research + Sales Navigator + Apollo |

**Sequence structure per role:**
- Decision maker: Business outcome focus, max 50 words, ultra-brief
- Champion: Day-to-day pain, team impact, 65 words
- Influencer: Workflow-level impact, 75 words

**Rules:**
- Stagger contacts — don't hit everyone at the same company on the same day
- Start with champion, then decision maker 2-3 days later
- If any contact replies, pause all other threads at that company
- Use LinkedIn warming before connection requests
- See `commands/account-based.md` for full playbook

**Best for:** High-value accounts worth multi-touch investment.

---

## Re-Engagement

Reaching back out to contacts who went through a previous sequence without converting.

| Setting | Default |
|---------|---------|
| Channel | email |
| Touches | 2 |
| Duration | 7 days |
| Interval | 5-7 days |
| Minimum gap | 60 days since last touch (90 preferred) |
| List source | Previous campaign non-responders |

**Sequence structure:**
1. Re-engagement angle — new signal, new offer, or honest check-in
2. Brief follow-up or breakup

**Rules:**
- Must have a new reason to reach out — never repeat the same pitch
- Subject line: reply to original thread if possible
- See `commands/re-engage.md` for full playbook

**Best for:** Reviving cold leads with a new angle or signal.

---

## How to use

During `/gtm:new-campaign`, ask:
> "What type of campaign is this? (cold outbound / signal-triggered / competitor displacement / event follow-up / product launch / ABM / re-engagement)"

Pre-fill campaign.config.md with the selected type's defaults. The user can override any setting.
