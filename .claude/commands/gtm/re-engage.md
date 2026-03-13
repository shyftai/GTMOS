---
name: gtm:re-engage
description: Re-engagement campaign for contacts who went cold, or OOO follow-ups
argument-hint: "<workspace-name> [source-campaign] [--ooo]"
---
<objective>
Create a re-engagement campaign for contacts from a previous sequence who didn't convert. Different rules than cold outreach.

Workspace and source campaign: $ARGUMENTS
</objective>

<execution_context>
@./commands/re-engage.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
@./.claude/gtmos/references/campaign-types.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // RE-ENGAGE >>`
2. Load SUPPRESSION.md, ICP.md, PERSONA.md
3. Check for `--ooo` flag in arguments

## Standard re-engagement (default)
4. Pull non-responders from source campaign (minimum 60 days since last touch)
5. Filter out: replied contacts, suppressed contacts, ICP mismatches
6. Check for new signals on remaining contacts
7. Choose re-engagement angle (must differ from original campaign)
8. Draft 2-touch sequence following re-engagement rules
9. Validate and present for approval
10. Track separately in PIPELINE.md with "re-engagement" tag

## OOO re-touch (--ooo flag)
When `--ooo` is passed, run the OOO return-date follow-up workflow instead:

4. Query reply_queue (Supabase if team mode, or local replies/ files) for replies classified as `ooo`
5. For each OOO reply, check if `ooo_return_date` exists and has passed (return date + 1 business day)
6. Filter out: suppressed contacts, contacts who replied again after OOO, contacts already re-touched
7. Display the OOO re-touch queue:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  OOO RE-TOUCH — {n} contacts back from leave         ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                       ┃
┃  {name} ({company})                                   ┃
┃  OOO since: {date}   Returned: {return_date}          ┃
┃  Original campaign: {campaign}   Touch: {touch_n}     ┃
┃  ─────────────────────────────────────────────────    ┃
┃  {name} ({company})                                   ┃
┃  OOO since: {date}   Returned: {return_date}          ┃
┃  Original campaign: {campaign}   Touch: {touch_n}     ┃
┃                                                       ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```
8. For each contact, draft a short re-touch message that:
   - References their absence naturally ("Hope you had a good break" / "Welcome back")
   - Does NOT assume details about their absence (no "hope the vacation was great")
   - Picks up the thread from the original campaign angle
   - Keeps it to 2-3 sentences max — they have a full inbox
9. Validate against TOV.md and BRIEFING.md
10. Present each draft for approval (HARD GATE — this is outbound)
11. On approval, send via the campaign's configured sending tool (Instantly reply API or equivalent)
12. Log in replies/ with "ooo-retouch" tag
13. Update PIPELINE.md — move contacts back to "contacted" stage with retouch note

**Suggested schedule:** Run `/gtm:re-engage --ooo` weekly or add to `/gtm:today` scan to surface OOO contacts whose return date has passed.
</process>
