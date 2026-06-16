# Spintax — GTMOS

Spintax lets the sending tool randomly pick one variant per send, so no two emails are byte-identical. This reduces pattern detection by spam filters and protects deliverability at volume. Loaded by `/gtm:spintax` and referenced by `/gtm:ship`.

Apply spintax **after** copy is approved and before it ships — never to drafts in review (it complicates QA and re-validation). Spintax never changes the meaning, claims, or tone of approved copy.

---

## Syntax by tool

| Tool | Syntax | Notes |
|------|--------|-------|
| Smartlead | `{option1\|option2\|option3}` | One picked at random per send |
| Instantly | `{option1\|option2\|option3}` | Same spintax syntax |
| Lemlist | Variables / liquid syntax | Use Lemlist's own variation feature, not pipe spintax |

Each option inside the curly braces is separated by a pipe `|`. Confirm the active sending tool in `campaign.config.md` before adding spintax — applying Smartlead spintax to a Lemlist campaign will render literal braces to recipients.

---

## The golden rule: no broken combinations

Every combination the sending tool could assemble MUST read as a natural, grammatically correct, complete sentence. This is the single most important rule.

**Bad — dependent blocks that can break:**
```
{let me know if|would} {{employee_line}} {would be better to speak to|be a better person to chat with}
```
"would" + "would be better to speak to" = "would {{name}} would be better to speak to" — broken.

**Good — each option is a full standalone phrase:**
```
{let me know if {{employee_line}} would be better to speak to about this?|would {{employee_line}} be a better person to chat with about this?|should I be reaching out to {{employee_line}} about this instead?}
```

Make each spintax block a self-contained phrase whose options are interchangeable regardless of what a neighbouring block picks. When sentence structure makes independent blocks risky, wrap the **entire sentence** in one spintax block with full-sentence alternatives.

**Verification step:** after adding spintax, mentally walk every combination across adjacent blocks. If any pairing reads wrong, restructure. State "all combos clean" when verified.

---

## What to spin

Add 2-3 options per block. Keep tone and register identical to the approved copy (`TOV.md`).

**Always spin**
- Greetings where present: `{Hey|Hi}` (note: `cold-email-skill.md` prefers no greeting prefix — only spin if the approved copy uses one)
- Opt-out / closeout lines — repetitive across the sequence, easy to vary without tone change
- CTAs — different phrasings of the same single ask
- Transitions and connectors

**Spin when natural**
- Verb choices: `{help|work with}`, `{built|made}`, `{handles|manages}`
- Sentence-level rephrasings where a line can be said 2-3 ways without changing meaning

**Never spin**
- Merge fields: `{{first_name}}`, `{{company}}`, any field from `PERSONALIZATION.md` — leave exactly as-is
- Signature placeholders (e.g. `%signature%`)
- Specific data points: numbers, stats, brand/product names, pricing, proof points from `BRIEFING.md`
- Booking links and UTM parameters from `BOOKING.md`

---

## Tone preservation

Options must match the register of the original. Casual stays casual, direct stays direct. Do not introduce formality where there was none, or slang where the original was professional.

- Good: `{Worth a shot?|Want to give it a try?|Open to trying it out?}`
- Bad: `{Would you be amenable to a trial?|Worth a shot?}` — register mismatch

---

## Constraints inherited from the rest of the system

- Every spintax option is still subject to `spam-words.md` — do not introduce a banned word in any variant
- Every option must still pass the five-check (`GTMOS.md`) and `TOV.md` channel rules
- Word limits still apply to the longest possible assembled combination, not just the shortest

---

## Output

Return the spintaxed copy in a code block, ready to paste into the sending tool. Preserve all formatting (line breaks, HTML tags if the input was HTML). After each email, state "all combos clean" and note anything you changed. Process multi-email sequences one email at a time.

## Quick reference

| Element | Example |
|---|---|
| Greeting | `{Hey\|Hi}` |
| Verb swap | `{help\|work with\|partner with}` |
| Full sentence | `{Is this worth exploring?\|Want to give it a try?\|Open to a quick chat?}` |
| Closeout | `{If this isn't relevant, just reply and I won't follow up.\|Not relevant? Just reply and I won't reach out again.}` |
| Never touch | `{{first_name}}`, `{{company}}`, `%signature%`, booking links |
