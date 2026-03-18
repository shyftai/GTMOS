# Workspace Configuration

---

## Workspace Identity

**Workspace name:** [Company name]
**Company:** [Company name]
**CRM system:** [Salesforce / HubSpot / Other]
**Industry:** [Company industry]
**Stage:** [Seed / Series A / Series B / Series C+ / Growth / Enterprise]
**ARR (current):** $[X]

---

## Execution Mode

**Mode:** interactive
*Options: interactive (default) | auto*

- `interactive`: Requires approval before any CRM writes, merges, or published outputs
- `auto`: Auto-approves analysis and draft generation; hard gates always require approval

---

## Collaboration Mode

**Mode:** solo
*Options: solo (default) | team*

- `solo`: All state is file-based; no external sync
- `team`: State syncs via Supabase (configure connection string below)

**Supabase connection (team mode only):**
```
SUPABASE_URL=
SUPABASE_KEY=
```

---

## Reporting Configuration

**Fiscal year start:** [January / February / other month]
**Quarter structure:** [Calendar quarters / Fiscal quarters — define if non-standard]
**Currency:** [USD / EUR / GBP — all monetary values in this currency]
**Board report recipients:** [Names or emails]
**Weekly forecast distributed to:** [Names or emails]

---

## Compliance

**Geography:** [US / EU / CA / AU / other]
**Regulations:** [CAN-SPAM / GDPR / CASL / CCPA — select applicable]
**DPA in place:** [Yes / No / Not applicable]
**Data retention policy:** [X years for CRM records; [X] months for scrape cache]

---

## Notification Preferences

**Slack workspace:** [Workspace URL or "not configured"]
**Alert channel:** [#channel or "not configured"]
**Weekly pipeline report sent to:** [channel or email]
**Data quality alerts:** [channel or email or "disabled"]
