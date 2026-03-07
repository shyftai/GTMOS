# PRD: GTMOS — The GTM Operating System

**Version:** 2.0  
**Status:** Final  

---

## 1. What this is

GTMOS (GTM Operating System) is a Claude Code plugin — a GitHub repo-based framework that turns Claude into a live GTM campaign intelligence layer. It is not a dev tool. It connects directly to your outbound stack via API, pulls live campaign data on demand, and closes the loop between what you brief, what you ship, and what actually performs.

GTMOS is built for two audiences with the same underlying needs:

- **GTM agencies** managing outbound campaigns across multiple clients — each client is a workspace, fully isolated, with its own ICP, persona, briefing, tone of voice, tools, and approval chain.
- **In-house GTM operators** at B2B companies running campaigns across segments, products, or markets — each segment or market is a workspace. The mechanics are identical.

The workspace concept is intentionally neutral. It can represent a client, a market segment, a product line, a geography, or any unit of GTM work that deserves its own context.

Every GTM task Claude touches gets checked against five sources of truth — the ICP, the persona, the briefing, the tone of voice, and the quality rules. Nothing ships if it drifts from those. Once campaigns are live, data flows back from every connected tool so Claude can analyse performance, surface patterns, and suggest specific improvements.

File naming is intentionally plain. `ICP.md` means ICP. `BRIEFING.md` means briefing. Anyone who opens the repo should understand it in 30 seconds without reading documentation.

---

## 2. Problem

When using Claude for GTM work across multiple clients, campaigns, and ICPs, context bleeds. Claude writes copy for one workspace and accidentally uses framing that fits a different ICP. A list gets built with the right job titles but wrong company signals. A sequence gets written without checking the briefing for tone restrictions.

There is no enforcement layer. GTMOS fixes that.

---

## 3. Goals

- Give Claude persistent, structured context about the ICP, briefing, and campaign rules before any task starts
- Enforce a "check before you ship" workflow for copy, lists, and outreach
- Keep multi-client work totally isolated — each workspace is a self-contained folder
- Make list-building structured and auditable
- Work entirely inside Claude Code via `GTMOS.md` and a flat, readable folder structure
- Be usable by anyone — the repo should require zero explanation to navigate

---

## 4. Non-goals

- No code generation, no dev tooling
- No CRM sync — that lives in your sequencer and enrichment stack. GTMOS is the thinking and briefing layer
- No UI — flat files, plain markdown, terminal-first
- Not a replacement for Clay, Apollo, or Lemlist — it is the brief-to-execution bridge that sits above them

---

## 5. Core concepts

### 5.1 The five sources of truth

Every output Claude produces gets validated against:

1. **ICP.md** — who we are targeting at the company level. Industry, size, signals, anti-signals, scoring criteria.
2. **PERSONA.md** — who we are targeting at the human level. Buyer voice, objections, stakeholder map, proof points by title.
3. **BRIEFING.md** — what this campaign is about. Offer, angle, tone constraints, CTA, what to avoid.
4. **TOV.md** — how we sound. Full brand voice per workspace: sentence structure, punctuation style, formality level, channel-specific rules for email vs LinkedIn, words to use, words to never use, before/after rewrites.
5. **RULES.md** — list quality and copy quality standards. What makes a good record, what makes a good line.

TOV.md is loaded on every copy task alongside BRIEFING.md. The briefing defines what to say. TOV.md defines how to say it. They are never merged — one changes per campaign, the other is stable per workspace.

### 5.2 The GTMOS loop

```
Intake → Research → Load context → Define task → Execute → Validate → Approve → Ship
                                                                                   ↓
                                                              Improve ← Health check ← Sync data
```

The loop is continuous. Once a campaign ships, data flows back from every connected tool. Claude runs health checks on demand, surfaces patterns, suggests specific updates to ICP, persona, and copy, and asks before applying any of them. Nothing is automatic — Claude proposes, you decide.

### 5.3 Client isolation

Each client lives in its own folder under `/clients/`. Everything — ICP, persona, briefing, rules, tools, context, campaigns, lists, copy, performance, and logs — lives inside that folder. Nothing bleeds across clients. Loading a client means loading one folder. Switching clients means switching folders.

### 5.4 Context as a first-class input

Meeting notes, research, competitor intel, and product assets live in a dedicated `context/` folder inside every workspace folder, right next to `ICP.md` and `PERSONA.md`. An `INDEX.md` tells Claude what is in there and what to prioritize. After every workspace call, notes get dropped in. Claude reads them and flags if anything changes the ICP, persona, or active campaign.

### 5.5 The persona layer

`ICP.md` defines the company. `PERSONA.md` defines the human. Intentionally separate — they answer different questions.

**Buyer voice** — the exact language this persona uses when talking about the problem. Not how you describe their pain. How they describe it. Claude uses this vocabulary in copy, not generic category language.

**Objection map** — the common pushbacks this persona gives and the most effective responses. Claude references this when writing follow-ups and break-up touches. It also flags if a sequence draft walks into a known objection without addressing it.

**Stakeholder map** — the difference between the champion (who feels the pain) and the economic buyer (who controls the budget). Sequences can address both. Copy angles differ by stakeholder, and Claude writes accordingly.

**Proof points by title** — what lands for a Head of Sales is different from what lands for a CFO. `PERSONA.md` maps which proof points, metrics, and outcomes resonate for each title in the target persona set. Claude pulls from these when writing to a specific title.

### 5.6 Signal-to-angle

When the research phase surfaces a signal — a funding round, a hiring spike, a product launch, a market event — Claude does not just flag it. It automatically maps it to a copy angle.

Format per signal:
- **Signal:** what was found and when
- **Relevance:** why this matters for the ICP
- **Angle:** the specific framing this signal enables in outreach
- **Sample line:** one opening line that uses the angle

Signal angles are saved to `context/research/signal-angles.md`. When writing sequences, Claude checks this file first and surfaces relevant angles before drafting. If a signal is time-sensitive, Claude flags it as expiring.

### 5.7 The performance feedback loop

Every campaign has a `performance/` folder. After a sequence runs, performance data gets logged there — reply rates, open rates, bounce rates, positive vs negative response breakdown, and notable reply text.

Claude reads this data in two ways:

**Per-campaign debrief** — after a campaign ends or pauses, run `performance-review` to get a structured breakdown: what worked, what did not, which angles generated responses, which touches had the highest drop-off, which job titles engaged vs went cold.

**Forward feed** — performance data feeds back into the next campaign automatically. Strong angles get flagged for future briefings. Consistently rejecting job titles get flagged for ICP refinement. Bounce-heavy lists trigger a rules review. The framework improves with every campaign that runs through it.

### 5.8 Tool connections and bidirectional sync

GTMOS connects directly to all tools via API from Claude Code. Every tool is both a destination (GTMOS pushes lists and copy into it) and a data source (it pushes performance data back into GTMOS). Connections are defined per workspace in `TOOLS.md`. API keys live in `.env` at repo root.

**Supported tools at launch:**

| Tool | Pushes to | Pulls from |
|------|-----------|------------|
| Apollo | List exports, contact filters | Enrichment updates, contact status, bounce flags |
| Clay | Enrichment jobs, waterfall configs | Enrichment results, field updates, scoring data |
| Lemlist | Sequences, contacts, campaigns | Open rates, reply rates, bounce rates, unsubscribes, reply text |
| Instantly | Sequences, contacts, sending schedules | Open rates, reply rates, bounce rates, deliverability data |
| Smartlead | Sequences, contacts, sending schedules | Open rates, reply rates, bounce rates, deliverability data |
| Crispy | Connection requests, LinkedIn messages | Connection acceptance rates, reply rates, reply content |
| Attio | Contacts, deals, campaign tags, notes | Deal stage changes, reply status, contact updates, won/lost |

