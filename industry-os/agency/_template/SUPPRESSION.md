# Suppression & Compliance — [Agency Name]

## Agency-specific suppression rule

All contacts in CLIENTS.md are automatically suppressed from new business outreach. Before every campaign send, cross-reference CLIENTS.md. This check is a hard gate.

---

## Global do-not-contact list

Contacts on this list are NEVER contacted again under any campaign in this workspace. This list takes absolute priority over any list, campaign, or signal.

| Email | Name | Company | Date added | Reason | Added by |
|-------|------|---------|------------|--------|----------|
| | | | | unsubscribe / client / bounce / complaint / manual | |

---

## Client suppression list

All current and recently churned clients (< 6 months) are suppressed. Synced from CLIENTS.md.

| Domain | Company | Status | Date added |
|--------|---------|--------|------------|
| | | active client | |
| | | churned < 6mo | |

---

## Active regulations

| Regulation | Status | Reason |
|------------|--------|--------|
| CAN-SPAM (US) | OFF | |
| GDPR (EU/UK) | OFF | |
| CASL (Canada) | OFF | |
| CCPA/CPRA (California) | OFF | |
| PECR (UK) | OFF | |
| LGPD (Brazil) | OFF | |
| Australian Spam Act | OFF | |

Run `/gtm:compliance --auto-detect` to set from ICP.md geography.

---

## Physical address (include in every email)

- Address: [Agency physical address — required for CAN-SPAM]

---

## Bounce management

- Hard bounce: remove from all lists, add to suppression immediately
- Soft bounce (2+): add to suppression
- Bounce rate target: below 2% per campaign
- Red flag: above 5% — pause and audit

---

## Unsubscribe handling

- Process immediately — never delay
- Add to suppression list
- Remove from all active sequences
- Flag in CRM as do-not-contact
- Log in campaign `logs/decisions.md`

---

## List hygiene before every send

- [ ] All emails verified (catch-all flagged)
- [ ] Checked against suppression list
- [ ] Checked against CLIENTS.md (no existing clients)
- [ ] No personal email domains (gmail, yahoo, etc.)
- [ ] No role-based emails (info@, sales@, support@)
- [ ] Duplicates removed within this campaign
