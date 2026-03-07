# Tools — [Workspace Name]

## Connection mode
All tools connect via direct API from Claude Code.
Reads are always auto-approved. Credit rules apply to writes only.

## Active tools

### Apollo
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Apollo: list exports, contact filters
- Pull from Apollo: enrichment updates, contact status, bounce flags
- Credit behaviour (writes): confirm-before-every-use
- Threshold:
- Notes:

### Clay
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Clay: enrichment jobs, waterfall configs
- Pull from Clay: enrichment results, field updates, scoring data
- Credit behaviour (writes): confirm-before-every-use
- Notes:

### Lemlist
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Lemlist: sequences, contacts, campaigns
- Pull from Lemlist: open rates, reply rates, bounce rates, unsubscribes, reply text
- Credit behaviour (writes): confirm-before-every-use
- Notes:

### Instantly
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Instantly: sequences, contacts, sending schedules
- Pull from Instantly: open rates, reply rates, bounce rates, deliverability data
- Credit behaviour (writes): confirm-before-every-use
- Notes:

### Smartlead
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Smartlead: sequences, contacts, sending schedules
- Pull from Smartlead: open rates, reply rates, bounce rates, deliverability data
- Credit behaviour (writes): confirm-before-every-use
- Notes:

### Crispy
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Crispy: connection requests, LinkedIn messages
- Pull from Crispy: connection acceptance rates, reply rates, reply content
- Credit behaviour (writes): confirm-before-every-use
- Notes:

### Attio
- Status: active / inactive
- Mode: bidirectional / read-only / write-only
- Push to Attio: contacts, deals, campaign tags, notes
- Pull from Attio: deal stage changes, reply status, contact updates, won/lost
- Credit behaviour (writes): auto-approved
- Notes:

### Signalbase
- Status: active / inactive
- Mode: read-only
- Pull from Signalbase: funding signals, hiring signals, company news, executive changes
- Used for: immediate action triggers during live campaigns
- Notes:

### Commonroom
- Status: active / inactive
- Mode: read-only
- Pull from Commonroom: community signals, social activity, intent signals
- Used for: immediate action triggers and ICP enrichment
- Notes:

## Default credit behaviour
confirm-before-every-use

## API key reference
All keys stored in .env at repo root:
- APOLLO_API_KEY
- CLAY_API_KEY
- LEMLIST_API_KEY
- INSTANTLY_API_KEY
- SMARTLEAD_API_KEY
- CRISPY_API_KEY
- ATTIO_API_KEY
- SIGNALBASE_API_KEY
- COMMONROOM_API_KEY