**Read vs write permissions** are set per tool per workspace in `TOOLS.md`. A tool can be read-only (GTMOS pulls data but never pushes), write-only (GTMOS pushes but ignores return data), or bidirectional. Default is bidirectional for all tools above.

**Credit rules** apply to writes only. Reads are always auto-approved since they consume no campaign credits. Before any write operation — pushing a list, launching a sequence, updating a contact — Claude states what it is about to do, which tool, and the estimated credit or record cost, then applies the credit behaviour rule from `TOOLS.md`.

### 5.9 The live campaign and health checks

Once a campaign is live, GTMOS operates in analysis mode. Claude does not monitor passively — it runs a structured health check on demand that pulls fresh data from every connected tool, analyses it against the ICP and briefing, and surfaces patterns.

**Health check covers:**

- **Deliverability** — bounce rate, spam flags, domain health signals from Lemlist, Instantly, and Smartlead
- **Engagement** — open rates, reply rates, click rates broken down by touch, channel, and sequence variant
- **LinkedIn** — connection acceptance rate, reply rate, and reply sentiment from Crispy
- **Pipeline** — deal stage distribution, conversion from reply to meeting, time in stage from Attio
- **List quality** — enrichment accuracy feedback from Clay and Apollo; contacts that bounced or were flagged post-send get written back to the validated list with updated status
- **Persona performance** — which job titles and company profiles are engaging vs going cold, measured against ICP scoring

**Pattern detection and suggestions:**

When Claude spots a pattern in live data — a job title converting 3x better than average, a specific touch with a 40% reply rate, a company segment with zero engagement — it does not just report it. It connects the pattern to the relevant source of truth and suggests a specific update:

- Title over-performing → suggest adding it as a Score 3 criterion in ICP.md
- Title consistently cold → suggest adding it to anti-personas
- Angle getting replies → suggest promoting it to primary hook in BRIEFING.md
- Objection appearing in 30%+ of negative replies → suggest adding it to PERSONA.md objection map
- Specific company signal correlating with replies → suggest adding as a priority signal in ICP.md

For every suggestion, Claude shows the data behind it, proposes the exact file edit, and asks for approval before applying anything. One confirmation per suggestion — no batch-applying changes silently.

**Sync data storage:**

Live data pulled from tools is stored in `sync/` inside each campaign folder as timestamped snapshots. This means every health check has a data trail, and Claude can compare snapshots over time to identify trends rather than just point-in-time readings.

### 5.10 Collaboration and approval flow

`WORKFLOW.md` per workspace defines who can do what and what requires sign-off before anything ships.

**Four roles:**

- **Owner** — full access. Sets credit rules. Approves final ship. Can override any flag.
- **Contributor** — builds lists, writes drafts, runs research. Output lands in `drafts/` and `validated/` only — never directly in `approved/` or `shipped/`.
- **Approver** — reviews contributor output. Can move copy from `drafts/` to `approved/` and lists from `validated/` to `shipped/`. Cannot change ICP, persona, or briefing without owner.
- **Client** — receives clean exports only. No repo access.

Every approval is logged in `logs/decisions.md` with approver name, date, and reason. Claude enforces this — it will not move a file to `approved/` or `shipped/` without writing the log entry first.

### 5.11 The reply handler

When replies come in from any channel — email or LinkedIn — Claude classifies them, drafts a suggested response, and presents it for approval before anything is sent. Nothing goes out without a human decision.

**Seven reply types and their default actions:**

| Type | Definition | Default action |
|------|-----------|----------------|
| **Positive** | Interested, wants to talk | Draft warm response moving toward booking. Update Attio to Interested. Suggest pausing sequence. |
| **Negative** | Not interested, wrong timing | Draft a graceful close that leaves the door open. Update Attio to Not Interested. Pause sequence. |
| **Objection** | Pushback that can be addressed | Load objection map from PERSONA.md. Draft a response handling the specific objection using known counters. |
| **Referral** | Not the right person, sends you elsewhere | Draft thank-you and a new first-touch for the referred contact. Create referral record in Attio. |
| **OOO** | Out of office | Extract return date if present. Schedule a follow-up for that date. Log in Attio. No response sent. |
| **Unsubscribe** | Requests removal | Remove from sequence immediately. Flag in Attio as do-not-contact. Never surface this contact again in any campaign. |
| **Competitor mention** | Currently using a competing tool | Load competitor context from PERSONA.md. Draft a response that acknowledges their setup and reframes — no attacking the competitor. |

All drafted responses are checked against TOV.md before being presented. Claude never sends — it proposes. The approval step is always required. Reply classifications and response drafts are saved to `replies/` inside the active campaign folder for audit trail.

### 5.12 Immediate actions and signal scanning

Immediate actions are triggered by time-sensitive signals — a contact gets a funding round, changes jobs, or their company appears in relevant news. These signals create a narrow window where personalised outreach has dramatically higher relevance. GTMOS catches them and turns them into ready-to-send messages before the window closes.

**Signal sources:**

- **Research phase** — signals surfaced during `run-research` are saved to `signal-angles.md` with a freshness flag. Claude checks at campaign start and flags any signals less than 30 days old as immediate action candidates.
- **Signal APIs** — during a live campaign, Claude pulls live signals from connected APIs including Signalbase and Commonroom, queried on demand via the `scan-signals` command and cross-referenced against the shipped list.

**What Claude does with a signal:**
1. Identifies the contact in the shipped list
2. Loads their record — company, title, current sequence position
3. Assesses the signal's relevance to the campaign offer
4. Drafts a signal-triggered message that references the signal naturally and connects it to the offer
5. Validates the draft against TOV.md, PERSONA.md, and BRIEFING.md
6. Presents it with the signal data and asks: "Send as a one-off touch outside the sequence, or replace the next scheduled touch?"
7. Waits for approval before anything moves

**Signal types that trigger immediate action:** funding announcement, executive hire or job change, company expansion, product launch, relevant industry news or regulation change, contact mentioned in press or on LinkedIn.

Signals older than 14 days are flagged as stale. Claude notes the staleness but still presents — you decide.

### 5.13 The questioning protocol

Claude asks questions at exactly three moments.

**Moment 1 — Client onboarding.** Structured intake interview covering ICP, persona, TOV, briefing, tools, and workflow. One topic block at a time. Stops when files are complete enough to work from.

**Moment 2 — Campaign start.** Checks `BRIEFING.md`, `PERSONA.md`, and `TOV.md` for critical gaps before writing copy or building a list brief. Does not write around gaps — surfaces them.

**Moment 3 — Mid-task gaps.** If a task requires information not in loaded context, stops and asks. Never invents or assumes.

Outside these three moments, Claude works with what is loaded and flags uncertainties inline.

### 5.14 The research phase

Before a campaign launches, Claude runs a structured research pass covering two areas:

**ICP company research** — signals, news, hiring patterns, and context on the target segment. Feeds ICP scoring, list building, and the signal-to-angle layer.

**Market and industry landscape** — market dynamics, terminology buyers use, and trends that make the campaign angle timely.

Both save to `context/research/` as dated markdown files. Signal angles are extracted automatically to `signal-angles.md`. `INDEX.md` is updated after every research run.

---

## 6. Repo structure

