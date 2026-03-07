# Command: Account-Based Multi-Threading

## Trigger
"Multi-thread [company]" or "Run account-based approach for [company]"

## When to use
When targeting a high-value account with multiple stakeholders. Instead of reaching one person, reach 2-4 people at the same company with role-appropriate messaging and coordinated timing.

## Steps

### 1. Account selection and qualification

Before multi-threading, confirm the account is worth the investment:

**ICP fit check:**
- Load ICP.md — does the company match on industry, size, revenue, tech stack?
- Score the account (0-100) using lead scoring model
- Minimum threshold for ABM: score >= 70

**Account research (use available tools):**

| Tool | What to look for |
|------|-----------------|
| Crispy / Sales Nav | Company profile, headcount, growth rate, recent hires, org structure |
| Exa | Recent news, funding, product launches, market positioning |
| Firecrawl | Website: pricing page, team page, tech stack, job postings |
| Apollo | Firmographics, tech stack, funding data |
| Crunchbase | Funding rounds, investors, acquisitions |
| Ocean.io | Revenue, web traffic, department sizes, headcount growth |

**Output:** Account brief with company overview, why they fit ICP, key signals, and estimated deal value.

### 2. Map the buying committee

Identify 2-4 contacts by role using Crispy/Sales Navigator people search filtered to the target company:

| Priority | Role | Messaging angle | Channel |
|----------|------|----------------|---------|
| 1 | **Champion** (Director/Head of) | Day-to-day pain, team impact, implementation ease | Email first, then LinkedIn |
| 2 | **Decision maker** (VP/C-suite) | Business outcome, ROI, strategic fit | Email (ultra-brief) |
| 3 | **Influencer** (Manager/IC) | Workflow improvement, time saved, ease of use | Email or LinkedIn |
| 4 | **Blocker** (Finance/Legal/IT) | Only if needed — security, compliance, cost justification | Email only |

**For each contact, enrich:**
- Run through email finding waterfall (Apollo → Icypeas → Prospeo → Dropcontact → FindyMail)
- Verify emails before sending
- Get LinkedIn profile URL for LinkedIn touches
- Research their background: posts, articles, mutual connections, career history

### 3. Audience warming (optional)

If ad platforms or HubSpot ABM features are available, you can warm accounts before outreach. This is optional — many successful ABM campaigns run without it.

**Option A: HubSpot ABM (if HubSpot is active)**
- Check if the workspace uses HubSpot with ABM features (Marketing Hub Professional+)
- If so, add target companies to HubSpot's built-in Target Accounts list
- HubSpot handles: company-level tracking, buying role assignment, account overview dashboard, and LinkedIn Ads audience sync natively
- This is often the simplest path — no additional API setup needed

**Option B: Ad platform audience sync**
- If ad platforms are connected (LinkedIn Ads, Meta, Google Ads), run `/gtm:audience-sync` to push the account list as a matched audience
- Start running brand awareness ads 7-14 days before cold outreach
- Ad content: thought leadership, industry insights — NOT product ads
- See `commands/audience-sync.md` for details

**Option C: No warming — direct outreach**
- Perfectly fine for most ABM campaigns. Skip to step 4.

### 4. Sequence design per role

Each contact gets a tailored sequence — same campaign angle, different framing per role.

#### Champion (Primary — start here)
- **Touches:** 3-4
- **Word count:** 55-75 words per touch
- **Angle:** Operational pain, team efficiency, implementation
- **CTA:** Soft interest ("Worth exploring?" / "Relevant to what you're dealing with?")
- **Channel:** Email touch 1-2, LinkedIn connection day 3, email touch 3-4

#### Decision Maker
- **Touches:** 2-3
- **Word count:** 40-55 words per touch (ultra-brief)
- **Angle:** Business outcome, revenue impact, strategic advantage
- **CTA:** Direct but low-pressure ("Make sense to chat?")
- **Channel:** Email only (unless LinkedIn connection already exists)

#### Influencer
- **Touches:** 2-3
- **Word count:** 50-70 words per touch
- **Angle:** Workflow-level impact, daily friction, peer comparison
- **CTA:** Value-first ("Happy to share what we're seeing")
- **Channel:** Email or LinkedIn DM

