# Experiment Design — GTMOS

Change your list, your copy, and your offer at the same time and you learn nothing. This framework forces **one variable per experiment** so the result is actually attributable. Loaded by `/gtm:experiment`; feeds `LEARNINGS.md` and the quarterly review in `weekly-rhythm.md`.

The success metric is always **positive reply rate** (`positive-reply-scoring.md`), measured after the sequence completes — not raw reply rate, not opens.

---

## Three experiment types

| Type | What varies | What stays fixed | Confidence |
|------|-------------|------------------|-----------|
| **List-only** | targeting criteria | copy, offer, infrastructure, timing | HIGH on targeting, LOW on copy |
| **Copy-only** | subject / body / sequence / variant | list, offer, infrastructure | HIGH on copy, LOW on targeting |
| **Combined** (sparingly) | list AND copy (± offer) | infrastructure only | MEDIUM on everything — hypothesis-generation, not conclusion |

Use combined only when launching a whole new campaign for a new ICP, where nothing can be held constant. Never adopt a combined-experiment winner as a new baseline — split it into single-variable follow-ups first.

---

## The framework

**1. Name the hypothesis (one sentence).**
> "Targeting Heads of Marketing at 50-200-person B2B SaaS will get a higher positive reply rate than our VP Sales baseline, because [reason]."

If you can't write it in one sentence, you don't understand the experiment yet.

**2. Identify the single variable.** Write what changes and explicitly list what stays fixed (industry, headcount, geo, copy, offer, infrastructure, schedule). If any "constant" is actually changing, lock it down or reclassify as combined.

**3. Baseline sanity check — the 1% rule.** Before running anything, confirm the baseline is healthy: overall reply rate ≥1% after 200+ sends. A broken baseline means you'll only learn "both arms are bad." Fix infrastructure/copy first via `/gtm:inbox-health` and `/gtm:validate-copy`.

**4. Minimum sample size.** Smaller effects need more volume:

| Baseline positive reply rate | Expected lift | Min sends per arm |
|---|---|---|
| 1% | 2× (→2%) | ~500 |
| 1% | 1.5× (→1.5%) | ~2,000 |
| 1% | 1.2× (→1.2%) | ~10,000 |
| 2% | 2× (→4%) | ~250 |
| 2% | 1.5× (→3%) | ~1,000 |

Rule of thumb: under 500 sends per arm, you can't tell signal from noise. Default to 2,000 per arm for beginners.

**5. Success criteria, set up front (not after seeing data):**
```
Success      = positive reply rate > X%   (baseline is Y%)
Failure      = positive reply rate < Z%
Inconclusive = between X and Z
Sample       = ≥ N sends per arm, measured at day 21
```

**6. Launch both arms simultaneously.** Same day, same infrastructure split, same schedule. If control sends Monday and variant sends Thursday, day-of-week effects confound the test. Best practice: two separate campaigns, half the inboxes each, launched at the same time.

**7. Measure at day 21.** Wait until the full sequence + reply grace period has finished for all leads. Pull metrics via `/gtm:reply-score` for each arm. Report positive reply rate as primary; bounce rate as a sanity check (if one arm bounces 2× the other, the list is bad — disqualify the test, not the copy).

**8. Weight the learnings.** Report HIGH confidence only if the type isolates the variable AND the sample meets the minimum. Otherwise MEDIUM/LOW. Decide:
- Winner ≥20% lift, HIGH confidence → adopt as new baseline, document in `LEARNINGS.md`
- Winner 10-20%, HIGH → run a replication with fresh leads; adopt if it wins again
- Winner <10% → inconclusive; run bigger or drop
- Loser → document *why* you think it lost (the loss is a learning)

---

## Priority order of experiments

Don't test step 6 while step 1 is broken:

1. **List** (biggest lever — a bad list kills any copy)
2. **Offer / lead magnet**
3. **Subject line** (cheap, drives opens)
4. **Opener / first line**
5. **CTA**
6. **Sequence timing**
7. **Sequence length**

Don't experiment at all until you have a baseline from a single shipped campaign that has run ~3 weeks. You need a control before you can run tests.

---

## Common mistakes

- A/B testing inside one campaign for hypothesis tests — the sending tool's built-in A/B mixes the data. Use two campaigns for real isolation. (The built-in variant feature is fine for small copy tweaks via `/gtm:ab-test`.)
- "I'll test three things at once" — you'll learn nothing.
- Calling it early — wait 21 days.
- Changing infrastructure mid-test.
- Ignoring bounce rate divergence.

---

## Output: experiment plan

Save to `campaigns/{campaign}/performance/experiments/{YYYY-MM-DD}-{name}.md` (create the folder if absent). Capture: name, hypothesis, type, variable, constants, success criteria, both arms (with sending-tool campaign IDs once launched), and a results block left empty until day 21. On completion, write the verdict + confidence + decision back into the same file and append the learning to `LEARNINGS.md`. This history is the input to the quarterly review in `weekly-rhythm.md`.
