# CRO Playbook

Conversion rate optimization tactics for product pages, checkout, and offers. Prioritized by impact.

---

## Impact hierarchy

1. Traffic quality — bad traffic cannot be optimized into buyers
2. Product-market fit — if the product is wrong, CRO cannot fix it
3. Offer and pricing — the most impactful single lever once fit is confirmed
4. Product page fundamentals — images, proof, clarity
5. Checkout friction — the final step losers
6. Advanced optimization — micro-improvements after fundamentals are solid

---

## Product page essentials

### Above the fold (what buyers see before scrolling)
Every product page must have all of these above the fold on desktop and mobile:
- [ ] Product name (clear, not just SKU code)
- [ ] Price — prominent, not hidden
- [ ] Primary image — high resolution, shows the product clearly
- [ ] Star rating + review count — click-through to reviews section
- [ ] Add to cart / Buy now button — large, high-contrast color
- [ ] 1 key proof point — review count, bestseller badge, or award
- [ ] Trust signal — "Free returns" or "Free shipping over $X"

### Images — minimum requirements
- 5–8 images per product (more for apparel/shoes)
- Hero: clean product on white or brand background
- Lifestyle: product in use, with aspirational context
- Detail: close-up of key features, texture, materials
- Scale/size reference: product next to a person or common object
- UGC: real customer photo (builds authenticity)
- Video (optional but high impact): 30–60s demonstration or tutorial

**Common mistakes:**
- Only 1–2 images — customers assume the product looks worse than shown
- No lifestyle image — customers can't visualize using it
- Dark or blurry images — immediately lowers perceived quality

### Social proof placement
- Review widget with star rating ABOVE the fold (not at the bottom of the page)
- Show review count: "4.8 stars (2,341 reviews)" beats "4.8 stars"
- Surface 2–3 highlighted reviews near the buy button
- UGC carousel — real customer content converts better than brand content for most categories

### Description structure — benefits before features
1. Lead with transformation: "Wake up with clearer skin in 14 days" not "Contains 2% niacinamide"
2. 3–5 benefit bullets
3. Features/ingredients/specs below
4. FAQ section to handle common objections before they arise

### Trust signals on product page
- "Free X-day returns" — explicit, not in fine print
- "Ships in 1–2 business days" — specific, not "fast shipping"
- Secure checkout badge
- Payment method icons (Visa, MC, Amex, PayPal, Shop Pay)
- "X people viewing this" — only if the real-time data is accurate

### Urgency (honest only)
- "Only 8 left in stock" — only show if there are genuinely < 20 units
- "X people bought this today" — only show if the data is live and accurate
- Manufactured scarcity = trust damage when customers test it

---

## Checkout optimization

### The non-negotiables
- **Guest checkout required** — never force account creation before purchase. Account creation after is fine.
- **Progress indicator** — "Step 1 of 3" reduces abandonment
- **Remove header navigation** — no exit links in checkout
- **Express checkout at the top** — Shop Pay, Apple Pay, Google Pay prominently above the form
- **Auto-fill** — ensure checkout supports browser autofill (test on mobile)

### Free shipping threshold
Show in cart and checkout: "Add $X more for free shipping"
- Drives meaningful AOV lift (typically 8–15%)
- Set threshold 15–20% above current AOV
- Update threshold as AOV grows

### Trust signals in checkout
- SSL lock icon + "Secure checkout" badge
- Accepted payment methods icons
- "30-day returns" reminder near the buy button (reduces purchase anxiety)
- Phone number or chat widget for last-minute questions

### Cart page
- Cart should show product images, not just names
- Quantity adjuster (not just "remove")
- Upsell module: "You might also like" or "Frequently bought together" — product recommendation, not random
- Free shipping threshold progress bar

### Post-purchase upsell
- One-click post-purchase upsell on Shopify (via app) — offer 1 product, 1 offer, clear value
- "People who bought [product] also added [product B] — add to order for [price]?"
- Conversion rate: 5–15% of orders — meaningfully increases AOV with no friction cost

---

## Offer optimization

### Free shipping vs. percentage discount
**Free shipping generally outperforms percentage discounts for AOV preservation.**
- "Free shipping" is perceived as a gift, not a price reduction
- 10% off $80 product = $8 discount
- Free shipping on $80 order = $6–10 cost — similar cost, better perceived value
- Exception: high AOV products ($200+) where shipping is already expected free

### Bundle pricing
- "Buy 2, save 15%" — drives AOV without discounting single units
- "Starter kit" or "complete set" bundles — anchor at high value, discount percentage looks good
- Bundle page vs. product page: some brands do better routing to a dedicated bundle page