```
ftm/
├── GTMOS.md                               ← Plugin entrypoint — Claude reads this first
├── README.md                            ← How to use the repo
├── .env                                 ← API keys for all tools (gitignored, never committed)
├── .env.example                         ← Safe reference showing which keys are needed
├── .gitignore                           ← Excludes .env and raw lists
│
├── _template/                           ← Copy this entire folder to onboard a new workspace
│   ├── workspace.config.md                 ← Client name, status, active campaigns, tool stack
│   ├── ICP.md                           ← Company-level targeting
│   ├── PERSONA.md                       ← Human-level targeting: voice, objections, stakeholders, proof points
│   ├── BRIEFING.md                      ← Campaign offer, angle, tone constraints, CTA
│   ├── TOV.md                           ← Full brand voice: structure, style, formality, channel rules, examples
│   ├── RULES.md                         ← List and copy quality standards
│   ├── TOOLS.md                         ← Active tools and credit rules for this workspace
│   ├── WORKFLOW.md                      ← Roles, approval gates, handoff process
│   │
│   ├── context/
│   │   ├── meeting-notes/               ← Call notes, discovery sessions, kickoffs
│   │   ├── research/                    ← Market research, competitor notes, positioning docs
│   │   ├── assets/                      ← Case studies, one-pagers, product info
│   │   └── INDEX.md                     ← What is in this folder and what Claude should prioritize
│   │
│   ├── campaigns/
│   │   └── _campaign-template/          ← Copy this to start a new campaign
│   │       ├── campaign.config.md       ← Campaign name, status, channel, target count, timeline
│   │       ├── lists/
│   │       │   ├── raw/                 ← Input from Apollo, Clay, or manual
│   │       │   ├── validated/           ← After Claude validation pass
│   │       │   └── shipped/             ← Approved and sent to sequencer
│   │       ├── copy/
│   │       │   ├── drafts/
│   │       │   └── approved/
│   │       ├── sync/                    ← Live data snapshots pulled from connected tools
│   │       │   ├── lemlist/
│   │       │   ├── instantly/
│   │       │   ├── smartlead/
│   │       │   ├── crispy/
│   │       │   ├── attio/
│   │       │   ├── apollo/
│   │       │   └── clay/
│   │       ├── replies/                 ← Classified replies and drafted responses awaiting approval
│   │       ├── performance/             ← Analysed health checks and debriefs
│   │       │   └── results.md
│   │       └── logs/
│   │           ├── decisions.md         ← Approvals, overrides, and why
│   │           └── iterations.md        ← Version history of copy and lists
│   │
│   └── logs/
│       └── workspace-log.md                ← High-level client activity log
│
├── workspaces/
│   └── example-workspace/                  ← Fictional example — shows the structure in use
│       ├── workspace.config.md
│       ├── ICP.md
│       ├── PERSONA.md
│       ├── BRIEFING.md
│       ├── RULES.md
│       ├── TOOLS.md
│       ├── WORKFLOW.md
│       │
│       ├── context/
│       │   ├── meeting-notes/
│       │   │   ├── 2025-01-10-kickoff.md
│       │   │   └── 2025-02-05-campaign-review.md
│       │   ├── research/
│       │   │   ├── icp-research-2025-01-10.md
│       │   │   ├── market-landscape-2025-01-10.md
│       │   │   └── signal-angles.md     ← Auto-generated: signal → copy angle map
│       │   ├── assets/
│       │   │   └── product-one-pager.md
│       │   └── INDEX.md
│       │
│       ├── campaigns/
│       │   └── outbound-q1/
│       │       ├── campaign.config.md
│       │       ├── lists/
│       │       │   ├── raw/
│       │       │   ├── validated/
│       │       │   └── shipped/
│       │       ├── copy/
│       │       │   ├── drafts/
│       │       │   └── approved/
│       │       ├── performance/
│       │       │   └── results.md
│       │       └── logs/
│       │           ├── decisions.md
│       │           └── iterations.md
│       │
│       └── logs/
│           └── workspace-log.md
│
├── commands/                            ← Reusable prompt templates, workspace-agnostic
│   ├── intake-interview.md
│   ├── run-research.md
│   ├── validate-list.md
│   ├── validate-copy.md
│   ├── build-list-brief.md
│   ├── write-sequence.md
│   ├── handle-replies.md
│   ├── scan-signals.md
│   ├── sync-data.md
│   ├── campaign-health-check.md
│   ├── audit-briefing.md
│   ├── icp-stress-test.md
│   └── performance-review.md
│
└── global/
    ├── RULES-GLOBAL.md                  ← Cross-client standards: GDPR, deliverability, ethics
    └── snippet-library.md               ← Reusable copy fragments across clients
```

### Why this structure works

**Client isolation is total.** One workspace folder, one context, one campaign tree. Claude loads one workspace at a time. Nothing leaks.

**Context is first-class.** Meeting notes, research, and assets sit next to `ICP.md` — not in some separate place Claude might miss. `INDEX.md` tells Claude what to actually read and what to skip.

**Campaigns nest under clients.** A client can run multiple campaigns in parallel. Each has its own list pipeline, copy state, and decision log.

**Templates make onboarding instant.** Copy `_template/`, fill in four files, load the client. Done.

**Global rules are shared.** GDPR compliance, email deliverability standards, and cross-client copy ethics live in `/global/` — written once, applied everywhere.

**Commands are workspace-agnostic.** The six prompt templates in `/commands/` work for any client. They always read from whichever client is currently loaded.

---

## 7. GTMOS.md spec

GTMOS.md is the one branded file — the plugin entrypoint that Claude reads when the repo is opened in Claude Code. It defines how Claude behaves across all clients and campaigns. Every other file uses plain English naming.

