# Ecommerce Channel Reference

Channel strategy, best practices, and benchmarks for every major ecommerce marketing channel.

---

## Meta Ads (Facebook / Instagram)

**Best for:** DTC brands, visual products, impulse purchases, lifestyle categories, LTV-driven brands.
**Not ideal for:** Pure B2B, highly regulated categories (financial products, some health claims), very low AOV (< $20) without strong repurchase.

### Account structure
- Campaign level: objective (Sales / Traffic / Awareness)
- Ad set level: audience, placement, budget
- Ad level: creative, copy, destination URL

### Audience strategy

**Cold prospecting (50% of budget)**
- LAL 1–2% from customer purchase list (180d) — highest quality
- LAL 2–3% from site visitors (90d) — good volume
- Broad interest targeting with creative differentiation
- Advantage+ audience (Meta's broad targeting) — test for scaling

**Warm audiences (30% of budget)**
- Site visitors 30d, 60d, 90d (exclude buyers)
- Engaged on Instagram/Facebook (30d)
- Video viewers (50%+ completion, 30d)

**Retargeting (20% of budget)**
- Dynamic product ads (DPA) — cart abandoners 14d
- PDP viewers 7d (non-buyers)
- Cart abandoners 30d (non-buyers)
- Cross-sell: buyers in last 30d, exclude their purchased SKU

### ROAS targets

| Audience type | Minimum viable | Target | Scale signal |
|---------------|----------------|--------|-------------|
| Cold (LAL / Interest) | 1.5x | 2.5–3.5x | > 4x |
| Warm (site visitors) | 3x | 4–6x | > 6x |
| Retargeting (cart) | 5x | 6–10x | > 10x |

### Creative best practices
- UGC-style (raw, authentic) wins for cold audiences — studio content under-indexes
- First 2 seconds must hook — assume sound off on mobile
- Show the product in use — lifestyle context outperforms product-only
- Refresh creative every 2–4 weeks or when frequency > 2.5 and ROAS drops
- Test 3–5 creative variants per ad set before scaling the winner

### Scaling signals
- ROAS > target for 7 consecutive days
- Frequency < 2.0
- CPMs stable or declining
- Action: increase budget 20% per week (do not double budgets)

### Pausing signals
- ROAS < cut threshold for 3+ days at statistically significant spend (> $100/day)
- Frequency > 3.5 on cold audiences
- CTR < 0.8% on cold prospecting

### UTM structure
`utm_source=meta&utm_medium=paid&utm_campaign={campaign_name}&utm_content={creative_id}`

---

## Google Ads

**Best for:** High-intent search, shopping campaigns, existing demand categories, brand protection.
**Not ideal for:** Creating demand for unknown products (use Meta/TikTok first), very low search volume categories.

### Campaign types

**Shopping (run always — highest volume, cleanest attribution)**
- Standard shopping or Performance Max
- Separate campaigns: brand terms vs. non-brand
- Negative keywords: run weekly search term report, add negatives aggressively

**Brand campaigns**
- Protect your brand terms — competitors bid on them
- Typically highest ROAS (8–20x), low volume
- Bid on brand + product variations + common misspellings

**Non-brand search**
- Higher CPC, lower ROAS — requires strong keyword intent
- Focus on bottom-funnel: "[product] buy", "[category] near me", "[problem] solution"
- Avoid broad match until algorithm has 30+ conversions

**Performance Max (PMAX)**
- Replaces Smart Shopping — runs across all Google inventory
- Requires high-quality creative assets (images + video)
- Effective for scaling, but less transparent than standard campaigns

### Attribution in Google
- Set conversion tracking in Google Ads, import from GA4
- Use data-driven attribution (not last click)
- Compare Google reported ROAS vs. MER — Google always over-reports

### UTM structure
`utm_source=google&utm_medium=cpc&utm_campaign={campaign}&utm_content={ad_group}`

---

## TikTok Ads

**Best for:** 18–35 demographic, viral/visual products, UGC-native brands, fashion, beauty, food, fitness.
**Not ideal for:** 45+ target demographic, B2B, low-visual products.

### What works
- Native-style content — looks like organic TikTok, not an ad
- "It's just content with a CTA" — testimonial, tutorial, transformation
- Creator partnerships: repurpose influencer content as Spark Ads (promote their posts)
- Trending sounds matched to product reveal

### Account structure
- Start with Spark Ads (whitelist influencer content) before creating brand content
- Test budget: $50–100/day minimum for meaningful data
- Creative fatigue happens faster than Meta — refresh weekly

### ROAS targets (typically lower than Meta due to top-of-funnel intent)
- Minimum viable: 1.2x (acquisition-focused, optimize for LTV)
- Target: 1.5–2.5x
- Scale: > 3x

### UTM structure
`utm_source=tiktok&utm_medium=paid&utm_campaign={campaign_name}&utm_content={creative_id}`

---

## Email Marketing (Klaviyo / Omnisend / Mailchimp)

**Best for:** Retention, LTV maximization, launch amplification, promotional events, lifecycle automation.
**Key insight:** For mature brands, flows drive 60–70% of email revenue with no ongoing effort.

### Flows vs. campaigns
- **Flows (automated):** Set up once, optimize continuously. Welcome, abandoned cart, post-purchase, win-back.
- **Campaigns (one-time):** Promotions, launches, newsletters. Require ongoing creation.
- Priority: build and optimize flows before scaling campaigns.

### Segmentation for deliverability
- Never send to full list without filtering by engagement
- Engaged = opened in last 90 days (use 60 days for high-volume senders)
- Unengaged recipients drag down deliverability for everyone
- Warm up new senders: start with most engaged, expand gradually

### Sending frequency
- Outside of BFCM: 2–3 campaigns per week maximum
- During BFCM (5-7 day window): up to 2/day
- After BFCM: 2-week pause before resuming standard cadence

### Re-engagement before suppression
1. 3-email win-back sequence for subscribers who haven't opened in 90d
2. Final email: "Should we keep sending?" (explicit choice)
3. No response → suppress from future sends (move to sunset segment)
4. Suppress non-openers after 180 days from list

### Revenue benchmarks

| Metric | Below average | Average | Good | Excellent |
|--------|--------------|---------|------|-----------|
| Revenue per email | < $0.05 | $0.08–0.12 | $0.12–0.20 | > $0.20 |
| Open rate | < 25% | 30–40% | 40–50% | > 50% |
| CTR | < 1% | 1–2.5% | 2.5–4% | > 4% |

---

## SMS Marketing (Klaviyo / Postscript / Attentive)

**Best for:** Flash sales, exclusive drops, order updates, loyalty member benefits, BFCM.
**Critical requirement:** Explicit opt-in required (TCPA compliance in US, CASL in Canada).

### What SMS is for
- Flash sales with 6–24 hour windows (urgency-dependent)
- Early access drops for subscribers
- Cart abandonment (supplement email, not replace)
- Order and shipping updates
- Loyalty program benefits

### Frequency limits
- Max 4 campaign SMS per month (higher fatigue than email)
- Order/transactional messages: no limit (customers expect these)
- BFCM exception: up to 2 campaign SMS on Black Friday, 1 on Cyber Monday

### Revenue benchmarks
- Revenue per SMS: $0.50–$2.00 (high intent channel)
- CTR: 15–30% (much higher than email)
- Opt-out rate: < 3% per message (> 5% = content or frequency issue)

### Compliance rules
- Never SMS contacts without explicit opt-in
- Always include "Reply STOP to unsubscribe"
- Honor opt-outs within 24 hours (platform should auto-handle)
- Do not SMS quiet hours (10pm–8am recipient time zone)

---

## SEO / Organic Search

**Priority order for DTC brands:**
1. Product pages — highest commercial intent
2. Collection/category pages — broad intent, high traffic potential
3. Blog/content — informational to commercial funnel

### Product page SEO
- Title tag: [Primary keyword] | [Brand name] — 55–60 characters
- H1: matches search intent (not necessarily the product name)
- Meta description: benefit-led, 150–155 characters, includes CTA
- ALT text on all images: descriptive, includes keyword naturally
- Schema markup: Product schema with price, availability, rating

### Technical SEO for ecommerce
- Site speed: LCP < 2.5s (mobile first)
- Core Web Vitals: all green in Google Search Console
- Faceted navigation: canonical or noindex to avoid duplicate content
- Pagination: proper rel=next/prev or load more pattern
- Hreflang for international stores

### Content for ecommerce
- Prioritize commercial intent: "best [product] for [use case]", "[product] vs [competitor]"
- Avoid pure informational content unless it feeds a strong commercial page
- Internal linking: collection pages and product pages should interlink naturally

---

## Influencer / UGC

### Gifting (low-cost, high-ROI for UGC)
- Ship product, no payment guarantee
- Ask for honest review and tagging permissions
- Use output as organic social content + paid ad creative
- Best for: micro-influencers (10K–100K followers) in your niche

### Paid partnerships
- Guaranteed deliverables, specific brief
- Negotiate usage rights upfront — especially for paid ad whitelisting
- Spark Ads (TikTok) and Whitelisted Posts (Meta) amplify creator content

### Affiliate program
- Set commission to preserve margin: if AOV $80 and margin 50%, max commission ≈ 15–20%
- Use Impact, ShareASale, or Refersion for tracking
- Prioritize content creators and comparison sites over coupon sites
- Coupon sites cannibalize organic conversions — exclude or set lower commission

### Usage rights
- Always get rights to repurpose content as paid ads
- Specify in writing: platform, duration, paid amplification
- Time-limited rights (12 months) are standard; perpetual costs more
