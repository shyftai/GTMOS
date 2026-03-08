---
name: gtm:nurture
description: Manage warm leads on a timer — "not now" doesn't mean "never"
argument-hint: "<workspace-name> [--scan | --add <contact> <date> | --due]"
---
<objective>
Track contacts who expressed interest but aren't ready now. "Not now, maybe Q3" or "Circle back after our funding round" or "Interesting, but we're locked into a contract until September." These are warm leads on a timer — not dead leads.

Workspace and mode: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // NURTURE >>`
2. Load workspace context — PERSONA.md, TOV.md, LEARNINGS.md, PIPELINE.md

## Nurture list management

### --add (add a contact to nurture)
3. When adding a contact:
   - Contact: {email/name}
   - Follow-up date: {when to reach back out}
   - Reason: {why not now — their exact words}
   - Original campaign: {which campaign they replied to}
   - Original reply: {their reply text}
   - Warmth: hot (very interested, timing issue) / warm (interested, needs trigger) / lukewarm (polite decline, might convert with new angle)
   - Trigger to watch: {what would make them ready — funding, contract end, hiring, etc.}

4. Save to workspace nurture/nurture-list.md:
```
| Contact | Company | Follow-up | Warmth | Reason | Trigger | Campaign | Added |
|---------|---------|-----------|--------|--------|---------|----------|-------|
| {name} | {co} | 2026-07-01 | hot | "After our Series B closes" | Funding | Q1 Cold | 2026-03-15 |
| {name} | {co} | 2026-09-01 | warm | "Contract ends in Sept" | Contract renewal | Q1 Cold | 2026-03-20 |
| {name} | {co} | 2026-06-15 | lukewarm | "Not a priority right now" | Hiring signal | Signal Q1 | 2026-03-22 |
```

### --scan (auto-detect nurture candidates)
5. Scan reply logs for nurture-eligible replies:
   - Look for: "not now", "maybe later", "next quarter", "after [event]", "circle back", "reach out in", "contract until", "budget in [month]", "timing isn't right", "revisit"
   - Exclude: hard "no", unsubscribes, wrong person, competitors
   - For each candidate, extract the follow-up date from their language:
     - "Next quarter" → 3 months from reply date
     - "After [month]" → first week of that month
     - "In a few months" → 90 days
     - "Next year" → January 1
     - No specific time → 90 days default

6. Display found candidates:
```
  Nurture candidates found: {n}

  {name} at {company}
    Reply: "Love the concept but we're locked in with {competitor} until September"
    Suggested follow-up: 2026-08-15 (2 weeks before contract end)
    Warmth: warm
    Trigger: Contract renewal
    >> Add to nurture? (y/n)

  {name} at {company}
    Reply: "Interesting but not a priority this quarter. Maybe Q3?"
    Suggested follow-up: 2026-07-01
    Warmth: lukewarm
    Trigger: Budget cycle
    >> Add to nurture? (y/n)
```

### --due (check what's due)
7. Check nurture list for contacts approaching follow-up date:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  NURTURE — Due for follow-up                                 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  Overdue
    !! {name} at {company} — was due 2026-03-01
       Reason: "After our funding round" — check: did they raise?
       >> Research and follow up

  Due this week
    >> {name} at {company} — due 2026-03-10
       Reason: "Circle back in Q1"
       Warmth: warm
       >> Draft follow-up

  Coming up (next 30 days)
    .. {name} at {company} — due 2026-04-01
       Reason: "Contract ends March"
       Trigger: watch for contract renewal signals
```

## Follow-up drafting
8. When a contact is due, draft a follow-up:
   - Reference the original conversation (not a cold restart)
   - Acknowledge the timing: "You mentioned [reason] back in [month]"
   - Add any new value: new feature, case study, relevant news about their company
   - Keep it short — they already know who you are
   - Apply LEARNINGS.md for this persona type

9. Display draft for approval:
```
  Follow-up for {name}:

  Subject: {subject — often a reply to original thread}

  {first_name} — you mentioned back in March that you were
  waiting for your Series B to close before looking at this.

  Saw the round closed last month — congrats. [New thing]
  since we last talked: {relevant update}.

  Still make sense to pick this back up?

  >> Approve / Edit / Snooze (new date) / Remove
```

## Signal integration
10. Cross-reference nurture list with signal scan:
    - If a nurtured contact's trigger fires (funding, hiring, contract end), surface immediately:
      "!! {name} is on your nurture list with trigger 'funding' — they just raised Series B. Follow up now."
    - This runs automatically during `/gtm:signals` and `/gtm:today`

## Pipeline integration
11. Nurtured contacts sit in a "Nurturing" stage in PIPELINE.md
12. When followed up → move to "Re-contacted"
13. Track nurture conversion rate in LEARNINGS.md
</process>
</content>
