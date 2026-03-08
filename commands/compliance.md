# Compliance Configuration

## Purpose
Optionally configure which privacy and anti-spam regulations apply to this workspace. GTM:OS can auto-detect based on target geography, but compliance is entirely optional. Users can skip, ignore, or disable all regulation checks. This is a helper, not a gatekeeper.

> **Compliance is OFF by default.** Nothing is enforced unless you explicitly enable it. Run `/gtm:compliance` to turn on regulation checks if you want them.

---

## Supported regulations

### CAN-SPAM (United States)
**Auto-enabled when:** targeting US contacts
**Requirements:**
- Physical mailing address in every email
- Working unsubscribe mechanism
- Unsubscribe honoured within 10 business days (GTM:OS default: immediately)
- Accurate "From" and "Reply-to" headers
- Subject lines not deceptive
- Email identifiable as commercial (B2B exemption applies for relationship-based)

### GDPR (European Union + UK)
**Auto-enabled when:** targeting EU/EEA/UK contacts
**Requirements:**
- Legitimate interest basis documented (see below)
- Data processing purpose stated and specific
- Data retention limited to campaign duration + 30 days
- Unsubscribes honoured immediately (not 10 days)
- Right to erasure — delete all data on request within 30 days
- Right to access — provide all held data on request within 30 days
- Data sources must be legitimate (no scraped personal data without legal basis)
- Data Processing Agreement (DPA) required with all tool vendors processing EU data
- Record of processing activities maintained

**Legitimate interest documentation:**
Before sending to EU contacts, document in SUPPRESSION.md:
1. Purpose: what business objective does the outreach serve?
2. Necessity: why is cold outreach necessary to achieve this?
3. Balancing test: recipient's reasonable expectation of being contacted (B2B context, professional email, relevant offer)

### CASL (Canada)
**Auto-enabled when:** targeting Canadian contacts
**Requirements:**
- Express or implied consent required before sending
- Implied consent valid for: existing business relationship (within 2 years of purchase, 6 months of inquiry), published email address (if relevant to role), professional association membership
- Sender identification: full name, mailing address, phone/email/web
- Working unsubscribe mechanism — processed within 10 business days
- Record of consent (type, date, method) maintained per contact
- Penalties: up to $10M CAD per violation — strictest in the world

**CASL consent types to track:**
| Type | Source | Validity |
|------|--------|----------|
| Express | Opt-in form, written/verbal agreement | Until withdrawn |
| Implied — business relationship | Purchase within 2 years, inquiry within 6 months | Time-limited |
| Implied — published address | Website, directory (must be relevant to role) | Until withdrawn |
| Implied — association | Professional org membership | Until withdrawn |

### CCPA/CPRA (California)
**Auto-enabled when:** targeting California contacts AND company meets threshold (>$25M revenue, or >100K consumers, or >50% revenue from data sales)
**Requirements:**
- Privacy notice available
- Opt-out mechanism ("Do Not Sell or Share My Personal Information")
- No selling personal information without consent
- Right to deletion on request
- Right to know what data is collected
- Note: B2B exemption was extended but may expire — check current status

### PECR (UK — supplements GDPR)
**Auto-enabled when:** targeting UK contacts (alongside GDPR)
**Requirements:**
- Soft opt-in rule for B2B: can email if the contact's corporate email is used and content is relevant to their professional role
- Must offer opt-out on every message
- No unsolicited marketing to individual subscribers without consent
- Corporate subscribers (company emails) can be contacted under soft opt-in

### LGPD (Brazil)
**Auto-enabled when:** targeting Brazilian contacts
**Requirements:**
- Legal basis required (legitimate interest applies for B2B)
- Data subject rights: access, correction, deletion, portability
- Unsubscribe mechanism required
- Data Processing Officer (DPO) appointment may be required
- International data transfers require adequate protection

### Australian Spam Act
**Auto-enabled when:** targeting Australian contacts
**Requirements:**
- Consent required (inferred consent OK for B2B if relevant to role)
- Sender must be clearly identified
- Working unsubscribe — honoured within 5 business days
- Functional unsubscribe for 30 days after send

---

## Compliance configuration in workspace

Add this section to SUPPRESSION.md to configure active regulations:

