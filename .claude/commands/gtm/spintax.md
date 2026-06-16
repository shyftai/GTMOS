---
name: gtm:spintax
description: Add deliverability spintax to an approved sequence before shipping
argument-hint: "<workspace-name> <campaign-name>"
---
<objective>
Add sending-tool spintax to approved copy so no two sends are byte-identical — without changing meaning, claims, or tone. Verify every combination reads cleanly. Output paste-ready copy for the sending tool.

Workspace and campaign: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/spintax.md
@./.claude/gtmos/references/spam-words.md
@./.claude/gtmos/references/cold-email-skill.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // SPINTAX >>`
2. Confirm the sending tool from `campaign.config.md` and load the matching syntax from `spintax.md`. If the tool uses a different variation mechanism (e.g. Lemlist), say so and use that mechanism — never apply pipe spintax to a tool that renders braces literally.
3. Load the **approved** sequence from `copy/approved/`. If copy is still in draft/review, stop and tell the user to approve copy first — spintax is a pre-ship step, not a drafting step.
4. Load `PERSONALIZATION.md` and `BOOKING.md` — note all merge fields, signature placeholders, and links that must never be spun.
5. Process one touch at a time. For each:
   - Spin greetings (only if the copy uses one), closeout/opt-out lines, CTAs, and natural verb/phrase choices — 2-3 options per block
   - Make every block a self-contained phrase (the golden rule — no broken combinations)
   - Never spin merge fields, signature placeholders, numbers, proof points, brand/product names, booking links, or UTM parameters
   - Keep every option within `TOV.md` register and clear of `spam-words.md`
6. Verify: walk every combination across adjacent blocks. State `all combos clean` per touch, and note anything restructured.
7. Output each touch in a code block, ready to paste into the sending tool, preserving formatting.
8. Save the spintaxed version alongside the approved copy (e.g. `copy/approved/{sequence}-spintax.md`) — do not overwrite the clean approved file (the integrity marker must stay intact for the ship gate).
9. Log the action in `logs/decisions.md`.

───────────────────────────────────────────────────────────────

## ▶ Next Up

**ship** — push the spintaxed sequence to the sending tool

`/gtm:ship {workspace} {campaign}`

───────────────────────────────────────────────────────────────
</process>
