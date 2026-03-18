# REV:OS Defaults

Sensible defaults for every configurable behavior in REV:OS. All values are overridable per workspace via `workspace.config.md`, `DATA-QUALITY.md`, `FORECAST.md`, or other workspace files. When a workspace file defines a different value, use that value. When no workspace value exists, use these defaults.

---

## Execution

| Setting | Default | Override location |
|---------|---------|-------------------|
| Execution mode | `interactive` | `workspace.config.md` |
| Collaboration mode | `solo` | `workspace.config.md` |
| Auto-approve enrichment reads | `yes` | `workspace.config.md` |
| Auto-approve CRM writes | `no — hard gate` | Cannot be overridden |
| Auto-approve duplicate merges | `no — hard gate` | Cannot be overridden |

---

## Data quality

| Setting | Default | Override location |
|---------|---------|-------------------|
| Data quality score target | 85% | `DATA-QUALITY.md` |
| Minimum acceptable score (trigger alert) | 70% | `DATA-QUALITY.md` |
| Enrichment cache TTL | 30 days | `DATA-QUALITY.md` |
| Dedupe confidence threshold (auto-merge) | 95% | `DATA-QUALITY.md` |
| Dedupe confidence threshold (flag for review) | 80–94% | `DATA-QUALITY.md` |
| Dedupe confidence threshold (ignore) | < 80% | `DATA-QUALITY.md` |
| Enrichment coverage target — Tier 1 accounts | 95% | `DATA-QUALITY.md` |
| Enrichment coverage target — Tier 2 accounts | 80% | `DATA-QUALITY.md` |
| Enrichment coverage target — Tier 3 accounts | 60% | `DATA-QUALITY.md` |
| Stale record threshold (no activity) | 90 days | `DATA-QUALITY.md` |
| Duplicate cluster alert threshold | > 50 records | `DATA-QUALITY.md` |

---

## Pipeline and forecast

| Setting | Default | Override location |
|---------|---------|-------------------|
| Pipeline coverage target | 3× quota | `PIPELINE.md` |
| Pipeline coverage warning threshold | < 2× quota | `PIPELINE.md` |
| Deal stage stall alert (no movement) | 21 days | `PIPELINE.md` |
| Win rate benchmark (SaaS B2B) | 20–30% | `references/rev-benchmarks.md` |
| Average sales cycle benchmark | 60–90 days | `references/rev-benchmarks.md` |
| Forecast variance threshold (flag) | > 10% vs. prior week | `FORECAST.md` |
| Forecast accuracy target | < 10% variance at W12 | `FORECAST.md` |
| Default forecast model | Weighted pipeline | `FORECAST.md` |
| Commit probability floor | 80% | `FORECAST.md` |

---

## Customer health

| Setting | Default | Override location |
|---------|---------|-------------------|
| Health score: product engagement weight | 30% | `CS-CONFIG.md` |
| Health score: relationship weight | 20% | `CS-CONFIG.md` |
| Health score: support + sentiment weight | 20% | `CS-CONFIG.md` |
| Health score: commercial health weight | 20% | `CS-CONFIG.md` |
| Health score: org stability weight | 10% | `CS-CONFIG.md` |
| Health status: 🟢 Green threshold | ≥ 75 | `CS-CONFIG.md` |
| Health status: 🟡 Yellow threshold | 50–74 | `CS-CONFIG.md` |
| Health status: 🔴 Red threshold | 25–49 | `CS-CONFIG.md` |
| Health status: 🚨 Critical threshold | < 25 | `CS-CONFIG.md` |
| Score decay (no update) | −5 points / 30 days | `CS-CONFIG.md` |
| Score floor (override rule active) | 20 | `CS-CONFIG.md` |

---

## Renewal and expansion

