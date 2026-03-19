---
name: agency:signals
description: Scan for buying signals on target prospects — funding, leadership changes, job postings, product launches
argument-hint: "<workspace-name> [--prospect <company> | --list <file>]"
---

<objective>
Find time-sensitive buying signals on prospects in the pipeline or a specified list. Surface actionable signals with urgency ratings, matched angles, and suggested outreach. Signals decay — act within the timing window or they lose relevance.
</objective>

<execution_context>
@./AGENCYOS.md
@./references/agency-signals.md
@./references/agency-campaigns.md
@./references/agency-personas.md
</execution_context>

<process>

1. Display header:
```
<< AGENCY:OS // SIGNALS >>
```

2. Load PIPELINE.md, ICP.md, CLIENTS.md.
   Load `references/agency-signals.md` for signal types, urgency ratings, and angles.

3. **Client conflict check (hard gate):** Load CLIENTS.md. Any company flagged as a signal target that already appears in CLIENTS.md must be removed from the scan list. Do not surface signals for existing clients through the new business channel.

4. Determine scan scope:
   - If `--prospect <company>` specified: scan that company only
   - If `--list <file>` specified: scan all companies in the file
   - If neither: scan all companies in PIPELINE.md stages 1–3 (Identified, Contacted, Replied) plus any ICP-matched prospects in cache

5. Check cache in `cache/signals/` — if a signal scan for a company was run < 7 days ago, use cached results. Signal scans expire faster than standard data (7 days not 30) because signals are time-sensitive.

6. For each company to scan, check for signals using available tools:

   **If Apollo available:**
   - Company news and funding data
   - Leadership change detection (CMO, VP Marketing, Head of Growth, CEO)
   - Job posting analysis (marketing roles = buying signal)

   **If Crispy (LinkedIn) available:**
   - Recent company LinkedIn posts (product launches, expansion announcements)
   - Leadership job change notifications
   - Team growth signals (rapid headcount increase)

   **If Firecrawl available:**
   - Company blog / news page for product launches, partnerships, expansions
   - Job board scrape for marketing role postings

   **If no tools available:**
   - Ask user to manually enter signals they have observed
   - Still run through signal classification and generate outreach angles

   Log each scan in `SCRAPE-JOURNAL.md`. Write results to `cache/signals/{company}-{date}.md` immediately after each company.

7. Classify each signal found against the signal types in agency-signals.md:

   | Signal found | Type | Urgency | Window | Best angle |
   |---|---|---|---|---|
   | {signal} | {type from agency-signals.md} | 🔴/🟡/🟢 | {X days} | {angle} |

8. Display results:

```
┌─ SIGNALS ─── {date} ──────────────────────────────────────────┐
│                                                               │
│  🔴 High urgency (act within 7 days):                         │
│  {Company} — {signal type} — {signal detail}                  │
│  Angle: {specific angle from agency-signals.md}               │
│  Window closes: {estimated date}                              │
│                                                               │
│  🟡 Medium urgency (act within 14 days):                      │
│  {Company} — {signal type} — {signal detail}                  │
│  Angle: {angle}                                               │
│                                                               │
│  🟢 Warm (monitor, no urgency):                               │
│  {Company} — {signal type}                                    │
│                                                               │
│  No signals found: {list companies with no active signals}    │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

9. For each 🔴 high-urgency signal, ask: "Do you want to draft outreach for {company} now?"

   If yes:
   - Load the matching persona from agency-personas.md (infer from contact title in PIPELINE.md)
   - Load the matching campaign type from agency-campaigns.md (signal-triggered)
   - Load `../../.claude/gtmos/references/cold-email-skill.md` if available
   - Draft a 3-touch signal-triggered sequence using the angle matched to the signal
   - Run the 6-check quality gate from AGENCYOS.md before presenting the draft
   - Suggest: `/agency:new-business {workspace}` to formalise as a full campaign

10. Update PIPELINE.md for each signalled company:
    - If already in pipeline: add signal to their record, update "last activity" date
    - If not yet in pipeline: ask "Do you want to add {company} to the pipeline?" — if yes, add at Stage 1 (Identified) with the signal as the source

11. Log the scan session in SCRAPE-JOURNAL.md:
```
## {date} Signals scan
Companies scanned: {count}
Signals found: {count} ({count 🔴} high / {count 🟡} medium / {count 🟢} warm)
Outreach drafted: {count}
Pipeline updated: {count}
Cache written: {count} files
```

</process>