```markdown
# GTMOS — The GTM Operating System

You are a GTM execution partner. Not a developer. Not a generalist assistant.
Your job inside this repo is:

- List building and validation
- Outbound copy writing and QA
- ICP and briefing enforcement
- Campaign logic and sequencing

---

## On startup

1. Ask which client is active, or detect from context
2. Load the following files from that workspace folder:
   - ICP.md
   - PERSONA.md
   - BRIEFING.md
   - TOV.md
   - RULES.md
   - TOOLS.md
   - WORKFLOW.md
   - workspace.config.md
   - context/INDEX.md (then read any files it flags as priority)
3. Check .env at repo root — confirm which API keys are present for active tools
4. If a tool is marked active in TOOLS.md but its key is missing from .env, flag it before proceeding
5. Confirm loaded context in a short summary before any task begins:
   - Who we are targeting (company + persona)
   - What the active campaign angle is
   - Who is in the approval chain
   - Which tools are ready to use
   - Any missing keys or active constraints

Do not proceed with any task until this is confirmed.

---

## Before using any tool

1. State what you are about to do
2. State which tool you will use
3. State the estimated credit cost or record count
4. Apply the credit behaviour from TOOLS.md:
   - confirm-before-every-use → stop and wait for explicit approval
   - confirm-above-threshold → proceed if under threshold, stop if over
   - auto-approved → proceed and log what was used
5. Never batch-process, enrich, or send without going through this check

---

## Before every output

Run these five checks:

1. **ICP fit** — does this match the company profile, signals, and scoring in ICP.md?
2. **Persona fit** — does this use the right language, address the right objections, and match the right stakeholder from PERSONA.md?
3. **Briefing fit** — does this match the offer, angle, and constraints in BRIEFING.md?
4. **Voice fit** — does this match the sentence structure, style, word choices, and channel rules in TOV.md?
5. **Quality fit** — does this meet the list or copy standards in RULES.md?

If any check fails, revise before presenting. Never show a draft that fails its own brief.

---

## List tasks

- Apply ICP filters strictly. When in doubt, reject.
- Score every record 0–3 using the rubric in RULES.md
- Explain rejections — say why, not just that it was rejected
- Output a validated CSV with added columns: icp_score, rejection_reason, review_flag
- Save output to lists/validated/ inside the active campaign folder

---

## Copy tasks

- Load the relevant template from commands/ before writing
- Apply tone, angle, and CTA from BRIEFING.md — not from general knowledge
- Subject lines: max 8 words
- Line 1: never start with "I" or the company name — earn relevance immediately
- First touch: max 75 words
- One CTA per touch, no stacking asks
- Flag any claim not supported by BRIEFING.md before presenting

---

## Reply handling

When a reply is provided for handling:

1. **Classify** — assign one of seven types:
   - Positive — interested, wants to talk
   - Negative — not interested or wrong timing
   - Objection — pushback that can be handled
   - Referral — not the right person, forwarded you to someone else
   - OOO — out of office
   - Unsubscribe — wants to be removed
   - Competitor mention — currently using an alternative

2. **Act based on type:**

   Positive:
   - Draft a response that advances toward a meeting
   - Apply TOV.md — keep it warm, brief, and low-friction
   - Suggest marking the contact as "Replied — Positive" in Attio
   - Suggest pausing their sequence in the sending tool

   Negative:
   - Draft a graceful acknowledgement — no pushback, door left open
   - Apply TOV.md
   - Suggest marking "Replied — Negative" in Attio
   - Suggest removing from active sequence

   Objection:
   - Load PERSONA.md objection map
   - Match the objection to the closest entry
   - Draft a response using the mapped approach
   - If objection is not in the map, flag it as a new entry to add
   - Apply TOV.md
   - Suggest keeping sequence paused until response is sent

   Referral:
   - Draft a response thanking them and acknowledging the referral
   - Flag the referred contact name for manual research and list addition
   - Apply TOV.md
   - Suggest marking original contact as "Referred" in Attio

   OOO:
   - Extract return date from the OOO message if present
   - Suggest a follow-up task in Attio for the day they return
   - Do not draft a response — no reply needed
   - Suggest pausing their sequence until return date

   Unsubscribe:
   - Do not draft a response
   - Flag for immediate removal from all active sequences
   - Suggest marking "Unsubscribed — Do Not Contact" in Attio
   - Log the unsubscribe in campaign logs/decisions.md
   - Never contact this person again under any campaign in this workspace

   Competitor mention:
   - Load PERSONA.md for any competitor-specific guidance
   - Draft a response that acknowledges their current tool without disparaging it
   - Pivot to the specific differentiation relevant to their situation
   - Apply TOV.md
   - Flag the competitor mentioned for logging in context/research/

3. **Present for approval** — always. Never send a reply without explicit approval.
4. **Log the classification and action** in campaign logs/decisions.md.

---

## Immediate actions — signal-triggered outreach

Immediate actions are triggered when a time-sensitive signal is detected for a contact
or company in the active campaign.

Signal sources:
- Signalbase, Commonroom, or similar signal APIs defined in TOOLS.md
- Manual signal drops into context/meeting-notes/ or context/research/

Signal types that trigger an immediate action:
- Funding round announced
- Key hire or job change at a target account
- Company news relevant to the campaign angle
- Product launch or expansion announcement
- Event attendance or speaker announcement

When a signal is detected:

1. Match the signal to the relevant contact(s) in the shipped list
2. Identify the angle the signal enables — check signal-angles.md first
3. Draft a signal-triggered outreach message:
   - Reference the specific signal in line 1
   - Connect it to the offer in 2-3 sentences
   - Apply TOV.md strictly — signal outreach should feel timely, not opportunistic
   - Max 60 words
   - Single low-friction CTA
4. Flag the signal with expiry — most signals are only relevant for 5-7 days
5. Present the draft and ask for approval before anything is sent or scheduled
6. If approved: push to the relevant sending tool (Lemlist / Instantly / Smartlead / Crispy)
   applying the credit behaviour rule from TOOLS.md
7. Log the action in campaign logs/decisions.md

---


- Read the new file
- Update your active understanding of the client
- Flag anything that changes the ICP, briefing, or an active campaign

---

## What you never do

- Never generalize the ICP to be more inclusive without explicit instruction
- Never write copy that makes promises the briefing does not authorize
- Never validate a list without loading RULES.md first
- Never skip the context load on startup
- Never assume a previous session's context carries over — always reload

---

## Questioning protocol

Ask questions at exactly three moments. Outside these, work with what is loaded
and flag uncertainties inline — do not ask.

### Moment 1 — Client onboarding
When setting up a new workspace folder, run a structured intake interview to fill
ICP.md and BRIEFING.md. Ask one topic area at a time. Build on previous answers.
Stop when the files are complete enough to execute from.

Intake question order:
1. What does the client sell? What is the specific offer?
2. Who is the ideal buyer — industry, company size, geography?
3. What job titles are we targeting? Who is NOT a fit?
4. What pain does the offer solve? What triggers a buying decision?
5. What is the campaign angle? What tension or insight leads the outreach?
6. What tone is right? What should we never say?
7. What is the CTA? What are we NOT asking for in this campaign?
8. What proof points exist? Data, case studies, credentials?
9. Any legal or compliance constraints?

Do not ask all nine at once. Group logically, one block at a time.

### Moment 2 — Campaign start
Before writing copy or building a list brief, check BRIEFING.md for critical gaps.
If any of the following are missing or vague, ask before proceeding:
- The specific offer
- The campaign angle or hook
- The primary CTA
- Tone constraints

Do not write around gaps. Surface them.

### Moment 3 — Mid-task gaps
If a task requires specific information not present in loaded context — a product
detail, a proof point, a constraint — stop and ask. Never invent or assume.

---

## Research phase

Run a research pass when instructed or when context/research/ is empty at campaign start.

### ICP company research
For a given target segment, surface:
- What these companies look like when they are a perfect fit
- Recent signals: hiring patterns, funding, expansions, events
- Common pain points and language buyers in this space use
- What they are already using (tools, vendors, alternatives)

Save output to: context/research/icp-research-[date].md

### Market and industry landscape
Map the target market:
- Market size and dynamics
- Key trends making the campaign angle relevant right now
- Terminology and framing buyers actually use
- Category context Claude should use when writing copy

Save output to: context/research/market-landscape-[date].md

After saving either file, update context/INDEX.md to reference it.
```

---

## 8. Template file specs

### TOOLS.md

```markdown
# Tools — [Client Name]

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
- Pull from Signalbase: funding signals, hiring signals, company news
- Credit behaviour: auto-approved
- Notes:

### Commonroom
- Status: active / inactive
- Mode: read-only
- Pull from Commonroom: community signals, job changes, engagement events
- Credit behaviour: auto-approved
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
```

### .env.example

```
# GTMOS — API Keys
# Copy this file to .env and fill in your keys
# Never commit .env to version control

# Prospecting and enrichment
APOLLO_API_KEY=
CLAY_API_KEY=

# Email sequencing
LEMLIST_API_KEY=
INSTANTLY_API_KEY=
SMARTLEAD_API_KEY=

# LinkedIn
CRISPY_API_KEY=

# CRM
ATTIO_API_KEY=

# Signal intelligence
SIGNALBASE_API_KEY=
COMMONROOM_API_KEY=
```

### workspace.config.md

```markdown
# Workspace Config

**Name:**
**Type:** agency-client / in-house-segment / market / product-line / geography
**Status:** active / paused / archived
**Primary contact:**
**Tool stack:** (e.g. Apollo, Clay, Lemlist, Attio)
**Active campaigns:**
**Notes:**
```

### ICP.md

```markdown
# ICP — [Client Name]

## Target company
- Industry:
- Sub-verticals (include):
- Sub-verticals (exclude):
- Company size (employees):
- Company size (revenue):
- Geography:
- Tech signals:
- Business signals (e.g. hiring, funding, events):
- Anti-signals (exclude if):

## Target persona
- Job titles (exact match):
- Job titles (acceptable variants):
- Seniority level:
- Decision-making authority:
- Anti-personas (never target):

## Pain points we address
1.
2.
3.

## Buying context
- Trigger events:
- Typical buying cycle:
- Alternatives they use today:

## ICP scoring criteria
- Score 3 — perfect fit:
- Score 2 — acceptable:
- Score 1 — borderline, needs manual review:
- Score 0 — reject:
```

