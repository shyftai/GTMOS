# Command: Campaign Health Check

## Trigger
"Run a health check on [campaign]" or "How is [campaign] performing?"

## Steps

### 1. Load context
- Active ICP.md, PERSONA.md, BRIEFING.md
- All latest sync data from sync/ subfolders
- Shipped list from lists/shipped/
- Approved copy from copy/approved/

### 2. Deliverability analysis
Pull from: Lemlist, Instantly, Smartlead sync data
- Bounce rate — flag if above 5%
- Spam complaint rate — flag if above 0.1%
- Unsubscribe rate — flag if above 2%
- Domain health signals — flag any warnings
Output: deliverability status (green / amber / red) with specific flags

### 3. Engagement analysis
Pull from: Lemlist, Instantly, Smartlead, Crispy sync data
- Open rate by touch — which touches are getting opened, which are dying
- Reply rate by touch — where in the sequence replies are coming from
- LinkedIn connection acceptance rate
- LinkedIn reply rate
- Best and worst performing subject lines
- Best and worst performing opening lines
Output: engagement breakdown with top and bottom performers highlighted

### 4. Pipeline analysis
Pull from: Attio sync data
- Contacts who replied — how many moved to meeting / deal stage
- Deal stage distribution for this campaign's contacts
- Average time from reply to meeting booked
- Won / lost / disqualified breakdown
Output: pipeline health with conversion rates at each stage

### 5. Persona performance
Cross-reference engagement data against shipped list fields:
- Which job titles are opening and replying?
- Which job titles are going cold?
- Which company sizes are converting?
- Which geographies or industries are over/underperforming vs ICP?
Output: persona performance matrix — who is engaging vs who is not

### 6. Pattern detection and suggestions
For each meaningful pattern found:
1. State the pattern with the data behind it
2. Identify which source of truth it affects (ICP / PERSONA / BRIEFING / RULES)
3. Propose the exact edit — show the current text and the suggested replacement
4. Ask: "Apply this change to [file]?"
5. Wait for explicit yes/no before writing anything
6. Log every accepted and declined suggestion in logs/decisions.md

Example suggestions:
- "Head of Operations is replying at 4x the rate of Operations Manager.
  Suggest updating ICP.md Score 3 criteria to prioritise 'Head of' seniority.
  Apply this change?"
- "Touch 3 has a 28% reply rate vs 4% for touch 1.
  The angle in touch 3 references [X]. Suggest promoting this to the primary hook in BRIEFING.md.
  Apply this change?"

### 7. Health check summary
Output a single summary with:
- Overall campaign status: on track / needs attention / critical
- Top 3 things working
- Top 3 things to fix
- Pending suggestions (those not yet accepted or declined)

Save full health check to: performance/health-check-[YYYY-MM-DD].md
