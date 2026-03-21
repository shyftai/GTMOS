---
name: gtm:clone-campaign
description: Clone a successful campaign for a new segment or market
argument-hint: "<workspace-name> <source-campaign> <new-campaign-name>"
---

## execution_context

- @./commands/clone-campaign.md
- @./.claude/gtmos/references/ui-brand.md
- @./.claude/gtmos/references/campaign-types.md

---

## process

### Step 1 — Display Mode Header

Display the GTM:OS mode header following ui-brand.md conventions:

```
Mode: CLONE CAMPAIGN
Workspace: {{workspace-name}}
Source: {{source-campaign}}
Target: {{new-campaign-name}}
```

Parse workspace name, source campaign, and new campaign name from $ARGUMENTS.

Validate all three names before touching any files:
- Only allow letters, numbers, hyphens, and underscores — no spaces, slashes, dots, or special characters
- Maximum 64 characters each
- If any name fails: stop and explain plainly: `"{{name}}" isn't a valid name — use letters, numbers, hyphens and underscores only (e.g. "q2-enterprise" or "acme_2024").`
- Show all three parsed values back before proceeding: `Cloning: workspaces/{workspace}/campaigns/{source} → {target} — confirm?`

Locate the workspace directory at `workspaces/{workspace-name}` and the source campaign directory at `workspaces/{workspace-name}/campaigns/{source-campaign}`. Confirm both exist before proceeding. If either is missing, report the error and list available workspaces/campaigns.

---

### Step 2 — Load Source Campaign Data

Load the source campaign's configuration and performance data:

1. Read `campaign.config.md` from the source campaign directory.
2. Read `BRIEFING.md` from the source campaign directory.
3. Read `PERSONALIZATION.md` from the source campaign directory.
4. Read `performance/ab-tests.md` from the source campaign directory (if it exists).
5. Read `performance/trends.md` from the source campaign directory (if it exists).

Extract key details:
- Campaign type, channel, number of touches, timing
- Angle, offer, CTA from the briefing
- Copy framework and angle rotation pattern
- A/B test winners (resolved tests with declared winners)

---

### Step 3 — Validate Source Campaign

Confirm the source campaign has results worth cloning. Check:

- Campaign status is `complete` or `active`
- Performance data exists (reply rate, meetings booked, or other outcome metrics)
- At least 100 contacts were shipped

If the source campaign does not meet these criteria, display a warning:

```
┌─ CLONE BLOCKED ───────────────────────────────────┐
│                                                    │
│  Source campaign does not have enough data to       │
│  justify cloning.                                  │
│                                                    │
│  Status: {{status}}                                │
│  Contacts shipped: {{count}}                       │
│  Reply rate: {{rate}}                              │
│                                                    │
│  Run the source campaign first, or use             │
│  /gtm:new-campaign to start fresh.                 │
│                                                    │
└────────────────────────────────────────────────────┘
```

Stop execution if validation fails.

---

### Step 4 — Display Clone Plan

Show the user exactly what will be cloned and what will not, using a GTM:OS-styled box:

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

Wait for user confirmation before proceeding.

---

### Step 5 — Ask About Segment Adjustments

Walk through each adjustment area. For each, show the source campaign's value and ask if it changes for the new segment:

**ICP differences:**
- Industry: "Source targets {{source_industry}}. Same or different?"
- Company size: "Source targets {{source_size}}. Same or different?"
- Geography: "Source targets {{source_geo}}. Same or different?"

**Persona differences:**
- Title: "Source targets {{source_title}}. Same or different?"
- Seniority: "Source targets {{source_seniority}}. Same or different?"

**Angle changes:**
- "Source angle: {{source_angle}}. Keep, adjust, or replace?"
- "Source CTA: {{source_cta}}. Keep, adjust, or replace?"

**Language:**
- "Source language: {{source_language}}. Same or different market?"
- If different language, note that `/gtm:write-multilang` should be used instead of `/gtm:write`.

Record all responses. These become adjustment markers in the cloned files.

---

### Step 6 — Create New Campaign Folder

Create the target campaign directory at `workspaces/{{workspace}}/campaigns/{{new-campaign-name}}/`.

1. Copy `campaign.config.md` from source. Apply any config adjustments from Step 5 (different channel, timing, etc.).

