---
name: gtm:deep-dive
description: Data deep-dive — analyze CRM, campaigns, and transcripts to build ICP from evidence
argument-hint: "<workspace-name>"
---
<objective>
Pull data from CRM and existing outbound campaigns, analyze transcripts and meeting notes, and build an evidence-based ICP, persona, and briefing. This replaces guesswork with data.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
@./.claude/gtmos/references/csv-format.md
@./.claude/gtmos/references/lead-scoring.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // DEEP DIVE >>`

2. Ask what data sources are available:
```
  What can we pull from?

  CRM data:
  [ ] HubSpot — contacts, deals, pipeline, won/lost
  [ ] Attio — contacts, deals, pipeline
  [ ] Salesforce — contacts, opportunities
  [ ] Pipedrive — contacts, deals

  Outbound campaigns:
  [ ] Instantly — campaign analytics, reply data
  [ ] Lemlist — campaign stats, activities
  [ ] Smartlead — campaign statistics

  Manual data:
  [ ] Call transcripts / meeting notes (paste or file path)
  [ ] Sales call recordings (transcribed)
  [ ] Customer interview notes
  [ ] Existing ICP docs or personas from other tools
  [ ] Competitor analysis docs

  >> Which do you have? (list all that apply)
```

## Phase 1 — CRM deep dive

3. Pull CRM data via API:

**Won deals analysis:**
- Pull all closed-won deals from last 12 months
- For each: company size, industry, title of buyer, deal size, time to close, source
- Map patterns: which company profiles close? which titles buy? average deal cycle?

**Lost deals analysis:**
- Pull all closed-lost deals
- For each: company size, industry, title, stage lost at, reason (if logged)
- Map patterns: where do deals die? which profiles don't convert?

**Pipeline analysis:**
- Current pipeline by stage
- Conversion rates between stages
- Average time per stage
- Stuck deals — in same stage for 2x average

**Contact analysis:**
- Which contact titles appear most in won deals?
- Which industries appear most?
- What company sizes close best?
- Are there patterns in geography, tech stack, or funding stage?

4. Display CRM findings:
```
  ┌─ CRM DEEP DIVE ─────────────────────────────┐
  │                                               │
  │  Won deals analyzed:     {n}                  │
  │  Lost deals analyzed:    {n}                  │
  │  Time period:            {start} — {end}      │
  │                                               │
  │  Best-fit company profile:                    │
  │    Industry: {top industries}                 │
  │    Size: {size range with best win rate}      │
  │    Stage: {funding/growth stage}              │
  │    Avg deal: ${amount}                        │
  │    Avg cycle: {days}                          │
  │                                               │
  │  Buyer persona (from won deals):              │
  │    Title: {most common titles}                │
  │    Seniority: {level}                         │
  │    Department: {dept}                         │
  │                                               │
  │  Top loss reasons:                            │
  │    1. {reason} ({pct}%)                       │
  │    2. {reason} ({pct}%)                       │
  │    3. {reason} ({pct}%)                       │
  │                                               │
  └───────────────────────────────────────────────┘
```

## Phase 2 — Outbound campaign analysis

5. Pull campaign data via API:

**Performance analysis:**
- Pull all campaigns from last 6 months
- For each: contacts shipped, open rate, reply rate, positive rate, meetings
- Identify best and worst performing campaigns

**Reply analysis:**
- Pull reply data — what did positive replies say?
- What objections came up most?
- Which subject lines and touches performed best?
- Which contact titles replied most?

**List quality analysis:**
- What was the bounce rate per campaign?
- Which list sources produced the best results?
- Which ICP segments converted best?

