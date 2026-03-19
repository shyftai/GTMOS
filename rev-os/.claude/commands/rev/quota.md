# /rev:quota

Quota planning, territory design, attainment tracking, and new hire ramp modeling.

## When to use

- Setting quotas for a new quarter or annual plan
- Checking current rep attainment and pace-to-goal
- Designing or rebalancing territories
- Modeling a new hire's ramp schedule
- Building coverage from board target down to individual rep

---

## What to do

Load `TEAM.md`, `PIPELINE.md`, `FORECAST.md`, and `references/rev-defaults.md`. Ask:

```
What do you need?

  [1] Set quotas — plan quotas for a new period
  [2] Check attainment — where is each rep right now?
  [3] Design territories — assign accounts and balance workload
  [4] Model a new hire — ramp schedule and capacity impact
  [5] Build coverage — derive rep quotas from a board target
  [6] Full quota dashboard — everything at once
```

---

## Mode 1: Set quotas for a new period

### Step 1: Period and target

Ask:
```
1. What period are we setting quotas for? (Q[X] [Year] / FY[Year])
2. What is the total new ARR target for this period?
3. Is this set by the board, or are we deriving it? (Board-set / Building bottom-up)
```

### Step 2: Top-down derivation

If board-set, derive the quota pyramid:

```
QUOTA PYRAMID — {Period}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Board / Investor target:      {currency}{X}M

CRO quota (board × 1.0):      {currency}{X}M
  — CRO owns the number; no uplift applied to board target itself

VP Sales quota (CRO × 1.15):  {currency}{X}M   ← 15% buffer above board
  — Covers for expected variance, rep attrition, deals that slip

Team quota total (VP × 1.20): {currency}{X}M   ← 20% buffer above VP
  — Sum of all rep quotas; accounts for ramp reps and territory gaps

Individual rep allocation:     See below
```

**Standard quota pyramid ratios (defaults from rev-defaults.md):**
- VP Sales quota = Board target × 1.15
- Total rep quota = VP quota × 1.20
- New hire ramp = see Mode 4

### Step 3: Rep quota allocation

Distribute team quota across reps. Ask if not already in TEAM.md:
```
For each rep, confirm:
- Name and segment (SMB / Mid-market / Enterprise)
- Territory (if applicable)
- Ramp status (Fully ramped / Month {X} of ramp)
- Prior quarter attainment (if known)
```

Present allocation:

```
REP QUOTA ALLOCATION — {Period}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Rep             Segment       Territory    Quota         Ramp
──────────────────────────────────────────────────────────────
{Name}          Enterprise    {Region}     {currency}{X}K  100%
{Name}          Mid-market    {Region}     {currency}{X}K  100%
{Name}          SMB           {Region}     {currency}{X}K  75% (Month 3)
{Name}          SMB           {Region}     {currency}{X}K  50% (Month 2)
──────────────────────────────────────────────────────────────
Total rep quota:              {currency}{X}M
VP quota:                     {currency}{X}M
Coverage ratio:               {X}× ({X}% buffer)   [🟢 / 🟡 / 🔴]
```

**Coverage ratio thresholds:**
- ≥ 1.20 → 🟢 Healthy buffer
- 1.10–1.19 → 🟡 Thin — any attrition creates risk
- < 1.10 → 🔴 Under-covered — hiring or quota reduction needed

### Step 4: Validation checks

Before finalising:

1. **Attainability check** — compare each rep's quota to their prior-period attainment. Flag if quota increase > 20% YoY without a clear reason (territory expansion, product improvement, more SDR support).

2. **Pipeline coverage check** — does current pipeline support the quota? (Target: 3× at period start). If < 2×, flag immediately.

3. **New hire timing** — if a ramp rep won't reach full quota until Week 8, their effective quota contribution this quarter is lower. Adjust team total accordingly.

