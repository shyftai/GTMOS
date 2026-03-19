# Command: Post-Meeting Workflow

## Trigger
"Run post-meeting workflow for [contact]" or after a meeting is logged in PIPELINE.md

## Steps
1. Load workspace context — BRIEFING.md, PERSONA.md, TOV.md, PIPELINE.md
2. Confirm meeting details: who was on the call, what was discussed, outcome
3. Generate the following:

### Pre-call research brief (if meeting is upcoming)
- Company overview from context/research/ or ICP.md
- Relevant signals (funding, hiring, news) from signal tools
- Pain points mapped from PERSONA.md
- Competitor intel from COMPETITORS.md (are they using an alternative?)
- Suggested discovery questions based on the campaign angle

### Post-call actions (after meeting is completed)
4. Log the touch that converted — ask the user which touch drove the reply that booked this meeting. Then write to LEARNINGS.md:
   - Which touch number (e.g. Touch 2)
   - Subject line used
   - Opening line used
   - Persona type targeted (from PERSONA.md)
   - Campaign angle
   - What the contact said in their positive reply (verbatim if possible)
   - Tag: `Meeting booked — {campaign} — {date}`
   - Why it worked (user's interpretation, if they have one)

   If the user doesn't know which touch, ask them to check the sending tool thread. This is the highest-signal learning in the system — do not skip it. Save to LEARNINGS.md under a new `## Wins` entry (or append to existing) with the format:

   ```
   ### Meeting booked — {contact} @ {company} — {date}
   **Campaign:** {campaign}
   **Touch:** {touch number} of {total}
   **Subject:** {subject line}
   **Opening:** {opening line}
   **Persona:** {persona type}
   **Angle:** {campaign angle}
   **Their reply:** "{verbatim reply snippet}"
   **Why it worked:** {user interpretation}
   ```

5. Draft a follow-up email:
   - Reference something specific from the conversation
   - Recap any agreed next steps
   - Include relevant resource if discussed (case study, pricing, demo link)
   - Apply TOV.md — keep it brief and human
   - Max 100 words
6. Update CRM pipeline stage:
   - Move contact to appropriate stage (Qualified / Proposal Sent / etc.)
   - Log meeting notes
   - Tag with campaign attribution
7. If next steps were agreed:
   - Create follow-up task with date
   - Draft the follow-up content (proposal outline, case study, intro email)
8. If deal is dead:
   - Log reason in lost deal analysis (PIPELINE.md)
   - Update COMPETITORS.md if competitor was mentioned
   - Move to Closed — Lost
9. Log all actions in campaign logs/decisions.md
