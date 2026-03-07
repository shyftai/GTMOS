# Command: Re-Engagement Campaign

## Trigger
"Re-engage [segment]" or "Create a re-engagement campaign"

## What it is
A campaign type for reaching back out to contacts who went through a previous sequence and didn't convert. Different rules than cold outreach — these people have seen your name before.

## Eligibility rules
- Minimum 60 days since last touch (90 preferred)
- Contact did NOT unsubscribe, mark as spam, or reply negatively
- Contact is NOT in SUPPRESSION.md
- Contact must still match current ICP (re-validate if ICP has changed)
- A new angle, signal, or reason to reach out must exist

## Steps
1. Load SUPPRESSION.md, ICP.md, PERSONA.md from workspace
2. Pull the target segment — contacts from campaign [X] who completed the sequence with no reply
3. Filter out:
   - Anyone who replied (positive, negative, or objection) — they already engaged
   - Anyone now in SUPPRESSION.md
   - Anyone whose company no longer matches ICP
4. Check for new signals on remaining contacts:
   - Job change? New role?
   - Company funding, hiring, or news?
   - New product launch or expansion?
5. Choose a re-engagement angle (must be DIFFERENT from the original campaign):
   - **New signal:** "Noticed [signal] — thought this might be relevant now"
   - **New offer:** "We just shipped [feature/product] — changes the math on [pain]"
   - **Value add:** Share a benchmark, report, or insight without asking for anything
   - **Honest check-in:** "Circling back on this — has anything changed on the [pain] front?"
6. Draft a 2-touch sequence (not 4 — these people already got a full sequence):
   - Touch 1: Re-engagement angle + soft CTA
   - Touch 2 (5-7 days later): Brief follow-up or breakup
7. Apply cold-email-skill.md writing principles — but acknowledge the previous touchpoint
8. Subject line: reply to original thread if possible (Re:), or new 2-4 word subject
9. Validate against all rules, present for approval
10. Track separately in PIPELINE.md — tag as "re-engagement" for attribution
