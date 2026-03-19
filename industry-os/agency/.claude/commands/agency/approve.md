---
name: agency:approve
description: Handle client approvals — track pending items, send reminders, record sign-offs
argument-hint: "<workspace-name> [client-name]"
---

<objective>
Surface all deliverables waiting on client approval, help the operator follow up on slow approvals, and record sign-offs when received. Keep the delivery pipeline moving — waiting on approval is the most common cause of delivery delays.
</objective>

<execution_context>
@./AGENCYOS.md
@./_template/clients/_client-template/DELIVERABLES.md
@./_template/clients/_client-template/CONTACTS.md
</execution_context>

<process>

1. Display header:
```
<< AGENCY:OS // APPROVE >>
{if client specified: "Client: {client-name}" | if not: "All clients"}
```

2. Load DELIVERABLES.md. If client specified, also load `clients/{client-name}/DELIVERABLES.md` and `clients/{client-name}/CONTACTS.md`.

3. Filter for all deliverables with status "Pending Approval". Display:

```
┌─ PENDING APPROVAL ─────────────────────────────────────────────┐
│                                                                │
│  {Deliverable} · {Client} · Sent {date} · {X} days waiting    │
│  Contact: {approver name}                                      │
│  {repeat for each}                                             │
│                                                                │
│  Nothing pending approval. {if empty}                          │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

Flag with urgency:
- 1–3 days waiting: normal
- 4–5 days waiting: 🟡 follow-up recommended
- 6+ days waiting: 🔴 escalate — this is blocking delivery

4. For each pending item, ask: "Did you receive a response on {deliverable}?"
   - **Yes, approved** → record approval (see step 5)
   - **Yes, feedback received** → log feedback, update status to "In Progress" (revision round starting)
   - **No response** → offer to draft a reminder (see step 6)
   - **Skip** → move to next item

5. **Record approval:**
   Update status to "Approved" in DELIVERABLES.md and `clients/{client}/DELIVERABLES.md`.
   Ask: "Is this fully done and filed, or does it move into the next phase?"
   - If done: update status to "Done". Log completion date and approver name.
   - If next phase: create the follow-on deliverable.

6. **Draft reminder (for items with no response):**

   For items waiting 4–5 days:
   "Hi {contact name}, just checking in on {deliverable} — do you have any feedback from your end? We want to keep things moving. Let us know by {date + 2 business days}."

   For items waiting 6+ days:
   "Hi {contact name}, we sent {deliverable} on {sent date} and have not yet received feedback. We need your input to keep the project on schedule. Can you review and respond by {date}? If the timeline is not working, let us know and we will find a solution."

   Show the message. Ask for approval before sending (interactive mode) or auto-approve the draft and note as pending send (auto mode — outbound gate still applies for actual sending).

7. **Escalation flag:** If any item has been waiting > 10 business days with no response and multiple follow-ups sent, flag it as a potential relationship issue. Suggest proactively checking in with a call rather than another written message. Log in `clients/{client}/LEARNINGS.md` if a pattern of slow approvals is emerging.

8. After all items reviewed: update DELIVERABLES.md with any status changes.

9. Display summary:
```
  Approvals recorded: {count}
  Reminders drafted: {count}
  Still pending: {count}
  Next follow-up recommended: {date}
```

</process>
