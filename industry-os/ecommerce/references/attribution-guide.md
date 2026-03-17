# Attribution Guide

Attribution models, setup recommendations, and how to use data across channels without being misled.

---

## Why attribution is hard for ecommerce

A customer sees a TikTok ad on Tuesday, Googles the brand on Thursday, clicks an email on Saturday, and buys on Sunday after a retargeting ad. How much credit does each channel get?

Every platform answers this differently — and each platform's answer gives that platform more credit.

**The result:** If you trust individual platform ROAS, you will:
- Over-invest in email (last-click overstates)
- Over-invest in Google Brand (last-click overstates)
- Under-invest in Meta and TikTok (view-through and assist credits ignored)
- Cut top-of-funnel channels that are actually driving most new customer acquisition

---

## Attribution models explained

### Last click
**How it works:** 100% credit to the last channel clicked before purchase.
**Overstates:** Email, Google Brand, Google Shopping (bottom-funnel channels).
**Understates:** Meta, TikTok, YouTube, display (top-of-funnel channels).
**When to use it:** Calculating email campaign revenue (within email platform only).

### First click
**How it works:** 100% credit to the first channel touched.
**Overstates:** Organic social, display, broad awareness channels.
**Understates:** Email, retargeting (bottom-funnel closers).
**When to use it:** Understanding what channels are introducing new customers.

### Linear
**How it works:** Equal credit across all touchpoints.
**Overstates:** Nothing dramatically — but dilutes high-value touchpoints.
**When to use it:** As a cross-check, not primary attribution.

### Time decay
**How it works:** More credit to channels touched closer to purchase.
**Good for:** Products with short purchase cycles (< 7 days consideration window).
**Less good for:** High-consideration purchases where early touchpoints are critical.

### Data-driven (Google / Meta)
**How it works:** Machine learning allocates credit based on which touchpoints actually incremented conversions.
**Advantage:** More accurate within a single platform.
**Limitation:** Still platform-biased — Google's DDA won't credit Meta, and vice versa.
**Recommended:** Use within-platform for optimization decisions.

### MTA — Multi-Touch Attribution (Triple Whale / Northbeam / Rockerbox)
**How it works:** Third-party pixel tracks all touchpoints across channels and applies a unified attribution model.
**Advantage:** Cross-channel view that isn't biased toward any single platform.
**Limitation:** Requires pixel installation, has cross-device gaps, iOS 14.5+ tracking limitations.
**Recommended:** Best for brands spending > $20K/month across multiple channels.

---

## Recommended attribution setup

### Tier 1 — Under $10K/month ad spend
**Primary:** Google Analytics 4 with data-driven attribution.
**Channel ROAS:** Check each platform's own dashboard — use directionally, not literally.
**North star:** MER (total revenue / total ad spend). Ignores attribution entirely. Always directionally accurate.

Setup:
1. Enable GA4 with data-driven attribution
2. Import GA4 conversions into Google Ads
3. Set up UTM parameters on all paid campaigns and emails
4. Track blended MER weekly in METRICS.md

### Tier 2 — $10K–$50K/month ad spend
**Primary:** GA4 + Triple Whale or Northbeam pixel
**Use platform dashboards:** For within-platform optimization only
**North star:** MER + Triple Whale's blended attribution view

Setup (Triple Whale / Northbeam):
1. Install Triple Whale pixel on storefront
2. Connect all ad accounts (Meta, Google, TikTok)
3. Connect Klaviyo (email/SMS)
4. Set attribution window: 1-day click, 7-day click, 1-day view (match Meta's default)
5. Review blended dashboard weekly

### Tier 3 — $50K+/month ad spend
**Primary:** Northbeam or Rockerbox (more sophisticated MTA)
**Secondary:** GA4 for site behavior
**North star:** Platform MER + Northbeam's new customer CAC

---

## MER as the sanity check

Marketing Efficiency Ratio = Total revenue / Total marketing spend.

This is the most reliable metric because:
- It ignores attribution entirely
- It can't be gamed by any single platform
- It moves directly with business health

**How to track:**
- Pull total revenue from Shopify (or your storefront)
- Pull total ad spend from each platform (Meta + Google + TikTok + influencer payouts)
- Calculate: MER = Total revenue / Total spend
- Update METRICS.md weekly

**MER targets by stage:**

| Stage | MER target | Notes |
|-------|-----------|-------|
| Early stage (< $1M/yr) | 2.5–4x | Customer acquisition phase — MER may be lower by design |
| Growth stage ($1–$5M/yr) | 3–5x | Flows and retention improving email contribution |
| Scale stage ($5M+/yr) | 4–7x | Email and organic contribute more, blended improves |

---

## UTM convention for ECOMMERCE:OS

**Required on every paid link and email link.** Hard gate — never launch without UTMs.

### Standard structure
`utm_source={channel}&utm_medium={type}&utm_campaign={campaign_name}&utm_content={creative_id}`

### By channel

| Channel | Source | Medium | Campaign | Content |
|---------|--------|--------|----------|---------|
| Meta Ads | meta | paid | campaign_name | creative_id or ad_set |
| Google Ads | google | cpc | campaign_name | ad_group |
| TikTok Ads | tiktok | paid | campaign_name | creative_id |
| Email campaigns | klaviyo | email | campaign_name | email_type |
| Email flows | klaviyo | email-flow | flow_name | email_number |
| SMS | sms | sms | campaign_name | — |
| Organic social | instagram / tiktok / pinterest | social | — | post_description |
| Influencer | influencer | social | influencer_name | — |

### How to verify UTMs
1. Click every link in the campaign before going live
2. Check GA4 real-time: Traffic sources → Campaigns
3. Confirm UTM parameters appear in GA4 within 30 seconds of click
4. If UTM missing: do not launch. Fix first.

---

## Attribution windows

### Recommended attribution windows by channel

| Channel | Click window | View window | Notes |
|---------|-------------|-------------|-------|
| Meta Ads | 7-day click | 1-day view | Meta default — use this |
| Google Ads | 30-day click | None | GA4 data-driven |
| Email | 5-day click | None | Most ESPs default to 5 days |
| SMS | 1-day click | None | High intent, short cycle |

### Overlapping attribution note
When email and paid ad both get credit for the same order, the total attributed revenue exceeds actual revenue. This is normal — it means multiple channels contributed. Resolve by using MER as the macro check.

---

## iOS 14.5+ impact and response

Apple's App Tracking Transparency (ATT) reduced Meta's ability to track cross-app conversions. Effect: Meta underreports conversions by 20–40% for most brands.

**How to compensate:**
1. Use Meta's Conversions API (CAPI) — server-side event passing bypasses browser tracking limits
2. Set up CAPI in Shopify + Meta integration (built-in for Shopify stores)
3. Compare Meta's reported revenue vs. GA4's Meta attribution — the gap is your ATT loss estimate
4. Set Meta ROAS targets 20–30% lower than your actual efficiency target to compensate for underreporting