### BRIEFING.md

```markdown
# Campaign Briefing — [Campaign Name]

## Offer
What exactly are we offering? Be specific. No vague value props.

## Angle / Hook
The core insight or tension this campaign leads with.

## Proof points
What evidence supports the hook? Data, case studies, credentials, specifics.

## Tone
- Voice:
- What to avoid:
- On-brand line examples:
- Off-brand line examples:

## CTA
- Primary CTA:
- Fallback CTA:
- What we are NOT asking for in this campaign:

## Constraints
- Topics to avoid:
- Claims we cannot make:
- Competitor mentions: allowed / not allowed
- Legal or compliance notes:

## What a good response looks like
Describe what a positive reply or conversion looks like for this campaign.
```

### RULES.md

```markdown
# Quality Rules — [Client Name]

## List quality

### Required fields
- [ ] First name
- [ ] Last name
- [ ] Company name
- [ ] Job title (verified against ICP)
- [ ] LinkedIn URL
- [ ] Work email (verified, or catch-all flagged)
- [ ] Company website

### Enrichment fields (populate where available)
- Company size (employees)
- Industry (standardized label)
- HQ location
- Relevant signal (event, hiring, funding, tech, etc.)

### Rejection rules
- Personal email domain (gmail, hotmail, etc.) → reject
- Job title outside ICP persona → reject
- Company outside ICP industry → reject
- Duplicate in this campaign → reject
- Unverifiable email with no LinkedIn → reject

### Scoring rubric
- 3: All required fields, strong ICP match, verified email, clear signal present
- 2: All required fields, solid ICP match, catch-all email or no signal
- 1: Missing 1–2 fields, or weak ICP signal — flag for manual review
- 0: Reject

## Copy quality

### Email
- Subject line: max 8 words, no question marks in cold outreach, no clickbait
- Line 1: no "I", no company name, must earn relevance immediately
- Body: max 75 words for first touch
- CTA: one ask only, make it low-friction
- Never use: buzzwords, excessive punctuation, ALL CAPS, generic openers

### LinkedIn
- Connection note: max 300 characters, no pitch in the note
- Follow-up message: reference something specific, never generic
```

### PERSONA.md

```markdown
# Persona — [Client Name]

## Buyer voice
How does this persona describe the problem in their own words?
(Use exact phrases from sales calls, reviews, LinkedIn posts, forums)
-
-
-

## Objection map
| Objection | Best response |
|-----------|---------------|
| | |
| | |
| | |

## Stakeholder map

### Champion
- Typical title:
- Their pain:
- What they want from this:
- How to write to them:

### Economic buyer
- Typical title:
- Their concern:
- What they need to see:
- How to write to them:

## Proof points by title
| Title | What lands | What to avoid |
|-------|-----------|---------------|
| | | |
| | | |
| | | |

## Do not use
Language, claims, or framings that this persona actively dislikes or distrusts:
-
-
```

### TOV.md

```markdown
# Tone of Voice — [Client Name]

## Brand voice in three words
(e.g. Direct. Human. Sharp.)

---

## Core voice

### Formality level
Choose one: conversational / professional / formal
Notes on where this shifts (e.g. more formal in enterprise email, looser on LinkedIn):

### Energy level
Choose one: calm / measured / energetic / urgent
Notes:

### What this voice is NOT
(e.g. not salesy, not corporate, not overly casual)
-
-
-

---

## Sentence structure

- Average sentence length: short (under 12 words) / medium / long
- Paragraph length in email: max [X] lines
- Use of questions: freely / sparingly / never in subject lines
- Sentence fragments: allowed / not allowed
- Starting sentences with "And" or "But": allowed / not allowed

---

## Punctuation and style

- Em dashes: use / avoid
- Ellipses: use / avoid
- Exclamation marks: allowed / never
- ALL CAPS for emphasis: allowed / never
- Bold in email body: allowed / never
- Oxford comma: yes / no
- Numbers: spell out under 10 / always use numerals
- % vs percent: use [choice]

---

## Words and phrases

### Always use
-
-
-

### Never use
(include category kills too — e.g. "no synergy-type words")
-
-
-

### Competitor names
Mention freely / avoid / never use

---

## Channel-specific rules

### Cold email
- Subject line style: (e.g. lowercase, no punctuation, curiosity-led)
- Line 1 rule: (e.g. never start with "I", must create relevance in under 10 words)
- Body length first touch: max [X] words
- Sign-off style:
- PS line: use / avoid

### LinkedIn connection note
- Max characters: 300
- Pitch in note: never
- Tone vs email:

### LinkedIn message (post-connect)
- Reference the connection: always / only if relevant
- Length: max [X] words
- CTA style:

---

## Before / after rewrites
(Show 2–3 examples of off-brand copy rewritten into on-brand)

### Example 1
**Before (off-brand):**

**After (on-brand):**
Why it works:

### Example 2
**Before (off-brand):**

**After (on-brand):**
Why it works:
```

```markdown
# Workflow — [Client Name]

## Roles

| Name / Role | Access level | Notes |
|-------------|-------------|-------|
| | Owner | |
| | Contributor | |
| | Approver | |
| | Client | Export only |

## Approval gates

### Copy
- Drafts written by: Contributor or Claude
- Reviewed by: Approver
- Final sign-off: Owner
- Client sees: Approved copy only, via export

### Lists
- Raw lists built by: Contributor or Claude
- Validated by: Claude + manual review of score-1 records
- Approved to ship by: Approver
- Final sign-off for large batches (500+): Owner

## Handoff format
How approved copy is shared with the client or sequencer:
-

## Escalation
When to pull in the Owner outside of normal approval flow:
-
```

### performance/results.md

```markdown
# Campaign Performance — [Campaign Name]

## Period
From: To:

## Volume
- Records shipped:
- Emails sent:
- LinkedIn touches sent:

## Email metrics
- Open rate:
- Reply rate:
- Bounce rate:
- Positive replies:
- Negative replies:
- Out-of-office / not relevant:

## LinkedIn metrics
- Connection acceptance rate:
- Reply rate:
- Positive replies:

## Best performing touch
Which touch in the sequence got the most responses?

## Best performing angle
Which hook or framing got the most positive replies?

## Worst performing element
What consistently got ignored or negative responses?

## Notable reply samples
(Anonymised — useful for refining persona or copy)
-
-

## Recommended changes for next campaign
- ICP refinement:
- PERSONA update:
- Copy angle to carry forward:
- Copy angle to drop:
- Rules update:
```

```markdown
# Context Index — [Client Name]

## Priority files (read on every workspace load)
-

## Reference files (read when relevant to the task)
-

## Last updated
```

### campaign.config.md

```markdown
# Campaign Config

**Name:**
**Status:** draft / active / paused / complete
**Channel:** email / LinkedIn / multi-channel
**Target list size:**
**Target send date:**
**Sequence length:** (e.g. 4-touch over 14 days)
**Notes:**
```

---

## 9. Commands spec

Each file in `/commands/` is a reusable prompt template. Claude loads the relevant command before executing that task type.

### intake-interview.md

