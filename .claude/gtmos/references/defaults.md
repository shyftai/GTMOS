# GTMOS Defaults

Sensible defaults that apply out of the box. Every default can be overridden per workspace in the relevant file. If a workspace doesn't specify a value, use these.

---

## Copy defaults

| Setting | Default | Override in |
|---------|---------|-------------|
| Subject line length | 2-4 words, lowercase, no punctuation | TOV.md |
| First touch max words | 75 | TOV.md or RULES.md |
| Follow-up max words | 50 | TOV.md or RULES.md |
| C-suite max words | 50 on any touch | TOV.md or RULES.md |
| CTA style | Interest-based ("Worth a look?") | TOV.md |
| Opening style | Observation-led, never start with "I" | TOV.md |
| Follow-up angle | Must differ from previous touch | RULES.md |
| Banned words | "excited", "thrilled", "game-changing", "synergy", "leverage", "unlock" | TOV.md |
| Email framework | Observation > Problem > Proof > Ask | write-sequence.md |

## Sequence defaults

| Setting | Default | Override in |
|---------|---------|-------------|
| Standard sequence length | 4 touches | campaign.config.md |
| Re-engagement sequence | 2 touches | campaign.config.md |
| Signal-triggered sequence | 2-3 touches | campaign.config.md |
| Interval between touches | 3-4 days | campaign.config.md |
| Re-engagement gap | 60 days minimum | campaign.config.md |
| Breakup touch | Always last touch, zero pressure | write-sequence.md |

## Sending defaults

| Setting | Default | Override in |
|---------|---------|-------------|
| Send days | Monday-Friday | campaign.config.md |
| Send window | 8:00-11:00 AM recipient timezone | campaign.config.md |
| Max cold emails per inbox per day | 40 | INFRASTRUCTURE.md |
| Warmup minimum before cold sending | 14 days (21 recommended) | INFRASTRUCTURE.md |
| Inbox rotation | Enabled when >1 inbox | INFRASTRUCTURE.md |

## LinkedIn defaults

| Setting | Default | Override in |
|---------|---------|-------------|
| Connection requests per day | 25 | MULTICHANNEL.md |
| Profile views per day | 50 | MULTICHANNEL.md |
| Messages per day | 100 | MULTICHANNEL.md |
| Connection note max | 300 characters | MULTICHANNEL.md |
| Pitch in connection note | Never | MULTICHANNEL.md |
| LinkedIn warming before connect | Optional, 3-7 days | MULTICHANNEL.md |

## Multi-channel defaults

| Setting | Default | Override in |
|---------|---------|-------------|
| Email then LinkedIn gap | 2-3 days | MULTICHANNEL.md |
| LinkedIn then email gap | 1-2 days after accepted | MULTICHANNEL.md |
| Same-day cross-channel | Never | MULTICHANNEL.md (non-overridable) |
| Reply on any channel | Pause all other channels | MULTICHANNEL.md (non-overridable) |

## List quality defaults

| Setting | Default | Override in |
|---------|---------|-------------|
| Score 3 criteria | All fields, strong ICP, verified email, signal | RULES.md |
| Score 0 criteria | Missing critical fields or outside ICP | RULES.md |
| Personal email domains | Reject | RULES.md |
| Role-based emails | Reject | RULES.md |
| Catch-all emails | Flag, don't reject | RULES.md |

## Lead scoring defaults

| Setting | Default | Override in |
|---------|---------|-------------|
| Company fit weight | 30% | RULES.md `## Lead scoring overrides` |
| Persona fit weight | 25% | RULES.md |
| Signal strength weight | 20% | RULES.md |
| Data quality weight | 15% | RULES.md |
| Engagement weight | 10% | RULES.md |
| Hot tier threshold | 80+ | RULES.md |
| Reject tier threshold | 0-19 | RULES.md |

## Enrichment defaults

