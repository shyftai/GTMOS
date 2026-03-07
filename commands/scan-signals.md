# Command: Scan Signals

## Trigger
"Scan for signals on [campaign]" or "Check for immediate action triggers"

## Steps

### 1. Load context
- Load shipped list from lists/shipped/
- Load ICP.md to know what signals are relevant for this segment
- Load signal-angles.md from context/research/ for reference angles
- Load TOOLS.md — check which signal tools are active and have API keys
- Load .env — skip any tool with a missing key

### 2. Signal waterfall

Query all active signal providers. Skip inactive tools silently — never error on a missing subscription.

**Check TOOLS.md status for each tool before querying. Only query tools marked as `active`.**

#### Tier 1 — Dedicated signal platforms (structured data, real-time)

| Source | Signals detected | API key needed | Cost |
|--------|-----------------|----------------|------|
| **Signalbase** | Funding, exec hires/departures, expansions, M&A, IPO, new offices | `SIGNALBASE_API_KEY` | Per-query |
| **Commonroom** | Community activity spikes, social engagement, intent signals, topic interest | `COMMONROOM_API_KEY` | Per-query |
| **Jungler.ai** | LinkedIn activity tracking, engagement with industry content, profile changes | `JUNGLER_API_KEY` | Per-query |
| **Trigify** | Social selling signals, competitor content engagement, topic-based social signals | `TRIGIFY_API_KEY` | Per-query |

#### Tier 2 — Job post monitoring (hiring = buying signal)

| Source | Signals detected | API key needed | Cost |
|--------|-----------------|----------------|------|
| **Sentrion.ai** | New job posts, role expansion, tech-specific hires, leadership hires | Via platform | Per-query |
| **Fantastic.jobs** | Job posts by company, role, location, seniority | Via platform | Per-query |

Note: Pick one of Sentrion/Fantastic.jobs — both do job monitoring. Use whichever is active.

#### Tier 3 — Web/search signals (broader, less structured)

| Source | Signals detected | API key needed | Cost |
|--------|-----------------|----------------|------|
| **Exa** | News, press releases, blog posts, funding announcements, product launches | `EXA_API_KEY` | FREE (1K/mo) |
| **Firecrawl** | Job board scraping, website changes, new pages/features | `FIRECRAWL_API_KEY` | 1 credit/page |
| **Crunchbase** | Funding rounds, acquisitions, IPO filings | `CRUNCHBASE_API_KEY` | FREE |

#### Tier 4 — LinkedIn signals (via Crispy)

| Source | Signals detected | API key needed | Cost |
|--------|-----------------|----------------|------|
| **Crispy/Sales Nav** | Job changes, promotions, new roles, company followers growth, post engagement | `CRISPY_API_KEY` | Included in sub |

### 3. Execution rules

**Before scanning:**
1. Check which tools are active in TOOLS.md
2. Check .env for API keys — skip tools with missing keys
3. Display the scan plan:

```
  ┌─ SIGNAL SCAN PLAN ──────────────────────────┐
  │                                               │
  │  Contacts:   {n} in shipped list              │
  │  Companies:  {n} unique                       │
  │                                               │
  │  Active sources:                              │
  │    [x] Signalbase     (funding, M&A, execs)   │
  │    [x] Jungler.ai     (LinkedIn activity)     │
  │    [x] Exa            (news, press — FREE)    │
  │    [x] Crunchbase     (funding — FREE)        │
  │    [x] Crispy         (job changes — included) │
  │    [ ] Commonroom     (no API key)            │
  │    [ ] Trigify         (inactive)              │
  │    [ ] Sentrion.ai    (inactive)              │
  │                                               │
  │  Scanning for signals < 14 days old           │
  │                                               │
  └───────────────────────────────────────────────┘
```

**During scanning:**
- Query each active source for signals on shipped list companies/contacts
- Cross-reference every signal against the shipped list
- Only surface signals for contacts who are still in-sequence or recently replied
- Deduplicate — if multiple sources report the same signal (e.g., Signalbase and Crunchbase both show funding), keep the richest version

**After scanning:**
Display results grouped by signal type:

```
  ── SIGNALS FOUND ──────────────────────────────
  Funding:      3 companies    (Signalbase, Crunchbase)
  Job changes:  7 contacts     (Crispy)
  Hiring:       4 companies    (Sentrion.ai)
  News:         2 companies    (Exa)
  Social:       5 contacts     (Jungler.ai)
  ───────────────────────────────────────────────
  Total: 21 actionable signals
```

### 4. Assess each signal
For every matched signal:
- Is it relevant to the campaign offer? (yes / borderline / no)
- How old is it? (flag if older than 14 days as stale)
- Does it match an existing angle in signal-angles.md?
- If no existing angle — draft a new one
- Priority rank: time-sensitive signals first (funding today > job change last week)

### 5. Draft immediate action messages
For each relevant, fresh signal:
1. Draft a personalised outreach message referencing the signal naturally
2. Connect it to the campaign offer without forcing it
3. Validate against TOV.md, PERSONA.md, and BRIEFING.md
4. Flag if the signal is time-sensitive (e.g. funding announced today)
5. Use the appropriate framework from cold-email-skill.md: **Trigger > Relevance > Value > Ask**

### 6. Present for decision
For each signal and draft:
- Show the signal with source, date, and relevance assessment
- Show the drafted message
- Ask: "Send as a one-off touch outside the sequence, or replace the next scheduled touch?"
- Wait for explicit decision before any action

### 7. Save and update
- Save all identified signals to context/research/signal-angles.md (append, do not overwrite)
- Log all actioned signals in logs/decisions.md
- Update CRM with signal note on relevant contacts
- Update signal hit rate per source in TOOLS.md (optional — helps optimize which sources to prioritize)
