---
name: ecom:onboard
description: First-time brand setup — create workspace and populate all brand files through a structured intake
argument-hint: "<workspace-name>"
---

<objective>
Guide the brand operator through a structured onboarding to create a complete, usable ECOMMERCE:OS workspace. At the end, the brand's identity, products, channels, audiences, metrics, flows, and finances should all be populated and ready for daily operation.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./_template/BRAND.md
@./_template/PRODUCTS.md
@./_template/CHANNELS.md
@./_template/AUDIENCES.md
@./_template/CALENDAR.md
@./_template/METRICS.md
@./_template/FLOWS.md
@./_template/FINANCE.md
@./_template/COMPETITORS.md
@./_template/TOOLS.md
@./_template/ROADMAP.md
@./_template/LEARNINGS.md
@./_template/SUPPRESSION.md
@./_template/COSTS.md
@./_template/workspace.config.md
</execution_context>

<process>

1. Display ECOMMERCE:OS banner (from ECOMMERCEOS.md).

2. Display header:
```
<< ECOMMERCE:OS // ONBOARDING >>
Let's get your brand set up. This will take 10–20 minutes.
You can stop at any point and continue later with /ecom:onboard {workspace}.
```

3. **Resume check:** Before asking anything, check if `workspaces/{workspace-name}/workspace.config.md` exists.
   - If it does: read it. If `onboard_status` is set, display:
     ```
     Resuming onboard for {workspace-name}.
     Last completed: Block {X} — {name}
     Continuing from Block {X+1}.
     ```
     Skip all completed blocks and resume from the next one.
   - If it doesn't exist: proceed with fresh setup.

4. Ask: "Quick setup (5 essential blocks, ~10 min) or Full setup (all blocks, ~20 min)?"

5. Create workspace folder structure at `workspaces/{workspace-name}/`:
   - Copy all files from `_template/` to `workspaces/{workspace-name}/`
   - Create `workspaces/{workspace-name}/logs/` with `auto-log.md` and `workspace-log.md`
   - Set `onboard_status: block_1_complete` in workspace.config.md after each block finishes

---

**BLOCK 1 — Brand identity** (both modes)

Ask in one block:
- What is your brand name?
- What category are you in? (Skincare / Apparel / Supplements / Home / Pet / Food & Beverage / Other)
- How would you describe your price positioning? (Budget / Mid-market / Premium / Luxury)
- Who is your customer in one sentence? (e.g. "Women 28–42 who are health-conscious and time-poor")
- What is your brand voice / tone? (e.g. "Direct and warm" / "Playful and bold" / "Clinical and credible")
- What is your tagline or hero message?

Create/update `workspaces/{workspace-name}/BRAND.md` with this information.

---

**BLOCK 2 — Products** (both modes)

Ask:
- What are your top 3–5 products? For each: name, price, approximate COGS or margin, current stock status
- Which is your hero / bestselling product that you lead with in acquisition?
- Do you have any bundles or subscription products?
- What is the minimum margin you would accept for a promotional discount?

Fill PRODUCTS.md with catalog and set margin floor.

---

**BLOCK 3 — Channels and performance** (both modes)

Ask:
- Which marketing channels are you active on? (Meta / Google / TikTok / Email / SMS / Influencer / SEO)
- For each active paid channel: what is your current monthly budget and current ROAS?
- For email: what platform (Klaviyo / Omnisend / other), list size, and typical open rate?
- What is your blended ROAS or MER right now? (If known)
- What is your current CAC?

Fill CHANNELS.md with active channels, budgets, and targets.

---

**BLOCK 4 — Metrics baseline** (both modes)

Ask:
- What is your current monthly revenue (approximate), and what is your target?
- What is your site CVR? (If known)
- What is your AOV?
- What is your 90-day repeat purchase rate? (If known)
- What percentage of your revenue comes from email?

Fill METRICS.md with performance baseline. This is the starting point for all future benchmarking.

---

**BLOCK 5 — Email and SMS flows** (both modes)

Ask:
- Which lifecycle flows do you currently have active? (Welcome / Abandoned Cart / Post-Purchase / Browse Abandonment / Win-Back / VIP / None yet)
- For each active flow: what platform, and roughly how much revenue does it generate per month?
- Are there any flows that are underperforming or not set up yet?

Fill FLOWS.md with current flow status.

---

**BLOCK 6 — Finance** (full mode only)

Ask:
- What is your gross margin and contribution margin? (Approximate % is fine)
- What is your LTV:CAC ratio? (If known)
- What is your total monthly marketing budget?
- What is your revenue target for this quarter and this year?

Fill FINANCE.md with unit economics and set contribution margin floor.

---

**BLOCK 7 — Tech stack** (full mode only)

Ask:
- What ecommerce platform are you on? (Shopify / WooCommerce / BigCommerce / Custom)
- What analytics and attribution tools are you using?
- What review platform do you use?
- Do you have a loyalty or subscription program?

Fill TOOLS.md.

---

**BLOCK 8 — Competitors** (full mode only)

Ask:
- Who are your top 2–3 competitors?
- What do they lead with? And where do you beat them?

Fill COMPETITORS.md.

---

**BLOCK 9 — Execution mode** (full mode only)

Ask:
- Execution mode: Interactive (approval before campaigns, sends, promos) or Auto (auto-approves drafts and research, stops at hard gates)?
- Solo operator or team?

Set in workspace.config.md.

---

**After all blocks complete:**

6. Display completion summary:
```
┌─ ONBOARDING COMPLETE ─────────────────────────────────────────┐
│                                                               │
│  Workspace: {workspace name}                                  │
│  Brand: {brand name}  ({category}, {price positioning})       │
│  Products loaded: {count}  Hero SKU: {name}                   │
│  Active channels: {list}                                      │
│  Flows configured: {count active} / {count total}             │
│  Monthly revenue target: ${X}                                 │
│  Contribution margin floor: {X%}                              │
│  Execution mode: {interactive / auto}                         │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

   Set `onboard_status: complete` in workspace.config.md.

7. Suggest first actions based on what was entered:
- Always: `/ecom:today {workspace}` — see what needs attention right now
- If flows are missing: `/ecom:flow {workspace}` — set up priority flows (welcome + abandoned cart first)
- If paid channels active: `/ecom:audit {workspace} paid` — check current channel health
- If no recent promo: `/ecom:signals {workspace}` — scan for market opportunities
- If email program weak (< 20% of revenue): `/ecom:audit {workspace} email`
- If strong baseline: `/ecom:health {workspace}` — get a full health check

</process>
