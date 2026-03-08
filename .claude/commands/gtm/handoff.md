---
name: gtm:handoff
description: SDR → AE handoff with full context transfer
argument-hint: "<workspace-name> <contact-email-or-name>"
---
<objective>
Create a structured handoff document when transferring a booked meeting from SDR to AE (or any role transition). Captures everything the next person needs so the prospect never has to repeat themselves.

Workspace and contact: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // HANDOFF >>`
2. Parse contact identifier from $ARGUMENTS

## Gather context
3. Pull all available data:
   - Contact history (campaigns, touches, replies)
   - CRM record (deal stage, value, notes)
   - Meeting prep doc if it exists (context/meeting-prep/)
   - Signal that triggered the outreach
   - Reply text and classification
   - Website visit data
   - LinkedIn interaction history
   - Any previous meetings or transcripts (Fireflies)

## Build handoff document
4. Generate the handoff:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  HANDOFF — {Full Name} → {AE/Owner name if known}            ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  Contact
    {Full Name} — {Title} at {Company}
    Email: {email}     Phone: {if available}
    LinkedIn: {URL}
    Location: {timezone}

  Company snapshot
    {What they do} · {size} employees · {industry}
    Stage: {funding/growth}
    Tech stack: {if known}
    Recent: {key news}

  ──────────────────────────────────────────────────────────

  How we got here

    Source: {campaign name} ({campaign type})
    Signal: {what triggered the outreach — funding, hiring, website visit, etc.}
    Channel: {email / LinkedIn / multi-channel}

    Outreach timeline:
      {date}  Touch 1 sent — {subject line}
      {date}  Opened
      {date}  Touch 2 sent — {subject line}
      {date}  Replied (positive)
      {date}  Meeting booked for {date/time}

    Their exact reply:
    "{full reply text}"

  ──────────────────────────────────────────────────────────

  What we know

    Why they took the meeting:
      {Inferred from reply + signal — e.g. "Recently raised Series B,
       hiring SDRs, replied to pain point about manual prospecting"}

    Pain points (likely):
      - {from persona + their reply language}
      - {from signal context}

    Buying stage:
      {Early exploration / Active evaluation / Comparing solutions}

    Decision makers:
      - {This person's role in the decision}
      - {Other stakeholders if known from research}

    Competitor context:
      {Using competitor? Evaluating alternatives? Mentioned in reply?}

    Budget signals:
      {Funding stage, company size, hiring patterns — what suggests budget}

  ──────────────────────────────────────────────────────────

  Recommended approach

    Open with: {Reference their reply — they said "{X}", start there}
    Avoid: {Don't re-pitch what the email already covered}
    Key discovery: {What do we still need to learn?}
    Likely objection: {Most common for this persona — with response}
    Propose as next step: {Demo / trial / technical call / proposal}

  ──────────────────────────────────────────────────────────

  Relevant learnings
    {Top 3 learnings from LEARNINGS.md that apply to this persona/company type}

  Meeting prep (if exists):
    See: context/meeting-prep/{file}
```

5. Save to context/handoffs/{contact-name}-{date}.md

## Distribution
6. If team mode (Supabase):
   - Log handoff in activity_feed
   - If deal exists in CRM, attach handoff notes
   - Update pipeline_contacts owner to AE

7. If Slack connected:
   - Offer to send handoff summary to a Slack channel or DM
   - "Send this handoff to the AE via Slack?"

8. Update CRM:
   - If Attio/HubSpot connected, add handoff notes to contact record
   - Update deal owner if AE is specified

9. Display:
```
  Handoff saved: context/handoffs/{file}

  >> Send to Slack: yes/no
  >> Meeting prep: /gtm:prep-meeting {ws} {contact}
  >> After meeting: /gtm:post-meeting {ws}
```
</process>
</content>
