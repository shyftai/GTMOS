---
name: agency:invoice
description: Generate invoices, check outstanding payments, and record payments received
argument-hint: "<workspace-name> <client-name>"
---

<objective>
Handle all invoicing for a client: generate new invoices from the signed SOW, track outstanding payments, send reminders for overdue invoices, and record payments received. No invoice is generated without a signed SOW on file.
</objective>

<execution_context>
@./AGENCYOS.md
@./references/financial-model.md
@./_template/clients/_client-template/SOW.md
@./_template/clients/_client-template/BILLING.md
</execution_context>

<process>

1. Display header:
```
<< AGENCY:OS // INVOICE >>
Client: {client-name}
```

2. Load `clients/{client-name}/SOW.md`, `clients/{client-name}/BILLING.md`, and FINANCE.md.

3. Ask: "What do you want to do?"
   A. Generate a new invoice
   B. Check outstanding invoices
   C. Record a payment received
   D. Send a payment reminder

---

**Option A — Generate new invoice:**

Hard gate: Check that `clients/{client-name}/SOW.md` exists and is signed (status: Signed). If SOW is missing or unsigned: stop. "An invoice cannot be generated without a signed SOW on file. Run `/agency:sow {workspace} {client-name}` first."

Ask:
- What period or milestone is this invoice for?
- Invoice number (suggest next sequential number based on BILLING.md history)
- Any additional line items beyond the standard SOW retainer?

Pull billing amount from SOW.md fee schedule. Calculate due date from payment terms in SOW.md.

Generate invoice with:
- Agency name, address, and billing details
- Client name, billing contact, and address
- Invoice number and date
- Line items from SOW.md (service description, period, amount)
- Subtotal, any applicable tax, total
- Due date
- Payment instructions (bank transfer details / payment link)

Show the invoice and ask for approval before finalising (interactive mode) or auto-approve the draft in auto mode (outbound gate still applies before sending to client).

After confirmation:
- Add to `clients/{client-name}/BILLING.md` with status "Sent"
- Update FINANCE.md outstanding invoices

---

**Option B — Check outstanding invoices:**

Load all invoices from `clients/{client-name}/BILLING.md` with status Pending, Sent, or Overdue.

Display:

```
┌─ OUTSTANDING INVOICES ─── {client-name} ───────────────────────┐
│                                                                │
│  {INV-001} · ${X} · Due {date} · {X days} · {Status}          │
│  {repeat}                                                      │
│                                                                │
│  🟡 > 7 days: send reminder                                    │
│  🔴 > 30 days: pause new work                                  │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

For any invoice > 7 days overdue: offer to draft a payment reminder (see Option D).
For any invoice > 30 days overdue: flag that new work should be paused per financial-model.md policy. Ask before pausing.

---

**Option C — Record payment received:**

Ask: which invoice number was paid, and on what date.

Update `clients/{client-name}/BILLING.md`: mark invoice as Paid, add payment date.
Update FINANCE.md: remove from outstanding, update cash position.

If this clears all outstanding invoices: confirm work can resume if it was paused.

---

**Option D — Send payment reminder:**

For invoices 7–14 days overdue, draft:
"Hi {billing contact}, this is a friendly reminder that invoice {INV-XXX} for ${amount}, covering {period}, was due on {due date}. Please arrange payment at your earliest convenience. Let us know if you have any questions."

For invoices 15–29 days overdue, draft:
"Hi {billing contact}, invoice {INV-XXX} for ${amount} is now {X} days overdue. Please arrange payment this week to avoid any disruption to your account. If there is an issue, please contact us directly so we can find a solution."

For invoices 30+ days overdue, draft:
"Hi {name}, invoice {INV-XXX} for ${amount} is now {X} days overdue. Per our payment terms, we are pausing new work on your account until this is resolved. We value our relationship and want to find a quick resolution — please contact us today."

Show the message and ask for approval (interactive) or auto-approve draft with outbound gate before sending (auto).

Log all reminders sent in `clients/{client-name}/BILLING.md`.

</process>
