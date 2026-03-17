---
name: ecom:signals
description: Scan for market trends, competitor moves, and growth opportunities
argument-hint: "<workspace-name>"
---

<objective>
Scan for signals across competitor pricing, product launches, ad creative changes, and market trends. Surface the most actionable signals with clear recommended responses. Cache results to avoid redundant scans.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./references/ecom-channels.md
@./references/ecom-calendar.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // SIGNALS >>
{workspace name} — {date}
```

2. Load COMPETITORS.md, CALENDAR.md, CHANNELS.md, PRODUCTS.md, SCRAPE-JOURNAL.md.

3. Check SCRAPE-JOURNAL.md — skip any scan that was completed < 7 days ago. If recent results exist, show cached data with "Cached {X} days ago" label.

4. Identify scans to run based on available tools and COMPETITORS.md:

   **Competitor pricing check:**
   - Check listed competitor URLs for pricing changes on comparable SKUs
   - Flag any price drop > 10% vs. last check
   - Flag any new product in their catalog

   **Meta Ad Library check:**
   - Review active ads for each competitor in COMPETITORS.md
   - Note: new creative angles, promotional offers, new products being advertised
   - Flag if a competitor has launched a new ad campaign in the last 7 days

   **Seasonal signal check:**
   - Review CALENDAR.md — what events are coming in the next 30 days?
   - Flag any high-demand event within 14 days with no campaign in CALENDAR.md
   - Identify any Prime Day halo effects, seasonal peaks, or demand shifts

   **Trend signals (if tools available):**
   - Search volume trends for category keywords
   - TikTok trending sounds or product hashtags relevant to category
   - Rising search terms in Google Search Console

5. Display signal report:

```
┌─ SIGNALS ─── {date} ──────────────────────────────────────────┐
│                                                               │
│  RED — Act now (respond within 7 days):                       │
│  {signal — e.g. "Competitor X dropped price on hero SKU 15%"} │
│  Suggested action: {specific response}                        │
│  Command: {/ecom:... to act}                                  │
│                                                               │
│  YELLOW — Monitor (respond within 30 days):                   │
│  {signal — e.g. "Competitor launched new SKU in your category"}│
│  Suggested action: {specific response}                        │
│                                                               │
│  GREEN — Watch (no immediate action):                         │
│  {signal — e.g. "Trend: search for [term] up 40% this month"} │
│  Keep an eye on for future campaign angle                     │
│                                                               │
│  Calendar signals:                                            │
│  {event} in {X} days — {prepared / not yet planned}          │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

6. For each RED signal: ask "Do you want to draft a response campaign now?"
   - If yes: route to `/ecom:campaign {workspace}` with the signal context pre-loaded

7. Log scan results to SCRAPE-JOURNAL.md with date, source, and findings.

8. Update COMPETITORS.md with any pricing or product changes found.

9. Suggest follow-up:
- Competitive pricing drop → `/ecom:promo {workspace}` to counter
- Upcoming calendar event → `/ecom:campaign {workspace}` to plan response
- New competitor product → note in COMPETITORS.md for monitoring

</process>
