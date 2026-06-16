# Infrastructure Provisioning — GTMOS

Stand up sending infrastructure end-to-end with the operator supplying **only the sender identities**. Everything else — domains, DNS, inboxes, photos, signatures, sequencer attach, warmup — provisions automatically and lands in `INFRASTRUCTURE.md`, which `/gtm:infra`, `/gtm:warmup`, and the ship launch-check already read.

Loaded by `/gtm:provision`. Markdown-native: Claude calls the provider REST APIs directly (documented in `api-reference.md`) — no scripts.

---

## Minimum operator input: who's sending

The only required input is the **senders** — the people whose names appear on the outbound:

- **LinkedIn URLs** (preferred) → Crispy `get_profile` resolves name, title/headline, and photo per sender.
- **Or just name + photo** → enough to create a credible mailbox; title falls back to a sensible default or one short prompt.

Company name and physical address (for the signature footer + CAN-SPAM) come from the **workspace**, not the person.

---

## The flow

```
sender LinkedIn URLs ──► Crispy get_profile (name / title / photo)
        │
Cloudflare Registrar ──► suggest + rank outbound domains ──► 🔒 reserve/buy (spend)
        │
Zapmail / InboxKit ─────► provision mailboxes + photo + SPF/DKIM/DMARC  🔒
        │
Cloudflare DNS ─────────► custom tracking CNAME (the one record providers don't set)
        │
Smartlead / Instantly ──► auto-attach mailboxes + enable warmup (signature here too)
        │
INFRASTRUCTURE.md ──────► state mirror → /gtm:infra, /gtm:warmup, ship launch-check
```

Customer-facing, this is: *paste sender URLs → approve the domain shortlist → approve the spend → walk away.* The two approvals are deliberate hard gates — it's their money and an annual commitment.

---

## Two stages

**Stage 1 — plan only (no spend).** `/gtm:provision` resolves senders, discovers + ranks domains, and produces a **costed provisioning plan**, then **stops at the purchase gate**. Nothing is bought, no DNS is written, no `.env` is touched. This is the default until real keys are in and one provider has been smoke-tested.

**Stage 2 — execution (gated).** With provider keys present and confirmed, the execution legs run — purchase → provision → DNS → attach → warmup — each behind its own hard gate, recorded in the provisioning journal.

---

## Provider roles

| Layer | Provider | Role |
|-------|----------|------|
| Registrar | **Cloudflare Registrar** (at-cost) | discover + reserve + buy domains |
| DNS | inbox provider (Zapmail/InboxKit) owns SPF/DKIM/DMARC; **Cloudflare DNS** holds the tracking CNAME | |
| Inboxes | **Zapmail** (default) or **InboxKit** | provision Google/MS mailboxes, set photo, auto-configure DNS |
| Identity | **Crispy** | LinkedIn URL → name / title / photo |
| Sequencer + warmup + signature | **Smartlead** (default) / Instantly | auto-attach mailboxes, enable warmup, set signature |

Select the inbox provider in `TOOLS.md` (`Inbox provider: zapmail` default). Endpoints for all of these live in `api-reference.md` under "Infrastructure provisioning".

### DNS authority — provider-managed
Both Zapmail and InboxKit auto-configure SPF/DKIM/DMARC when they own the domain, and do it well. Don't fight them: **let the inbox provider own DNS**, and use **Cloudflare for the registrar + the custom tracking CNAME only** (the record the provider doesn't set, which the sending tool needs). One authority per record, fewer breakages.

---

## Domain discovery + ranking

1. From the primary domain (e.g. `acme.com`), generate secondary-domain candidates per the naming strategy in `INFRASTRUCTURE.md` — `getacme`, `tryacme`, `acmehq`, `useacme`, `acme-mail`, plus `.co`/`.io` where the `.com` is taken. **Never the primary domain** — protect its reputation.
2. Query the registrar for availability + price across candidates.
3. Rank by: brand-closeness, TLD trust (`.com` first), length, no hyphens, price.
4. Present a ranked table; the operator picks how many (sender × domain math below).

## Sender × domain math
Default: **every sender gets a mailbox on every sending domain** (e.g. 3 senders × 4 domains = 12 inboxes), ~25–40 cold sends/inbox/day. Override in the provisioning plan. This is the core input that sizes the buy.

---

## Inboxes, photos, signatures, warmup

- **Mailboxes:** real-name local-parts (`james@getacme.com`, `sarah.c@tryacme.com`) per the `INFRASTRUCTURE.md` convention; display name from the sender identity.
- **Photo:** pass the Crispy LinkedIn photo URL into the provider's `profilePicture` / `profile_picture` field (Zapmail can also auto-generate one).
- **Signature:** set at the **sequencer** layer (Smartlead/Instantly), not the inbox provider — name + title from the sender, company + physical address from the workspace.
- **Attach + warmup:** auto-attach mailboxes to the sequencer (InboxKit `sequencer_uid` at purchase / Zapmail OAuth export / Smartlead SmartSenders), then enable warmup (`Smartlead POST /email-accounts/{id}/warmup`, `warmup_enabled`, ramp ≤40/day, reply-rate) and **leave it on permanently**.
- **Fresh inboxes only — no pre-warmed.** Pre-warmed mailboxes carry generic, artificial reputation you didn't build; warm your own and ramp. Expect **~2–3 weeks** to sendable. Start domain purchases early (the weekly-rhythm and insurance-pool rotation account for this).

---

## Safety

Every spend / DNS-write / credential step is a **hard gate** (stops even in auto mode), with cost shown and logged to `COSTS.md` first per the "Before using any tool" rules in `GTMOS.md`. A bulk-buy circuit breaker stops above a per-run domain/inbox threshold.

**Never write `.env` without explicit confirmation** — provider keys (`CLOUDFLARE_API_TOKEN`, `ZAPMAIL_API_KEY`, `INBOXKIT_API_KEY`) follow the same preview-and-confirm rule as any credential (see `GTMOS.md`). Scope the Cloudflare token to Registrar + DNS only.

### Provisioning journal (idempotent, resumable)
Provisioning is multi-step and spends real money — it must never double-buy on a re-run. Mirror the `scrape-cache.md` pattern:

- Write each step to `logs/provision-journal.md` as it happens: candidates, purchased domains, created mailboxes, DNS records written, attach/warmup status — each with a state (`planned` / `done` / `failed`).
- On every run, **read the journal first** and skip anything already `done`. Resume from the first incomplete step.
- Never purchase a domain or create a mailbox that the journal already records as `done`.

---

## Output → INFRASTRUCTURE.md

On completion (Stage 2), write the provisioned domains, mailboxes, DNS status, tracking domain, and warmup status into the workspace `INFRASTRUCTURE.md` tables. From there the existing audit (`/gtm:infra`), warmup tracking (`/gtm:warmup`), and ship launch-check consume it unchanged — provisioning just *fills in* what they already read.
