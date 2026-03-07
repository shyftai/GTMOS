# A/B Testing — Command Reference

> GTM:OS Command: `ab-test`
> Lifecycle: Setup > Run > Evaluate > Resolve > Forward-Feed

---

## 1. What Can Be A/B Tested

| Variable          | Metric to Measure | Notes                                      |
|-------------------|--------------------|--------------------------------------------|
| Subject line      | Open rate          | Most common and fastest test to run         |
| Opening line      | Reply rate         | First 1-2 sentences after the greeting      |
| CTA               | Reply rate         | The specific ask or call-to-action          |
| Full email body   | Reply rate         | Use when testing entirely different angles   |
| Send time         | Open rate          | Day of week and/or time of day              |
| Sender name       | Open rate          | First name, full name, or role-based        |
| Sequence length   | Overall reply rate | Compare 3-step vs 5-step, etc.             |

**Rule: Only test ONE variable at a time.** If you change the subject line, the body must remain identical across variants. Isolate the variable or the results are meaningless.

---

## 2. Test Setup

### Define Your Hypothesis

Before creating any test, write a hypothesis in plain language:

> "I believe [Variant B] will outperform [Variant A] on [metric] because [reasoning]."

Example:
> "I believe a pain-point subject line will outperform a curiosity-based subject line on open rate because it signals immediate relevance."

### Define Variants

- **Variant A (Control):** The current default or baseline version.
- **Variant B (Challenger):** The new version being tested against the control.

Each variant must be clearly labeled and documented before sending begins.

### Minimum Sample Size

| Threshold     | Contacts Per Variant | Total Test Size |
|---------------|----------------------|-----------------|
| **Minimum**   | 50                   | 100             |
| **Recommended**| 100                 | 200             |

Never run a test on fewer than 50 contacts per variant. Results below this threshold are not actionable and should not inform decisions.

### Metric Selection

| If testing...       | Measure...   |
|---------------------|-------------|
| Subject line        | Open rate    |
| Send time           | Open rate    |
| Sender name         | Open rate    |
| Opening line        | Reply rate   |
| CTA                 | Reply rate   |
| Full email body     | Reply rate   |
| Sequence length     | Reply rate   |

---

## 3. Running the Test

### List Splitting

- Split the eligible contact list **evenly** between Variant A and Variant B (50/50).
- Assignment must be **random** — never alphabetical, never by company name, never by import order.
- If using a sequencer, use its built-in randomization. If splitting manually, shuffle the list before dividing.

### Send Window

- Both variants must be sent in the **same send window** (same day, same time range).
- Do not send Variant A on Monday and Variant B on Thursday. Time-of-day and day-of-week effects will contaminate results.
- If testing send time specifically, this rule is obviously excepted — but all other variables must remain identical.

### During the Test

- Do not modify either variant once sends have started.
- Do not pull contacts out of one variant mid-test.
- Let the test run until both variants reach the minimum sample size.

---

## 4. Statistical Significance

### When to Declare a Winner

Do NOT declare a winner based on gut feel. Use these thresholds:

```
SIGNIFICANCE RULES
------------------
Path 1: 50+ sends per variant AND >20% relative difference
Path 2: 100+ sends per variant AND >10% relative difference
```

**Relative difference** is calculated as:

```
Relative Difference = |A_rate - B_rate| / min(A_rate, B_rate) * 100
```

Example: Variant A has 22% open rate, Variant B has 28% open rate.
- Absolute difference: 6 percentage points
- Relative difference: (28 - 22) / 22 * 100 = 27.3% — exceeds 20%, winner can be declared at 50+ sends.

### Inconclusive Results

If neither significance path is met after both variants reach 100+ sends, log the test as **"Inconclusive"** and move on. Do not:

- Keep running the test hoping for divergence
- Cherry-pick a sub-segment where one variant "won"
- Declare a winner based on a 2-3% difference

Inconclusive is a valid outcome. It means the variable you tested does not meaningfully impact results for this audience. Log it and test something else.

---

## 5. Declaring a Winner

When significance is reached, display results in a GTM:OS results box:

```
+----------------------------------------------------------+
|  A/B TEST RESULT                                          |
|----------------------------------------------------------|
|  Test ID:     AB-2026-003                                 |
|  Variable:    Subject Line                                |
|  Metric:      Open Rate                                   |
|                                                           |
|  Variant A:   "Quick question about {{pain_point}}"       |
|  Result A:    18.4% open rate (n=112)                     |
|                                                           |
|  Variant B:   "{{first_name}}, saw this about {{company}}"|
|  Result B:    26.1% open rate (n=108)                     |
|                                                           |
|  Relative Difference: 41.8%                               |
|  WINNER: Variant B                                        |
|  Confidence: High (100+ sends, >10% relative diff)       |
+----------------------------------------------------------+
```

Confidence levels:
- **High:** 100+ sends per variant, >10% relative difference
- **Moderate:** 50+ sends per variant, >20% relative difference
- **Inconclusive:** Neither threshold met

---

## 6. Forward-Feed

Once a winner is declared, apply results immediately:

1. **Update default:** The winning variant becomes the new default for the campaign. Replace the current version in the active sequence.
2. **Archive loser:** Move the losing variant to the campaign's archive or note it as deprecated. Do not delete — keep for historical reference.
3. **Snippet library:** If the winning pattern is reusable (e.g., a subject line formula, a CTA structure), add it to `snippet-library.md` with the test ID and performance data as provenance.
4. **Trends log:** Log the insight in `performance/trends.md` so it informs future campaign design. Example entry: "Pain-point subject lines outperform curiosity-based by ~40% for DevOps persona (AB-2026-003)."

Forward-feed is not optional. A test without applied learnings is wasted effort.

---

## 7. Tracking

Maintain a test log at the campaign level in `performance/ab-tests.md`.

Each test entry must include:

| Field       | Description                                         |
|-------------|-----------------------------------------------------|
| Test ID     | Unique identifier (format: AB-YYYY-NNN)             |
| Date        | Date the test was started                           |
| Variable    | What was tested (subject line, CTA, etc.)           |
| Variant A   | Description or text of Variant A                    |
| Variant B   | Description or text of Variant B                    |
| Metric      | What was measured (open rate, reply rate)            |
| A Result    | Variant A performance (rate + sample size)           |
| B Result    | Variant B performance (rate + sample size)           |
| Winner      | A, B, or Inconclusive                               |
| Applied     | Whether the result was forward-fed (Yes/No/Pending) |

Test IDs are sequential per year. The first test of 2026 is AB-2026-001.

---

## 8. Rules

1. **One variable at a time.** Never test subject line and CTA simultaneously. Isolate or invalidate.
2. **Minimum 50 contacts per variant.** Non-negotiable floor. Below this, results are noise.
3. **Always have a hypothesis.** "Let's just try something different" is not a hypothesis. State what you expect and why.
4. **Random assignment only.** No alphabetical splits, no geographic splits (unless geography is the variable).
5. **Same send window.** Both variants go out at the same time unless send time is the variable being tested.
6. **Don't peek and stop early.** Let both variants reach minimum sample size before evaluating.
7. **Forward-feed every result.** Winners get applied. Inconclusive gets logged. Nothing gets ignored.
8. **One active test per campaign.** Do not run overlapping tests in the same campaign. Finish one, apply results, then start the next.
