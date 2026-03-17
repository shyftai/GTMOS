# Email and SMS Flow Library

Standard lifecycle flow sequences with triggers, timing, copy guidance, and performance benchmarks.

---

## Flow priority order (build in this sequence)

1. Welcome Series — highest LTV impact, captures new subscriber intent
2. Abandoned Cart — highest revenue per recipient, recovers near-buyers
3. Post-Purchase — sets retention trajectory for every buyer
4. Browse Abandonment — captures warm intent before cart
5. Win-Back — reactivates lapsed customers
6. VIP / Loyalty — rewards and retains highest-LTV customers

---

## Welcome Series

**The most important flow.** First impression sets LTV trajectory.

| Spec | Detail |
|------|--------|
| Trigger | New subscriber via any opt-in (pop-up, form, checkout, landing page) |
| Goal | First purchase within 7 days |
| Duration | 7–10 days |
| Exit condition | Purchase at any point — remove from all remaining emails |
| Performance target | Revenue per recipient > $0.50, CVR > 3% |

### Sequence

**Email 1 — Immediate (0–5 min)**
- Subject: "Welcome to [Brand] — here's [X]% off"
- Preview: "Your [X]% off code is inside."
- Content: Brand story in 3 sentences. Hero product or bestseller. Clear CTA with discount code.
- Tone: Warm, personal, confident.
- Offer: 10–15% off (or free shipping for high AOV brands).
- One CTA only — do not confuse with multiple products.

**Email 2 — Day 1**
- Subject: "What [X,000] customers say about us"
- Preview: "Don't take our word for it."
- Content: 3–5 curated reviews with star ratings. UGC images if available. Bestsellers list.
- Goal: Build trust through social proof.
- CTA: "Shop bestsellers" — back to the offer from Email 1.

**Email 3 — Day 3**
- Subject: "How [product] actually works"
- Preview: "The science behind [benefit]" — or — "Why [X] works when others don't"
- Content: Education-first. Explain the mechanism of action, key ingredients, or unique approach.
- Goal: Address the skeptic. Justify the purchase with information.
- CTA: Soft — "Learn more" leading to PDP or blog post.

**Email 4 — Day 5**
- Subject: "Your [X]% off expires in 48 hours"
- Preview: "Don't leave it behind."
- Content: Urgency. Show the offer expiry. Display 3 product options (not just one).
- Goal: Convert hesitant subscribers.
- CTA: "Use my discount" — direct to cart or PDP.

**Email 5 — Day 7 (non-buyers only)**
- Subject: "Not ready? Save this for later."
- Preview: "Your offer is still valid — no pressure."
- Content: Acknowledge they haven't bought yet. Offer alternative action (follow on social, bookmark the page). Keep the offer alive but don't push hard.
- Goal: Keep the door open. Reduce unsubscribes from people not ready to buy.
- Optional CTA: "Remind me later" (SMS opt-in, or just a low-key shop button).

---

## Abandoned Cart

**Highest ROI per email sent for most brands.**

| Spec | Detail |
|------|--------|
| Trigger | Product added to cart → session ends without purchase (30–60 min delay before first email) |
| Goal | Recover the sale |
| Duration | 48 hours |
| Exit condition | Purchase at any point |
| Performance target | Revenue per recipient > $2.00, CVR > 5% |

### Sequence

