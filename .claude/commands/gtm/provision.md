---
name: gtm:provision
description: Stand up sending infrastructure from sender identities — domains, DNS, inboxes, warmup
argument-hint: "<workspace-name> [linkedin-url ...]"
---
<objective>
Provision sending infrastructure end-to-end with the operator supplying only the **senders**. Resolve identities, suggest and rank outbound domains, and produce a costed provisioning plan. Stage 1 stops at the purchase gate (no spend); Stage 2 (with provider keys) executes the buy → provision → DNS → attach → warmup flow, each step hard-gated and journaled.

Workspace and optional sender LinkedIn URLs: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/infrastructure-provisioning.md
@./.claude/gtmos/references/api-reference.md
@./.claude/gtmos/references/tool-pricing.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // PROVISION >>`
2. Load workspace INFRASTRUCTURE.md, TOOLS.md (`Registrar`, `Inbox provider` config — default Cloudflare + Zapmail), COSTS.md, and BOOKING.md (company name + physical address for signatures). Check `.env` for provider keys (`CLOUDFLARE_API_TOKEN`, `ZAPMAIL_API_KEY` / `INBOXKIT_API_KEY`, `SMARTLEAD_API_KEY`) — report which are present/missing without printing values. If keys are missing, this run is **Stage 1 (plan only)**.

## Senders
3. Gather the senders (the only required input):
   - Parse LinkedIn URLs from $ARGUMENTS, or ask for them
   - For each URL, use Crispy `get_profile` → name, title/headline, photo URL
   - If only a name + photo is given, accept it; infer a sensible title or ask in one line
   - Confirm the sender list back to the operator before proceeding

## Plan
4. Determine the **primary domain** (from the workspace / sender companies) and the **sender × domain math** — default: every sender gets a mailbox on every sending domain (e.g. 3 senders × 4 domains = 12 inboxes). Confirm the domain count.
5. **Discover + rank domains** (Cloudflare Registrar — see api-reference.md): generate secondary-domain candidates per the naming strategy in INFRASTRUCTURE.md (never the primary domain), query availability + price, and rank by brand-closeness, TLD trust (`.com` first), length, no hyphens, price. Display the ranked table.
6. Build the **costed provisioning plan**: domains (one-time × price), inboxes (per-month), email verification, estimated total. Check COSTS.md and flag against budget.
7. Present the plan and the purchase gate:
```
╔══════════════════════════════════════════════════════════════╗
║  CHECKPOINT: Provisioning Spend                              ║
╚══════════════════════════════════════════════════════════════╝

  Senders:   {n}  ·  Domains: {n}  ·  Inboxes: {n}
  Domains:   {list}  —  ${one-time}
  Inboxes:   {n} × {provider}  —  ${per-month}
  Estimated: ${total} one-time + ${recurring}/mo

──────────────────────────────────────────────────────────────
→ This buys domains and provisions inboxes (real spend, annual commitment).
   >> approve / reject / edit
──────────────────────────────────────────────────────────────
```

## Stage 1 — stop here (no spend)
8. **If keys are missing OR this is a plan-only run:** stop at the gate. Output the plan, save it to the workspace, and list exactly what to enable for Stage 2 (which keys, which provider in TOOLS.md). Do not buy, write DNS, or touch `.env`.

## Stage 2 — execute (gated, keys present)
9. **On approval only**, run the infrastructure-provisioning.md flow, each step a hard gate and written to `logs/provision-journal.md` (read it first; skip anything already `done` — never double-buy):
   - Reserve/buy domains (Cloudflare) → log spend to COSTS.md
   - Provision mailboxes (Zapmail/InboxKit) with real-name local-parts + the Crispy photo; provider auto-configures SPF/DKIM/DMARC
   - Write the custom tracking CNAME (Cloudflare DNS)
   - Auto-attach mailboxes to the sequencer and enable warmup (Smartlead `POST /warmup`, ramp ≤40/day, permanent) — fresh inboxes only, no pre-warmed
   - Set signatures at the sequencer (name/title from sender; company/address from workspace)
   - Write provisioned domains, mailboxes, DNS + warmup status into INFRASTRUCTURE.md
10. **Never write `.env` without explicit confirmation** — preview any key write and disclose its source first (GTMOS.md).
11. Note the timeline: inboxes are provisioned in minutes but warm over ~2–3 weeks before they can send.

───────────────────────────────────────────────────────────────

## ▶ Next Up

**warmup** — track the new inboxes to go-live; then `/gtm:infra` to audit

`/gtm:warmup {workspace}`

───────────────────────────────────────────────────────────────
</process>
