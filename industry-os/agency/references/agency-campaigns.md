# Agency Campaign Types

Seven campaign types for agency new business. Load the relevant section before running `/agency:new-business`.

---

## 1. Cold Outbound — New Business

**Purpose:** Primary proactive new business channel. Reach ICP-matching companies with no existing agency relationship or an unknown one.
**Best for:** Building consistent pipeline from scratch. Most scalable channel.

**Target:** Companies matching ICP.md with active buying signals
**Minimum signal requirement:** ICP match + at least one buying signal from agency-signals.md

**Sequence structure (4-touch email + 2 LinkedIn over 8 business days):**

| Touch | Channel | Day | Angle | Length |
|-------|---------|-----|-------|--------|
| 1 | Email | Day 1 | Lead with result or specific observation | 80 words max |
| 2 | LinkedIn | Day 3 | Connection request + 1-sentence context | 1 sentence |
| 3 | Email | Day 5 | Different angle — case study or question | 70 words max |
| 4 | LinkedIn | Day 7 | Message after connection accept | 50 words max |
| 5 | Email | Day 9 | Breakup or hard question | 40 words max |
| 6 | Email | Day 12 | Close the loop — short, no pressure | 30 words max |

**Angle options:**
- **Performance gap:** "Saw something in your [channel] that's worth flagging..."
- **Growth opportunity:** "Companies at your stage usually have [gap X] — here's what we did about it for [similar company]..."
- **Signal reference:** "Noticed [trigger]. Usually means [implication]. Here's what's worked for others in that position..."

**Copy rules:**
- Touch 1: Never start with "I" — open with observation about them or a result
- Each follow-up: rotate angle — never repeat the same hook twice
- Subject lines: 2–4 words, lowercase, no punctuation
- See TOV.md and `../../.claude/gtmos/references/cold-email-skill.md` for full copy rules

**List size:** 50–200 per campaign batch (match list size to inbox capacity)
**Expected results (benchmark):** 4–8% reply rate, 1.5–3% positive reply rate

---

## 2. Signal-Triggered — New CMO or VP Marketing Hired

**Purpose:** Catch new marketing leaders in their 90-day "clean slate" window. Highest-converting trigger for agency new business.
**Best for:** Any agency that can credibly say they help new marketing leaders hit their first 90-day goals.

**Target:** Company just hired a new CMO, VP Marketing, Head of Marketing, or Marketing Director
**Trigger detection:** LinkedIn job change notification / LinkedIn Sales Navigator alert / Apollo job change signal
**Timing window:** Outreach within 14 days of job change. First 90 days is peak conversion window.

**Sequence structure (3-touch email over 7 days):**

| Touch | Day | Angle |
|-------|-----|-------|
| 1 | Day 1 | "New leader → audit everything → agency is part of that audit" |
| 2 | Day 4 | Case study from a new marketing leader we helped in their first 90 days |
| 3 | Day 7 | Short: "Happy to share our new-leader marketing audit — no pitch, just useful" |

**Touch 1 template angle:**
"Saw you just joined [company] as [title]. New marketing leader usually means a full audit of what's working and what's not — we've helped a few marketing leaders in that position recently. Happy to share what we found, if useful."

**Key personalisation variables:**
- `{{new_hire_name}}` — their name (load from LinkedIn, not assumed)
- `{{company_name}}`
- `{{title}}`
- `{{time_in_role}}` — "last week", "last month" (keep it current — stale feels creepy)

**Why this works:** New leaders have budget authority, a mandate to make changes, and no existing agency loyalty. They are the most open they will ever be to an agency conversation.

**Expected results:** 6–12% reply rate, 3–5% positive reply rate (2x baseline)

---

## 3. Signal-Triggered — Funding Round Announced

**Purpose:** Catch companies with fresh capital under pressure to show growth. Budget has expanded. Growth targets have increased. They need execution capacity.
**Best for:** Agencies with strong performance marketing, demand gen, or go-to-market experience at funded startup stage.

**Target:** Companies announcing Series A, B, or growth equity round
**Trigger detection:** Crunchbase, Apollo funding alerts, TechCrunch/Axios/LinkedIn posts
**Timing window:** Outreach within 7 days of announcement. After 2 weeks, the moment has passed.

**Sequence structure (3-touch over 5 days — fast cadence):**

| Touch | Day | Angle |
|-------|-----|-------|
| 1 | Day 1–2 | "Congrats on the round — here's what companies at this stage usually need next" |
| 2 | Day 3 | Specific case study: what we did for a company after they raised at the same stage |
| 3 | Day 5 | Short close: "If now isn't the right time, when would be?" |

**Touch 1 angle:**
"Saw [company] just raised [amount]. Capital usually means one thing: the board wants to see growth faster. We've helped [n] companies build that growth engine after their [Series X] — usually takes 90 days to get the machine running. Worth a quick call to compare notes?"

**Persona targeting:**
- If company has a CMO/VP Marketing: target them
- If company is <100 employees: target Founder/CEO
- If round is Series A and no marketing hire yet: target Founder

**Expected results:** 5–10% reply rate (time-sensitive signal = high relevance)

---

## 4. Competitor Displacement

