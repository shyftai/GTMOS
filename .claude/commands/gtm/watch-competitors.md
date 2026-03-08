---
name: gtm:watch-competitors
description: Monitor competitor changes — pricing, messaging, hiring, news
argument-hint: "<workspace-name> [--scan | --setup | --report]"
---
<objective>
Actively monitor competitors for changes that create outreach opportunities. Track pricing changes, messaging shifts, hiring patterns, and news. Surface actionable signals.

Workspace and mode: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // COMPETITOR WATCH >>`
2. Load COMPETITORS.md for tracked competitors

## --setup (first time)
3. For each competitor, configure what to monitor:
```
  ┌─ COMPETITOR WATCH SETUP ────────────────────────┐
  │                                                   │
  │  Competitor: {name}                               │
  │  Website: {domain}                                │
  │                                                   │
  │  Monitor:                                         │
  │  [x] Pricing page — detect price changes          │
  │  [x] Homepage messaging — detect positioning shifts│
  │  [x] Job posts — hiring = investment signals      │
  │  [x] News/funding — Exa semantic search           │
  │  [ ] Product changelog — feature launches         │
  │  [ ] Review sites — G2, Capterra sentiment        │
  │                                                   │
  │  URLs to track:                                   │
  │    Pricing: {url}                                 │
  │    Homepage: {url}                                │
  │    Careers: {url}                                 │
  │    Changelog: {url}                               │
  │                                                   │
  └───────────────────────────────────────────────────┘
```
4. Save watch configuration to COMPETITORS.md `## Watch config` section

## --scan (run monitoring)
5. For each tracked competitor:

**Pricing scan (Firecrawl):**
- Scrape pricing page, extract plan names, prices, feature lists
- Compare against last saved snapshot in COMPETITORS.md
- Flag: price increases, plan changes, new tiers, removed features

**Messaging scan (Firecrawl):**
- Scrape homepage, extract headline, subheadline, key value props
- Compare against last saved snapshot
- Flag: positioning shifts, new messaging angles, changed CTAs

**Hiring scan (Exa + Sentrion/Fantastic.jobs):**
- Search for open roles at competitor
- Flag: new sales/marketing hires (scaling GTM), new product roles (building features), leadership changes
- Hiring patterns = investment signals

**News scan (Exa):**
- Semantic search: "{competitor name} funding OR acquisition OR partnership OR launch"
- Filter to last 30 days
- Flag: funding rounds, partnerships, product launches, executive moves

6. Display findings:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  COMPETITOR WATCH — {date}                                   ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  {Competitor 1}
    !! Price increase: Pro plan $49 → $79/mo (+61%)
       Opportunity: displacement campaign targeting their users
    >> New job post: "Head of Sales" — scaling GTM team
    .. Messaging unchanged since last scan

  {Competitor 2}
    !! New feature launched: "{feature name}"
       Check: does this affect our positioning?
    >> 3 new sales roles posted — aggressive growth phase
    .. Pricing unchanged

  {Competitor 3}
    .. No changes detected
```

7. For each actionable finding, suggest a campaign:
```
  ┌─ OPPORTUNITY ──────────────────────────────────┐
  │                                                  │
  │  {Competitor} raised prices by 61%               │
  │                                                  │
  │  Suggested action:                               │
  │  → Create competitor displacement campaign       │
  │  → Target: {competitor} users (find via          │
  │    technographic data or LinkedIn search)         │
  │  → Angle: "Looking for alternatives after        │
  │    {competitor}'s price change?"                  │
  │                                                  │
  │  >> Create campaign? /gtm:new-campaign {ws}      │
  │     competitor-displacement-{competitor}          │
  │                                                  │
  └──────────────────────────────────────────────────┘
```

8. Update COMPETITORS.md with:
   - Latest snapshots (pricing, messaging, job counts)
   - Scan date
   - Flagged changes
9. Add to-dos to ROADMAP.md for actionable findings
10. Add to LEARNINGS.md if patterns emerge (e.g. "competitor raises prices every Q1")

## --report
11. Generate a competitor intelligence summary from all historical scans
</process>
</content>
