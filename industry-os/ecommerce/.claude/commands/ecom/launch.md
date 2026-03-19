---
name: ecom:launch
description: Full product launch workflow — 4-week plan, email sequence, paid brief, and launch day checklist
argument-hint: "<workspace-name> [product-name]"
---

<objective>
Build a complete product launch plan covering the 4-week runup, launch day sequence, and post-launch cadence. Generate all launch assets: email sequence, SMS, paid brief, and social plan. Ensure inventory and calendar gates pass before confirming the launch.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./references/product-launch.md
@./references/ecom-calendar.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // LAUNCH >>
{workspace name} — {date}
```

2. Load PRODUCTS.md, CALENDAR.md, CHANNELS.md, FLOWS.md, AUDIENCES.md, FINANCE.md, LEARNINGS.md.

3. Check LEARNINGS.md — surface any prior launch learnings relevant to this product category or audience.

4. Ask for launch details:
   - Product name (confirm it exists or is being added to PRODUCTS.md)
   - Launch date target
   - Primary target audience (reference AUDIENCES.md)
   - Launch goal: units or revenue target for Week 1 and Week 4
   - Launch type: Full launch / Soft launch / Restock / Exclusive drop

5. Run pre-launch gates:

   **Stock check (hard gate):** Is inventory sufficient?
   - Calculate: expected daily velocity × 14 days = minimum stock
   - If PRODUCTS.md shows less than this minimum: flag the shortfall. Ask to delay launch or reduce paid spend commitment.

   **Calendar check (hard gate):** Any conflicting promo or launch within 7 days?
   - Check CALENDAR.md. Surface any conflict. Require explicit approval to proceed.

   **Budget check (hard gate):** Is planned paid spend within budget?
   - Check CHANNELS.md daily and weekly limits for each channel in the launch plan.
   - Calculate total planned launch spend across all channels.
   - If total exceeds available budget for the period: surface the overage, show breakdown by channel, and require explicit approval before continuing.

   **Post-purchase flow check:** Does a post-purchase flow exist for this product in FLOWS.md?
   - If no: flag — recommend setting up before launch day.

6. Build launch plan using product-launch.md framework:

**4-week runup checklist** — tailored to launch date:

Week 4 (content creation):
- Photography brief for hero, lifestyle, detail shots
- Video brief (30–60s for ads)
- Copy brief for all email and ad assets
- Submit ads to Meta/Google for early review (7 days lead time)

Week 3 (audience building):
- Waitlist opt-in form recommendation
- Social teaser post schedule (2–3 posts)
- Influencer briefing (if applicable)
- VIP early access email to top customers

Week 2 (build and pre-activate):
- Email sequences to load in ESP
- Paid ad campaigns built
- Post-purchase flow configured for this SKU
- Full checkout test checklist

Week 1 (final checks and VIP access):
- All assets and links reviewed
- Suppression list refreshed
- VIP early access email ready to send (24–48h before general launch)

7. Generate launch day sequence with recommended send times.

8. Generate all copy assets:

**Email 1 — VIP early access (24h before general launch):**
- Subject line: 3 variants
- Preview text
- Full email copy with product intro, benefit statement, CTA

**Email 2 — General launch (launch day, 12pm):**
- Subject line: 3 variants
- Full email copy with social proof angle (if influencer posts live) or product angle
- CTA: "Shop now" with UTM link

**Email 3 — Non-openers resend (Day 2):**
- New subject line (3 variants)
- Same body copy, minor CTA tweak

**SMS launch message:**
- Launch announcement (160 characters)
- UTM link

**Paid ad brief:**
- Creative direction (4 variants)
- Headline and copy variants
- Audience targeting (reference CHANNELS.md and AUDIENCES.md)
- UTM parameters (hard gate)

9. Add launch to CALENDAR.md.

10. Check UTMs on all generated links (hard gate before presenting).

11. Log launch plan to `logs/workspace-log.md`.

12. Display launch summary:
```
┌─ LAUNCH PLAN ─── {product name} ─────────────────────────────┐
│                                                               │
│  Launch date: {date}                                          │
│  Type: {Full / Soft / Restock / Drop}                         │
│  Stock: {units available} — {OK / WARNING: low}              │
│  Budget: ${planned spend} — {OK / WARNING: over limit}        │
│  Goal: {units or revenue target}                              │
│                                                               │
│  Checklist:                                                   │
│  Week 4 tasks: {count items}                                  │
│  Week 3 tasks: {count items}                                  │
│  Week 2 tasks: {count items}                                  │
│  Launch day: {send times listed}                              │
│                                                               │
│  Post-purchase flow: {configured / needs setup}               │
│  Calendar conflicts: {none / flagged}                         │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

13. Suggest follow-up:
- `/ecom:flow {workspace}` — set up post-purchase flow for this product before launch
- `/ecom:signals {workspace}` — check competitor activity before launch
- After launch: `/ecom:report {workspace}` — capture Week 1 results and update LEARNINGS.md

</process>