**Purpose:** Target companies currently with a competitor agency (or recently left one) who may be open to switching. Empathy-led, not attack-led.
**Best for:** Agencies with specific evidence of winning against or outperforming specific competitor agencies.

**Target:** Companies known to be unhappy with or actively switching from a competitor agency
**Trigger signals:**
- Job posting for "Agency Manager", "Agency Partner", "Performance Marketing Manager" (signals they're managing or replacing an agency)
- Negative G2/Clutch reviews posted about a competitor
- Former client of a known competitor (if identifiable through case studies or public mentions)
- LinkedIn posts from company expressing frustration with marketing results

**Sequence structure (3-touch, empathy-led):**

| Touch | Day | Angle |
|-------|-----|-------|
| 1 | Day 1 | Acknowledge that not all agencies work the same way — specific differentiator |
| 2 | Day 4 | Case study from a company that switched and what changed |
| 3 | Day 8 | Soft close — offer an audit or quick call, no commitment |

**Touch 1 framing:**
Do NOT name or attack the competitor. Lead with a question about what's working, not with "I know you're unhappy with [agency]."

"Most companies at your stage have tried at least one agency and have opinions about what didn't work. We built [agency name] around fixing the three things most agencies get wrong: [thing 1], [thing 2], [thing 3]. Happy to show you how it's different."

**What NOT to do:** Never disparage a competitor by name in cold outreach. It looks desperate and risks a reply that quotes you.

**Load COMPETITORS.md** before running this campaign type — you need the specific differentiators per competitor.

---

## 5. Referral Activation

**Purpose:** Activate existing happy clients, alumni, and warm introducers to refer new business. Highest close rate, lowest effort. Should run continuously.
**Best for:** Any agency — this is the highest-ROI new business channel and is chronically under-used.

**Target:** Existing clients with health = Green (from CLIENTS.md), plus alumni, advisors, and warm contacts
**Trigger:** QBR completion with positive result, milestone hit (goal achieved), NPS score submitted, contract renewal

**Sequence structure (1–2 touch, soft ask):**

| Touch | Channel | Angle |
|-------|---------|-------|
| 1 | Email or Slack (existing relationship) | Reference their result — then ask "do you know anyone who could use this?" |
| 2 (optional) | Follow-up 10 days later | Brief reminder if no response |

**Touch 1 template:**
"[Name] — hitting [specific result] with [company] has been great to be part of. We're looking to work with a few more companies like yours this quarter. Any chance you know someone in your network who'd benefit from the same approach? Happy to make it easy for them — one intro call is all it takes."

**Referral ask rules:**
- Only ask Green-health clients — never Yellow or Red
- Reference their specific result, not a generic "we're doing great work"
- Make the ask soft — a suggestion, not a pressure
- Include a shareable one-liner of their results they can forward

**Log all referral asks in CLIENTS.md** and track referral pipeline in PIPELINE.md

**Expected results:** 40–60% intro-to-close rate (highest of all channels)

---

## 6. Win-Back — Lapsed Client

**Purpose:** Re-engage clients who churned 6–18 months ago on decent terms. Often lower cost to re-acquire than a cold new client.
**Best for:** Agencies with >12 months of operating history who have a genuine "what's changed" story.

**Target:** Clients who churned 6–18 months ago, not on bad terms (check churned clients section of CLIENTS.md)
**Trigger signals:** New marketing job posting at former client (signals struggle), flat content/ad activity, new round of funding
**Timing:** 6–18 months post-churn. Under 6 months = too fresh. Over 18 months = too cold, different buyer.

**Sequence structure (2-touch):**

| Touch | Day | Angle |
|-------|-----|-------|
| 1 | Day 1 | Acknowledge the gap — lead with what's changed at the agency since they left |
| 2 | Day 8 | Specific: new case study or capability that addresses what wasn't working before |

**Touch 1 framing:**
Do not pretend nothing happened. Acknowledge the time, reference what's new, be direct.

"[Name] — it's been [X months] since we worked together. We've done a lot since then, including [specific new capability or result]. Not sure if the timing is right, but wanted to reconnect in case the context has changed. Happy to share what's different."

**Hard rule:** Only contact former clients who left on neutral or positive terms. If churn reason was a genuine failure or bad relationship, do not contact without leadership review first.

---

## 7. Retainer Renewal / Upsell

**Purpose:** Renew existing retainers and expand into adjacent service lines. Not a campaign — a workflow.
**Best for:** All retainer clients. This is retention, not new business.

**Target:** Existing active clients (in CLIENTS.md)
**Trigger:** 60 days before contract renewal, or milestone hit (2 months of consistent results, new market expansion, new product launch)

**This is not an email campaign.** Renewal and upsell are conversation-led, not sequence-driven:
- Renewal: QBR → proposal → call → signed contract
- Upsell: results review → gap identified → 1-page pitch → client call

**For full workflows, see:**
- `/agency:retainer-renewal` — run the full renewal workflow
- `/agency:upsell` — identify and pitch upsell
- `/agency:qbr-prep` — prepare the QBR deck
- `references/retainer-workflows.md` — full process details

**Why it's campaign #7:** Retention revenue is cheaper than new business revenue. Every renewal is worth more than a new client because you already have the relationship and the context.
