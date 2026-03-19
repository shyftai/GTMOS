---
name: agency:sow
description: Generate a statement of work for a new or existing client engagement
argument-hint: "<workspace-name> <client-name>"
---

<objective>
Produce a complete, valid Statement of Work for a client engagement. The SOW must have scope, deliverables, inclusions, exclusions, timeline, revision policy, fees, payment terms, and assumptions before it is considered valid. Incomplete SOWs are not valid and cannot be used for invoicing.
</objective>

<execution_context>
@./AGENCYOS.md
@./references/sow-templates.md
@./_template/clients/_client-template/CLIENT-BRIEF.md
@./_template/clients/_client-template/SOW.md
</execution_context>

<process>

1. Display header:
```
<< AGENCY:OS // SOW >>
Client: {client-name}
```

2. Load `clients/{client-name}/CLIENT-BRIEF.md` if it exists. Load SERVICE-LINES.md and PRICING.md.

3. Load `references/sow-templates.md`.

4. Ask in one block:
   - Which service lines are in scope for this engagement?
   - Is this a monthly retainer or a one-off project?
   - What is the intended start date?
   - Is there a fixed end date, or is this ongoing?
   - Are there any custom scope elements not covered by the standard service line templates?

5. For each service line selected: pull the matching SOW template from sow-templates.md. Pull pricing from PRICING.md.

6. Pre-fill from CLIENT-BRIEF.md: client name, goals, budget, constraints.

7. Walk through each SOW section. For anything that requires a specific client decision, ask:
   - Specific deliverables within each service line (confirm the standard list or customise)
   - Inclusions and exclusions (confirm defaults or adjust)
   - Number of revision rounds (default: 2)
   - Payment terms (default: Net 15 for projects, Net 30 for retainers)
   - Any custom assumptions that apply to this engagement

8. Run the SOW validity gate — the SOW is not valid without all of the following:
   - [ ] Scope of work defined (what will be done)
   - [ ] Deliverables listed (what will be produced)
   - [ ] Inclusions and exclusions explicit
   - [ ] Timeline with at least a start date and first delivery milestone
   - [ ] Revision policy stated
   - [ ] Fees: monthly retainer or project total, with any one-time setup fee
   - [ ] Payment terms
   - [ ] At least one assumption documented

   If any are missing: flag the gap and ask before proceeding. Do not generate an incomplete SOW.

9. Generate the complete SOW document using the `_template/clients/_client-template/SOW.md` structure.

10. Display the SOW and ask: "Does this look right? Any changes before I save it?"

11. After confirmation:
    - Set `**Status:** Pending signature` in the SOW header
    - Write to `clients/{client-name}/SOW.md`
    - Update `clients/{client-name}/CLIENT-BRIEF.md` with the contract start/end dates if not already set
    - Log the SOW in `logs/workspace-log.md`: date, client, SOW version, status

12. Mark as signed (when client returns the signed document):
    - Ask: "Has the client signed this SOW?"
    - If yes: update `**Status:** Signed` and add `**Signed date:** {date}` in `clients/{client-name}/SOW.md`
    - Signing unlocks invoicing. If status is not "Signed", `/agency:invoice` will hard-gate.

13. Suggest next steps:
    - "SOW is saved with status: Pending signature. Send it to the client for sign-off."
    - "Once signed, run `/agency:sow {workspace} {client-name}` and confirm signing to unlock invoicing."
    - If deposit invoice needed (project work): run after signing — `/agency:invoice {workspace} {client-name}`
    - If brief not yet created: `/agency:brief {workspace} {client-name}`

</process>
