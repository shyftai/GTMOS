---
name: gtm:warm-intro
description: Find mutual connections for warm introductions before cold outreach
argument-hint: "<workspace-name> [campaign-name | contact-email]"
---
<objective>
Before cold emailing a prospect, check if you have a mutual connection who could make a warm introduction. Warm intros convert 5-10x better than cold outreach. Uses LinkedIn/Crispy to find connection paths.

Workspace and target: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // WARM INTROS >>`
2. Determine mode:
   - If campaign name → scan entire validated list for warm paths
   - If contact email → check single contact

## Single contact mode
3. For a single contact:
   a. Look up on LinkedIn via Crispy — get their connections, mutual connections
   b. Check: do you share any 1st-degree connections?
   c. Check: do you share any 2nd-degree connections through relevant people?
   d. Check: have they engaged with any content from people in your network?
   e. Check: are they in any common LinkedIn groups?
   f. Check CRM — have any of your closed-won contacts worked at their company before?

4. Display warm path:
```
  ┌─ WARM PATH — {Contact Name} ────────────────────┐
  │                                                    │
  │  1st degree mutual: {name} — {how you know them}   │
  │    Connection strength: strong / moderate / weak    │
  │    Last interaction: {date}                        │
  │    Ask: "{name}, could you intro me to {contact}   │
  │          at {company}? We help with {value prop}."  │
  │                                                    │
  │  2nd degree path: You → {A} → {B} → {Contact}     │
  │    Feasibility: medium                             │
  │                                                    │
  │  No warm path? Use cold outreach with              │
  │  personalization: /gtm:personalize                 │
  │                                                    │
  └────────────────────────────────────────────────────┘
```

## Campaign mode (batch)
5. For an entire list:
   a. Scan all contacts on the validated list via Crispy
   b. Categorize by connection type:

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  WARM INTRO SCAN — {campaign}                                ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                              ┃
┃  Total contacts: {n}                                         ┃
┃                                                              ┃
┃  Warm paths found:                                           ┃
┃    1st degree mutual:    {n} contacts ({pct}%)               ┃
┃    2nd degree path:      {n} contacts ({pct}%)               ┃
┃    Same company alumni:  {n} contacts ({pct}%)               ┃
┃    No warm path:         {n} contacts ({pct}%)               ┃
┃                                                              ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

6. Recommend outreach strategy:
```
  Recommended approach:

  Tier 1 — Warm intro ({n} contacts)
    Request introductions from mutual connections first.
    These contacts should NOT go into the cold sequence.
    >> Draft intro requests? (y/n)

  Tier 2 — Warm reference ({n} contacts)
    No direct intro possible, but you can reference mutual
    connections or shared groups in your opener.
    >> Add to cold sequence with warm reference personalization

  Tier 3 — Cold ({n} contacts)
    No warm path found. Standard cold outreach.
    >> Personalize with research: /gtm:personalize
```

## Intro request drafting
7. For Tier 1 contacts, draft intro requests:
```
  Intro request to: {mutual connection name}

  Hey {name} — I noticed you're connected to {contact} at
  {company}. We're helping {type of companies} with {value prop}
  and {company} looks like a strong fit.

  Would you be open to making an intro? Happy to send you a
  blurb you can forward.

  ---
  Forwardable blurb:

  "{mutual} suggested I reach out — {1-sentence value prop
  relevant to contact's role}. Would love 15 minutes to
  see if it's relevant for {company}."

  >> Send via LinkedIn (Crispy) / Draft email / Skip
```

8. Track warm intro results:
   - Intro requested → Intro made → Meeting booked → Deal
   - Compare conversion rate vs cold outreach
   - Log in LEARNINGS.md

9. Update ROADMAP.md if warm intros surface new campaign ideas
</process>
</content>
