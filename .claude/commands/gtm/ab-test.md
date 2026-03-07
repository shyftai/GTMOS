---
name: gtm:ab-test
description: Set up, track, or resolve an A/B test
argument-hint: "<workspace-name> <campaign-name> [setup|check|resolve]"
---

## execution_context

- @./commands/ab-test.md
- @./.claude/gtmos/references/ui-brand.md
- @./.claude/gtmos/references/cold-email-skill.md

---

## process

### Step 1 — Display Mode Header

Display the GTM:OS mode header following ui-brand.md conventions:

```
Mode: A/B TEST
Workspace: {{workspace-name}}
Campaign: {{campaign-name}}
Action: {{setup|check|resolve}}
```

Locate the workspace directory at `workspaces/{{workspace-name}}` and the campaign directory at `workspaces/{{workspace-name}}/campaigns/{{campaign-name}}`. Confirm both exist before proceeding. If either is missing, report the error and stop.

Load the campaign's test log from `performance/ab-tests.md` within the campaign directory. If it does not exist yet, create it from the template at `_template/campaigns/_campaign-template/performance/ab-tests.md`.

---

### Step 2 — Setup (if action is "setup")

1. **Ask what to test.** Present the list of testable variables from the ab-test command reference (subject line, opening line, CTA, full email body, send time, sender name, sequence length). The user selects one.

2. **Collect hypothesis.** Ask the user to state their hypothesis: "I believe [Variant B] will outperform [Variant A] on [metric] because [reasoning]."

3. **Define variants.** Ask the user to provide the text or configuration for Variant A (control) and Variant B (challenger). Display both side-by-side for confirmation.

4. **Determine metric.** Auto-select the metric based on the variable being tested (open rate for subject/send-time/sender, reply rate for body/CTA/opening). Confirm with user.

5. **Set sample size.** Ask how many contacts are available for this test. Enforce the 50-per-variant minimum. Recommend 100 per variant if the list supports it. If fewer than 100 total contacts are available, stop and advise the user the list is too small to test.

6. **Split the list.** Instruct on random 50/50 split. If the sequencer supports built-in A/B splitting, reference that. Otherwise, note that the list must be shuffled before dividing.

7. **Assign Test ID.** Read existing tests from `performance/ab-tests.md`, determine the next sequential ID (format: AB-YYYY-NNN), and assign it.

8. **Save test config.** Add a new row to `performance/ab-tests.md` with the test ID, today's date, variable, both variants, metric, and placeholders for results (marked as "Pending"). Set Winner to "—" and Applied to "No".

9. **Display confirmation.** Show the test setup in a GTM:OS-styled result box with all details. Remind the user: do not modify variants once sends begin, and let both variants reach minimum sample size before checking.

---

### Step 3 — Check (if action is "check")

1. **Identify active test.** Look in `performance/ab-tests.md` for tests with Winner marked as "—" (active/pending). If multiple active tests exist (which should not happen per the rules), flag the issue. If no active test exists, report that and stop.

2. **Collect current metrics.** Ask the user for the current performance numbers for each variant:
   - Number of sends for Variant A
   - Metric result for Variant A (open rate or reply rate as applicable)
   - Number of sends for Variant B
   - Metric result for Variant B

3. **Display comparison.** Show a side-by-side comparison in a GTM:OS-styled box:
   ```
   +----------------------------------------------------------+
   |  A/B TEST STATUS — {{Test ID}}                            |
   |----------------------------------------------------------|
   |  Variable:    {{variable}}                                |
   |  Metric:      {{metric}}                                  |
   |                                                           |
   |  Variant A:   {{variant_a_description}}                   |
   |  Sends:       {{a_sends}}    Result: {{a_rate}}           |
   |                                                           |
   |  Variant B:   {{variant_b_description}}                   |
   |  Sends:       {{b_sends}}    Result: {{b_rate}}           |
   |                                                           |
   |  Relative Difference: {{rel_diff}}%                       |
   |  Status: {{READY TO RESOLVE | NOT YET SIGNIFICANT | ...}} |
   +----------------------------------------------------------+
   ```

4. **Evaluate significance.** Apply the significance rules from the command reference:
   - Path 1: Both variants have 50+ sends AND relative difference >20%
   - Path 2: Both variants have 100+ sends AND relative difference >10%
   - If neither path is met but both have 100+ sends, flag as likely inconclusive.
   - If sample sizes are still below thresholds, advise to keep running.

5. **Recommend action.** Based on evaluation:
   - If significant: "This test is ready to resolve. Run `gtm:ab-test {{workspace}} {{campaign}} resolve` to declare the winner and apply forward-feed."
   - If not yet significant: "Keep running. Both variants need to reach {{target}} sends before evaluation."
   - If likely inconclusive: "Consider resolving as Inconclusive. The difference is within noise at 100+ sends."

---

### Step 4 — Resolve (if action is "resolve")

1. **Identify the active test.** Same as Check step 1.

2. **Confirm final metrics.** Ask for or confirm the final performance numbers for both variants. These are the numbers that will be recorded permanently.

3. **Calculate and declare winner.** Apply significance rules. Determine:
   - Winner (A, B, or Inconclusive)
   - Confidence level (High, Moderate, or Inconclusive)
   - Relative difference

4. **Display result box.** Show the full GTM:OS-styled A/B Test Result box as defined in the command reference, including test ID, variants, results, relative difference, winner, and confidence level.

5. **Apply forward-feed.** If a winner was declared (not Inconclusive):
   - a. **Update default:** Identify where the winning variant should replace the current default in the campaign's sequence files. Make the replacement or instruct the user to do so.
   - b. **Archive loser:** Note the losing variant as deprecated in the test log.
   - c. **Snippet library:** If the winning pattern is reusable, add it to `snippet-library.md` in the workspace with the test ID as provenance and the performance data.
   - d. **Trends log:** Add an insight entry to `performance/trends.md` in the campaign directory summarizing what was learned.

6. **Update test log.** Update the row in `performance/ab-tests.md`:
   - Fill in A Result and B Result with final numbers
   - Set Winner to A, B, or Inconclusive
   - Set Applied to "Yes" (if forward-feed was completed) or "Pending" (if user needs to manually apply)

7. **Display summary.** Confirm all forward-feed actions taken and display the updated test log entry.

---

## error_handling

- If workspace or campaign directory does not exist, display an error and list available workspaces/campaigns.
- If action is not one of `setup`, `check`, or `resolve`, display usage hint with the three valid actions.
- If no argument is provided, prompt the user for workspace name, campaign name, and action interactively.
- If a test is being set up but there is already an active (unresolved) test in the campaign, warn the user and cite the one-active-test-per-campaign rule. Ask if they want to resolve the existing test first.