### Gift with purchase (GWP)
- Threshold GWP: "Spend $75, receive [product] free"
- Drives AOV toward threshold — typically 10–20% AOV lift
- Cost < equivalent percentage discount
- Feels premium — enhances brand perception

### Tiered discount
- "Spend $60, get 10% off" / "Spend $100, get 15% off" / "Spend $150, get 20% off"
- Drives step-change AOV behavior
- Anchors to the brand's discount ceiling — don't use if brand avoids discounting

### Pricing presentation
- $49.99 vs $50.00: .99 pricing signals lower-end positioning — premium brands should avoid
- "Was $80, now $60" — sale price with strikethrough is highly effective in promotional context
- Subscription price alongside one-time: "Subscribe & save: $40/mo (vs. $50 one-time)" — anchors subscription

---

## A/B testing priorities

Run in this order — each test must reach statistical significance (95% confidence, typically 100–200 orders per variant).

| Priority | Test | Expected lift | Effort |
|----------|------|--------------|--------|
| 1 | CTA copy ("Add to Cart" vs "Get Yours" vs "Shop Now") | 5–15% | Low |
| 2 | Primary image selection (UGC vs studio vs lifestyle) | 10–25% | Low |
| 3 | Free shipping threshold level ($X vs $Y vs always free) | 8–20% | Low |
| 4 | Review placement (above vs below the fold) | 5–12% | Low |
| 5 | Pricing presentation ($49.99 vs $50 vs $49) | 2–8% | Low |
| 6 | Exit intent pop-up offer (% off vs free shipping vs no offer) | 10–20% on exit traffic | Low |
| 7 | Product page layout (sidebar vs. stacked) | 5–15% | Medium |
| 8 | Video on PDP | 8–20% | High |
| 9 | Post-purchase upsell (different products) | 3–8% on AOV | Low |

### A/B test rules
- Test one variable at a time
- Run until 95% statistical significance
- Do not call tests early (even if one variant looks like a winner)
- Log result in LEARNINGS.md regardless of outcome — failures are as valuable as wins
- Never run A/B tests during BFCM or major promotions (traffic quality is atypical)

---

## Site speed — critical for mobile

Over 60% of DTC traffic is mobile. Mobile CVR is 30–40% lower than desktop. Most of that gap is speed.

| Metric | Poor | Needs work | Good | Excellent |
|--------|------|-----------|------|-----------|
| LCP (Largest Contentful Paint) | > 4s | 2.5–4s | < 2.5s | < 1.5s |
| CLS (Cumulative Layout Shift) | > 0.25 | 0.1–0.25 | < 0.1 | < 0.05 |
| INP (Interaction to Next Paint) | > 500ms | 200–500ms | < 200ms | < 100ms |

### Common speed culprits on Shopify
- Unoptimized images (use WebP, compress, lazy load)
- Too many apps (every app adds JS overhead)
- Non-critical CSS/JS blocking render
- Third-party chat widgets loaded synchronously

### Quick wins
1. Compress all product images (use Shopify's built-in optimization + Crush.pics app)
2. Audit installed apps — remove unused apps immediately
3. Lazy-load images below the fold
4. Use a performance-focused theme (Dawn, Hydrogen) vs. feature-heavy themes

---

## Mobile-specific CRO

- Sticky add-to-cart bar on mobile (shows when native button scrolls out of view)
- Thumb-friendly CTAs — minimum 44px height
- One-tap checkout options (Shop Pay, Apple Pay) — fastest path to purchase
- Swipeable image gallery (not click arrows)
- Collapsible description sections (reduces scroll overload)
- Phone number field: trigger numeric keyboard on mobile

---

## CRO audit checklist

Run this before every full audit:

### Product page
- [ ] Above-fold has all 6 required elements
- [ ] 5+ product images present
- [ ] Reviews visible above the fold
- [ ] 2–3 highlighted reviews near buy button
- [ ] Trust signals present (returns + shipping)
- [ ] Description leads with benefits
- [ ] FAQ section addresses top 3 objections
- [ ] No broken links or missing images

### Checkout
- [ ] Guest checkout available
- [ ] Express checkout options present
- [ ] No navigation links in checkout
- [ ] Free shipping threshold shown in cart
- [ ] Progress indicator present
- [ ] Returns policy visible in checkout

### Site speed
- [ ] LCP < 2.5s on mobile
- [ ] CLS < 0.1
- [ ] Google PageSpeed mobile score > 60
- [ ] All product images < 200KB
