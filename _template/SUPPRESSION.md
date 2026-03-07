# Suppression & Compliance — [Workspace Name]

## Global do-not-contact list
Contacts on this list are NEVER contacted again under any campaign in this workspace.
This list takes absolute priority over any list, campaign, or signal.

| Email | Name | Company | Date added | Reason | Added by |
|-------|------|---------|------------|--------|----------|
| | | | | unsubscribe / bounce / complaint / manual | |

---

## Compliance requirements

### CAN-SPAM (US)
- [ ] Every email includes a physical mailing address
- [ ] Every email has a working unsubscribe mechanism
- [ ] Unsubscribe requests processed within 10 business days (best practice: immediately)
- [ ] Subject lines are not deceptive
- [ ] "From" and "Reply-to" headers are accurate
- [ ] Email is clearly identifiable as commercial (or qualifies as B2B relationship)

### GDPR (EU/UK)
- [ ] Legitimate interest basis documented for B2B prospecting
- [ ] Data processing purpose is clear and specific
- [ ] Contact data is only retained as long as needed for the campaign
- [ ] Unsubscribes are honoured immediately (not 10 days — immediately)
- [ ] Right to erasure: if requested, all data about the person is deleted
- [ ] Data sources are legitimate (no scraped personal data without legal basis)

### CCPA (California)
- [ ] Privacy notice available if targeting California residents
- [ ] Opt-out mechanism provided
- [ ] No selling of personal information without consent

### Physical address
Include in every outbound email (footer or signature):
- Address:

---

## Bounce management

### Bounce thresholds
- Hard bounce (invalid email): remove from all lists immediately, add to suppression
- Soft bounce (mailbox full, temporary): retry once after 48 hours, then suppress
- Overall bounce rate target: below 2% per campaign
- Red flag: above 5% — pause campaign and audit list source

### Bounce handling rules
1. Any hard bounce → add to suppression list automatically
2. Any contact with 2+ soft bounces → add to suppression list
3. After every campaign, export bounced contacts and merge into suppression list
4. Before every new campaign, check the new list against the suppression list — remove matches before shipping

---

## Spam complaint handling

### Thresholds
- Target: below 0.1% complaint rate
- Warning: 0.1% - 0.3%
- Critical: above 0.3% — pause sending immediately

### Response protocol
1. Pause the complaining contact's sequence immediately
2. Add to suppression list as do-not-contact
3. If complaint rate rises above 0.3%:
   - Pause all sending on the affected inbox
   - Audit the list segment that generated complaints
   - Review copy for potential spam triggers
   - Check inbox warmup health before resuming

---

## Unsubscribe handling
- Process immediately — not "within 10 days"
- Add to suppression list
- Remove from all active sequences across all campaigns
- Flag in CRM as do-not-contact
- Never re-add, even if they appear in a future list pull
- Log in campaign decisions.md

---

## List hygiene before every send
Run this checklist before shipping any list:

- [ ] All emails verified (catch-all flagged, not assumed valid)
- [ ] Checked against workspace suppression list
- [ ] Checked against global suppression list (if maintained at repo level)
- [ ] No personal email domains (gmail, yahoo, hotmail, etc.)
- [ ] No role-based emails (info@, sales@, support@)
- [ ] Bounce history checked from previous campaigns
- [ ] Duplicates removed within this campaign
- [ ] Duplicates checked against other active campaigns in this workspace
