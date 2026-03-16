---
name: agency:referral
description: Run a referral activation campaign with existing happy clients
argument-hint: "<workspace-name>"
---
<objective>
Identify Green-health clients, draft personalised referral ask messages, and track referral asks in CLIENTS.md.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./references/agency-campaigns.md
@./../../.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< AGENCY:OS // REFERRAL ACTIVATION >>`

2. Load workspace files:
   - `CLIENTS.md` — full client roster and health statuses
   - `ICP.md` — to describe the ideal referral target in outreach
   - `PIPELINE.md` — to log referral pipeline entries

3. Load agency-campaigns.md (referral activation section).

4. Filter eligible clients:
   Only Green-health clients qualify for referral asks.

   ```
   ┌─ REFERRAL ELIGIBILITY ──────────────────────────────┐
   │                                                     │
   │  Eligible (Green):   {count} clients                │
   │  Ineligible (Yellow): {count} — skip               │
   │  Ineligible (Red):   {count} — skip                 │
   │                                                     │
   │  Eligible clients:                                  │
   │  [x] {Client 1} — {MRR} — since {date}             │
   │  [x] {Client 2} — {MRR} — since {date}             │
   │                                                     │
   └─────────────────────────────────────────────────────┘
   ```

   If no Green clients: "No Green-health clients available for referral asks. Check CLIENTS.md — update health statuses and try again."

5. For each eligible client, ask for:
   - Their most significant result to date (to personalise the referral ask)
   - Preferred outreach channel: email / Slack / in their next call
   - Any specific people or companies they've mentioned who might be a fit

6. Draft personalised referral messages (1–2 touches per client):

   **Touch 1 template (personalised per client):**
   Subject / Slack heading: "quick favour — intro?"

   Body:
   "[Name] — [result specific to this client] has been great to be part of. We're looking to work with a few more companies like [their company] this quarter — [ICP description in their language].

   Any chance you know someone in your network who'd benefit from the same results? Happy to make it easy — one intro email is all it takes, and I'll take it from there.

   No pressure at all. [Your name]"

   Max 80 words. Personalise the result and the ICP description per client.

   **Touch 2 (optional — 10 days later, if no response):**
   "[Name] — following up on my last note. If anyone comes to mind, I'd love a quick intro. If not, no problem at all — just keeping the door open."
   Max 30 words.

7. Include a shareable result one-liner for each client:
   A sentence the client can forward as context with their intro.
   "[Agency name] helped us [specific result] in [timeframe]. They're [one sentence on approach]. Worth an intro if you know anyone who needs the same."

8. Quality check all messages:
   - Uses client's specific result — not a generic claim
   - Soft ask — not a pressure
   - ICP description is accurate (matches ICP.md)
   - No banned phrases

9. Log referral asks in CLIENTS.md:
   For each client where a referral ask is being made, add to their record:
   "Referral ask sent: [date]"

10. Track referral pipeline in PIPELINE.md:
    When an introduction is made, add to Stage 3 — Replied with source = "referral from [client]".

11. Suggest next steps:
    ```
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      >> Send referral asks → track introductions in PIPELINE.md
         For any referral that books a call: /agency:pitch {workspace} {company}
         Run this command again in 90 days (after next QBR cycle)

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ```
</process>