| Setting | Default | Override location |
|---------|---------|-------------------|
| Renewal outreach start (minimum) | 60 days before renewal | `CS-CONFIG.md` |
| Renewal escalation trigger | < 30 days, no engagement | `CS-CONFIG.md` |
| Renewal at-risk threshold | Health score < 60 | `CS-CONFIG.md` |
| Expansion eligibility threshold | Health score ≥ 75 (🟢) | `CS-CONFIG.md` |
| Expansion signal: seat utilization | ≥ 80% of licensed seats | `CS-CONFIG.md` |
| Expansion signal: usage growth MoM | ≥ 20% | `CS-CONFIG.md` |
| NPS score for expansion trigger | ≥ 8 (Promoter) | `CS-CONFIG.md` |
| Churn prediction window | 90 days | `CS-CONFIG.md` |
| VP CS escalation trigger | 🚨 Critical health | Cannot be overridden |

---

## NRR and revenue benchmarks

| Metric | Default benchmark | Source |
|--------|-------------------|--------|
| Net Revenue Retention (NRR) target | ≥ 110% | `references/rev-benchmarks.md` |
| Gross Revenue Retention (GRR) target | ≥ 90% | `references/rev-benchmarks.md` |
| MRR churn rate target | < 1% monthly | `references/rev-benchmarks.md` |
| Logo churn rate target | < 5% annually | `references/rev-benchmarks.md` |
| Expansion ARR as % of total ARR | ≥ 20% | `references/rev-benchmarks.md` |

---

## Circuit breakers (auto mode)

| Breaker | Default threshold | Override location |
|---------|-------------------|-------------------|
| API calls per session | 300 | `workspace.config.md` |
| CRM records modified per session | 500 | `workspace.config.md` |
| Duplicate merges per batch | 50 | `workspace.config.md` |
| Consecutive data quality failures | 3 | `workspace.config.md` |
| Enrichment credit spend per session | $50 | `workspace.config.md` |
| Enrichment match rate floor | 70% (first 50 records) | `workspace.config.md` |

---

## Reporting cadence

| Report | Default frequency | Override location |
|--------|-------------------|-------------------|
| Pipeline review | Weekly (Monday) | `workspace.config.md` |
| Revenue report | Monthly (1st of month) | `workspace.config.md` |
| QBR | Quarterly | `workspace.config.md` |
| Board / investor report | Quarterly | `workspace.config.md` |
| Win/loss report | Monthly | `workspace.config.md` |
| Data quality audit | Monthly | `workspace.config.md` |
| Stripe reconciliation | Weekly | `workspace.config.md` |

---

## Win/loss analysis

| Setting | Default | Override location |
|---------|---------|-------------------|
| Minimum N for win/loss conclusions | 10 deals | `WIN-LOSS.md` |
| Win/loss capture deadline | 14 days after close | `RULES.md` |
| Win/loss interview target (enterprise) | 60% of deals | `RULES.md` |
| Stale win/loss record alert | > 14 days without record | `WIN-LOSS.md` |

---

## Attribution

| Setting | Default | Override location |
|---------|---------|-------------------|
| Default attribution model | Multi-touch linear | `ATTRIBUTION.md` |
| UTM source — paid search | `google` / `bing` | `ATTRIBUTION.md` |
| UTM medium — paid | `cpc` | `ATTRIBUTION.md` |
| UTM medium — email | `email` | `ATTRIBUTION.md` |
| UTM medium — organic social | `social` | `ATTRIBUTION.md` |
| Attribution lookback window | 90 days | `ATTRIBUTION.md` |

---

## Stripe reconciliation

| Setting | Default | Override location |
|---------|---------|-------------------|
| ARR/MRR variance tolerance | < 1% | `STRIPE.md` |
| Reconciliation frequency | Weekly | `workspace.config.md` |
| Stripe → CRM sync lag tolerance | < 24 hours | `STRIPE.md` |
| Excluded revenue types | Trials, refunds, one-time fees | `STRIPE.md` |

---

## How to override

All defaults can be overridden at the workspace level. To change a default:

1. Open the relevant workspace file (e.g., `CS-CONFIG.md` for health score weights)
2. Add an explicit entry — e.g., `Health score: product engagement weight: 40%`
3. REV:OS will use the workspace value instead of this default from that point forward

Document *why* you changed a default in `RULES.md` — especially for thresholds that affect automated decisions.
