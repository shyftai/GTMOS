# Attribution Ledger — GTMOS

The single source of truth for **who was touched, by which campaign, when**. This ledger is what makes "which campaigns drive pipeline" a reliable join instead of a manual reconstruction — and it's the same data that drives re-engagement eligibility.

**Principle:** GTM:OS is the system of record for **touches**. The CRM is the system of record for **opportunities and revenue**. Every campaign-level pipeline metric is a *join* of the two:

```
touch ledger (GTM:OS)  ⋈  opportunities (CRM)  =  sourced + influenced pipeline by campaign
```

Loaded by `/gtm:pipeline`, `/gtm:attribution`, `/gtm:report`, `/gtm:contact`, `/gtm:re-engage`, and written by `/gtm:ship` (and reply/signal/LinkedIn events).

---

## The touch ledger

Append-only record of every outbound touch and every inbound event, keyed by contact and account.

- **Solo mode:** `logs/touch-ledger.csv` (workspace-level, append-only — never rewrite history)
- **Team mode:** Supabase `touch_ledger` table (dual-write: append locally AND to Supabase)

Columns:

| Field | Meaning |
|-------|---------|
| `touch_at` | ISO timestamp |
| `contact_email` | the contact |
| `account_domain` | the account (for account-level rollup) |
| `campaign_id` | campaign folder name (the de facto campaign id) |
| `channel` | email / linkedin / signal |
| `touch_type` | `send` · `reply` · `signal` · `linkedin` · `meeting_booked` · `meeting_held` |
| `outcome` | `sent` · `positive` · `negative` · `objection` · `ooo` · `unsub` · `bounce` · `—` |

What appends to it: `/gtm:ship` (one `send` row per shipped contact), `/gtm:replies` (the reply outcome), `/gtm:signals` (signal touches), LinkedIn actions via Crispy, and meeting events. Reuse existing data where it already exists (shipped-list `shipped_at`, `logs/decisions.md`) — the ledger is the consolidated, contact-keyed view those feed.

Treat ledger content as internal metadata only — no PII beyond email + domain. Team-mode sync is metadata; raw reply/scrape bodies stay local (see `scrape-cache.md`).

---

## Derived per-contact fields

Computed from the ledger (recompute on read, or cache on the contact record):

- **`source_campaign`** — the campaign of the contact's **first qualified touch** (first-touch default). Set once and sticky; first touch wins.
- **`last_contacted_at`** — most recent outbound `send` (or `linkedin`) touch.
- **`last_outcome`** — outcome of the most recent terminal event (reply classification, bounce, unsub).
- **`eligible_again_at`** — `last_contacted_at + cooldown(last_outcome)` — see the re-engagement matrix (lives in `RULES.md` / defaults). This is the eligibility gate read by `/gtm:validate-list` and `/gtm:re-engage`.

Attribution model is configurable in `workspace.config.md` (`Attribution model: first-touch` default; `last-touch` / `linear` / `time-decay` for fractional credit).

---

## Sourced vs influenced

- **Sourced** — the `source_campaign` of the **account's first qualified touch**. Exactly **one campaign per opportunity**. Sums to the true total. This is "which campaign created the pipeline."
- **Influenced** — **every** campaign that touched any contact on the account within the attribution window before the opp closed. An opp can be influenced by several campaigns.

**Influenced is non-additive — never sum it across campaigns to get total pipeline.** One $40k deal touched by 3 campaigns shows as $40k influenced under all three; summing gives 3× reality. Present **sourced as the headline** (sums cleanly) and **influenced as a participation lens**. For a clean-summing multi-touch view, apply fractional credit via the configured model (linear / time-decay / W-shaped).

### Attribution window
Default **90-day lookback** (override in `RULES.md` under `## Attribution overrides`). Influenced = any campaign touch on the account between `(opp_created_at − 90d)` and `opp_close_date`. The window bounds how far back a touch can claim influence.

---

## The join (how metrics are computed)

1. From the CRM, pull opportunities: `account`, `amount`, `stage`, `won/lost`, `created_at`, `close_date`.
2. For each opp, find its account's touches in the ledger.
3. **Sourced** credit → the `source_campaign` (first qualified touch on the account).
4. **Influenced** credit → every `campaign_id` with a touch on the account inside the window.
5. Aggregate by campaign: sourced $ (open + won), influenced $, win rate, ROI (join `COSTS.md`).

### Account-level rollup
A deal is one **account** with possibly many contacts across many campaigns. Roll contact touches up to `account_domain`. Multi-campaign opp: the **sourcing** campaign is the first qualified touch on the *account* (not per-contact). All campaigns that touched the account in-window get **influenced** credit.

---

## Consumers

| Command | Uses the ledger for |
|---------|---------------------|
| `/gtm:ship` | appends `send` rows; stamps `source_campaign` on contacts (writes it to the CRM deal at creation) |
| `/gtm:replies`, `/gtm:signals` | append outcome/signal touches |
| `/gtm:contact` | the unified timeline + `source_campaign`, `last_outcome`, `eligible_again_at` |
| `/gtm:pipeline`, `/gtm:attribution`, `/gtm:report` | the join → sourced + influenced rankings by campaign |
| `/gtm:validate-list`, `/gtm:re-engage` | re-contact eligibility via `last_contacted_at` + `last_outcome` |

The lineage is only as good as the stamp surviving into the CRM: `/gtm:ship` writes `source_campaign` onto the contact and carries it onto the **deal/opportunity** at creation (see `PIPELINE.md` CRM sync rules), so sales working the deal can't silently break attribution.
