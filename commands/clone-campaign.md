# Campaign Cloning — Command Reference

> GTMOS Command: `clone-campaign`
> Lifecycle: Select Source > Name Target > Review Clone Plan > Adjust for Segment > Create > Flag for Review

---

## 1. When to Clone

Clone a campaign when you have a campaign that performed well and want to run the same playbook for a different segment, market, or persona. Instead of building from scratch, clone the structure and adjust.

Common clone scenarios:
- **New market:** Same offer, different geography (e.g., US campaign worked, now targeting EMEA)
- **New persona:** Same product, different buyer (e.g., worked for VPs of Engineering, now targeting CTOs)
- **New segment:** Same angle, different industry vertical (e.g., FinTech worked, now targeting HealthTech)
- **Seasonal repeat:** Same campaign type, new quarter (e.g., Q1 cold outbound proved out, run it again in Q2)
- **Cross-client reuse:** Agency proved a playbook for Client A, applying the structure to Client B

**Rule: Only clone campaigns with demonstrated results.** A campaign must have status `complete` or `active` with meaningful performance data (reply rate, meetings booked) before it qualifies as a clone source. Do not clone campaigns that have not been validated.

---

## 2. What Gets Cloned

| File / Asset                  | Clone Behavior                                                                 |
|-------------------------------|--------------------------------------------------------------------------------|
| `campaign.config.md`          | Cloned in full — type, channel, touches, timing, sending config                |
| `BRIEFING.md`                 | Cloned with review flag — angle, offer, CTA are carried over but marked for review |
| `PERSONALIZATION.md`          | Cloned — variable structure (merge fields, personalization slots)               |
| Copy structure                | Cloned — number of touches, frameworks used, angle rotation pattern             |
| A/B test winners              | Cloned — winning variants from source campaign applied as new defaults          |
| `performance/ab-tests.md`     | Cleared — fresh file, but source campaign winners noted as starting points      |

### A/B Test Winner Forward-Feed

When a source campaign has resolved A/B tests with declared winners, those winners become the defaults in the cloned campaign:

- Winning subject line formula becomes the default subject line approach
- Winning CTA structure becomes the default CTA
- Winning opening line pattern becomes the default opener
- Winners are noted with their source test ID for provenance (e.g., "Default from AB-2026-003, 26.1% open rate")

This gives the new campaign a head start. It does not mean these defaults are permanent — the new segment may respond differently — but it means you start from a proven baseline instead of guessing.

---

## 3. What Does NOT Get Cloned

| Asset                | Reason                                                        |
|----------------------|---------------------------------------------------------------|
| Contact lists        | New segment = new list. Never reuse contacts across segments. |
| Performance data     | Fresh start. The new campaign earns its own metrics.          |
| Sync data            | Fresh. Tool sync state is campaign-specific.                  |
| Reply logs           | Fresh. Reply classifications belong to the source campaign.   |
| Attribution data     | Fresh. Pipeline attribution starts clean.                     |
| `logs/decisions.md`  | Fresh. Decision log is campaign-specific.                     |

**Rule: Never carry over contact-level or performance-level data.** The clone inherits strategy and structure, not results. Results must be earned by the new campaign.

---

## 4. Clone Workflow

### Step 1 — Select Source Campaign

Identify the source campaign to clone from. The source must meet one of these criteria:

- Status: `complete` with performance data logged
- Status: `active` with at least 100 contacts shipped and reply data available

If the source campaign has no performance data, reject the clone and suggest running the campaign first. A clone without validated results is just a copy of unproven guesses.

### Step 2 — Name the New Campaign

Assign a name to the new campaign. Follow workspace naming conventions (typically: `{quarter}-{descriptor}` or `{segment}-{channel}`).

Examples:
- Source: `q1-cold-outbound` → Target: `q2-emea-expansion`
- Source: `fintech-vp-eng` → Target: `healthtech-vp-eng`
- Source: `us-product-launch` → Target: `uk-product-launch`

### Step 3 — Review Clone Plan

Before creating anything, display a clear summary of what will and will not be cloned. Show this in a GTMOS box so the user can confirm before proceeding.

```
┌─ CLONE PLAN ──────────────────────────────────────┐
│                                                    │
│  Source: {{workspace}}/campaigns/{{source}}         │
│  Target: {{workspace}}/campaigns/{{target}}         │
│                                                    │
│  Will clone:                                       │
│    - Campaign config ({{touches}} touches, {{ch}}) │
│    - Briefing structure (angle, offer, CTA)        │
│    - Personalization variable structure             │
│    - Copy framework ({{framework}})                │
│    - A/B winners: {{winner_summary}}               │
│                                                    │
│  Will NOT clone:                                   │
│    - Contact list                                  │
│    - Performance data                              │
│    - Sync data                                     │
│    - Reply logs                                    │
│    - Attribution data                              │
│                                                    │
│  Proceed? (yes / no)                               │
│                                                    │
└────────────────────────────────────────────────────┘
```

### Step 4 — Adjust for the New Segment

After confirmation, walk through segment-specific adjustments. For each area, show the source campaign's current value and ask if it changes:

**ICP differences:**
- Different industry? (source: FinTech → target: HealthTech)
- Different company size? (source: 50-200 → target: 200-1000)
- Different geography? (source: US → target: EMEA)
- Different funding stage? (source: Series A-B → target: Series C+)

**Persona differences:**
- Different title? (source: VP Engineering → target: CTO)
- Different seniority? (source: VP → target: C-suite)
- Different department? (source: Engineering → target: Product)

