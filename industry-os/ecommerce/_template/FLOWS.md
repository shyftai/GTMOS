# Email and SMS Flows

## Active flows

| Flow | Platform | Trigger | Audience | Status | Revenue (30d) | Rev/Recipient |
|------|----------|---------|----------|--------|---------------|---------------|
| Welcome Series | [Klaviyo] | Opt-in (form/pop-up) | New subscribers | Active | $[X] | $[Y] |
| Abandoned Cart | [Klaviyo] | Cart abandon | All | Active | $[X] | $[Y] |
| Browse Abandonment | [Klaviyo] | PDP view, no purchase | All | Active | $[X] | $[Y] |
| Post-Purchase | [Klaviyo] | Order placed | Buyers | Active | $[X] | $[Y] |
| Win-Back | [Klaviyo] | 90d no purchase | Lapsed | Active | $[X] | $[Y] |
| VIP Welcome | [Klaviyo] | LTV threshold crossed | VIP | Active | $[X] | $[Y] |

---

## Flow architecture

### Welcome Series (5 emails, 10 days)
- **Trigger:** New opt-in via form, pop-up, or checkout opt-in
- **Goal:** First purchase within 7 days
- **Exit condition:** Purchase at any point — exit all remaining emails

| # | Delay | Subject line | Goal | Offer |
|---|-------|-------------|------|-------|
| 1 | Immediate | "Welcome to [Brand] — here's [X]% off" | Brand intro + first purchase | 10–15% off |
| 2 | Day 1 | "What [X,000] customers say about us" | Social proof | None |
| 3 | Day 3 | "How [product] actually works" | Education + trust | None |
| 4 | Day 5 | "Your discount expires in 48 hours" | Urgency | Reinforce offer |
| 5 | Day 7 | "Not ready? Save this for later" | Last chance (non-buyers only) | Final offer |

### Abandoned Cart (3 emails, 48 hours)
- **Trigger:** Add to cart → session ends without purchase
- **Goal:** Recover the sale
- **Exit condition:** Purchase at any point

| # | Delay | Subject line | Goal | Offer |
|---|-------|-------------|------|-------|
| 1 | 20 min | "Your cart is waiting" | Soft reminder | None — no discount in email 1 |
| 2 | 4 hours | "Others are loving this" | Social proof + mild urgency | None |
| 3 | 24 hours | "Here's a little push." | Time-limited offer | Free shipping or 10% off |

### Browse Abandonment (2 emails, 2 days)
- **Trigger:** Viewed product page 2+ times in 24h, no add to cart
- **Exit condition:** Add to cart or purchase

| # | Delay | Subject line | Goal |
|---|-------|-------------|------|
| 1 | 4 hours | "Still thinking about it?" | Show viewed product + 3 reviews |
| 2 | Day 2 | "Other customers also loved..." | Cross-sell (non-buyers only) |

### Post-Purchase (5 emails, 60 days)
- **Trigger:** Order placed
- **Goal:** Delight, drive review, drive repeat purchase
- **Note:** Suppress all promotional emails for 7 days after purchase

| # | Delay | Subject line | Goal |
|---|-------|-------------|------|
| 1 | Day 1 | "Your order is confirmed" | Order confirmation + shipping ETA |
| 2 | Day 3 | "[Shipping update] + what to expect" | Brand story, anticipation |
| 3 | Day 7–14 post-delivery | "How's your [product]?" | Review request |
| 4 | Day 30 | "Complete your routine" | Cross-sell (complementary product) |
| 5 | Day 45–60 | "Time for a refill?" | Replenishment or subscription upsell |

### Win-Back (3 emails, 14 days)
- **Trigger:** No purchase in 90 days (adjust per product repurchase frequency)
- **Goal:** Reactivate lapsed customer

| # | Delay | Subject line | Goal |
|---|-------|-------------|------|
| 1 | Day 90 | "A lot has happened since you last visited" | What's new, highlight hero product |
| 2 | Day 97 | "Here's a reason to come back" | 15% off or free shipping |
| 3 | Day 104 | "Your offer expires tomorrow" | Urgency — last chance |

After no purchase at Day 104: move to low-frequency segment or suppression.

### VIP / Loyalty Welcome
- **Trigger:** Customer crosses LTV threshold (top 10–20% by spend)
- **Goal:** Recognize, delight, drive referral and advocacy

| # | Delay | Subject line | Goal |
|---|-------|-------------|------|
| 1 | Trigger day | "You're officially a [Brand] VIP" | VIP status announcement + exclusive benefit |
| Ongoing | — | Early access, personalized picks, exclusive drops | Maintain high engagement |

---

## Flow conflict rules
- A contact should not be in more than 2 active flows simultaneously
- Abandoned cart flow takes priority over win-back if both would trigger
- Post-purchase flow suppresses all promotional emails for 7 days
- Welcome series suppresses win-back and promotional sends during sequence
- Flag any new flow enrollment that would conflict with an existing active flow (Flow conflict gate)

---

## Flow A/B tests in progress

| Flow | Test | Variant A | Variant B | Started | Result |
|------|------|-----------|-----------|---------|--------|
| [Flow] | [Subject line / timing / offer] | [A] | [B] | [date] | [winner / running] |

---

## Benchmark performance targets

| Flow | Rev/Recipient | Open Rate | CVR |
|------|---------------|-----------|-----|
| Welcome Series | > $0.50 | > 45% | > 3% |
| Abandoned Cart | > $2.00 | > 40% | > 5% |
| Browse Abandonment | > $0.30 | > 35% | > 2% |
| Post-Purchase | > $0.40 | > 50% | > 2% |
| Win-Back | > $0.15 | > 25% | > 1.5% |
