---
name: gtm:write-multilang
description: Write an outbound sequence in a non-English language
argument-hint: "<workspace-name> <language> [touches] [channel]"
---
<objective>
Write an outbound sequence in a non-English language. Load all context, detect or confirm the target language, draft each touch natively (not translated), auto-validate with the extended 14-point checklist, and present for approval.

Workspace, language, and options: $ARGUMENTS
</objective>

<execution_context>
@./commands/write-multilang.md
@./commands/write-sequence.md
@./commands/validate-copy.md
@./.claude/gtmos/references/cold-email-skill.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/campaign-types.md
@./global/snippet-library.md
@./global/swipe-file.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // COPY LAB — MULTILANG >>`
2. Parse $ARGUMENTS for workspace name, target language, touch count, and channel
3. Detect or confirm target language:
   - If language is explicitly provided, confirm it
   - If not provided, check prospect data: Crispy `locale` field, company website language (Firecrawl), and location
   - Apply decision logic from write-multilang.md — if signals are mixed, default to English and confirm with operator
   - Display: `Language: [language] | Formality: [formal/informal] | Word limit adjustment: [+X%]`
4. Load workspace context — ICP.md, PERSONA.md, TOV.md, RULES.md from the active workspace
5. Load BRIEFING.md from the active campaign
6. Load campaign.config.md for channel and touch count
7. Load campaign type from campaign-types.md — use type defaults for touch count, spacing, and structure
8. Check TOV.md for a `## Language rules` section — if it exists, load per-language overrides for formality, banned phrases, and preferred terms
9. Apply language-specific adjustments from write-multilang.md:
   - Set formality register (formal/informal) based on language defaults or TOV.md override
   - Adjust word limits per the language adjustment table (e.g., German +15-20%, Dutch +10-15%)
   - Apply seniority adjustments on top of language adjustments
   - Note cultural norms for touch structure (more context vs more direct)
10. Load MULTICHANNEL.md if multi-channel campaign
11. Check AB-TESTS.md for winning variants to incorporate
12. Load PERSONALIZATION.md — verify all merge fields work in the target language (grammar, word order, character sets)
13. Load BOOKING.md — use correct booking link and UTM parameters
14. Check context/research/signal-angles.md for relevant angles
15. Load global/snippet-library.md — reference proven patterns matching this campaign's channel and angle (adapt to target language, do not translate)
16. Load global/swipe-file.md — reference full sequence examples as structural guides (adapt to target language natively)
17. Draft each touch natively in the target language:
    - Do NOT write in English first and translate — draft directly in the target language
    - Touch 1: observation-led cold open, framework from cold-email-skill.md, adapted to cultural norms
    - Touch 2: different angle — new pain point, social proof, or industry insight
    - Touch 3: value add — share something useful without asking
    - Touch 4 (if applicable): breakup — honest, short, zero pressure
    - Subject lines: short, lowercase, no punctuation — native to the target language
    - Follow-up subject lines: Re: original thread
    - Include compliance/unsubscribe text in the correct language (GDPR, CASL, LGPD as applicable)
18. Verify all {{variables}} exist in PERSONALIZATION.md — flag any that don't
19. Verify all links come from BOOKING.md — never invent URLs
20. If A/B test is planned, create variants A and B clearly labeled
21. Apply TOV.md channel-specific rules (email vs LinkedIn)
22. Run the extended 14-point quality checklist from write-multilang.md on every touch:
    - Checks 1-10: standard cold-email-skill.md checklist (with adjusted word limits)
    - Check 11: language matches prospect's locale
    - Check 12: formality level is appropriate
    - Check 13: no unnecessary English loanwords where native terms exist
    - Check 14: compliance text in the correct language
    - Display results inline per touch
23. Present with language-specific notes:
    - Confirm language and formality used
    - Flag any cultural adjustments made (e.g., "Added extra context sentence for German market")
    - Flag any merge field concerns (e.g., "Verify {{first_name}} renders accented characters correctly")
    - Use approval gate from ui-brand.md
24. On approval, save to copy/approved/
25. Suggest next action: `/gtm:validate-copy` or `/gtm:ship`
</process>