```
QUOTA VALIDATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Attainability
  {Name}: quota up {X}% YoY · prior attainment {X}% · [🟢 Reasonable / 🟡 Stretch / 🔴 Flag]
  {Name}: new hire — ramp quota applies · reaching full quota {Month}

Pipeline coverage at period start
  Required (3×):    {currency}{X}M
  Available:        {currency}{X}M   [{X}× — 🟢/🟡/🔴]

Effective quota this period (adjusting for ramp):
  Fully ramped reps: {currency}{X}M
  Ramp reps (adj.):  {currency}{X}M
  Effective total:   {currency}{X}M  vs. VP quota {currency}{X}M
```

Update `TEAM.md` and `QUOTA.md` with the finalised quota plan.

---

## Mode 2: Check attainment

Show where every rep stands right now against their quota.

```
QUOTA ATTAINMENT — {Period} — Week {X} of {total weeks}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Period elapsed: {X}%   Expected attainment at this pace: {X}% of quota

Rep             Quota        Closed      Attainment   Pace     Status
────────────────────────────────────────────────────────────────────
{Name}          {curr}{X}K   {curr}{X}K   {X}%        {X}%    🟢 On track
{Name}          {curr}{X}K   {curr}{X}K   {X}%        {X}%    🟡 Needs push
{Name}          {curr}{X}K   {curr}{X}K   {X}%        {X}%    🔴 At risk
{Name}          {curr}{X}K   {curr}{X}K   {X}%        —       ⚙ Ramping
────────────────────────────────────────────────────────────────────
Team total      {curr}{X}M   {curr}{X}M   {X}%        {X}%    [status]

VP quota:       {curr}{X}M   Attainment: {X}%
Board target:   {curr}{X}M   Gap to target: {curr}{X}K
```

**Pace calculation:** `(closed ÷ quota) ÷ (period elapsed ÷ total period)`. Pace > 1.0 = ahead of schedule.

**Status thresholds:**
- Pace ≥ 1.0 → 🟢 On track
- Pace 0.75–0.99 → 🟡 Needs push — achievable with strong close
- Pace < 0.75 → 🔴 At risk — unlikely to hit without significant pipeline addition
- Ramp rep → ⚙ track against ramp quota, not full quota

### At-risk rep analysis

For any 🔴 rep, show:

```
AT-RISK: {Name}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Quota:      {curr}{X}K
Closed:     {curr}{X}K  ({X}%)
Pipeline:   {curr}{X}K  ({X}× remaining quota)
Commit:     {curr}{X}K

Gap to quota:  {curr}{X}K
Pipeline needed to close gap (at {X}% win rate): {curr}{X}K
Current pipeline vs. needed: {curr}{X}K {short / sufficient}

Recommended actions:
  1. {Action — e.g. "Review all pipeline deals — which are truly closeable this quarter?"}
  2. {Action — e.g. "Identify 3 deals to accelerate with exec engagement or pricing levers"}
  3. {Action — e.g. "Flag to CRO — quota relief or spiff may be needed to preserve pipeline"}
```

---

## Mode 3: Territory design

### Step 1: Scope

Ask:
```
1. What's the basis for territories? (Geographic region / Named accounts / Industry vertical / Company size / Mixed)
2. How many AEs need territories?
3. Do you have overlay roles? (SEs, CSMs, SDRs with their own territory assignments)
4. What's the primary data source for accounts? (CRM account list / TAM analysis / Imported list)
```

### Step 2: Territory balance analysis

Evaluate current territory distribution:

```
TERRITORY ANALYSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Territory       Rep        Accounts   ARR potential   Open deals   Quota
────────────────────────────────────────────────────────────────────────
{Territory 1}   {Name}     {X}        {curr}{X}M       {X} · {curr}{X}K  {curr}{X}K
{Territory 2}   {Name}     {X}        {curr}{X}M       {X} · {curr}{X}K  {curr}{X}K
{Territory 3}   {Name}     {X}        {curr}{X}M       {X} · {curr}{X}K  {curr}{X}K
Unassigned      —          {X}        {curr}{X}M       {X} · {curr}{X}K  —
────────────────────────────────────────────────────────────────────────

Balance score: {X}%  (100% = perfectly even ARR potential per rep)
Imbalance flag: {any territory with ARR potential > 1.5× average — name it}
```