6. Display outbound findings:
```
  ┌─ OUTBOUND DEEP DIVE ────────────────────────┐
  │                                               │
  │  Campaigns analyzed:     {n}                  │
  │  Total contacts sent:    {n}                  │
  │                                               │
  │  Best campaign:          {name}               │
  │    Reply rate: {pct}%    Meetings: {n}        │
  │    What worked: {insight}                     │
  │                                               │
  │  Worst campaign:         {name}               │
  │    Reply rate: {pct}%    Issue: {insight}      │
  │                                               │
  │  Best performing:                             │
  │    Title: {title with highest reply rate}     │
  │    Industry: {industry}                       │
  │    Subject: "{best subject line}"             │
  │    Touch: Touch {n} converts most             │
  │                                               │
  │  Top objections:                              │
  │    1. {objection} ({count} times)             │
  │    2. {objection} ({count} times)             │
  │                                               │
  └───────────────────────────────────────────────┘
```

## Phase 3 — Transcript analysis

7. For each transcript/meeting note provided:
   - Extract: who was on the call, their title, company, industry
   - Extract: pain points mentioned (in their words)
   - Extract: buying triggers — what made them take the call?
   - Extract: objections raised
   - Extract: competitor mentions
   - Extract: language and terminology they use (exact phrases)
   - Extract: what they said about their current situation
   - Extract: what outcome they're looking for

8. Cross-reference transcript insights with CRM and campaign data:
   - Do the pain points match what CRM data suggests?
   - Are the titles that take calls the same ones that close?
   - Do the objections from transcripts match CRM loss reasons?
   - Is the language prospects use different from the copy we've been sending?

9. Display transcript findings:
```
  ┌─ TRANSCRIPT ANALYSIS ───────────────────────┐
  │                                               │
  │  Transcripts analyzed:   {n}                  │
  │                                               │
  │  Pain points (in their words):                │
  │    - "{exact quote}" ({n} mentions)           │
  │    - "{exact quote}" ({n} mentions)           │
  │                                               │
  │  Buying triggers:                             │
  │    - {trigger} ({n} mentions)                 │
  │                                               │
  │  Language they use vs. language we use:       │
  │    They say: "{their phrase}"                 │
  │    We say:   "{our phrase}"                   │
  │    → Use their language in copy               │
  │                                               │
  │  Competitors mentioned:                       │
  │    - {competitor} ({n} times, context: {x})   │
  │                                               │
  └───────────────────────────────────────────────┘
```

## Phase 4 — Synthesis and ICP generation

10. Combine all three data sources into a unified picture:
    - Company profile (from CRM + campaigns)
    - Buyer persona (from CRM + transcripts)
    - Pain points (from transcripts, validated by campaign data)
    - Buying triggers (from transcripts + CRM deal timing)
    - Objection map (from transcripts + campaign replies + CRM loss reasons)
    - Language (from transcripts — use their words, not yours)
    - Competitor positioning (from transcripts + campaign replies)

11. Generate populated drafts of:
    - ICP.md — with data-backed criteria and scoring
    - PERSONA.md — with real titles, real objections, real language
    - COMPETITORS.md — with mentioned competitors and positioning
    - Draft BRIEFING.md angles — based on what resonated in past campaigns

12. Present each file for approval:
```
  ┌─ DEEP DIVE COMPLETE ────────────────────────┐
  │                                               │
  │  Data sources used:                           │
  │    [x] CRM: {n} deals analyzed                │
  │    [x] Outbound: {n} campaigns analyzed       │
  │    [x] Transcripts: {n} analyzed              │
  │                                               │
  │  Generated:                                   │
  │    [x] ICP.md — data-backed company profile   │
  │    [x] PERSONA.md — evidence-based personas   │
  │    [x] COMPETITORS.md — from real mentions    │
  │    [x] Draft angles for BRIEFING.md           │
  │                                               │
  │  Confidence: HIGH / MEDIUM / LOW              │
  │  (based on data volume and consistency)       │
  │                                               │
  └───────────────────────────────────────────────┘

  >> Review each file? (y/n)
```

13. After approval, suggest: `/gtm:new-campaign` to build the first campaign from the data-backed ICP.
</process>