**Email 1 — 20 minutes after abandonment**
- Subject: "Your cart is waiting"
- Preview: "You left something behind."
- Content: Show cart contents (dynamic product block). Product image, name, price. No offer — no discount in Email 1 (you're training customers to abandon for discounts).
- Tone: Light, helpful, no pressure.
- CTA: "Return to cart"

**Email 2 — 4 hours after abandonment**
- Subject: "Others are loving this"
- Preview: "[X] people bought this this week."
- Content: Social proof specific to the abandoned product. 2–3 reviews for that SKU. Optional: "Only X left in stock" if genuinely true.
- Tone: Warm urgency without being pushy.
- CTA: "Grab it before it's gone"

**Email 3 — 24 hours after abandonment**
- Subject: "Here's a little push."
- Preview: "Free shipping, just for you — expires in 24 hours."
- Content: Time-limited offer — free shipping or 10% off. Show cart again. Make the offer specific to this email, time-limited.
- Tone: Direct. This is the last attempt.
- CTA: "Complete my order — [offer] expires soon"

---

## Browse Abandonment

| Spec | Detail |
|------|--------|
| Trigger | Viewed product page 2+ times in 24 hours with no add to cart |
| Goal | Move from browse intent to add-to-cart |
| Duration | 2 days |
| Exit condition | Add to cart or purchase |
| Performance target | Revenue per recipient > $0.30, Open rate > 35% |

### Sequence

**Email 1 — 4 hours after last PDP view**
- Subject: "Still thinking about it?"
- Preview: "We noticed you were looking at [product name]."
- Content: Hero image of viewed product. 3 relevant reviews. Key benefit points.
- CTA: "Take a closer look"

**Email 2 — Day 2 (non-buyers only)**
- Subject: "Other customers also loved..."
- Preview: "Something you might not have considered."
- Content: Cross-sell 2–3 related products. "If you liked [product], you'll love..." approach.
- Goal: Capture alternative interest if the original product wasn't right.

---

## Post-Purchase

**Sets the entire retention trajectory for each buyer.**

| Spec | Detail |
|------|--------|
| Trigger | Order placed (confirmed payment) |
| Goal | Delight, review, repeat purchase |
| Duration | 45–60 days |
| Suppression rule | Suppress ALL promotional emails for 7 days after purchase |
| Performance target | Revenue per recipient > $0.40, review rate > 15% |

### Sequence

**Email 1 — Day 1 (order confirmed)**
- Subject: "Your order is confirmed — here's what to expect"
- Content: Order summary. Realistic shipping timeline. What to do if something goes wrong (returns email). Brand warm message.
- Tone: Warm, personal, reassuring.
- No upsell here — let them enjoy the purchase.

**Email 2 — Day 3 (shipped or processing)**
- Subject: "[Shipping update] + something to read while you wait"
- Content: Shipping update (link to tracking). Brief brand story — why you started, what you care about.
- Goal: Build brand affinity before the product arrives.

**Email 3 — Day 7–14 (post-delivery, timed to expected delivery + 3–5 days)**
- Subject: "How's your [product name]?"
- Content: Check-in. Review request. NPS or star rating.
- Tone: Genuine curiosity. Not transactional.
- CTA: "Leave a review" (link to review platform)

**Email 4 — Day 30**
- Subject: "Complete your routine" — or — "Something to go with your [product]"
- Content: Cross-sell complementary product. "Customers who bought [X] also love [Y]."
- Goal: Drive second purchase.
- Data-personalize where possible: use purchased SKU to drive specific cross-sell.

**Email 5 — Day 45–60 (non-repurchasers)**
- Subject: "Time for a refill?" — or — "Running low on [product]?"
- Content: Replenishment reminder (for consumables). Subscription upsell ("Never run out — subscribe and save [X]%").
- If not consumable: "Discover what's new" — highlight new arrivals.

---

## Win-Back

| Spec | Detail |
|------|--------|
| Trigger | No purchase in 90 days (adjust based on product repurchase frequency — consumables: 60d, durables: 120d) |
| Goal | Reactivate lapsed customer |
| Duration | 14 days |
| Post-flow action | No purchase → move to low-frequency or sunset segment |
| Performance target | Revenue per recipient > $0.15, Reactivation rate > 8% |

### Sequence

**Email 1 — Day 90 (trigger day)**
- Subject: "A lot has happened since you last visited"
- Preview: "Here's what's new at [Brand]."
- Content: What's new — new products, restocks, improvements. No hard sell. Brand update, not a pitch.
- Tone: Warm, non-pushy. Acknowledge the time gap without guilt.
- CTA: "See what's new"

**Email 2 — Day 97**
- Subject: "Here's a reason to come back"
- Preview: "[X]% off — just for you."
- Content: Personalized offer — 15% off or free shipping. Show products aligned with past purchase history.
- Tone: Direct. This is the real attempt.
- CTA: "Claim my offer"

**Email 3 — Day 104**
- Subject: "Your offer expires tomorrow"
- Preview: "Last chance — then we're moving on."
- Content: Urgency. Final reminder. Single CTA. Brief.
- Tone: Clear and honest — not fear, just deadline.
- After this: no more win-back. Move to low-frequency or suppression.

---

## VIP / Loyalty Welcome

| Spec | Detail |
|------|--------|
| Trigger | Customer crosses LTV threshold (define in FINANCE.md — typically top 10–20% by spend) |
| Goal | Recognize, delight, drive advocacy |
| Duration | Ongoing — VIP segment maintained |
| Performance target | Open rate > 55%, repeat purchase rate > 60% in 90d |

### Sequence

**Email 1 — Trigger day**
- Subject: "You're officially a [Brand] VIP"
- Content: VIP status announcement. What it means — exclusive benefits (early access, higher discount tier, free gift on next order, dedicated support line).
- Tone: Celebratory, personal, premium.
- CTA: "See your VIP benefits"

**Ongoing VIP treatment**
- Early product access: 24–48 hours before general launch
- Exclusive products or bundles (VIP-only SKUs)
- Personalized recommendations (based on purchase history)
- Birthday offer (if date captured)
- Annual VIP anniversary recognition

---

## Flow conflict matrix

| If contact is in... | Do NOT enroll in... | Notes |
|--------------------|---------------------|-------|
| Welcome Series | Any promotional campaign | Wait until series completes or purchase |
| Post-Purchase (days 1–7) | Any promotional campaign | 7-day suppression window |
| Abandoned Cart | Win-Back | Cart flow takes priority |
| Win-Back | Promotional campaigns | Don't overlap — confusing signals |

**Maximum simultaneous flows per contact:** 2 (e.g. Post-Purchase + VIP is fine; Welcome + Abandoned Cart + Win-Back is not)

---

## SMS flow notes

### Abandoned Cart SMS
- Send 1 SMS at 1-hour mark (if email was sent at 20 min)
- Short copy: "[First name], your [Brand] cart is waiting. [link] — text STOP to unsubscribe"
- Do not send SMS if they've already converted via email

### BFCM SMS
- Launch announcement: Day of at 9am recipient time zone
- Last-chance: Cyber Monday at 4pm
- Never more than 2 SMS in the BFCM window

### Win-Back SMS
- Optional addition to win-back email flow
- Send at Day 97 (same timing as Email 2)
- Single message with offer
