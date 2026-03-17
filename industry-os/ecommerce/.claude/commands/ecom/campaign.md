---
name: ecom:campaign
description: Create an acquisition campaign — paid social, paid search, email, or SMS
argument-hint: "<workspace-name> [channel]"
---

<objective>
Build a complete acquisition campaign with targeting, creative brief or copy, UTM parameters, and quality gate checks. Ensure every campaign passes stock, calendar, budget, and UTM gates before output.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./references/ecom-channels.md
@./references/ecom-calendar.md
@./_template/AUDIENCES.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // CAMPAIGN >>
{workspace name} — {date}
```

2. Load PRODUCTS.md, CHANNELS.md, AUDIENCES.md, CALENDAR.md, SUPPRESSION.md, LEARNINGS.md.

3. Check LEARNINGS.md — surface any relevant campaign learnings for the channel or product being targeted.

4. Run pre-campaign quality gate before proceeding:
   - **Stock check (hard gate):** Confirm featured products are Active in PRODUCTS.md. If OOS: STOP — cannot build a campaign for OOS products.
   - **Calendar check (hard gate):** Check CALENDAR.md for any conflicting promo within 7 days. If conflict: surface the conflict and ask for explicit approval before continuing.
   - **Budget check (hard gate):** Confirm proposed spend is within CHANNELS.md monthly budget and daily cap. If over: surface the overage and ask for approval.

5. Ask: What type of campaign?
   - A. Paid Social (Meta / TikTok)
   - B. Paid Search (Google)
   - C. Email campaign
   - D. SMS campaign
   - E. Multi-channel (specify)

6. Ask: What is the goal?
   - New customer acquisition (prospecting)
   - Retargeting (warm / cart)
   - Retention / win-back
   - Launch support
   - Promotional event

7. Ask: Which products are featured? (Confirm each is Active in PRODUCTS.md)

8. Ask: Which audience? (Reference AUDIENCES.md segments — or specify new)

---

**For Paid Social (Meta / TikTok):**

Generate:
- Campaign structure: objective, ad set targeting, budget split (prospecting / warm / retargeting)
- Audience targeting spec based on goal and AUDIENCES.md
- Creative brief: format recommendation (UGC/static/video), 3 headline variants, 3 primary text variants, CTA copy
- UTM parameters (hard gate: required) — follow utm convention from CHANNELS.md
- A/B test recommendation: which element to test first
- ROAS target: based on audience type, reference ecom-channels.md benchmarks

---

**For Paid Search (Google):**

Generate:
- Campaign type recommendation (Shopping / Brand / PMAX / Non-brand)
- Keyword themes and match types
- Ad copy: 3 headline variants, 2 description variants
- Negative keyword list (initial)
- UTM parameters (hard gate)
- Bid strategy recommendation
- ROAS target

---

**For Email campaign:**

Generate:
- Subject line: 3 variants (A/B test recommended)
- Preview text: matched to each subject line
- Full email copy: header, body, CTA
- Audience segment to send to (reference AUDIENCES.md — never send to full list without segmentation)
- Send timing recommendation
- UTM parameters on all links (hard gate)
- Quality gates: suppression check, unsubscribe link, brand voice match

---

**For SMS campaign:**

Generate:
- Message copy (160 characters, personalization token, opt-out instruction)
- Audience segment
- Send timing
- UTM-tagged link
- Quality gates: TCPA compliance, suppression check, frequency check vs. CHANNELS.md

---

9. Run quality gate before presenting output:
   - [ ] All featured products Active in PRODUCTS.md (stock gate)
   - [ ] No calendar conflict within 7 days (calendar gate)
   - [ ] Budget within CHANNELS.md limits (budget gate)
   - [ ] UTM parameters present on all links (UTM gate)
   - [ ] For email/SMS: suppression loaded (suppression gate)
   - [ ] Brand voice matches BRAND.md tone

10. Log campaign brief to `logs/workspace-log.md`.

11. Ask: "Ready to use this brief, or would you like to adjust any element?"

12. Suggest follow-up commands:
- If email: `/ecom:flow {workspace}` — check if an automation flow supports this campaign
- If paid: `/ecom:signals {workspace}` — scan for competitor activity before launching
- After results: `/ecom:report {workspace}` — capture performance in METRICS.md

</process>
