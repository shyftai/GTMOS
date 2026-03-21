# Command: Handle Replies

## Trigger
"Handle replies for [campaign]" or "Process new replies"

## Steps

### 1. Pull new replies
- Pull unprocessed replies from active email tools (Lemlist / Instantly / Smartlead)
- Pull unprocessed LinkedIn replies from Crispy
- Cross-reference with shipped list to identify sender

### 2. Classify each reply
Classify as one of seven types:
- Positive — interested, wants to talk, asking for next steps
- Negative — not interested, wrong timing, polite decline
- Objection — pushback that can be addressed (budget, timing, relevance, incumbent)
- Referral — not the right person, redirects to someone else
- OOO — out of office, auto-reply or human message
- Unsubscribe — explicit opt-out request or opt-out language
- Competitor mention — references a competing tool or vendor they use

Then assign a confidence level:
- **High** — signal is unambiguous (one clear interpretation)
- **Medium** — most likely classification but some ambiguity
- **Uncertain** — reply is unclear; two or more classifications are plausible

**Uncertain replies:** do NOT draft a response. Show the quoted reply and both possible classifications. Ask the operator to decide before any draft is created. Flag in the log as `Uncertain — pending human decision`.

### 3. Default action per type

**Positive:**
- Draft a warm, low-friction response moving toward booking
- Tone: human, unhurried, clear on next step
- CTA: suggest a specific time or send a booking link
- Update Attio: move to Interested stage
- Suggest: pause sequence for this contact

**Negative:**
- Draft a graceful close — acknowledge, leave the door open, no pressure
- Do not argue or re-pitch
- Update Attio: move to Not Interested
- Pause sequence immediately

**Objection:**
- Load PERSONA.md objection map
- Match the specific objection to the closest known counter
- Draft a response that addresses it directly without being defensive
- Flag if the objection is not in PERSONA.md — suggest adding it after the campaign

**Referral:**
- Draft a thank-you to the original contact
- Draft a new personalised first-touch for the referred contact
- Check if referred contact already exists in Attio
- Create new record in Attio if not — tag as referral with source noted

**OOO:**
- Extract return date from message if present
- Schedule a follow-up touch for return date + 1 business day
- Log in Attio with OOO flag and expected return date
- No response drafted

**Unsubscribe:**
- Remove from sequence immediately — no delay
- Add do-not-contact flag in Attio
- Log removal with timestamp
- Never surface this contact in any future campaign suggestion
- No response drafted

**Competitor mention:**
- Load competitor context from PERSONA.md if available
- Draft a response that acknowledges their current setup
- Reframe — find the gap or the reason to consider switching
- No attacking, no dismissing the competitor
- Keep it short — one point only

### 4. Validate all drafts against TOV.md
Before presenting, check every drafted response against:
- Sentence structure and length rules
- Words to use and never use
- Channel-specific rules (email vs LinkedIn)
Flag any violations and revise before presenting

### 5. Present for approval
Show each classified reply and its proposed response together.
For each one: confirm classification, review draft, approve or edit.
Nothing is sent until explicitly approved.

### 6. Log and save
- Save all reply classifications to replies/[YYYY-MM-DD].md
- Update Attio for all actioned contacts
- Note any new objections or patterns to flag in next health check