**Copy rules (all roles):**
- Never copy-paste the same email to multiple people at the same company
- Reference specific company signals (hiring, funding, product launches)
- Use peer voice — read like a colleague, not a marketer
- Load snippet-library.md and swipe-file.md Example 8 (ABM) for reference
- Run `/gtm:validate-copy` against all sequences before sending

### 5. Timing and coordination

**Stagger rules:**
```
  Day 0:   Champion — Touch 1 (email)
  Day 2:   Champion — LinkedIn connection request
  Day 3:   Decision Maker — Touch 1 (email)
  Day 4:   Champion — Touch 2 (email, different angle)
  Day 6:   Influencer — Touch 1 (email or LinkedIn)
  Day 7:   Decision Maker — Touch 2 (email)
  Day 8:   Champion — Touch 3 (value add, no ask)
  Day 10:  Influencer — Touch 2 (email)
  Day 12:  Decision Maker — Touch 3 (breakup)
  Day 14:  Champion — Touch 4 (breakup)
```

**Never:**
- Contact all people at the same company on the same day
- Send more than 2 touches to the same company on the same day (across all contacts)
- Start with the decision maker (always warm the champion first)

**If champion replies positively:**
- Ask for an internal intro to the decision maker before reaching them cold
- Pause the decision maker's cold sequence
- Adjust influencer messaging to reference the champion's engagement

### 6. Cross-reference rules

**Pause triggers (pause ALL threads at this company):**
- Any contact replies (positive or negative)
- One person refers you to someone else at the company
- A meeting is booked with any contact
- Contact marks as unsubscribed

**Resume triggers:**
- Positive reply from one contact — adjust other threads accordingly
- Negative reply from one contact — continue other threads after 3-day pause
- Referral — create new thread for referred contact, stop original threads

**Log everything:**
- All thread activity in campaign `logs/decisions.md`
- Which role converted in PIPELINE.md for future learning
- Cross-reference events (who replied, what happened to other threads)

### 7. Validate against suppression
- Check all contacts against SUPPRESSION.md before any outreach
- Check sending calendar for country-specific holidays
- Verify domain health before sending

### 8. Present multi-thread plan for approval

Display the complete plan before executing:

```
  ┌─ ABM PLAN: {Company Name} ────────────────────┐
  │                                                 │
  │  Account score: 85/100                          │
  │  Est. deal value: $XX,000                       │
  │  Signals: Series B funding, 3 new AE hires      │
  │                                                 │
  │  Buying committee:                              │
  │    1. Jane Smith — VP Sales (Decision Maker)    │
  │       → 3 email touches, business outcome angle │
  │    2. Tom Jones — Head of RevOps (Champion)     │
  │       → 4 touches (email+LinkedIn), ops pain    │
  │    3. Alex Chen — Sales Ops Mgr (Influencer)    │
  │       → 2 email touches, workflow angle         │
  │                                                 │
  │  Audience warming: optional (HubSpot ABM / ads)  │
  │  Timeline: 14-day staggered sequence            │
  │  Est. cost: ~$XX enrichment                     │
  │                                                 │
  └─────────────────────────────────────────────────┘
  >> Approve and execute? (y/n)
```

### 9. Track and monitor

After execution, track at the account level (not just contact level):

| Metric | How to track |
|--------|-------------|
| Account engagement score | Sum of opens, clicks, replies across all contacts |
| Thread conversion | Which role replied first and led to a meeting |
| Time to meeting | Days from first touch to meeting booked |
| Multi-thread lift | Compare ABM reply rate vs single-thread cold outbound |
| Ad influence | If ads were running: did the contact engage before replying? |

Update PIPELINE.md with account-level deal tracking.

---

## Scaling ABM

### Tier 1: Full ABM (1-10 accounts)
- 3-4 contacts per account
- Deep research per account
- Custom copy per contact
- Ad warming (LinkedIn Ads + Meta)
- LinkedIn connection requests
- Full cross-reference coordination

### Tier 2: ABM Lite (10-50 accounts)
- 2-3 contacts per account
- Template-based copy with account-specific personalization
- Ad warming (LinkedIn Ads company list only)
- Email only (no LinkedIn touches)
- Basic cross-reference (pause on reply)

### Tier 3: Programmatic ABM (50-200 accounts)
- 1-2 contacts per account (champion + decision maker)
- Segment-level personalization (by industry/size, not per account)
- Ad warming via company list upload (batch)
- Email only
- Auto-pause on reply

Choose tier based on deal value and available bandwidth.