| Setting | Default | Override in |
|---------|---------|-------------|
| Email waterfall | Apollo → Icypeas → Prospeo → Lemlist DB | RULES.md `## Enrichment waterfall overrides` |
| Email verification | ZeroBounce → MillionVerifier | RULES.md |
| Catch-all verification | Scrubby | RULES.md |
| Phone enrichment threshold | lead_score >= 80 (A-tier only) | RULES.md |
| Phone waterfall | Apollo (5 credits) → Crispy → Apify | RULES.md |
| People enrichment waterfall | Apollo → Crispy → Apify → Prospeo | RULES.md |
| Company enrichment waterfall | Apollo (free) → Freckle → StoreLeads → Apify | RULES.md |
| People search waterfall | Apollo (free) → Crispy/SalesNav → Lemlist → Instantly → Apify | RULES.md |
| Company search waterfall | Apollo (free) → StoreLeads → Openmart → Apify | RULES.md |
| Batch size | 50 contacts per API call | RULES.md |
| Ship unverified emails | Never | Non-overridable |

## Compliance defaults

| Setting | Default | Override in |
|---------|---------|-------------|
| All regulations | OFF by default — opt in via `/gtm:compliance` | SUPPRESSION.md `## Active regulations` |
| CAN-SPAM | OFF (enable if targeting US) | SUPPRESSION.md |
| GDPR | OFF (enable if targeting EU/UK) | SUPPRESSION.md |
| CASL | OFF (enable if targeting Canada) | SUPPRESSION.md |
| CCPA/CPRA | OFF (enable if targeting California) | SUPPRESSION.md |
| PECR | OFF (enable with GDPR for UK) | SUPPRESSION.md |
| LGPD | OFF (enable if targeting Brazil) | SUPPRESSION.md |
| Australian Spam Act | OFF (enable if targeting Australia) | SUPPRESSION.md |
| Unsubscribe mechanism | Required on every email | SUPPRESSION.md (non-overridable) |
| Physical address | Required on every email | SUPPRESSION.md (non-overridable) |
| Suppression check before send | Always | SUPPRESSION.md (non-overridable) |
| Bounce handling — hard | Remove immediately, suppress | RULES-GLOBAL.md (non-overridable) |
| Bounce handling — soft | Retry once after 48h, then suppress | RULES-GLOBAL.md |
| Bounce rate pause threshold | 5% | RULES-GLOBAL.md |
| Spam complaint pause threshold | 0.3% | RULES-GLOBAL.md |
| GDPR data retention | Campaign + 30 days | SUPPRESSION.md |
| CASL consent tracking | Required when CASL is ON | SUPPRESSION.md (non-overridable) |
| Right to erasure | Process within 30 days | SUPPRESSION.md (non-overridable) |
| Regulation auto-detect | ON during onboarding | `/gtm:compliance` |

## Budget defaults

| Setting | Default | Override in |
|---------|---------|-------------|
| Alert threshold | 80% of budget | COSTS.md |
| Default credit behaviour | confirm-before-every-use | TOOLS.md |
| CRM writes | Auto-approved (free) | TOOLS.md |

## Notification defaults

| Setting | Default | Override in |
|---------|---------|-------------|
| Slack notifications | Disabled | COLLABORATION.md |
| Critical alerts | Enabled (when Slack is on) | COLLABORATION.md |
| Important alerts | Enabled | COLLABORATION.md |
| Informational alerts | Disabled | COLLABORATION.md |

## Campaign type defaults

See `campaign-types.md` for full defaults per campaign type. Users select a type during `/gtm:new-campaign` and can override any setting.

---

## How overrides work

1. GTMOS checks the workspace-level file first (e.g. RULES.md, TOV.md)
2. If the setting is specified there, use it
3. If not specified, fall back to these defaults
4. Non-overridable settings (marked above) always apply regardless of workspace config
5. Users can add a `## GTMOS overrides` section to any workspace file to change defaults
