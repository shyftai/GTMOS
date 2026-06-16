---
name: gtm:spam-check
description: Scan outbound copy for spam-trigger and deliverability-killing wording
argument-hint: "<workspace-name> [campaign-name | file-path]"
---
<objective>
Scan subject lines, openers, follow-ups, CTAs, and closeout lines against the spam word guard. Flag every hit, propose a plain-language rewrite, and report a clean/dirty verdict per touch. Does not send or ship anything.

Workspace and target: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/spam-words.md
@./.claude/gtmos/references/cold-email-skill.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // SPAM CHECK >>`
2. Resolve the target:
   - If a campaign name is given, load the approved (or draft) sequence from that campaign's `copy/`
   - If a file path is given, load that file
   - If neither, scan the most recent draft in the active campaign's `copy/drafts/`
3. Load workspace `RULES.md` — apply any `## Spam word overrides` (these take precedence over defaults)
4. For each touch (subject + body + closeout), scan against `spam-words.md`:
   - Banned single words (including hyphen/split variants where the root token is obvious)
   - Banned short phrases
   - High-risk promotional / pressure wording
   - Phishing-style and blacklisted-category wording
   - Formatting bans (em dashes, ALL CAPS, multiple exclamation marks, greeting prefixes, third-person company references)
   - Closeout lines that promise to stop on silence (must be action-conditional)
   - Banned tokens inside `{{company}}` values
5. Display results per touch using `ui-brand.md` status indicators:
```
  Touch 1
    Subject: "quick thought"            [x] clean
    Body                                [!] 2 flags
      !! "free consultation"  → open to a short conversation
      !! em dash in line 3    → use a period
    Closeout                            [x] clean
```
6. For every flag, show the offending text and a concrete rewrite from the safe-replacement patterns (or an equivalent plain-language line). Never just say "flagged" — propose the fix.
7. End with a verdict line per touch and overall: `Clean` or `{n} flags — rewrite before approval`.
8. If flags fired, do not mark copy approved. Route back to `/gtm:write` (or `/gtm:validate-copy`) to apply rewrites, then re-run this check.
9. This check is also run automatically inside `/gtm:write` and `/gtm:validate-copy` — running it standalone is for spot-checks and imported copy.

───────────────────────────────────────────────────────────────

## ▶ Next Up

**validate-copy** — full five-check QA once wording is clean

`/gtm:validate-copy {workspace}`

───────────────────────────────────────────────────────────────
</process>
