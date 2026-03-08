---
name: gtm:prep-meeting
description: Prepare a briefing sheet before a booked meeting
argument-hint: "<workspace-name> <contact-email-or-name>"
---
<objective>
Generate a complete meeting prep briefing for a booked call. Pull contact history, company research, deal context, talking points, and objection prep. Everything the person running the meeting needs in one doc.

Workspace and contact: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // MEETING PREP >>`
2. Parse contact identifier from $ARGUMENTS

## Contact intelligence
3. Pull full contact history (same logic as `/gtm:contact`):
   - All campaign touchpoints, replies, signals
   - CRM data (deal stage, value, owner, notes)
   - LinkedIn profile data (if Crispy connected)
   - Website visits (if visitor ID connected)
   - Email thread that led to the meeting

4. Research the contact and company:

**Person research (Crispy + Exa):**
- Current role, tenure, career path
- Recent LinkedIn activity (posts, comments, shares)
- Mutual connections
- Content they've engaged with

**Company research (Exa + Firecrawl + Apollo):**
- What the company does (in plain language)
- Size, funding stage, growth trajectory
- Recent news (funding, launches, hires, press)
- Tech stack (if relevant to your product)
- Competitors they face
- Job posts (what they're investing in)

5. Load workspace context:
- ICP.md — how well does this company fit?
- PERSONA.md — which persona is this person?
- BRIEFING.md — which angles are strongest for this persona?
- COMPETITORS.md — are they using a competitor?
- LEARNINGS.md — what's worked with similar personas/companies?

## Meeting briefing
6. Generate the prep doc:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  MEETING PREP — {Full Name}                                  ┃
┃  {Title} at {Company}                                        ┃
┃  {Date/time if known}                                        ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  About them
    Role: {title}, {tenure} at {company}
    Reports to: {if known}
    LinkedIn: {URL}
    Previous role: {if relevant}

  About the company
    {1-2 sentence description}
    Size: {employees}  |  Stage: {funding}  |  Industry: {industry}
    Recent: {most relevant news — funding, hiring, launch}

  How we got here
    Signal: {what triggered the outreach}
    Campaign: {which campaign}
    Touch that converted: {which email/message they replied to}
    Their reply: "{exact words}"
    Website visits: {pages visited, if any}

  ICP fit
    Score: {n}/100
    Fit: {strong/moderate/weak} — {why}

  ──────────────────────────────────────────────────────────

  Talking points
    1. {Opening — reference their reply or signal}
    2. {Pain point most likely for this persona — from PERSONA.md}
    3. {Proof point that matches their company profile}
    4. {Discovery question to uncover their situation}
    5. {Second discovery question — dig deeper}

  Their likely pain points (from learnings + persona)
    - {pain point 1 — why it matters to this role}
    - {pain point 2}
    - {pain point 3}

  Objection prep
    If "{common objection 1}":
      → {response from LEARNINGS.md or snippet library}
    If "{common objection 2}":
      → {response}
    If "we use {competitor}":
      → {differentiator from COMPETITORS.md}

  Questions to ask them
    - What's driving this conversation now?
    - What have you tried before?
    - Who else is involved in this decision?
    - What does success look like?
    - What's your timeline?

  ──────────────────────────────────────────────────────────

  Do NOT mention
    - That you saw them visit your website
    - Specific signal data ("I saw you raised funding")
    - Previous campaign touches ("I emailed you 3 times")
    - Competitor weaknesses unprompted

  Next steps to propose
    - {Relevant next step based on deal stage}
    - {Fallback if not ready to move forward}
```

7. Save to workspace context/meeting-prep/{contact-name}-{date}.md
8. If team mode and handoff needed, suggest: `/gtm:handoff`

9. Display:
```
  Meeting prep saved.

  >> Print: context/meeting-prep/{file}
  >> Handoff to AE: /gtm:handoff {ws} {contact}
  >> After meeting: /gtm:post-meeting {ws}
```
</process>
</content>
