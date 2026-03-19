---
name: agency:deliver
description: Manage active deliverables — update status, flag blockers, mark complete, send to client
argument-hint: "<workspace-name> [client-name]"
---

<objective>
Give the agency operator a clear view of active deliverables and help them move work forward: updating status, flagging blockers, running the delivery quality gate before completion, and drafting client-facing send messages.
</objective>

<execution_context>
@./AGENCYOS.md
@./references/delivery-standards.md
@./_template/clients/_client-template/DELIVERABLES.md
</execution_context>

<process>

1. Display header:
```
<< AGENCY:OS // DELIVER >>
{if client specified: "Client: {client-name}" | if not: "All clients"}
```

2. Load workspace DELIVERABLES.md. If client specified, also load `clients/{client-name}/DELIVERABLES.md` and `clients/{client-name}/SOW.md`.

3. Display current deliverables table:

```
┌─ ACTIVE DELIVERABLES ──────────────────────────────────────────┐
│                                                                │
│  {Deliverable} · {Client} · {Owner} · Due {date} · {Status}   │
│  {repeat for each active deliverable}                          │
│                                                                │
│  Blocked ({count}):                                            │
│  {list blocked deliverables with what they are blocked on}     │
│                                                                │
│  Pending client approval ({count}):                            │
│  {list with days waiting}                                      │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

4. Ask: "What do you want to do?"
   A. Update status on a deliverable
   B. Add a new deliverable
   C. Flag a blocker
   D. Mark a deliverable complete (triggers quality gate)
   E. Draft a send-to-client message

---

**Option A — Update status:**
Ask which deliverable and what the new status is. Update DELIVERABLES.md and `clients/{client}/DELIVERABLES.md`.

---

**Option B — Add a new deliverable:**
Ask: deliverable name, client, owner, due date, type. Add to both DELIVERABLES.md and `clients/{client}/DELIVERABLES.md` with status "In Progress". Suggest creating a brief with `/agency:brief {workspace} {client}` if one does not exist.

---

**Option C — Flag a blocker:**
Ask: which deliverable, what is blocking it, and who is responsible for unblocking (agency or client). Update status to "Blocked" in DELIVERABLES.md. If client needs to provide something, draft a message: "Hi {contact}, we are ready to move forward on {deliverable} but we need {specific item} from your side. Can you get us that by {date}?"

---

**Option D — Mark complete (delivery quality gate):**

Before marking anything complete, run all five quality checks from delivery-standards.md:

1. Brief fit — does this output match what was requested in the brief? (Load brief from `clients/{client}/DELIVERABLES.md`)
2. SOW fit — is this within the agreed scope in `clients/{client}/SOW.md`? No scope creep absorbed?
3. Quality standard — does this meet the standard for this output type (from delivery-standards.md)?
4. Approval status — has an internal reviewer (account manager) signed off?
5. Completeness — are all required elements present?

Display each check with pass / fail. If all pass: update status to "In Review" (not Done — client must approve before Done).

If any check fails: show which check failed and what is needed to pass it. Do not mark complete.

**Hard gate (interactive and auto mode):** Do not mark a deliverable as Done and filed until client approval is confirmed. "In Review" → send to client → "Pending Approval" → client approves → "Done".

---

**Option E — Draft send-to-client message:**

Ask: which deliverable, which contact to send to, and what deadline to set for their feedback.

Draft the client message:
"Hi {contact name},

{Deliverable name} is ready for your review. You will find it here: {link or attached}.

Please send us your feedback by {date} so we can keep things on track. If we do not hear back by then, we will follow up.

Let us know if you have any questions.

{Account manager name}"

Show message and ask for approval before marking it as "Pending Approval" in DELIVERABLES.md.

---

5. After any action: update both the workspace DELIVERABLES.md and the client-specific `clients/{client}/DELIVERABLES.md`.

</process>
