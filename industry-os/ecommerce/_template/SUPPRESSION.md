# Suppression and Compliance

## Hard rule
Every email and SMS send must be checked against this list before scheduling. This check is a hard gate — no exceptions in any mode.

---

## Global do-not-contact list

Contacts on this list are never contacted again under any campaign in this workspace.

| Email / Phone | Name | Date added | Reason | Added by |
|--------------|------|------------|--------|----------|
| | | | unsubscribe / bounce / complaint / GDPR / manual | |

---

## Unsubscribe handling
- Process immediately — never delay
- Add to suppression list within 24 hours
- Remove from all active flows and sequences
- Flag in email/SMS platform as suppressed
- Log in workspace-log.md

---

## Bounce management
- **Hard bounce:** remove from all lists, add to suppression immediately
- **Soft bounce (2+ occurrences):** add to suppression
- **Bounce rate target:** below 2% per campaign
- **Red flag threshold:** > 5% bounce rate — pause and audit deliverability

---

## Active regulations

| Regulation | Active | Region | Key requirement |
|------------|--------|--------|-----------------|
| CAN-SPAM (US) | [ ] | United States | Physical address in every email, unsubscribe mechanism |
| GDPR (EU/UK) | [ ] | Europe / UK | Explicit consent, right to be forgotten |
| CASL (Canada) | [ ] | Canada | Express or implied consent required |
| CCPA/CPRA (California) | [ ] | California | Right to opt out of sale of data |
| PECR (UK) | [ ] | United Kingdom | Consent for marketing emails |
| TCPA (US — SMS) | [ ] | United States | Explicit written consent for SMS marketing |
| Australian Spam Act | [ ] | Australia | Consent + unsubscribe mechanism |

Mark [x] for active regulations based on where your customers are located.

---

## Physical address (required for CAN-SPAM)
[Brand physical address — include in every email footer]

---

## SMS compliance
- Explicit opt-in required for all SMS marketing (TCPA/CASL)
- Include "Reply STOP to unsubscribe" in every SMS
- Honor opt-outs within 24 hours
- Do not message TCPA non-compliant contacts

---

## List hygiene checklist (run before every send)
- [ ] Checked against suppression list
- [ ] Platform unsubscribes synced
- [ ] Hard bounces removed
- [ ] No role-based emails targeted (info@, sales@, support@ — acquisition only, not for broadcast)
- [ ] Duplicates removed within this send
- [ ] Correct segment selected (not "All subscribers" without review)
