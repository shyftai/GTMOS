# Command: Scan Signals

## Trigger
"Scan for signals on [campaign]" or "Check for immediate action triggers"

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
