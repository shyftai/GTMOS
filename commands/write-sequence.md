# Command: Write Outbound Sequence

## Trigger
"Write a [N]-touch sequence" or "Draft the outbound sequence for [campaign]"

## Cold email skill
Load `.claude/gtmos/references/cold-email-skill.md` before writing any copy. All email and LinkedIn copy must follow these principles:
- **Peer voice** — write as a colleague, not a salesperson
- **Observation-led** — open with something specific about them, never about yourself
- **Ruthless brevity** — touch 1 max 75 words, follow-ups max 50 words
- **Interest-based CTA** — ask if they want to learn more, never ask to book/buy
- **Subject lines** — 2-4 words, lowercase, no punctuation
- **Angle rotation** — each follow-up must use a DIFFERENT angle than the previous touch

## Frameworks (choose based on campaign angle)
- **Observation > Problem > Proof > Ask** — best for first touch cold opens
- **Pattern > Insight > Bridge > Ask** — best for industry-level angles
- **Trigger > Relevance > Value > Ask** — best for signal-triggered outreach

## Steps
1. Load ICP.md, PERSONA.md, and TOV.md from active workspace; load BRIEFING.md from active campaign
2. Load campaign.config.md for channel and touch count
3. Load cold-email-skill.md for writing principles and quality checklist
4. Load campaign-types.md — match campaign type for default structure (touch count, spacing, framework)
5. Load global/snippet-library.md — scan for proven opening lines, CTAs, and proof lines that match:
   - The channel (email / LinkedIn)
   - The campaign angle (growth signal, competitor, event, etc.)
   - Adapt to fit this workspace's TOV.md — never copy-paste raw snippets
6. Load global/swipe-file.md — find full sequence examples matching this campaign type:
   - Use as structural reference (framework, touch flow, tone calibration)
   - Adapt to this workspace's ICP, persona, and offer — never copy-paste
7. Check context/research/signal-angles.md for relevant angles to incorporate
8. Calibrate tone to persona seniority (C-suite: max 50 words, Director: max 65, Manager/IC: max 75)
9. Draft each touch in order:
   - Touch 1: observation-led cold open using Observation > Problem > Proof > Ask framework, single interest-based CTA
   - Touch 2: different angle — new pain point, social proof, or industry insight
   - Touch 3: value add — share something useful (benchmark, insight, case study) without asking
   - Touch 4 (if applicable): breakup — honest, short, zero pressure
7. Subject lines: 2-4 words, lowercase, no punctuation. Follow-ups use Re: original thread.
8. For LinkedIn touches (via Crispy): max 50 words, more conversational, no links in first message
9. Apply TOV.md channel-specific rules (email vs LinkedIn)
10. Run the 10-point quality checklist from cold-email-skill.md on every touch
11. After drafting: run validate-copy automatically
12. Present with inline flags for anything borderline
13. Save approved version to copy/approved/
