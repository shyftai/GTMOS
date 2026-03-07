---
name: gtm:account-based
description: Multi-thread a high-value target account
argument-hint: "<workspace-name> <company-name>"
---
<objective>
Run account-based multi-threading — reach 2-4 people at one company with role-appropriate messaging and coordinated timing.

Workspace and company: $ARGUMENTS
</objective>

<execution_context>
@./commands/account-based.md
@./commands/audience-sync.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
@./.claude/gtmos/references/campaign-types.md
@./.claude/gtmos/references/enrichment-waterfall.md
@./.claude/gtmos/references/api-reference.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // ACCOUNT-BASED >>`
2. Load ICP.md, PERSONA.md, BRIEFING.md, SUPPRESSION.md
3. Research and qualify the target account (Crispy, Exa, Firecrawl, Apollo)
4. Score the account against ICP — minimum 70/100 for ABM investment
5. Map the buying committee — identify 2-4 contacts by role (Champion → Decision Maker → Influencer → Blocker)
6. Enrich all contacts via email finding waterfall
7. Optional: if HubSpot ABM or ad platforms are available, mention audience warming as an option (not required)
8. Design per-role sequences (same angle, different framing per role)
9. Apply stagger timing — never hit all contacts on the same day
10. Set cross-reference rules — any reply pauses all other threads at that company
11. Present full multi-thread plan for approval (contacts, sequences, timeline, costs)
12. On approval, execute and track all threads in campaign logs
13. Monitor at account level — engagement score across all contacts
</process>
