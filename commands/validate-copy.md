# Command: Validate Copy

## Trigger
"Validate this copy" or runs automatically after write-sequence

## Steps
1. Confirm active workspace (ICP.md + BRIEFING.md + TOV.md + RULES.md loaded)
2. Load `.claude/gtmos/references/cold-email-skill.md` for the quality checklist
3. Check each touch against:
   - Copy quality rules in RULES.md
   - Tone, voice, and channel rules in TOV.md
   - Tone and constraints in BRIEFING.md
   - ICP relevance — does this land for the target persona?
4. Run the cold-email 10-point quality checklist on every touch:
   - [ ] Peer voice — reads like a colleague, not a salesperson
   - [ ] Under word limit — Touch 1: 75 words, Touch 2+: 50 words
   - [ ] No "I" opener — first word is not "I" or company name
   - [ ] Observation-led — opens with something specific about them
   - [ ] Single CTA — one ask, interest-based, low friction
   - [ ] No spam words — no "excited", "thrilled", "game-changing", "synergy", "leverage", "unlock"
   - [ ] Subject line — 2-4 words, lowercase, no punctuation
   - [ ] Angle rotation — each touch uses a different angle than the previous
   - [ ] Specificity — at least one specific detail (company, role, signal, metric)
   - [ ] Brevity — no filler sentences, no throat-clearing, no preamble
5. Flag any violations inline with the reason
6. Suggest a revised version for each flagged line
7. Do not present the sequence as approved until all flags are resolved