```
## Active regulations

| Regulation | Status | Auto-detected | Reason |
|------------|--------|---------------|--------|
| CAN-SPAM | ON | Yes | Targeting US contacts |
| GDPR | ON | Yes | Targeting EU/UK contacts |
| CASL | OFF | No | Not targeting Canada |
| CCPA/CPRA | OFF | No | Below threshold / not targeting CA |
| PECR | ON | Yes | Targeting UK contacts (with GDPR) |
| LGPD | OFF | No | Not targeting Brazil |
| Australian Spam Act | OFF | No | Not targeting Australia |

Override: set any regulation to ON/OFF manually. Auto-detection is a suggestion, not a mandate.
```

---

## Auto-detection logic

During `/gtm:onboard`, `/gtm:list-brief`, and `/gtm:validate-list`:

1. Check ICP.md for target geographies
2. Check contact list for country fields
3. Map countries to regulations:
   - US → CAN-SPAM
   - EU/EEA countries (27 member states) + UK → GDPR + PECR (UK only)
   - Canada → CASL
   - California (if detectable) → CCPA/CPRA
   - Brazil → LGPD
   - Australia → Australian Spam Act
4. Display detected regulations and ask user to confirm or adjust
5. Save to SUPPRESSION.md `## Active regulations` table

---

## Launch check enforcement

During `/gtm:ship`, check each active regulation:

### If CAN-SPAM is ON:
- [x] Physical address in footer
- [x] Unsubscribe link present
- [x] From/Reply-to accurate
- [x] Subject line not deceptive

### If GDPR is ON:
- [x] Legitimate interest documented in SUPPRESSION.md
- [x] Data retention policy stated
- [x] Right to erasure process documented
- [x] Unsubscribe mechanism (immediate processing)
- [x] No scraped personal data without legal basis

### If CASL is ON:
- [x] Consent type recorded for each contact (express/implied + source)
- [x] Implied consent not expired (2 years for business, 6 months for inquiry)
- [x] Full sender identification in email
- [x] Unsubscribe mechanism present
- [x] Contacts without valid consent removed from send list

### If CCPA/CPRA is ON:
- [x] Privacy notice link available
- [x] Opt-out mechanism referenced

### If PECR is ON:
- [x] All UK contacts use corporate email addresses (not personal)
- [x] Content is relevant to recipient's professional role

### If LGPD is ON:
- [x] Legal basis documented
- [x] Unsubscribe mechanism present

### If Australian Spam Act is ON:
- [x] Sender clearly identified
- [x] Unsubscribe mechanism present
- [x] Consent basis recorded

---

## Right to erasure workflow

When a contact requests data deletion (GDPR Article 17, CCPA, LGPD):

1. Add to suppression list with reason: "erasure request"
2. Remove from ALL active campaign lists
3. Remove from ALL sending tools (Instantly, Lemlist, Smartlead)
4. Delete from local CSV files
5. Request deletion from CRM (flag for manual review if CRM has other records)
6. Log in SUPPRESSION.md with date and confirmation
7. Respond to requester within 30 days confirming deletion
8. Notify any third-party processors (enrichment tools) if data was shared

---

## Data retention policy

| Regulation | Default retention | After campaign ends |
|------------|-------------------|---------------------|
| GDPR | Campaign duration + 30 days | Delete or anonymize |
| CASL | Until consent expires or withdrawn | Delete consent records after 3 years |
| CCPA/CPRA | 12 months | Delete on request |
| LGPD | Campaign duration + 30 days | Delete or anonymize |
| CAN-SPAM | No specific limit | Maintain suppression list indefinitely |
| Australian Spam Act | No specific limit | Maintain suppression list indefinitely |

---

## Compliance footer templates

Use these in email footers based on active regulations:

**CAN-SPAM (English):**
```
{company_name} | {street_address}, {city}, {state} {zip}
Unsubscribe: {unsubscribe_link}
```

**GDPR (English):**
```
You're receiving this because of your role as {title} at {company}.
Unsubscribe instantly: {unsubscribe_link}
```

**GDPR (German — formal):**
```
Sie erhalten diese Nachricht aufgrund Ihrer Position als {title} bei {company}.
Sofort abmelden: {unsubscribe_link}
```

**GDPR (French — formal):**
```
Vous recevez ce message en raison de votre role de {title} chez {company}.
Se desinscrire: {unsubscribe_link}
```

**CASL (English):**
```
{sender_name} | {company_name}
{street_address}, {city}, {province} {postal_code}
Phone: {phone} | Email: {reply_email}
Unsubscribe: {unsubscribe_link}
```

**LGPD (Portuguese):**
```
{company_name} | {endereco}
Cancelar inscricao: {unsubscribe_link}
```
