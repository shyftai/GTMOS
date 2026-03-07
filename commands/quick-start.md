# Command: Quick Start Onboarding

## Trigger
"Quick start" or "Fast onboarding" or `/gtm:onboard <name> --quick`

## What it is
A streamlined 5-block onboarding that gets a workspace ready to run in minutes. Skips the deep-dive blocks (infrastructure, compliance, pipeline, etc.) and fills them later when needed.

## Blocks (5 instead of 14)

### Block 1 — The offer (30 seconds)
- What do you sell?
- What specific offer are we leading with in outreach?

### Block 2 — The target (60 seconds)
- Who buys this? (industry, company size, geography)
- What job titles do we target?
- Who is NOT a fit?

### Block 3 — The pain (30 seconds)
- What pain does this solve?
- What triggers a buying decision?

### Block 4 — The angle (60 seconds)
- What is the campaign hook? What insight or tension leads the outreach?
- What proof points exist? (data, case studies, customer names)
- What is the CTA? (e.g. "Worth a chat?" not "Book a demo")

### Block 5 — The voice (30 seconds)
- Describe your brand voice in 3 words
- Anything you should NEVER say?
- Formal or casual?

## After quick start
Write answers into:
- ICP.md (from blocks 2-3)
- PERSONA.md (from block 2)
- TOV.md (from block 5 — populate channel rules with cold-email-skill defaults)
- workspace.config.md

Leave these as templates with defaults — fill them in later:
- TOOLS.md (ask only: "Which sending tool? Instantly / Lemlist / Smartlead")
- COSTS.md (populate with default pricing from tool-pricing.md)
- INFRASTRUCTURE.md (template only)
- SUPPRESSION.md (empty — populated when first list ships)
- PIPELINE.md (template only)
- MULTICHANNEL.md (set based on whether they said email/LinkedIn/both)
- BOOKING.md (ask: "What is your calendar booking link?" — one question)
- COMPETITORS.md (ask: "Who are the top 1-2 competitors?" — one question)

## Flag what's missing
After quick start, display:
```
  ┌─ QUICK START COMPLETE ───────────────────────┐
  │                                                │
  │  [x] ICP          [x] Persona    [x] TOV      │
  │  [x] Sending tool [x] Booking    [x] Voice     │
  │                                                │
  │  Filled later (when needed):                   │
  │  [ ] Infrastructure (before first ship)         │
  │  [ ] Compliance (before first ship)             │
  │  [ ] Pipeline (when first meeting books)        │
  │  [ ] Detailed competitors (when mentioned)      │
  │  [ ] Lead scoring overrides                     │
  │                                                │
  └────────────────────────────────────────────────┘

  >> Next: /gtm:new-campaign {workspace} {name}
```

## Trigger full onboarding later
User can run `/gtm:onboard <name> --complete` at any time to go through the remaining blocks and fill in what's missing. The system checks which files are still templates and only asks about those.
