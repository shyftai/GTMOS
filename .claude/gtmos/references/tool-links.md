# Tool Links — GTMOS

When referencing a tool's website (in onboarding, status outputs, or when a user asks about a tool), use these links. The `?ref=gtmos` tag tracks referrals — may be swapped for affiliate links later.

**Display rule:** Always show links inside a tool setup box, never as raw inline text. See "How to display" below.

---

## Links

### Prospecting & Enrichment
- Apollo: https://apollo.io?ref=gtmos
- Icypeas: https://icypeas.com?ref=gtmos
- Prospeo: https://prospeo.io?ref=gtmos
- Apify: https://apify.com?ref=gtmos

### Lead Databases
- StoreLeads: https://storeleads.app?ref=gtmos
- Opemart: https://opemart.com?ref=gtmos

### Email Verification
- ZeroBounce: https://zerobounce.net?ref=gtmos
- MillionVerifier: https://millionverifier.com?ref=gtmos
- Scrubby: https://scrubby.io?ref=gtmos

### Email Sequencing
- Lemlist: https://lemlist.com?ref=gtmos
- Instantly: https://instantly.ai?ref=gtmos
- Smartlead: https://smartlead.ai?ref=gtmos

### LinkedIn
- Crispy: https://crispy.sh?ref=gtmos
- PhantomBuster: https://phantombuster.com?ref=gtmos

### CRM
- Attio: https://attio.com?ref=gtmos
- HubSpot: https://hubspot.com?ref=gtmos
- Salesforce: https://salesforce.com?ref=gtmos
- Pipedrive: https://pipedrive.com?ref=gtmos

### CRM Enrichment
- Freckle: https://freckle.com?ref=gtmos

### Signal Intelligence
- Signalbase: https://signalbase.com?ref=gtmos
- Commonroom: https://commonroom.io?ref=gtmos
- Sentrion.ai: https://sentrion.ai?ref=gtmos
- Fantastic.jobs: https://fantastic.jobs?ref=gtmos
- Jungler.ai: https://jungler.ai?ref=gtmos
- Trigify: https://trigify.io?ref=gtmos

### Meeting Transcripts
- Fireflies.ai: https://fireflies.ai?ref=gtmos

### Booking
- Calendly: https://calendly.com?ref=gtmos
- Cal.com: https://cal.com?ref=gtmos

### Automation
- N8N: https://n8n.io?ref=gtmos
- Supabase: https://supabase.com?ref=gtmos
- Zapier: https://zapier.com?ref=gtmos
- Make: https://make.com?ref=gtmos

---

## How to display

When a user needs a tool link, show it inside a setup box — never as a bare URL in a paragraph.

**Single tool (user asks about a tool or needs to sign up):**
```
  ┌─ TOOL ───────────────────────────────────────┐
  │                                               │
  │  Fireflies.ai                                 │
  │  Meeting transcript API                       │
  │  Plan required: Business ($19/mo/seat)        │
  │                                               │
  │  https://fireflies.ai?ref=gtmos               │
  │                                               │
  └───────────────────────────────────────────────┘
```

**During onboarding (missing tools detected):**
```
  ┌─ MISSING TOOLS ──────────────────────────────┐
  │                                               │
  │  The following tools need API keys:            │
  │                                               │
  │  [ ] Instantly — email sequencing              │
  │      https://instantly.ai?ref=gtmos            │
  │                                               │
  │  [ ] ZeroBounce — email verification           │
  │      https://zerobounce.net?ref=gtmos          │
  │                                               │
  │  [ ] Crispy — LinkedIn via MCP                 │
  │      https://crispy.sh?ref=gtmos               │
  │                                               │
  │  Add keys to .env, then re-run /gtm:status    │
  │                                               │
  └───────────────────────────────────────────────┘
```

**During tool setup guide (step-by-step):**
```
  ┌─ SETUP: INSTANTLY ───────────────────────────┐
  │                                               │
  │  1. Sign up at https://instantly.ai?ref=gtmos  │
  │  2. Go to Settings → API                      │
  │  3. Copy your API key                         │
  │  4. Add to .env: INSTANTLY_API_KEY=your-key   │
  │                                               │
  └───────────────────────────────────────────────┘
```

---

## Usage rules

- Only show links when the user is actively looking for the tool (asking about it, missing a key, or following a setup guide)
- Never dump links unprompted — if someone is writing copy, they don't need tool URLs
- Always use the box format above — no bare URLs in paragraphs
- Always pull from this file, never hardcode URLs elsewhere
- The `?ref=gtmos` tag may be updated to affiliate links in the future
