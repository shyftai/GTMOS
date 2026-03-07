# Command: ROI Attribution

## Trigger
"Show attribution for [campaign]" or "Compare ROI across campaigns" or triggered via `/gtm:attribution`

## What it does
Connects pipeline revenue back to specific campaigns, channels, and touches. Answers the question: "What's actually working and what should we double down on?"

## Attribution Models

Users choose their model in workspace config (`workspace.config.md`). Default: **first touch**.

### First touch (default)
Full credit goes to the campaign/channel that made first contact with the prospect. Simplest model — most common for cold outbound where the first touch created the opportunity from nothing.

### Last touch
Full credit goes to the last interaction before the meeting was booked or deal was created. Useful when multiple campaigns touched the same prospect and you want to know what finally converted them.

### Linear
Credit split evenly across all touches that interacted with the prospect before conversion. Useful for multi-channel campaigns where email and LinkedIn work together.

### Time decay
More credit to recent touches, less to older ones. Each touch gets a weighted share based on recency. Useful for long sales cycles where later touches are more likely to have influenced the decision.

## What Gets Attributed

Every won deal (and pipeline deal) gets tagged with:

| Dimension     | What it tracks                                                    |
|---------------|-------------------------------------------------------------------|
| Campaign      | Which campaign generated or influenced the deal                   |
| Channel       | Email vs LinkedIn vs multi-channel                                |
| Touch         | Which touch number in the sequence led to the positive reply      |
| Persona       | Which job title/role converted                                    |
| Signal        | Which buying signal was present at time of outreach (if any)      |
| Copy variant  | Which A/B test variant was sent (if applicable)                   |
| Source         | Which list source or enrichment tool found the contact            |

## Data Sources for Attribution

### Sending tools
- **Instantly**: campaign name, sequence step, reply timestamp, reply classification
- **Lemlist**: campaign name, step number, reply data, lead tags
- **Smartlead**: campaign identifier, touch number, reply status

### CRM
- **Attio**: deal stages, deal amounts, won/lost dates, associated contacts
- **HubSpot**: deal pipeline stages, amounts, close dates, contact associations

### LinkedIn
- **Crispy**: connection acceptance data, LinkedIn reply data, message step

### Campaign logs
- Reply classifications from GTM:OS reply handling
- Meeting notes from post-meeting debriefs
- Decision logs from campaign iterations

## Metrics Calculated

### Cost metrics
- **Cost per reply**: total campaign cost / positive replies
- **Cost per meeting**: total campaign cost / meetings booked
- **Cost per deal**: total campaign cost / deals won

### Revenue metrics
- **Revenue per campaign**: sum of won deal values attributed to campaign
- **ROI**: (revenue - total cost) / total cost, expressed as percentage

### Velocity metrics
- **Time to meeting**: days from first touch to meeting booked
- **Time to close**: days from first touch to deal won

### Conversion rates (funnel)
Each stage expressed as a percentage of the previous stage:
- Sent to reply
- Reply to positive reply
- Positive reply to meeting
- Meeting to proposal
- Proposal to won deal

## Attribution Report Display

### Single-campaign attribution

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
<< GTM:OS // ATTRIBUTION >>
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

┌─ CAMPAIGN ATTRIBUTION ───────────────────────────┐
│                                                   │
│  Campaign:       Q1 VP Eng outbound               │
│  Model:          First touch                      │
│  Period:         Jan 6 — Feb 28                   │
│                                                   │
│  Contacts shipped:    842                         │
│  Total cost:          $3,280                      │
│  Positive replies:    31                          │
│  Meetings booked:     12                          │
│  Deals created:       5                           │
│  Deals won:           2                           │
│  Revenue:             $74,000                     │
│                                                   │
│  ── Key Ratios ──                                 │
│  ROI:                 2,156%                      │
│  Cost per reply:      $105.81                     │
│  Cost per meeting:    $273.33                     │
│  Cost per deal:       $1,640.00                   │
│  Time to meeting:     9.3 days avg                │
│  Time to close:       34 days avg                 │
│                                                   │
│  ── Funnel ──                                     │
│  Sent → Reply:        7.8%                        │
│  Reply → Positive:    46.9%                       │
│  Positive → Meeting:  38.7%                       │
│  Meeting → Proposal:  41.7%                       │
│  Proposal → Won:      40.0%                       │
│                                                   │
│  ── Best Performers ──                            │
│  Best persona:        VP Engineering              │
│  Best channel:        Email                       │
│  Best touch:          Touch 3 (breakup)           │
│  Best signal:         Recent Series B funding     │
│  Best source:         Apollo + Clay enrichment    │
│                                                   │
└───────────────────────────────────────────────────┘
```

### Cross-campaign comparison

```
┌─ CROSS-CAMPAIGN ROI ─────────────────────────────────────────────────────────────────────┐
│                                                                                           │
│  Campaign              Contacts   Cost       Meetings  Deals   Revenue     ROI     $/Mtg  │
│  ─────────────────────────────────────────────────────────────────────────────────────────  │
│  Q1 VP Eng outbound       842    $3,280        12        2    $74,000   2,156%    $273    │
│  Q1 CTO signal-based      410    $1,640         8        3    $112,000  6,729%    $205    │
│  Q1 Head of Ops test       215    $860          2        0    $0        -100%     $430    │
│  ─────────────────────────────────────────────────────────────────────────────────────────  │
│  TOTAL                   1,467   $5,780        22        5    $186,000  3,118%    $263    │
│                                                                                           │
│  >> Top performer: Q1 CTO signal-based (6,729% ROI, $205/meeting)                        │
│  >> Underperformer: Q1 Head of Ops test (0 deals, $430/meeting)                           │
│                                                                                           │
└───────────────────────────────────────────────────────────────────────────────────────────┘
```

## Forward Feed to Auto-Refine

Attribution data feeds directly into the auto-refine loop. When patterns emerge:

### Persona-level ROI
If a persona consistently produces higher ROI across 2+ campaigns:
- Suggest increasing that persona's weight in ICP scoring
- Suggest allocating more list volume to that persona
- Flag in PERSONA.md as "proven converter"

### Signal-level ROI
If a buying signal correlates with higher deal values or faster close times:
- Suggest promoting that signal to a must-have in ICP.md
- Suggest building dedicated signal-based campaigns around it
- Feed into scan-signals.md for prioritized monitoring

### Channel-level ROI
If one channel consistently outperforms:
- Suggest shifting budget toward that channel
- If multi-channel outperforms single-channel, flag for future campaign planning

### Source-level ROI
If contacts from a specific source convert at higher rates:
- Suggest increasing volume from that source
- Suggest reducing spend on underperforming sources
- Update RULES.md with source quality rankings

### Touch-level ROI
If a specific touch number drives most conversions:
- Feed into copy strategy for next campaign
- Consider sequence length optimization
- Flag for write-sequence.md as anchor touch
