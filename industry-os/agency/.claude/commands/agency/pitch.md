---
name: agency:pitch
description: Generate a pitch or proposal for a qualified prospect
argument-hint: "<workspace-name> <prospect-company>"
---
<objective>
Generate a pitch or proposal tailored to a specific prospect. Matches case studies, selects pricing tier, and outputs a ready-to-send document.

Workspace and prospect company: $ARGUMENTS
</objective>

<execution_context>
@./references/pitch-frameworks.md
@./references/agency-personas.md
@./../../.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< AGENCY:OS // PITCH >>`

2. Load workspace files:
   - `SERVICE-LINES.md` — what the agency can actually deliver
   - `CASE-STUDIES.md` — available proof points
   - `PRICING.md` — service packages and tiers
   - `CLIENTS.md` — **HARD GATE: confirm prospect is not an existing client**

3. **Client conflict check (hard gate):**
   Search CLIENTS.md for the prospect company name and domain.
   If found: STOP — this is an existing client. Do not generate a new business pitch. Redirect to `/agency:upsell` or `/agency:qbr-prep`.

4. Load pitch-frameworks.md.

5. Gather prospect context (ask these in order, one block at a time):

   **Block 1: The company**
   - Company name and what they do
   - Company size (employees) and growth stage
   - Geography
   - How they came into pipeline (cold outbound / signal-triggered / referral / inbound)

   **Block 2: The deal context**
   - What is the key challenge or reason they're talking to the agency?
   - What have they tried before? (in-house, previous agency, nothing)
   - Which service line is most relevant?
   - What's their rough budget range? (if known)

   **Block 3: The buyer**
   - Who is the primary decision maker? (CMO / VP Marketing / Founder — or other title)
   - Who else is involved in the decision?
   - What matters most to them? (results / speed / accountability / price)

   **Block 4: Format**
   - Format preference: 1-page brief OR full proposal (5–8 slides)
   - Deadline: when does this need to be ready?

6. Match case studies:
   Search CASE-STUDIES.md for 2–3 case studies matching:
   - Same or adjacent industry/vertical
   - Same challenge or service line
   - Same company size range (if possible)

   If no direct match found: use closest available case study and note the gap.
   If no case study exists for this vertical: FLAG before proceeding. "No case study found for [vertical]. Proceeding with [closest match] — recommend adding a relevant case study before sending this proposal."

7. Select pricing tier:
   Based on scope discussed and budget signals:
   - Default recommendation: Growth tier (present all three)
   - If budget signals are low: lead with Starter
   - If scope discussed is comprehensive: lead with Scale
   Load PRICING.md to confirm exact figures.

8. Generate pitch in selected format:

   **If 1-page brief:**
   Follow the 1-page brief template from pitch-frameworks.md.
   Sections: situation, approach, proof, scope, next step.
   Length: max one page / one screen.

   **If full proposal (5–8 slides):**
   Follow the full proposal structure from pitch-frameworks.md.
   Slides: situation, what we found, approach, case studies, team, pricing (3 tiers), next steps.
   Include speaker notes for each slide.

9. **Service line gate (hard gate):**
   Review the completed pitch for any promise, capability, or deliverable not listed in SERVICE-LINES.md.
   If found: STOP — flag the item. "This proposal references [X] which is not in SERVICE-LINES.md. Confirm before sending."
   Do not send until resolved.

10. Quality check:
    ```
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    PITCH VALIDATION
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    [x] Prospect not in CLIENTS.md (conflict check passed)
    [x] All services referenced are in SERVICE-LINES.md
    [x] At least one case study included from CASE-STUDIES.md
    [x] Pricing from PRICING.md — no invented figures
    [x] Persona tone matches buyer type
    [x] No unsupported claims or fabricated results
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ```

11. Update PIPELINE.md:
    Move prospect to Stage 5 — Proposal Sent.
    Record: proposal date, value, services, follow-up date (7 days from today).

12. Suggest next steps:
    ```
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      >> Proposal sent — set 7-day follow-up reminder
         If they say yes: /agency:client-onboard {workspace} {company}
         If they ask for QBR after onboarding: /agency:qbr-prep {workspace} {company}

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ```
</process>
