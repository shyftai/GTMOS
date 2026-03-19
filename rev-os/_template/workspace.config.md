# Workspace Configuration

---

## Workspace Identity

**Workspace name:** [Company name]
**Company:** [Company name]
**CRM system:** [Salesforce / HubSpot / Pipedrive / Other]
**CRM edition:** [e.g. HubSpot Sales Hub Professional / Salesforce Enterprise]
**Industry:** [Company industry]
**Stage:** [Seed / Series A / Series B / Series C+ / Growth / Enterprise]
**ARR (current):** [symbol][X] [e.g. $2.4M / €1.8M / £1.2M]

---

## Locale and Currency

**Primary currency:** [USD / EUR / GBP / AUD / CAD / SGD / other]
**Currency symbol:** [$  / € / £ / A$ / C$ / S$]
**Currency code (ISO 4217):** [USD / EUR / GBP / AUD / CAD / SGD]
**Number format:** [1,234,567.89 (US/UK) / 1.234.567,89 (EU)]
**Date format:** [MM/DD/YYYY (US) / DD/MM/YYYY (EU/UK/AU)]

**Multi-currency:** [No — single currency / Yes — list currencies used]

If multi-currency:
| Currency | Markets | Exchange rate source | Rate update frequency |
|----------|---------|---------------------|----------------------|
| [USD] | [US] | [ECB / XE / manual] | [Weekly / Monthly] |
| [EUR] | [EU] | [ECB / XE / manual] | [Weekly / Monthly] |

> All ARR/MRR values in REV:OS are reported in primary currency. Multi-currency pipeline is converted at the rate recorded in the Deal at close — do not retroactively restate closed deals when rates change.

---

## Team Composition

**RevOps team size:** [Solo (1) / Small team (2–3) / Full team (4+)]

| Role | Name | Count | Notes |
|------|------|-------|-------|
| RevOps lead / Head of RevOps | [Name] | [X] | |
| RevOps analyst | [Name] | [X] | |
| Sales ops | [Name] | [X] | |
| Account Executives (AEs) | [Names or count] | [X] | |
| Sales Development Reps (SDRs) | [Names or count] | [X] | |
| Customer Success Managers (CSMs) | [Names or count] | [X] | |
| Solutions Engineers (SEs) | [Names or count] | [X] | |

**RevOps operating model:**
- [ ] Solo RevOps — one person covers all four loops
- [ ] Specialized — separate owners for Sales Ops, CS Ops, Data
- [ ] Distributed — RevOps is embedded in each GTM function (no central team)

**Forecast model by team size:**
- 1–3 AEs: bottom-up rep commit is the primary forecast signal
- 4–10 AEs: weighted pipeline + rep commit blended
- 10+ AEs: weighted pipeline + territory model + rep commit

> Adjust forecast methodology in `FORECAST.md` to match team size.

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