```markdown
# Command: Intake Interview

## Trigger
"Onboard a new workspace" or "Run the intake interview for [client]"

## Steps
1. Create the workspace folder structure from _template/
2. Ask intake questions in blocks — not all at once:
   Block 1: Offer and product
   Block 2: ICP — company profile and persona
   Block 3: Pain points and buying triggers
   Block 4: Campaign angle, hook, proof points
   Block 5: Tone, CTA, constraints
   Block 6: Tone of voice deep-dive — sentence structure, style, words, channel rules, examples
   Block 7: Tool stack and credit rules
3. After each block, confirm what was captured before moving on
4. On completion, write answers directly into:
   - ICP.md
   - BRIEFING.md
   - workspace.config.md
   - TOOLS.md
5. Check .env for any keys needed by active tools — flag any that are missing
6. Flag any fields still empty that will need to be filled before copy can start
7. Suggest running the research phase next

## Block 6 — Tool stack questions
- Which tools are active for this workspace? (Apollo / Clay / Lemlist / Crispy)
- For each active tool: what is the credit behaviour? (confirm-every-time / confirm-above-threshold / auto-approved)
- For confirm-above-threshold tools: what is the batch size limit?
- Are there any tools this client specifically should not use?
```

### run-research.md

```markdown
# Command: Run Research

## Trigger
"Run research for [workspace]" or "Research the market for [campaign]"

## Steps

### ICP company research
1. Load ICP.md to understand the target segment
2. Research what perfect-fit companies look like in practice:
   - Typical signals: hiring, funding, events, expansions
   - Tools and vendors they commonly use
   - Pain language buyers in this space actually use
   - What triggers a buying decision
3. Save to: context/research/icp-research-[YYYY-MM-DD].md

### Market and industry landscape
1. Map the broader target market:
   - Market size and current dynamics
   - Trends making the campaign angle relevant right now
   - Terminology and framing buyers actually use
   - Category context for copy and positioning
2. Save to: context/research/market-landscape-[YYYY-MM-DD].md

### Signal-to-angle extraction
For every meaningful signal found in research:
1. Name the signal
2. State why it is relevant for this ICP
3. Write the copy angle it enables
4. Write one sample opening line using that angle
5. Flag if the signal is time-sensitive or expiring

Save all signals and angles to: context/research/signal-angles.md
Format as a scannable table — one row per signal.

### After all files are saved
- Update context/INDEX.md to reference all three files as priority reads
- Flag any findings that should update ICP.md or PERSONA.md
- Summarise the top 3 recommended angles for the next sequence
```

```markdown
# Command: Validate List

## Trigger
"Validate this list" or "Run a validation pass on [file]"

## Steps
1. Confirm active workspace (ICP.md + RULES.md loaded)
2. Load the raw CSV from lists/raw/
3. Score every record against ICP.md using the rubric in RULES.md
4. Add columns to output: icp_score, rejection_reason (if 0), review_flag (if 1)
5. Save validated file to lists/validated/
6. Output summary:
   - Total records reviewed
   - Count by score (0 / 1 / 2 / 3)
   - Top 3 rejection reasons
   - Records flagged for manual review
```

### validate-copy.md

```markdown
# Command: Validate Copy

## Trigger
"Validate this copy" or runs automatically after write-sequence

## Steps
1. Confirm active workspace (ICP.md + BRIEFING.md + RULES.md loaded)
2. Check each touch against:
   - Copy quality rules in RULES.md
   - Tone and constraints in BRIEFING.md
   - ICP relevance — does this land for the target persona?
3. Flag any violations inline with the reason
4. Suggest a revised version for each flagged line
5. Do not present the sequence as approved until all flags are resolved
```

### build-list-brief.md

```markdown
# Command: Build List Brief

## Trigger
"Create a list brief for this campaign"

## Steps
1. Load ICP.md and campaign.config.md for the active campaign
2. Output a structured brief for list building that includes:
   - Exact Apollo / Clay filter criteria
   - Required fields to pull
   - Enrichment fields to add
   - Signals to prioritize
   - Hard exclusion rules
3. Format as a copy-paste brief ready to hand to a VA or input into Clay
```

### write-sequence.md

```markdown
# Command: Write Outbound Sequence

## Trigger
"Write a [N]-touch sequence" or "Draft the outbound sequence for [campaign]"

## Steps
1. Load BRIEFING.md and ICP.md from active workspace
2. Load campaign.config.md for channel and touch count
3. Draft each touch in order:
   - Touch 1: cold open, hook-led, single CTA
   - Touch 2: light nudge, different angle
   - Touch 3: value add or social proof
   - Touch 4 (if applicable): low-pressure close
4. After drafting: run validate-copy automatically
5. Present with inline flags for anything borderline
6. Save approved version to copy/approved/
```

### audit-briefing.md

```markdown
# Command: Audit Briefing

## Trigger
"Audit the briefing" or "What's missing from the briefing?"

## Steps
1. Load BRIEFING.md from active workspace
2. Check for gaps:
   - Is the offer specific or vague?
   - Is the hook defensible with the proof points provided?
   - Are tone guidelines concrete enough to write to?
   - Is the CTA clear and singular?
   - Are constraints defined?
3. Output a list of gaps with a specific question to resolve each one
4. Do not proceed with copy tasks until critical gaps are filled
```

### handle-replies.md

```markdown
# Command: Handle Replies

## Trigger
"Handle replies for [campaign]" or "Process new replies"

## Steps

### 1. Pull new replies
- Pull unprocessed replies from active email tools (Lemlist / Instantly / Smartlead)
- Pull unprocessed LinkedIn replies from Crispy
- Cross-reference with shipped list to identify sender

### 2. Classify each reply
Classify as one of seven types:
- Positive — interested, wants to talk, asking for next steps
- Negative — not interested, wrong timing, polite decline
- Objection — pushback that can be addressed (budget, timing, relevance, incumbent)
- Referral — not the right person, redirects to someone else
- OOO — out of office, auto-reply or human message
- Unsubscribe — explicit opt-out request or opt-out language
- Competitor mention — references a competing tool or vendor they use

### 3. Default action per type

**Positive:**
- Draft a warm, low-friction response moving toward booking
- Tone: human, unhurried, clear on next step
- CTA: suggest a specific time or send a booking link
- Update Attio: move to Interested stage
- Suggest: pause sequence for this contact

**Negative:**
- Draft a graceful close — acknowledge, leave the door open, no pressure
- Do not argue or re-pitch
- Update Attio: move to Not Interested
- Pause sequence immediately

**Objection:**
- Load PERSONA.md objection map
- Match the specific objection to the closest known counter
- Draft a response that addresses it directly without being defensive
- Flag if the objection is not in PERSONA.md — suggest adding it after the campaign

**Referral:**
- Draft a thank-you to the original contact
- Draft a new personalised first-touch for the referred contact
- Check if referred contact already exists in Attio
- Create new record in Attio if not — tag as referral with source noted

**OOO:**
- Extract return date from message if present
- Schedule a follow-up touch for return date + 1 business day
- Log in Attio with OOO flag and expected return date
- No response drafted

**Unsubscribe:**
- Remove from sequence immediately — no delay
- Add do-not-contact flag in Attio
- Log removal with timestamp
- Never surface this contact in any future campaign suggestion
- No response drafted

**Competitor mention:**
- Load competitor context from PERSONA.md if available
- Draft a response that acknowledges their current setup
- Reframe — find the gap or the reason to consider switching
- No attacking, no dismissing the competitor
- Keep it short — one point only

### 4. Validate all drafts against TOV.md
Before presenting, check every drafted response against:
- Sentence structure and length rules
- Words to use and never use
- Channel-specific rules (email vs LinkedIn)
Flag any violations and revise before presenting

### 5. Present for approval
Show each classified reply and its proposed response together.
For each one: confirm classification, review draft, approve or edit.
Nothing is sent until explicitly approved.

### 6. Log and save
- Save all reply classifications to replies/[YYYY-MM-DD].md
- Update Attio for all actioned contacts
- Note any new objections or patterns to flag in next health check
```

### scan-signals.md