### Step 3: Recommendations

Flag and recommend fixes for:
- **Overloaded territories** — one rep has significantly more addressable ARR than others → carve and redistribute
- **Unassigned accounts** — accounts with no AE owner → assign or create a named account pool
- **Stale assignments** — accounts assigned to a rep who has since left → reassign
- **Overlay gaps** — accounts with an AE but no SDR or SE coverage where needed

Update `TEAM.md` territory assignments based on approved changes.

---

## Mode 4: New hire ramp modeling

### Step 1: Hire details

Ask:
```
1. Name and start date
2. Segment and territory
3. Prior experience — new to SaaS sales / experienced in segment / experienced AE new to company
4. Full quota for this role once ramped
```

### Step 2: Ramp schedule

Generate ramp schedule based on experience level:

```
RAMP SCHEDULE — {Name}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Start date:    {Date}
Full quota:    {currency}{X}K / quarter
Experience:    {level}

Month   Quota multiplier   Effective quota   Expected close
──────────────────────────────────────────────────────────
1       25%                {currency}{X}K    {currency}0 — pipeline building only
2       50%                {currency}{X}K    {currency}{X}K
3       75%                {currency}{X}K    {currency}{X}K
4+      100%               {currency}{X}K    {currency}{X}K

Full productivity expected: {Month} {Year}
```

**Ramp multiplier defaults (override in RULES.md):**

| Experience level | Month 1 | Month 2 | Month 3 | Full quota from |
|-----------------|---------|---------|---------|----------------|
| New to SaaS / SDR → AE | 0% | 25% | 50% | Month 5 |
| Experienced, new to company | 25% | 50% | 75% | Month 4 |
| Senior, same segment | 33% | 67% | 83% | Month 4 |
| Internal promotion | 50% | 75% | 100% | Month 3 |

### Step 3: Capacity impact

Show how this hire affects team quota coverage this period:

```
CAPACITY IMPACT — {Period}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Before hire:  {X} fully ramped AEs · effective quota {currency}{X}M
After hire:   {X} fully ramped + 1 ramping · effective quota {currency}{X}M
Added capacity this period:   {currency}{X}K  (at {X}% ramp)
First full-quota period:      Q{X} {Year}
```

Add the new hire to `TEAM.md` and `QUOTA.md` with ramp schedule.

---

## Mode 5: Build coverage from board target

Work backwards from a board-set target to determine how many reps you need.

Ask:
```
1. Board/investor ARR target for this period: {currency}{X}
2. Average AE quota (fully ramped): {currency}{X}
3. Expected average attainment rate (use prior period or 75% if unknown)
4. How many AEs are currently fully ramped?
5. Any planned hires this period? If yes, start month and experience level?
```

```
COVERAGE ANALYSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Board target:           {currency}{X}M
Required at {X}% att.:  {currency}{X}M in quota  (target ÷ attainment rate)
Required with 1.2× buf: {currency}{X}M in quota

Current ramped capacity: {currency}{X}M  ({X} AEs × {currency}{X}K avg quota)
Planned hire additions:  {currency}{X}K  ({X} hires × ramp-adjusted quota)
Total capacity:          {currency}{X}M

Gap:                     {currency}{X}M  [{🟢 Covered / 🟡 Thin / 🔴 Need X more hires}]

To cover the gap, you need:
  {X} additional fully-ramped AEs — hire by {Date} to ramp in time
  OR increase average quota by {X}% — feasible if [condition]
  OR reduce board target by {X}% — requires board conversation
```

---

## After any quota operation

Update these files:
- `QUOTA.md` — quota plan, attainment, territory assignments
- `TEAM.md` — rep quotas and territory changes
- `FORECAST.md` — quota baseline for current period

Recommended follow-on commands:
- Quotas set → `/rev:forecast` to check pipeline coverage against new quotas
- At-risk reps identified → `/rev:pipeline` to inspect their deals
- Territory changed → `/rev:signals` to check for unassigned account alerts
- New hire added → set a reminder to check ramp progress in 30 days