**Angle changes:**
- Same problem, different framing? (source: cost reduction → target: compliance)
- Same framing, different proof points? (source: startup case study → target: enterprise case study)
- Entirely different angle? (if so, consider whether cloning is the right approach vs. a fresh campaign)

**Language:**
- Same language or different market? (source: English → target: German)
- If different language: flag for `/gtm:write-multilang` instead of `/gtm:write`

Record all adjustments. These become markers in the cloned files.

### Step 5 — Create New Campaign Folder

Create the new campaign directory at `workspaces/{{workspace}}/campaigns/{{target}}/` with the following:

1. Copy `campaign.config.md` from source. Apply any config adjustments from Step 4.
2. Copy `BRIEFING.md` from source. Insert adjustment markers at every section that needs review for the new segment. Mark the file header with: `<!-- CLONED FROM: {{source}} — REVIEW REQUIRED BEFORE SHIPPING -->`
3. Copy `PERSONALIZATION.md` from source. Adjust merge field structure if persona or segment changes require different variables.
4. Create fresh `performance/` directory from template (empty ab-tests.md, empty trends.md).
5. In the new `performance/ab-tests.md`, add a reference section at the top noting the source campaign's A/B winners as starting points.
6. Create fresh `logs/` directory from template.
7. Create fresh sync files from template.

### Step 6 — Flag Items Needing Review

Before the cloned campaign can ship, certain items require manual review and adaptation. Display these as action items:

```
┌─ REVIEW REQUIRED ─────────────────────────────────┐
│                                                    │
│  Before this campaign can ship:                    │
│                                                    │
│  ! BRIEFING.md — Review angle, offer, and CTA     │
│    for {{target_segment}}. Source briefing was      │
│    written for {{source_segment}}.                  │
│                                                    │
│  ! Copy adaptation — Do NOT send source campaign   │
│    emails to a different segment without rewriting. │
│    Same framework, different specifics.             │
│                                                    │
│  ! Contact list — Build and validate a new list    │
│    for {{target_segment}}. Run /gtm:list-brief     │
│    followed by /gtm:validate-list.                  │
│                                                    │
│  ! Personalization — Confirm merge fields match    │
│    the new list's available data.                   │
│                                                    │
└────────────────────────────────────────────────────┘
```

**Rule: Never ship a cloned campaign without reviewing every cloned file for segment fit.** Cloning saves structure, not thinking. The new segment deserves tailored messaging.

### Step 7 — Suggest Next Steps

After the clone is complete, suggest the natural next actions:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Next: /gtm:list-brief {{workspace}} {{target}}
     Then: /gtm:write {{workspace}} {{target}}
     Or:   /gtm:write-multilang {{workspace}} {{target}}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## 5. Clone from Different Workspace

Optionally, a campaign can be cloned from a campaign in a different workspace. This is common for agencies running a proven playbook across multiple clients.

### Cross-Workspace Clone Rules

1. **Only clone structure and anonymized patterns.** Do not carry over:
   - Client-specific company names, contact names, or identifiers
   - Client-specific offer details or pricing
   - Client-specific proof points or case studies
   - Any data that belongs to the source client

2. **What transfers across workspaces:**
   - Campaign type and channel configuration
   - Sequence length and timing pattern
   - Copy framework and angle rotation structure
   - A/B test winner patterns (anonymized — e.g., "pain-point subject line outperformed curiosity-based by 40%" not the actual subject line text)
   - Personalization variable structure (the slots, not the data)

3. **Syntax:** Specify the source workspace explicitly:
   ```
   /gtm:clone-campaign {{target-workspace}} {{source-workspace}}/{{source-campaign}} {{new-campaign-name}}
   ```

4. **Anonymization pass:** After cloning, scan all cloned files for source-client-specific references and flag them for replacement. Display any found references so they can be removed before work begins.

---

## 6. Clone Summary Display

After a successful clone, display the full summary:

```
┌─ CAMPAIGN CLONE ──────────────────────────────────┐
│                                                    │
│  Source: workspace/campaigns/q1-cold-outbound       │
│  Target: workspace/campaigns/q2-emea-expansion      │
│                                                    │
│  Cloned:                                           │
│    [x] Campaign config (4 touches, email)           │
│    [x] Briefing structure (needs review)            │
│    [x] A/B winners (subject: "your team")           │
│    [x] Copy framework (Obs > Prob > Proof > Ask)    │
│                                                    │
│  Not cloned:                                       │
│    [ ] Contact list (build new)                     │
│    [ ] Performance data (fresh start)               │
│                                                    │
│  Action needed:                                    │
│    ! Review BRIEFING.md for EMEA market             │
│    ! Adapt copy for new persona                     │
│    ! Build and validate new list                    │
│                                                    │
└────────────────────────────────────────────────────┘
```

---

## 7. Rules

1. **Only clone proven campaigns.** Source must have status `complete` or `active` with results. Do not clone unvalidated campaigns.
2. **Never carry over contacts.** New segment = new list. Always.
3. **Never carry over performance data.** The clone earns its own metrics from scratch.
4. **Always review BRIEFING.md before shipping.** A briefing written for one segment does not automatically apply to another.
5. **Always adapt copy.** Cloning the framework is smart. Sending identical emails to a different segment is lazy and will underperform.
6. **Forward-feed A/B winners as defaults, not as gospel.** The new segment may respond differently. Use winners as starting points, not final answers.
7. **Cross-workspace clones must be anonymized.** No client-specific data crosses workspace boundaries.
8. **One clone, one review.** Every cloned file must be reviewed and adjusted before the campaign ships. No exceptions.