```markdown
# Command: Scan Signals

## Trigger
"Scan for signals" or "Run a signal check for [campaign]"

## Steps

### 1. Load context
- Load shipped list from lists/shipped/
- Load ICP.md to know what signals are relevant for this segment
- Load signal-angles.md from context/research/ for reference angles

### 2. Pull live signals
Query connected signal APIs for each contact/company in the shipped list:

**Signalbase:**
- Funding announcements
- Executive hires and departures
- Company expansions and new office openings
- M&A activity

**Commonroom:**
- Community activity and engagement spikes
- Social signals and content publishing
- Intent signals and topic interest changes

Cross-reference every signal against the shipped list.
Only surface signals for contacts who are still in-sequence or recently replied.

### 3. Assess each signal
For every matched signal:
- Is it relevant to the campaign offer? (yes / borderline / no)
- How old is it? (flag if older than 14 days as stale)
- Does it match an existing angle in signal-angles.md?
- If no existing angle — draft a new one

### 4. Draft immediate action messages
For each relevant, fresh signal:
1. Draft a personalised outreach message referencing the signal naturally
2. Connect it to the campaign offer without forcing it
3. Validate against TOV.md, PERSONA.md, and BRIEFING.md
4. Flag if the signal is time-sensitive (e.g. funding announced today)

### 5. Present for decision
For each signal and draft:
- Show the signal with source and date
- Show the drafted message
- Ask: "Send as a one-off touch outside the sequence, or replace the next scheduled touch?"
- Wait for explicit decision before any action

### 6. Save and update
- Save all identified signals to context/research/signal-angles.md (append, do not overwrite)
- Log all actioned signals in logs/decisions.md
- Update Attio with signal note on relevant contacts
```

```markdown
# Command: Sync Data

## Trigger
"Sync data for [campaign]" or "Pull latest data from all tools"

## Steps
1. Load TOOLS.md — identify which tools are active and in bidirectional or read mode
2. For each active tool, pull the latest data via direct API call:

   Apollo:
   - Contact status updates for shipped list records
   - Bounce and invalid email flags
   - Save to sync/apollo/[YYYY-MM-DD-HH].json

   Clay:
   - Enrichment results for any pending jobs
   - Field-level updates for records in validated/
   - Save to sync/clay/[YYYY-MM-DD-HH].json

   Lemlist:
   - Per-sequence: open rate, reply rate, bounce rate, unsubscribe rate
   - Per-touch: open rate, click rate, reply rate
   - Reply text samples (last 50 replies, anonymised on save)
   - Save to sync/lemlist/[YYYY-MM-DD-HH].json

   Instantly:
   - Per-campaign: open rate, reply rate, bounce rate, deliverability flags
   - Sending domain health signals
   - Save to sync/instantly/[YYYY-MM-DD-HH].json

   Smartlead:
   - Per-campaign: open rate, reply rate, bounce rate, deliverability flags
   - Save to sync/smartlead/[YYYY-MM-DD-HH].json

   Crispy:
   - Connection acceptance rate
   - Reply rate and reply content samples
   - Save to sync/crispy/[YYYY-MM-DD-HH].json

   Attio:
   - Deal stage distribution for contacts in this campaign
   - New replies or status changes since last sync
   - Contacts marked won, lost, or disqualified
   - Save to sync/attio/[YYYY-MM-DD-HH].json

3. Confirm sync complete — show timestamp and record count per tool
4. Flag if any tool returned an error or empty response
5. Do not analyse yet — sync is a data pull only. Run campaign-health-check to analyse.
```

### campaign-health-check.md

```markdown
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
- Contacts who replied → how many moved to meeting / deal stage
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
- "38% of negative replies contain the word 'already using [competitor]'.
  Suggest adding this as an objection in PERSONA.md with a suggested response.
  Apply this change?"

### 7. Health check summary
Output a single summary with:
- Overall campaign status: on track / needs attention / critical
- Top 3 things working
- Top 3 things to fix
- Pending suggestions (those not yet accepted or declined)

Save full health check to: performance/health-check-[YYYY-MM-DD].md
```

```markdown
# Command: Performance Review

## Trigger
"Review performance for [campaign]" or "Run a performance debrief"

## Steps

### Per-campaign debrief
1. Load performance/results.md from the active campaign
2. Load the approved copy from copy/approved/
3. Cross-reference metrics with copy — which touches and angles performed
4. Output structured debrief:
   - What worked: angles, touches, titles that responded
   - What did not: drop-off points, ignored angles, titles that went cold
   - Anomalies: anything unexpected worth investigating
   - Recommended carry-forwards for next campaign

### Forward feed — ICP refinement
1. If any job title or company type consistently underperformed → flag for ICP.md review
2. If bounce rate was high on a segment → flag RULES.md review for that list source
3. Suggest specific edits to ICP scoring criteria based on results

### Forward feed — persona refinement
1. If any objection appeared repeatedly in negative replies → add to PERSONA.md objection map
2. If any language in positive replies stands out → add to buyer voice section
3. If champion vs economic buyer split was unclear → flag for PERSONA.md stakeholder map

### Forward feed — copy improvement
1. Extract the single best-performing angle → flag for next BRIEFING.md
2. Extract the worst-performing angle → add to BRIEFING.md as angle to avoid
3. Suggest 2-3 new angles to test based on what resonated

### Output
Save debrief summary to: performance/debrief-[YYYY-MM-DD].md
Update logs/decisions.md with key decisions made from this review
```

### handle-reply.md

```markdown
# Command: Handle Reply

## Trigger
"Handle this reply" or "Process reply from [name]"

## Steps

1. Read the reply text in full
2. Classify into one of seven types:
   - Positive — interested, wants to talk
   - Negative — not interested or wrong timing
   - Objection — pushback that can be handled
   - Referral — not the right person, forwarded elsewhere
   - OOO — out of office
   - Unsubscribe — wants to be removed
   - Competitor mention — currently using something else

3. Load relevant context:
   - PERSONA.md — objection map, stakeholder notes, buyer voice
   - TOV.md — voice, channel rules, sentence structure
   - BRIEFING.md — offer and angle, for objection and competitor responses

4. Draft response based on type:

   Positive → advance to meeting, warm but brief, single ask
   Negative → acknowledge gracefully, door left open, no pushback
   Objection → match to objection map, use mapped response, flag if not in map
   Referral → thank, acknowledge referral, flag referred contact for research
   OOO → no response needed, extract return date, suggest Attio follow-up task
   Unsubscribe → no response, flag for immediate sequence removal and Attio update
   Competitor → acknowledge without disparaging, pivot to specific differentiation

5. Run voice check against TOV.md before presenting draft

6. Present:
   - Classification
   - Suggested response (if applicable)
   - Suggested Attio status update
   - Suggested sequence action (pause / remove / continue)

7. Wait for explicit approval before any action
8. Log classification and outcome in campaign logs/decisions.md
```

### scan-signals.md

```markdown
# Command: Scan Signals

## Trigger
"Scan for signals on [campaign]" or "Check for immediate action triggers"

## Steps

1. Load the shipped list for the active campaign
2. Load active signal tools from TOOLS.md (Signalbase, Commonroom, etc.)
3. For each active signal tool, query for activity on companies and contacts in the list:
   - Funding rounds (last 30 days)
   - Key executive hires or job changes
   - Product launches or expansions
   - News mentions relevant to the campaign angle
   - Event participation or speaking slots

4. For each signal found:
   - Match to the relevant contact(s) in the shipped list
   - Check signal-angles.md for an existing angle that fits
   - If no match: generate a new angle using the signal + BRIEFING.md
   - Draft a signal-triggered outreach message:
     * Reference the signal in line 1
     * Connect to the offer in 2–3 sentences
     * Apply TOV.md — timely, not opportunistic
     * Max 60 words, single CTA
   - Flag signal expiry (default: 7 days from detection date)

5. Present all signals as a prioritised list:
   - Signal, company/contact, angle, draft message, expiry date
   - Highest-urgency signals first

6. For each signal: ask "Send this to [contact] via [tool]?"
7. On approval: push to the relevant sending tool with credit confirmation
8. Save all detected signals to context/research/signal-angles.md
9. Log approved sends in campaign logs/decisions.md
```

