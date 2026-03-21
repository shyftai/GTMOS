# Suppression & Compliance — [Workspace Name]

## Global do-not-contact list
Contacts on this list are NEVER contacted again under any campaign in this workspace.
This list takes absolute priority over any list, campaign, or signal.

| Email | Name | Company | Date added | Reason | Added by |
|-------|------|---------|------------|--------|----------|
| | | | | unsubscribe / bounce / complaint / manual | |

---

## Do not contact — companies

Companies on this list block ALL contacts at that domain from being contacted in any campaign in this workspace. Applies regardless of the individual contact's status.

Use for: former clients with bad exits, legal disputes, competitors, investor relations sensitivities, or explicit account-level requests.

| Domain | Company name | Date added | Reason | Added by |
|--------|-------------|------------|--------|----------|
| | | | competitor / legal / former-client / manual | |

**Ship check:** before shipping any campaign, check every contact's email domain against this list. If any match is found, remove the contact from the campaign list without logging their details — just report "Removed: {n} contacts from blocked companies."

---

## Active regulations

Optional. All regulations are OFF by default. Enable what you need with `/gtm:compliance`, or ignore entirely.

| Regulation | Status | Reason |
|------------|--------|--------|
| CAN-SPAM (US) | OFF | |
| GDPR (EU/UK) | OFF | |
| CASL (Canada) | OFF | |
| CCPA/CPRA (California) | OFF | |
| PECR (UK) | OFF | |
| LGPD (Brazil) | OFF | |
| Australian Spam Act | OFF | |

> All OFF by default. Turn on what applies to you. Run `/gtm:compliance --auto-detect` to set from ICP.md, or leave them all off.

### Legitimate interest documentation (required when GDPR is ON)
- **Purpose:**
- **Necessity:**
- **Balancing test:**

### CASL consent tracking (required when CASL is ON)
Maintain consent type and source for every Canadian contact in your list CSVs. Required columns: `casl_consent_type` (express/implied), `casl_consent_source`, `casl_consent_date`.

### Data retention policy
| Regulation | Retention period | Action after |
|------------|-----------------|--------------|
| GDPR | Campaign + 30 days | Delete or anonymize |
| CASL | Until consent expires | Delete consent records after 3 years |
| CCPA/CPRA | 12 months | Delete on request |
| LGPD | Campaign + 30 days | Delete or anonymize |

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
Include in every outbound email footer. Required for CAN-SPAM compliance.
- Address: [Fill in: your company's registered or business mailing address — e.g. "Acme Inc., 123 Main St, Austin TX 78701, USA"]

---

## Bounce management

### Bounce thresholds
- Hard bounce (invalid email): remove from all lists immediately, add to suppression
- Soft bounce (mailbox full, temporary): retry once after 48 hours, then suppress
- Overall bounce rate target: below 2% per campaign
- Warning: above 3% in any 24h window — flag in /gtm:today
- Red flag: above 5% cumulative — pause campaign and audit list source

### Bounce handling rules
1. Any hard bounce → add to suppression list automatically
2. Any contact with 2+ soft bounces → add to suppression list
3. After every campaign, export bounced contacts and merge into suppression list
4. Before every new campaign, check the new list against the suppression list — remove matches before shipping

---

## Spam complaint handling

### Thresholds
- Target: below 0.1% complaint rate
- Monitor: 0.1% – 0.2% — watch closely, review list quality
- Alert: above 0.2% — flag as urgent in /gtm:today, audit list source
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
