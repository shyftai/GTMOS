# /rev:signals

Scan for time-sensitive revenue operations signals — data quality decay, pipeline risks, churn indicators, and forecast alerts.

## When to use

- Daily (quick scan) — surface anything that needs attention today
- Weekly (full scan) — comprehensive signal check before pipeline review
- Run automatically as part of /rev:today

---

## What to do

Load `rev-signals.md`, `PIPELINE.md`, `REVENUE.md`, `DATA-QUALITY.md`, and `STRIPE.md`.

### Step 1: Determine scan mode

Ask: "Quick scan (critical only) or full scan (all signals)?"

- **Quick scan:** 🔴 Critical signals only
- **Full scan:** 🔴 Critical + 🟡 Warning signals, with action plan

### Step 2: Run signal checks

Check each signal category from `rev-signals.md`:

**Data signals:**
- [ ] Stripe ↔ CRM ARR mismatch > 5%
- [ ] Duplicate accounts > 5% of total
- [ ] Opportunity owner field blank on active deals
- [ ] Close date not updated in > 14 days on active deals
- [ ] Enrichment decay on active deal contacts > 20%
- [ ] CRM field completion dropping below 70%

**Pipeline signals:**
- [ ] Deals stalled > 21 days in same stage
- [ ] No next meeting scheduled on deals > $[threshold] in evaluation
- [ ] Pipeline coverage below 2.5× quota for current quarter
- [ ] Win rate dropping > 5 points vs. prior quarter
- [ ] Average sales cycle lengthening > 20%

**Revenue signals:**
- [ ] Gross monthly churn > 2%
- [ ] NRR dropping below 100%
- [ ] Customer not logged in to product for > 30 days (if product data available)
- [ ] Renewal within 60 days without renewal conversation started
- [ ] Account executive change at key customer account

### Step 3: Present results

```
SIGNAL SCAN — [Date] | [Quick / Full] scan
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔴 CRITICAL ([X] signals)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Signal 1]
  → [What was found — specific numbers]
  → Recommended action: [Action]
  → Run: [Command that addresses this]

[Signal 2]
  → [What was found]
  → Recommended action: [Action]

[If no critical signals: "✓ No critical signals"]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🟡 WARNING ([X] signals)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Signal 1]
  → [What was found]
  → Recommended action: [Action]
  → Urgency: address this week

[If no warnings: "✓ No warnings"]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🟢 ALL CLEAR ([X] signals checked, [X] passed)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Step 4: Action prioritization

If multiple signals are active, prioritize by:
1. Revenue risk (direct ARR impact)
2. Urgency (how fast will it get worse?)
3. Ease of fix (quick wins first)

Present a ranked action list:

```
PRIORITY ACTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. [Action] — [Why urgent] — [Command to run]
2. [Action] — [Why urgent] — [Command to run]
3. [Action] — [Why urgent] — [Command to run]
```

### Step 5: Slack notification (if configured)

If signals are 🔴 Critical and Slack is configured in workspace.config.md, offer to post an alert to the configured channel.

**Format for Slack:**
```
🔴 REV:OS Alert — [Date]

[X] critical signals detected:

1. [Signal] — [One-line description]
2. [Signal] — [One-line description]

Full details: run /rev:signals
```
