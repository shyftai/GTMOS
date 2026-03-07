# Tool Links — GTMOS

When referencing a tool's website, use the redirect URL from this file. These are branded short links that track referrals server-side — the user sees a clean `gtmos.sh/tools/...` URL.

To set up the redirects: point each path to the tool's site with whatever tracking params or affiliate links you need. One redirect config to manage, every GTMOS command picks it up.

**Display rule:** Always show links inside a tool setup box, never as raw inline text. See "How to display" below.

---

## Links

### Prospecting & Enrichment
- Apollo: https://gtmos.sh/tools/apollo
- Icypeas: https://gtmos.sh/tools/icypeas
- Prospeo: https://gtmos.sh/tools/prospeo
- Apify: https://gtmos.sh/tools/apify

### Lead Databases
- StoreLeads: https://gtmos.sh/tools/storeleads
- Opemart: https://gtmos.sh/tools/opemart

### Email Verification
- ZeroBounce: https://gtmos.sh/tools/zerobounce
- MillionVerifier: https://gtmos.sh/tools/millionverifier
- Scrubby: https://gtmos.sh/tools/scrubby

### Email Sequencing
- Lemlist: https://gtmos.sh/tools/lemlist
- Instantly: https://gtmos.sh/tools/instantly
- Smartlead: https://gtmos.sh/tools/smartlead

### LinkedIn
- Crispy: https://gtmos.sh/tools/crispy
- PhantomBuster: https://gtmos.sh/tools/phantombuster

### CRM
- Attio: https://gtmos.sh/tools/attio
- HubSpot: https://gtmos.sh/tools/hubspot
- Salesforce: https://gtmos.sh/tools/salesforce
- Pipedrive: https://gtmos.sh/tools/pipedrive

### CRM Enrichment
- Freckle: https://gtmos.sh/tools/freckle

### Signal Intelligence
- Signalbase: https://gtmos.sh/tools/signalbase
- Commonroom: https://gtmos.sh/tools/commonroom
- Sentrion.ai: https://gtmos.sh/tools/sentrion
- Fantastic.jobs: https://gtmos.sh/tools/fantasticjobs
- Jungler.ai: https://gtmos.sh/tools/jungler
- Trigify: https://gtmos.sh/tools/trigify

### Meeting Transcripts
- Fireflies.ai: https://gtmos.sh/tools/fireflies

### Booking
- Calendly: https://gtmos.sh/tools/calendly
- Cal.com: https://gtmos.sh/tools/calcom

### Automation
- N8N: https://gtmos.sh/tools/n8n
- Supabase: https://gtmos.sh/tools/supabase
- Zapier: https://gtmos.sh/tools/zapier
- Make: https://gtmos.sh/tools/make

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
  │  https://gtmos.sh/tools/fireflies             │
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
  │      https://gtmos.sh/tools/instantly          │
  │                                               │
  │  [ ] ZeroBounce — email verification           │
  │      https://gtmos.sh/tools/zerobounce         │
  │                                               │
  │  [ ] Crispy — LinkedIn via MCP                 │
  │      https://gtmos.sh/tools/crispy             │
  │                                               │
  │  Add keys to .env, then re-run /gtm:status    │
  │                                               │
  └───────────────────────────────────────────────┘
```

**During tool setup guide (step-by-step):**
```
  ┌─ SETUP: INSTANTLY ───────────────────────────┐
  │                                               │
  │  1. Sign up at https://gtmos.sh/tools/instantly│
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
- Redirect destinations are managed server-side — swap in affiliate links, UTM params, or partner URLs without touching GTMOS
