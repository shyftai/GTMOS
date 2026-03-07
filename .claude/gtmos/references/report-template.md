# Report Template — GTMOS

Visual template for client-facing campaign reports. Used by `/gtm:report`.

---

## Report types

- **Weekly pulse** — quick status update, key metrics, any flags
- **Monthly review** — full performance analysis, trends, recommendations
- **Campaign final** — end-of-campaign debrief with ROI and learnings

---

## Weekly Pulse Template

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  WEEKLY PULSE — {Workspace} / {Campaign}                       ┃
┃  Week of {date}                                                ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  Status: ON TRACK / NEEDS ATTENTION / PAUSED

  ┌─ Key Metrics ────────────────────────────────────────────────┐
  │                                                              │
  │  Sent          {n}        Open rate       {n}%               │
  │  Replied       {n}        Reply rate      {n}%               │
  │  Bounced       {n}        Bounce rate     {n}%               │
  │  Meetings      {n}        Meeting rate    {n}%               │
  │                                                              │
  └──────────────────────────────────────────────────────────────┘

  Highlights:
  - {what went well this week}
  - {notable reply or meeting}

  Flags:
  - {anything that needs attention}

  Next week:
  - {planned actions}

  Spend this week: ${amount} | Total: ${total} of ${budget}
```

---

## Monthly Review Template

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  MONTHLY REVIEW — {Workspace}                                  ┃
┃  {Month Year}                                                  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  ┌─ Performance Summary ────────────────────────────────────────┐
  │                                                              │
  │  Campaign          Sent    Replies  Mtgs   Pipeline          │
  │  ─────────────────────────────────────────────────────────   │
  │  {campaign-1}      {n}     {n}      {n}    ${value}          │
  │  {campaign-2}      {n}     {n}      {n}    ${value}          │
  │  ─────────────────────────────────────────────────────────   │
  │  Total             {n}     {n}      {n}    ${value}          │
  │                                                              │
  └──────────────────────────────────────────────────────────────┘

  ┌─ Funnel ─────────────────────────────────────────────────────┐
  │                                                              │
  │  Shipped        {n}   ████████████████████████████████  100%  │
  │  Contacted      {n}   ██████████████████████████████░░   95%  │
  │  Replied        {n}   ████░░░░░░░░░░░░░░░░░░░░░░░░░░    5%  │
  │  Positive       {n}   ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░    2%  │
  │  Meeting        {n}   █░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    1%  │
  │  Won            {n}   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  0.3%  │
  │                                                              │
  └──────────────────────────────────────────────────────────────┘

  ┌─ Channel Performance ────────────────────────────────────────┐
  │                                                              │
  │  Channel     Contacts   Reply rate   Meeting rate            │
  │  Email       {n}        {n}%         {n}%                    │
  │  LinkedIn    {n}        {n}%         {n}%                    │
  │                                                              │
  └──────────────────────────────────────────────────────────────┘

  ┌─ A/B Test Results ───────────────────────────────────────────┐
  │                                                              │
  │  Test: {description}                                         │
  │  Winner: Variant {A/B} — {metric} was {x}% higher           │
  │  Applied: {yes/no}                                           │
  │                                                              │
  └──────────────────────────────────────────────────────────────┘

  ┌─ Spend ──────────────────────────────────────────────────────┐
  │                                                              │
  │  Monthly budget:   ${budget}                                 │
  │  Spent:            ${spent}     ████████░░░░  {pct}%         │
  │  Cost per meeting: ${cpm}                                    │
  │  Cost per reply:   ${cpr}                                    │
  │                                                              │
  └──────────────────────────────────────────────────────────────┘

  Recommendations:
  1. {data-backed recommendation}
  2. {data-backed recommendation}
  3. {data-backed recommendation}

  Plan for next month:
  - {planned campaigns or changes}
```

---

## Campaign Final Template

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  CAMPAIGN FINAL — {Campaign Name}                              ┃
┃  {Start date} — {End date}                                     ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  ┌─ Results ────────────────────────────────────────────────────┐
  │                                                              │
  │  Contacts shipped:     {n}                                   │
  │  Emails sent:          {n}                                   │
  │  Total replies:        {n}      ({pct}% reply rate)          │
  │  Positive replies:     {n}      ({pct}% positive rate)       │
  │  Meetings booked:      {n}      ({pct}% meeting rate)        │
  │  Deals won:            {n}      Revenue: ${amount}           │
  │                                                              │
  │  Total spend:          ${amount}                             │
  │  Cost per meeting:     ${amount}                             │
  │  ROI:                  {x}x                                  │
  │                                                              │
  └──────────────────────────────────────────────────────────────┘

  ┌─ What Worked ────────────────────────────────────────────────┐
  │                                                              │
  │  Best subject line:    "{subject}" — {open rate}%            │
  │  Best opening line:    "{line}" — {reply rate}%              │
  │  Best touch:           Touch {n} — {n} replies               │
  │  Best persona:         {title} — {n}% reply rate             │
  │  Best signal:          {signal type} — {n}x avg reply rate   │
  │                                                              │
  └──────────────────────────────────────────────────────────────┘

  ┌─ What Didn't Work ──────────────────────────────────────────┐
  │                                                              │
  │  Lowest performing:    {detail}                              │
  │  Unexpected:           {detail}                              │
  │  Drop-off point:       {where in the funnel and why}         │
  │                                                              │
  └──────────────────────────────────────────────────────────────┘

  ┌─ Learnings ──────────────────────────────────────────────────┐
  │                                                              │
  │  1. {learning with data}                                     │
  │  2. {learning with data}                                     │
  │  3. {learning with data}                                     │
  │                                                              │
  │  Forward-feed:                                               │
  │  - ICP.md: {suggested update}                                │
  │  - PERSONA.md: {suggested update}                            │
  │  - TOV.md: {suggested update}                                │
  │  - snippet-library: {add winning copy}                       │
  │                                                              │
  └──────────────────────────────────────────────────────────────┘

  ┌─ Recommendations ───────────────────────────────────────────┐
  │                                                              │
  │  Next campaign: {suggested angle, ICP shift, or new segment} │
  │  Re-engagement: {n} non-responders eligible in 60 days       │
  │  Pipeline: {n} deals still in progress, follow-up needed     │
  │                                                              │
  └──────────────────────────────────────────────────────────────┘
```

---

## Notes

- All reports use the GTMOS box style from ui-brand.md
- Render in orange for headers, white for data
- Include benchmark comparisons from BENCHMARKS.md where relevant
- Highlight metrics that are above or below benchmarks with [GREEN] or [RED]
- Reports can be exported as markdown files to `performance/reports/`
