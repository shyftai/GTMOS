---
name: ecom:budget-allocation
description: Set or rebalance channel budget — apply allocation frameworks, model expected ROAS, recommend split
argument-hint: "<workspace-name> [--total <monthly-budget>]"
---

<objective>
Help the brand operator set or rebalance their paid marketing budget across channels. Apply proven allocation frameworks, model expected ROAS at each budget level, flag where spend is misallocated, and output an updated CHANNELS.md budget plan.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./references/ecom-channels.md
@./references/ecom-metrics.md
@./references/ecom-benchmarks.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // BUDGET ALLOCATION >>
{workspace name}
```

2. Load CHANNELS.md, FINANCE.md, METRICS.md, LEARNINGS.md.
   Load `references/ecom-channels.md` for channel scaling and pausing signals.
   Load `references/ecom-benchmarks.md` for ROAS targets by channel.

3. Pull current state from CHANNELS.md:
   - Total monthly budget
   - Per-channel: current spend, current ROAS, target ROAS, budget cap

4. Confirm or collect the total budget to allocate:
   - If `--total` argument provided: use that figure
   - If not: ask "What is your total monthly marketing budget? (Currently: ${X} from CHANNELS.md)"

5. Display current allocation:

```
┌─ CURRENT ALLOCATION ──────────────────────────────────────────┐
│                                                               │
│  Total budget: ${total}                                        │
│                                                               │
│  Channel        Budget    % of total   ROAS    vs. target     │
│  ─────────────────────────────────────────────────────────── │
│  Meta           ${X}      {Y%}         {Z}x    🟢/🟡/🔴      │
│  Google         ${X}      {Y%}         {Z}x    🟢/🟡/🔴      │
│  Email          ${X}      {Y%}         {Z}x    🟢/🟡/🔴      │
│  SMS            ${X}      {Y%}         {Z}x    🟢/🟡/🔴      │
│  {other}        ${X}      {Y%}         {Z}x    🟢/🟡/🔴      │
│                                                               │
│  MER (blended): {current MER}x                                │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

6. Apply the allocation framework from ecom-channels.md:

   **Standard allocation model (adjust based on stage):**

   | Stage | Cold (acquisition) | Warm (retargeting) | Retention (email/SMS) |
   |-------|-------------------|--------------------|----------------------|
   | Early (<$50K/mo revenue) | 40% | 20% | 40% |
   | Growth ($50K–$250K/mo) | 50% | 25% | 25% |
   | Scale ($250K+/mo) | 55% | 25% | 20% |

   Determine the brand's stage from FINANCE.md revenue. Apply the matching model as the baseline allocation.

   **Rebalancing signals — check each:**
   - If any channel ROAS is 🔴 (< 70% of target): flag for budget reduction
   - If any channel ROAS is 🟢 and at budget cap: flag for budget increase
   - If email revenue < 20% of total: flag — email is underallocated
   - If cold audience spend > 60% of total: flag — retargeting and retention likely underfunded

7. Model the recommended allocation:

```
┌─ RECOMMENDED ALLOCATION ──────────────────────────────────────┐
│                                                               │
│  Total budget: ${total}                                        │
│                                                               │
│  Channel        Current   Recommended   Change   Expected ROAS│
│  ─────────────────────────────────────────────────────────── │
│  Meta Cold      ${X}      ${Y}          {+/-$Z}  {est. Nx}    │
│  Meta Retarget  ${X}      ${Y}          {+/-$Z}  {est. Nx}    │
│  Google         ${X}      ${Y}          {+/-$Z}  {est. Nx}    │
│  Email          ${X}      ${Y}          {+/-$Z}  n/a          │
│  SMS            ${X}      ${Y}          {+/-$Z}  n/a          │
│                                                               │
│  Projected blended MER: {est. Nx}  (current: {Nx})            │
│  Expected revenue impact: {+/-$X} / month                    │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

   Expected ROAS estimates: use the benchmark ranges from ecom-benchmarks.md and scale by the channel's current efficiency trend.

8. Check LEARNINGS.md — if any prior budget reallocation learnings exist, surface them before confirming.

9. **Budget gate (hard gate):** If any recommended channel increase exceeds the circuit breaker threshold (> 20% monthly budget change), flag it:
   "This change moves {channel} budget by {%} — this exceeds the 20% circuit breaker. Confirm before updating."

10. Ask: "Apply this allocation to CHANNELS.md?"
    - If yes: update CHANNELS.md with new budget figures and note `last_budget_review: {date}`
    - If no: save the recommended allocation as a draft note at the bottom of CHANNELS.md

11. Log to `logs/workspace-log.md`:
```
## {date} Budget allocation review
Total budget: ${X}
Changes made: {count channels adjusted}
Projected MER change: {current} → {projected}
```

</process>