2. Copy `BRIEFING.md` from source. Add the header marker:
   ```
   <!-- CLONED FROM: {{source-campaign}} — REVIEW REQUIRED BEFORE SHIPPING -->
   ```
   Insert adjustment notes at relevant sections based on Step 5 responses.

3. Copy `PERSONALIZATION.md` from source. Adjust variable structure if persona or segment changes require different merge fields.

4. Create fresh directories from template:
   - `performance/` — empty ab-tests.md, empty trends.md
   - `logs/` — empty decision log, empty reply log
   - Sync files — fresh state

5. Do NOT copy contact lists, performance data, sync data, reply logs, or attribution data.

---

### Step 7 — Copy Cloned Files with Adjustment Markers

For each cloned file, insert markers where content needs review:

- In `BRIEFING.md`: Add `<!-- REVIEW: Does this angle apply to {{new_segment}}? -->` at angle, offer, and CTA sections.
- In `campaign.config.md`: Add notes where config may need updating for the new segment.
- In `PERSONALIZATION.md`: Flag any merge fields that may not be available for the new list.

---

### Step 8 — Apply A/B Test Winners

Read resolved A/B tests from the source campaign's `performance/ab-tests.md`. For each test with a declared winner:

1. Apply the winning variant as the default in the new campaign.
2. Note the provenance in the new campaign's `performance/ab-tests.md`:
   ```
   ## Starting Points (from source campaign)
   - Subject line: "{{winning_subject}}" — {{open_rate}} open rate (source: AB-{{id}})
   - CTA: "{{winning_cta}}" — {{reply_rate}} reply rate (source: AB-{{id}})
   ```
3. These are defaults, not locked values. The new campaign should still test and iterate.

If no A/B tests were run in the source campaign, note that in the clone summary.

---

### Step 9 — Flag Items Needing Review

Display all items that need attention before the cloned campaign can ship:

```
┌─ REVIEW REQUIRED ─────────────────────────────────┐
│                                                    │
│  Before this campaign can ship:                    │
│                                                    │
│  ! BRIEFING.md — Review angle, offer, and CTA     │
│    for {{target_segment}}.                          │
│                                                    │
│  ! Copy adaptation — Do NOT send source emails     │
│    to a different segment without rewriting.        │
│                                                    │
│  ! Contact list — Build and validate a new list.   │
│    Run /gtm:list-brief then /gtm:validate-list.    │
│                                                    │
│  ! Personalization — Confirm merge fields match    │
│    the new list's available data.                   │
│                                                    │
└────────────────────────────────────────────────────┘
```

---

### Step 10 — Display Clone Summary and Suggest Next Steps

Display the final clone summary:

```
┌─ CAMPAIGN CLONE ──────────────────────────────────┐
│                                                    │
│  Source: {{workspace}}/campaigns/{{source}}          │
│  Target: {{workspace}}/campaigns/{{target}}          │
│                                                    │
│  Cloned:                                           │
│    [x] Campaign config ({{touches}} touches, {{ch}})│
│    [x] Briefing structure (needs review)            │
│    [x] A/B winners ({{winner_summary}})             │
│    [x] Copy framework ({{framework}})               │
│                                                    │
│  Not cloned:                                       │
│    [ ] Contact list (build new)                     │
│    [ ] Performance data (fresh start)               │
│                                                    │
│  Action needed:                                    │
│    ! Review BRIEFING.md for {{target_segment}}      │
│    ! Adapt copy for new persona                     │
│    ! Build and validate new list                    │
│                                                    │
└────────────────────────────────────────────────────┘
```

Then suggest next steps:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Next: /gtm:list-brief {{workspace}} {{target}}
     Then: /gtm:write {{workspace}} {{target}}
     Or:   /gtm:write-multilang {{workspace}} {{target}}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Update `workspace.config.md` to add the new campaign to the active campaigns list. Log the clone action in `logs/workspace-log.md`.

---

## error_handling

- If workspace directory does not exist, display an error and list available workspaces.
- If source campaign directory does not exist, display an error and list available campaigns in the workspace.
- If target campaign name already exists, display an error and ask for a different name.
- If source campaign has no performance data, block the clone and suggest running the campaign first or using `/gtm:new-campaign`.
- If no arguments are provided, prompt the user interactively for workspace name, source campaign, and new campaign name.
- If the source is in a different workspace (cross-workspace clone), run the anonymization pass before creating cloned files. Flag any source-client-specific references found in cloned content.
