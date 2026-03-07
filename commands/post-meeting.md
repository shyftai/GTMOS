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
4. Draft a follow-up email:
   - Reference something specific from the conversation
   - Recap any agreed next steps
   - Include relevant resource if discussed (case study, pricing, demo link)
   - Apply TOV.md — keep it brief and human
   - Max 100 words
5. Update CRM pipeline stage:
   - Move contact to appropriate stage (Qualified / Proposal Sent / etc.)
   - Log meeting notes
   - Tag with campaign attribution
6. If next steps were agreed:
   - Create follow-up task with date
   - Draft the follow-up content (proposal outline, case study, intro email)
7. If deal is dead:
   - Log reason in lost deal analysis (PIPELINE.md)
   - Update COMPETITORS.md if competitor was mentioned
   - Move to Closed — Lost
8. Log all actions in campaign logs/decisions.md