### icp-stress-test.md

```markdown
# Command: ICP Stress Test

## Trigger
"Stress test the ICP" or "Challenge the ICP assumptions"

## Steps
1. Load ICP.md from active workspace
2. Challenge each major assumption:
   - Are anti-signals tight enough, or could valid targets be excluded?
   - Are job titles too narrow or too broad?
   - Do the pain points differentiate, or are they generic to the category?
   - Are the scoring criteria specific enough to apply consistently?
3. Propose 3 edge cases that would expose weaknesses in the current ICP
4. Suggest specific refinements — not just questions
```

---

## 10. Global rules spec

### global/RULES-GLOBAL.md

Cross-client standards loaded by Claude alongside the client-level RULES.md.

```markdown
# Global Rules

## Email deliverability
- Never send to unverified addresses without flagging catch-all status
- Do not import contacts with known bounce history
- Minimum 3 days between touches in any sequence

## GDPR and compliance
- Only prospect individuals where legitimate interest applies
- Do not store personal data beyond what is needed for the campaign
- Honour unsubscribes immediately — flag any opted-out contact before it enters a sequence

## Copy ethics
- Never fabricate proof points, data, or case study details
- Never imply an existing relationship that does not exist
- Never use urgency that is invented (fake deadlines, false scarcity)

## List sourcing
- Only use data from sources with legitimate collection practices
- Do not use scraped personal data without a valid legal basis
```

---

## 11. Workflows

### Onboard a new workspace

```
1. Say: "Onboard a new workspace" or "Run the intake interview"
2. Claude creates the folder structure from _template/ and asks intake questions in blocks
3. Block 6 covers tool stack — Claude asks which tools are active and what the credit rules are
4. Claude writes all answers into ICP.md, BRIEFING.md, workspace.config.md, and TOOLS.md
5. Claude checks .env for required API keys — flags any that are missing
6. Add any missing keys to .env manually
7. Review all written files — correct anything off
8. Say: "Run research for [client-name]"
9. Claude researches ICP company signals and market landscape, saves to context/research/
10. Claude flags any findings that should refine ICP.md or BRIEFING.md
11. Make any refinements — client is ready to work
```

### Start a new campaign

```
1. cp -r workspaces/[workspace]/campaigns/_campaign-template workspaces/[workspace]/campaigns/[name]
2. Fill campaign.config.md
3. Say: "Load client [client-name], campaign [campaign-name]"
4. Run audit-briefing before writing any copy
5. Fill gaps Claude surfaces before proceeding
```

### Build and validate a list

```
1. Pull raw data from Apollo / Clay
2. Drop CSV into workspaces/[workspace]/campaigns/[campaign]/lists/raw/
3. Say: "Validate the list at [path]"
4. Claude scores every record, outputs to validated/
5. Review score-1 records manually
6. Say: "Mark this list as shipped"
7. Claude moves approved records to shipped/
```

### Write and approve a sequence

```
1. Confirm client and campaign are loaded
2. Say: "Write a 4-touch cold email sequence"
3. Claude drafts, then auto-runs validate-copy
4. Review flagged lines — approve revisions or override with a reason
5. Log override decisions in campaigns/[campaign]/logs/decisions.md
6. Approved copy saves to copy/approved/
```

### Update context after a client call

```
1. Write up notes
2. Save to workspaces/[workspace]/context/meeting-notes/[YYYY-MM-DD-topic].md
3. Update context/INDEX.md if anything is now a priority read
4. Say: "I've added new meeting notes for [workspace] — update your context"
5. Claude reads the notes and flags if anything affects ICP, briefing, or active campaigns
```

---

## 12. MVP scope

### Phase 1 — Core framework
- GitHub repo with full folder structure including replies/ and sync/ per campaign
- `GTMOS.md` written and tested in Claude Code — five-check validation, TOV loaded on startup
- `_template/` complete with all files including TOV.md
- `example-workspace/` with realistic fictional data across all files
- `intake-interview` command — including TOV and tool blocks
- `run-research` command with signal-to-angle extraction
- `validate-list` command
- `write-sequence` command
- `global/RULES-GLOBAL.md`

### Phase 2 — Live campaign intelligence and reply handling
- `sync-data` command — direct API to all 9 tools
- `campaign-health-check` command — full analysis with pattern detection
- `handle-replies` command — all 7 reply types, TOV-validated drafts
- `scan-signals` command — Signalbase and Commonroom integration
- `performance-review` command with forward-feed logic
- All bidirectional syncs tested and validated per tool

### Phase 3 — Full command library and hardening
- All 13 commands written, tested, and documented
- Multi-client switching tested across 3+ clients
- `audit-briefing` and `icp-stress-test` validated on real campaigns
- `snippet-library.md` seeded with reusable copy fragments
- README polished for public use
- `.gitignore` finalized — excludes .env, raw lists, sync/ snapshots

---

## 13. Success criteria

- Claude never writes copy without loading briefing, persona, and TOV first
- Every copy output passes five checks before being presented
- Reply handler classifies and drafts responses for all 7 reply types
- Signal scanner surfaces and connects signals to personalised messages before the window closes
- Live data syncs from all 9 tools with a single command
- Health checks surface patterns connected to specific suggested file edits
- No ICP, persona, briefing, or TOV change applied without explicit approval
- Performance data from every campaign feeds forward into the next
- Nothing moves to approved/ or shipped/ without a log entry
- Switching between clients takes under 60 seconds
- The framework works equally well for a solo in-house operator or an agency managing twenty clients

---

## 14. Decisions made

- **Five sources of truth:** ICP.md (company), PERSONA.md (human), BRIEFING.md (campaign), TOV.md (voice), RULES.md (quality) — each with one job, none merged
- **TOV.md:** Per client, full brand voice — structure, style, formality, channel rules (email vs LinkedIn), words to use/avoid, before/after rewrites
- **Reply handler:** Classifies 7 reply types, drafts responses validated against TOV.md, presents for approval — nothing sent automatically
- **Immediate actions:** Signal-triggered outreach from Signalbase and Commonroom, cross-referenced against shipped list, drafted and presented for decision
- **Signal staleness threshold:** 14 days — flagged as stale but still presented for human decision
- **Integration model:** Direct API calls from Claude Code — no middleware
- **Bidirectional sync:** Apollo, Clay, Lemlist, Instantly, Smartlead, Crispy, Attio — all bidirectional. Signalbase and Commonroom read-only
- **Reads auto-approved, writes require credit rule check**
- **Sync storage:** Timestamped JSON snapshots in sync/ per tool per campaign
- **Pattern detection:** Suggests specific file edits with data behind them — never applies silently
- **Health check is on-demand** — Claude runs when instructed
- **Output format for validated lists:** CSV with score columns
- **Global rules:** Separate `global/RULES-GLOBAL.md` loaded alongside client rules
- **Raw lists and sync snapshots:** Gitignored by default
- **Branding:** `GTMOS.md` only — everything else plain English
- **Supported tools at launch:** Apollo, Clay, Lemlist, Instantly, Smartlead, Crispy, Attio, Signalbase, Commonroom
- **API key storage:** Single `.env` at repo root, always gitignored
- **Collaboration:** Four roles (Owner / Contributor / Approver / Client), log entry required before any file moves to approved/ or shipped/
