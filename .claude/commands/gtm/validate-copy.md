---
name: gtm:validate-copy
description: QA check copy against briefing, TOV, and quality rules
argument-hint: "<workspace-name>"
---
<objective>
Validate copy against all five sources of truth. Flag violations, suggest revisions, display five-check results.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./commands/validate-copy.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
@./.claude/gtmos/references/spam-words.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // COPY LAB >>`
2. Load workspace context — ICP.md, PERSONA.md, BRIEFING.md, TOV.md, RULES.md (apply any `## Spam word overrides`)
3. Check each touch against all rules
4. Run the spam word guard (`spam-words.md`) across every subject, body, and closeout line — flag banned single words/phrases, promotional/phishing wording, formatting bans, and silence-based closeouts. This is the deep scan behind quality check #6.
5. Display five-check validation per touch using ui-brand.md format
6. Flag violations inline with reason
7. Suggest revised version for each flagged line (use the safe-replacement patterns for spam flags)
8. Do not present as approved until all flags are resolved
</process>
