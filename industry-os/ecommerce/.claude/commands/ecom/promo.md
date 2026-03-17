---
name: ecom:promo
description: Plan a promotion or sale event — margin check, creative assets, and email + SMS + paid sequence
argument-hint: "<workspace-name> [promo-type]"
---

<objective>
Plan a complete promotional event with margin verification, offer structure, and all creative assets. Every promotion must pass margin, calendar, and stock gates before output. Check LEARNINGS.md for prior promo results before recommending an offer structure.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./references/ecom-calendar.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // PROMO >>
{workspace name} — {date}
```

2. Load PRODUCTS.md, FINANCE.md, CALENDAR.md, AUDIENCES.md, CHANNELS.md, SUPPRESSION.md, LEARNINGS.md.

3. Check LEARNINGS.md — surface any prior promo learnings: which discount structure drove best margin + volume, what angle resonated, what to avoid.

4. Ask: What type of promotion?
   - Flash sale (24–72 hours)
   - Seasonal sale (e.g. Spring, Summer, BFCM)
   - Sitewide discount
   - Category or product-specific discount
   - Bundle or gift-with-purchase
   - Loyalty-exclusive offer
   - Other (describe)

5. Ask:
   - Proposed discount structure (e.g. 20% off, free shipping, buy 2 get 1, GWP over $75)
   - Featured products (or sitewide)
   - Promotion dates (start + end)
   - Target channels (email / SMS / paid / all)
   - Primary audience (new customers / existing customers / VIP only / all)

6. Run promo quality gates:

   **Margin check (hard gate):**
   - For each featured SKU: calculate margin at the discount level
   - Compare against contribution margin floor in FINANCE.md
   - If any SKU would go below floor: STOP. Surface the specific SKU and the margin gap. Ask to modify the discount or exclude that SKU.
   - Show the calculation: "SKU [X] at [Y%] discount = [Z%] margin vs [W%] floor"

   **Calendar check (hard gate):**
   - Check CALENDAR.md for any promo within 7 days of proposed dates
   - If conflict: surface the conflict. Require explicit approval to proceed.

   **Stock check:**
   - Check PRODUCTS.md for inventory on featured SKUs
   - Estimate demand: apply 3–5x velocity multiplier for promotional period
   - Flag any SKU that projects OOS before promo end date

7. Check LEARNINGS.md for any directly relevant prior promo insight — surface it before building the brief.

8. Generate promo assets:

**Promo brief:**
- Offer headline (3 variants)
- Key message (1 sentence: the offer in plain language)
- Exclusions and terms
- Promo code (or auto-discount)
- Start/end time (be specific — time zone)

**Email sequence (4 emails):**
- Email 1 — Teaser (3–5 days before): "Something's coming" — no reveal yet, build anticipation
- Email 2 — Launch: Full offer reveal, urgency, product showcase, CTA
- Email 3 — Reminder (midway or Day 2): Social proof + "still going" for fence-sitters
- Email 4 — Last chance (8–12 hours before end): Hard urgency, countdown timer copy

For each email: subject line (3 variants), preview text, full copy, UTM links.

**SMS messages:**
- Launch SMS: Offer + link + opt-out (160 chars)
- Last chance SMS: Final urgency + link + opt-out

**Paid ad brief:**
- Headline variants (3) and copy variants (3) for paid social
- Audience: warm retargeting + existing customer cross-sell
- UTM parameters (hard gate: must have UTMs)

**Site promotion:**
- Banner / announcement bar copy
- Pop-up headline and CTA (for new visitors during promo)
- If applicable: collection page hero text

9. Run suppression check confirmation: confirm SUPPRESSION.md will be applied to all email and SMS sends.

10. Add promo to CALENDAR.md.

11. Log promo plan to `logs/workspace-log.md`.

12. Display summary:
```
┌─ PROMO PLAN ─── {promo name} ─────────────────────────────────┐
│                                                               │
│  Offer: {discount structure}                                  │
│  Dates: {start} → {end}                                       │
│  Channels: {list}                                             │
│                                                               │
│  Margin check:                                                │
│  {SKU}: {margin at discount}% vs {floor}% floor — {OK/FAIL}  │
│                                                               │
│  Stock check:                                                 │
│  {SKU}: {units} available — {OK / LOW / OOS RISK}            │
│                                                               │
│  Calendar: {no conflicts / conflicts noted}                   │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

13. After promo completes, prompt:
- Update LEARNINGS.md with promo result
- Update METRICS.md with revenue contribution
- Run `/ecom:report {workspace}` to capture the period

</process>
