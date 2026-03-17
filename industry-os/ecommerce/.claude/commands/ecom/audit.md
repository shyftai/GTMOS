---
name: ecom:audit
description: Channel audit — paid ads, email/SMS program, or site CRO — with scored findings and action plan
argument-hint: "<workspace-name> [paid|email|site|full]"
---

<objective>
Run a structured audit of paid channels, the email program, or site conversion performance. Score each area against benchmarks. Produce a prioritized action plan with expected impact estimates.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./references/ecom-channels.md
@./references/cro-playbook.md
@./references/ecom-benchmarks.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // AUDIT >>
{workspace name} — {date}
```

2. Ask: Which audit type?
   - A. Paid channels audit
   - B. Email and SMS program audit
   - C. Site CRO audit
   - D. Full audit (all three — produces a unified action plan)

3. Load relevant workspace files based on audit type:
   - Paid: CHANNELS.md, METRICS.md, FINANCE.md
   - Email: FLOWS.md, CHANNELS.md, METRICS.md, SUPPRESSION.md
   - Site: METRICS.md, PRODUCTS.md
   - Full: all workspace files

---

**PAID CHANNELS AUDIT:**

For each active paid channel (from CHANNELS.md):

Assess:
- Current ROAS vs. target and vs. benchmark (ecom-benchmarks.md by channel type)
- Budget utilization: underspending, on-pace, or overspending?
- Creative refresh cadence: when was creative last updated?
- Audience setup: are cold, warm, and retargeting audiences all active?
- UTM hygiene: are all campaigns tagged?

Score each channel: Green (on target) / Yellow (watch) / Red (action required)

Output:
```
┌─ PAID AUDIT ─────────────────────────────────────────────────┐
│                                                               │
│  Meta:   {ROAS}x vs {target}x target  — {Green/Yellow/Red}  │
│          Budget: ${spent} / ${budget} ({X%} used)            │
│          Creative age: {X} weeks  ({OK / STALE — refresh})   │
│                                                               │
│  Google: {ROAS}x vs {target}x target  — {Green/Yellow/Red}  │
│          Budget: ${spent} / ${budget} ({X%} used)            │
│                                                               │
│  Blended MER: {X}x vs {target}x  — {status}                  │
│                                                               │
│  Top findings:                                                │
│  1. {finding with channel and specific metric}                │
│  2. {finding}                                                 │
│  3. {finding}                                                 │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

Produce action plan: per-channel, scored by expected impact (High / Medium / Low).

---

**EMAIL AND SMS AUDIT:**

Assess:
- Flow performance: each active flow revenue vs. benchmark from email-flows.md
  - Open rate vs. benchmark per flow
  - CTR vs. benchmark
  - Revenue per recipient vs. benchmark
  - Score each flow: Green / Yellow / Red
- Campaign performance: open rate, CTR, revenue per email vs. ecom-benchmarks.md
- List health: % active (opened in 90d), growth rate, unsubscribe rate
- Deliverability indicators: bounce rate, spam complaint rate
- Suppression: is SUPPRESSION.md being applied to all sends?
- Flow coverage: which standard flows from email-flows.md are missing?

Output:
```
┌─ EMAIL AUDIT ────────────────────────────────────────────────┐
│                                                               │
│  List health:                                                 │
│  {X} subscribers  ({Y%} active)  Growth: {+Z/mo}            │
│  Unsubscribe rate: {X%}  Bounce rate: {Y%}                   │
│                                                               │
│  Flows:                                                       │
│  Welcome:      ${rev/mo}  Rev/recip: ${X}  — {status}        │
│  Abandoned Cart: ${rev/mo}  Rev/recip: ${X}  — {status}      │
│  Post-Purchase: ${rev/mo}  Rev/recip: ${X}  — {status}       │
│  Win-Back:     ${rev/mo}  Rev/recip: ${X}  — {status}        │
│                                                               │
│  Missing flows: {list any from email-flows.md not set up}    │
│                                                               │
│  Campaign avg: Open {X%}  CTR {Y%}  Rev/email ${Z}           │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

Produce action plan: prioritized by revenue uplift potential.

---

**SITE CRO AUDIT:**

Assess using cro-playbook.md checklist:

Product page audit (for top 3 SKUs by revenue):
- Above-fold completeness (6 required elements)
- Image count and quality
- Review placement (above or below fold)
- Description structure (benefits vs. features lead)
- Trust signals present

Checkout audit:
- Guest checkout available?
- Express payment options present?
- Progress indicator?
- Free shipping threshold shown?
- Navigation removed?

Site speed:
- LCP — above or below 2.5s?
- Mobile CVR vs. desktop CVR gap

AOV optimization:
- Free shipping threshold set?
- Bundles or upsells available?
- Post-purchase upsell active?

Score each area: Green / Yellow / Red using cro-playbook.md standards.

Output:
```
┌─ CRO AUDIT ──────────────────────────────────────────────────┐
│                                                               │
│  CVR: {X%}  (benchmark: 1.5–3.5%)  — {status}               │
│  AOV: ${X}  (vs target: ${Y})  — {status}                    │
│  Cart abandonment: {X%}  — {status}                          │
│  Mobile CVR gap: {X%} vs desktop  — {OK / ISSUE}             │
│                                                               │
│  Product pages: {Green/Yellow/Red}                            │
│  {Specific gaps from checklist}                               │
│                                                               │
│  Checkout: {Green/Yellow/Red}                                 │
│  {Specific gaps}                                              │
│                                                               │
│  Site speed: LCP {X}s  — {Green/Yellow/Red}                  │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

Produce prioritized CRO recommendations with impact vs. effort score (High/Low for both).

---

**For Full audit:** Run all three, then produce a unified cross-channel action plan — ranked top 5 actions with expected revenue impact across all loops.

4. Log audit findings to `logs/workspace-log.md`.

5. Update LEARNINGS.md with any strategic audit finding that should inform future decisions.

6. Suggest follow-up commands:
- Paid issues → `/ecom:campaign {workspace}` to rebuild
- Email flow gaps → `/ecom:flow {workspace}` to set up missing flows
- Site speed issues → Review TOOLS.md for app bloat, engage developer
- Promo opportunity → `/ecom:promo {workspace}`

</process>
