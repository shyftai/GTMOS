# /rev:migrate

Move your RevOps workspace from one CRM to another — with clean data, preserved attribution, and zero lost history.

## When to use

- Moving from Salesforce → HubSpot, HubSpot → Salesforce, Pipedrive → either, or any other CRM pair
- After a CRM migration has already happened and you need to validate the result
- When joining a company mid-migration and need to understand where things stand

---

## Overview

Migration runs in three phases. You can start at any phase:

```
  Phase 1: PRE-MIGRATION AUDIT      ← start here if migration hasn't happened yet
  Phase 2: MIGRATION EXECUTION      ← start here if you're ready to move data
  Phase 3: POST-MIGRATION VALIDATION ← start here if data is already in the new CRM
```

Ask the user:

```
What's your migration situation?

  [1] Haven't started — help me prepare (Phase 1)
  [2] Ready to move — let's do it (Phase 2)
  [3] Already moved — need to validate and clean up (Phase 3)
  [4] Mid-migration — things are messy, need to recover
```

Then ask:
- **Source CRM** — what are you moving FROM? (Salesforce / HubSpot / Pipedrive / Other)
- **Destination CRM** — what are you moving TO? (Salesforce / HubSpot / Pipedrive / Other)
- **Timeline** — when does the migration need to be complete?
- **Data volume** — roughly how many: Contacts? Companies? Deals (open + historical)?

Load `references/rev-migration.md` for field mapping tables, tool recommendations, and what survives each migration path.

Create `MIGRATION.md` in the workspace if it doesn't exist (copy from `_template/MIGRATION.md`).

---

## Phase 1: Pre-migration audit

**Goal:** Leave the old CRM in the best possible shape before exporting. Never migrate a mess.

### Step 1a: Data quality baseline

Run a targeted health check on the source CRM. Report:

```
PRE-MIGRATION DATA AUDIT — [Source CRM] → [Destination CRM]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Date: [Date]   Migration target: [Date]   Days remaining: [X]

RECORD COUNTS (what will be migrated)
  Contacts:     [X]    Active: [X]   Suppressed: [X]
  Companies:    [X]    Tier 1: [X]   Tier 2: [X]   Tier 3: [X]
  Deals (open): [X]    Value: $[X]
  Deals (won):  [X]    Last 12 months: [X]
  Deals (lost): [X]    Last 12 months: [X]

DATA QUALITY — will these records be useful in the new CRM?
  Overall score:     [X]%   [🟢/🟡/🔴]
  Missing lead source:   [X]% of contacts — 🔴 FIX BEFORE MIGRATING
  Missing company link:  [X]% of contacts
  Duplicate accounts:    [X] clusters detected
  Null email:            [X] contacts
  NULL deal stage:       [X] deals

ATTRIBUTION RISK
  Contacts with UTM data:   [X]%
  Contacts with lead source: [X]%
  Deals with source set:    [X]%
  ⚠ [X] deals have no source — will arrive in new CRM as "Unknown"

MIGRATION READINESS: [🟢 Ready / 🟡 Fix recommended / 🔴 Do not migrate yet]
```

### Step 1b: Pre-migration cleanup

Based on audit results, recommend in priority order:

1. **Fix lead source gaps** — any contact or deal with NULL lead source will arrive in the new CRM as unknown. Fix before migrating, not after. Mark unrecoverable ones as "Import — pre-migration" so they're identifiable.

2. **Deduplicate** — run `/rev:dedupe` before exporting. Merging duplicates after migration is 3× harder because records arrive with different IDs in the new system.

3. **Archive dead records** — contacts with no activity in > 2 years, deals with no movement in > 1 year. Do not migrate them. Tag with "Archived — pre-migration [date]" in source CRM.

4. **Normalize field values** — stage names, lead source values, industry categories. Inconsistent picklist values cause mapping failures. Standardize to match destination CRM values before exporting.

5. **Document current field structure** — run a field inventory and record it in `MIGRATION.md`. You'll need this when field values don't appear in the new CRM.

### Step 1c: Field mapping table

Generate the field mapping for the specific CRM pair. Pull from `references/rev-migration.md` for the standard mapping, then customize:

```
FIELD MAPPING — [Source CRM] → [Destination CRM]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Object: Company / Account / Organization

Source field               → Destination field          Notes
──────────────────────────────────────────────────────────────
[Source name]              → [Destination name]         [Any transform needed]
[Source name]              → [Create new custom field]  [Field doesn't exist in dest]
[Source name]              → DO NOT MIGRATE             [Why — e.g. system field, irrelevant]
```

Flag any source fields that have no destination equivalent — these need a custom field created in the destination CRM before migration starts. Reference `rev-crm-setup.md` for the custom fields REV:OS requires.

### Step 1d: What survives vs. what you lose

Present this before migration so there are no surprises:

```
WHAT SURVIVES THIS MIGRATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Contacts, Companies, Deals (with field mapping applied)
✅ Custom field values (if mapped)
✅ Lead source / UTM fields (if stored as field values)
✅ Deal stage (current stage only)
✅ Open activities / tasks (varies by tool and method)
✅ Tags / lists (if using CSV method)

⚠ PARTIAL — requires extra steps
  Email thread history — stays in email provider; log to new CRM via integration
  Call logs — stay in Gong/Chorus; reconnect Gong to new CRM after migration
  Activity notes — export as CSV notes; import as timeline entries
  Deal stage history — current stage transfers; history usually does not

❌ YOU WILL LOSE
  Report and dashboard configurations — rebuild in new CRM
  File attachments — download and re-upload manually (or use cloud storage)
  Marketing email history — stays in marketing automation tool
  Workflow / sequence enrollment state — document manually before migrating
  Native integration configs — all integrations must be reconnected

ACTION REQUIRED: Download and archive before migrating:
  [ ] All report/dashboard configs (screenshot or export)
  [ ] File attachments on key accounts
  [ ] Current workflow enrollment lists
  [ ] Sequence enrollment state for active prospects
```

### Step 1e: Pre-migration checklist

```
PRE-MIGRATION CHECKLIST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Data preparation
  [ ] Lead source set on > 95% of contacts and deals
  [ ] Duplicate accounts and contacts resolved
  [ ] Dead records archived and excluded from export
  [ ] Field values normalized (stages, sources, industries)
  [ ] Custom fields created in destination CRM (from rev-crm-setup.md list)

Documentation
  [ ] Field mapping table completed in MIGRATION.md
  [ ] Current pipeline value documented (compare after migration)
  [ ] Current data quality score documented (compare after migration)
  [ ] Attribution snapshot taken (source breakdown saved)
  [ ] Active deal list exported (verify all arrive post-migration)
  [ ] Integration list documented (all tools to reconnect)

Backup
  [ ] Full export from source CRM downloaded and stored
  [ ] Report/dashboard screenshots archived
  [ ] Key account files downloaded
  [ ] Workflow enrollment states documented

Access
  [ ] Admin access confirmed in destination CRM
  [ ] Migration tool selected and credentials ready
  [ ] Test environment available (sandbox) if using Salesforce
```

Record the pre-migration score and pipeline snapshot in `MIGRATION.md` — you'll compare these after Phase 3.

---

## Phase 2: Migration execution

**Goal:** Move data cleanly, in stages, with validation at each step.

### Step 2a: Migration method selection

Based on CRM pair, recommend the migration approach:

```
RECOMMENDED MIGRATION METHOD — [Source] → [Destination]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Primary method: [see references/rev-migration.md for CRM-pair-specific recommendation]

Tools:
  [Tool name] — [what it handles] — [cost estimate]

Migration order (always follow this sequence):
  1. Companies / Accounts first — deals and contacts link to them
  2. Contacts — associate to companies on import
  3. Deals (historical, closed) — preserve source and attribution fields
  4. Deals (open) — highest priority; verify every open deal arrives
  5. Activities / notes — last, after all parent records exist
```

### Step 2b: Staged migration

Never migrate all records at once. Use this staged approach:

**Test batch (50 records):**
- Select 50 records that represent your full data diversity (Tier 1 accounts, open deals, different sources)
- Migrate test batch using selected method
- Validate immediately — check every field mapping, every association, every custom field value
- Fix any mapping errors before proceeding

**Full migration:**
- Only proceed after test batch validates cleanly
- Migrate in object order: Companies → Contacts → Deals (historical) → Deals (open) → Activities
- Log each object batch in `MIGRATION.md` as it completes: record count in, record count arrived, delta

### Step 2c: During migration — what to watch

```
MIGRATION MONITOR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Object          Sent    Arrived   Delta   Status
────────────────────────────────────────────────
Companies       [X]     [X]       [X]     [✅/⚠/🔴]
Contacts        [X]     [X]       [X]     [✅/⚠/🔴]
Deals (hist.)   [X]     [X]       [X]     [✅/⚠/🔴]
Deals (open)    [X]     [X]       [X]     [✅/⚠/🔴]
Activities      [X]     [X]       [X]     [✅/⚠/🔴]
```

Flag immediately if delta > 0. Do not proceed to next object until previous object is reconciled.

### Step 2d: Integration disconnection order

Before going live in new CRM, disconnect integrations from old CRM in this order:

```
DISCONNECT FROM OLD CRM (in order)
  1. Sequencing tool (Outreach / Salesloft / Instantly) — stop sends first
  2. Marketing automation (HubSpot Marketing / Marketo) — prevent duplicate syncs
  3. Enrichment tools (Apollo / Clay / Clearbit) — stop writing to old CRM
  4. Gong / Chorus — disconnect CRM sync (calls stay in Gong)
  5. CS platform — disconnect old CRM sync (keep CS data intact)
  6. Stripe — disconnect old CRM sync (critical — do this last before cutover)

DO NOT disconnect until all data is confirmed in new CRM.
Keep old CRM in READ-ONLY mode for 30 days post-cutover.
```

---

## Phase 3: Post-migration validation

**Goal:** Confirm everything arrived, attribution is intact, integrations are live, and the team is unblocked.

### Step 3a: Record count validation

```
POST-MIGRATION RECORD COUNT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Object          Pre-migration   Post-migration   Delta   Status
────────────────────────────────────────────────────────────────
Companies       [X]             [X]              [X]     [✅/🔴]
Contacts        [X]             [X]              [X]     [✅/🔴]
Open deals      [X]             [X]              [X]     [✅/🔴]
Historical deals [X]            [X]              [X]     [✅/🔴]

Open deal value (pre):  $[X]M
Open deal value (post): $[X]M
Delta:                  $[X]   [✅ < 1% variance / 🔴 investigate]

Any delta > 0 on open deals is a blocker — find missing records before proceeding.
```

### Step 3b: Attribution continuity check

```
ATTRIBUTION CONTINUITY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Contacts with lead source set
  Pre-migration:  [X]%
  Post-migration: [X]%
  Delta:          [+/-X pp]   [✅ / ⚠ regression]

Deals with source set
  Pre-migration:  [X]%
  Post-migration: [X]%
  Delta:          [+/-X pp]   [✅ / ⚠ regression]

Top sources (verify values transferred correctly)
  [Source 1]: [X] pre → [X] post   [✅/⚠]
  [Source 2]: [X] pre → [X] post   [✅/⚠]
  [Source 3]: [X] pre → [X] post   [✅/⚠]

UTM fields preserved: [X]% of contacts
```

If attribution has regressed — identify which source values failed to transfer (usually picklist value mismatch) and batch-update in new CRM before team starts using it.

### Step 3c: Data quality comparison

Run `/rev:health` in the new CRM context and compare:

```
DATA QUALITY COMPARISON
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                Pre-migration   Post-migration   Delta
Overall score:  [X]%            [X]%             [+/-X pp]
Duplicate rate: [X]%            [X]%             [+/-X pp]
Enrichment:     [X]%            [X]%             [+/-X pp]
Source coverage:[X]%            [X]%             [+/-X pp]

Score should be equal or better post-migration.
If worse, identify which categories regressed — likely field mapping issues.
```

### Step 3d: Integration reconnection order

Reconnect in reverse order of disconnection — lowest risk first:

```
RECONNECT TO NEW CRM (in order)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  1. Gong / Chorus           → reconnect CRM sync; verify calls log to deals
  2. CS platform             → reconnect; verify health scores sync to Company records
  3. Enrichment tools        → reconnect; do NOT bulk re-enrich on day 1 (cache still valid)
  4. Marketing automation    → reconnect; verify lifecycle stage sync is bidirectional
  5. Sequencing tool         → reconnect; verify contact sync and suppression list
  6. Stripe                  → reconnect last; verify MRR syncs to Company ARR field
                               Run /rev:stripe immediately after to confirm reconciliation

Verify each integration before connecting the next.
Log each reconnection in MIGRATION.md with date and status.
```

### Step 3e: Parallel running period

Keep old CRM in read-only for 30 days:

```
PARALLEL RUNNING PROTOCOL (30 days)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Old CRM ([Name]) — READ ONLY until [Date + 30 days]
  ✅ Use for: looking up historical records, retrieving archived data
  ❌ Do not: create new records, update existing records, run reports

If a record is missing from new CRM:
  1. Find it in old CRM (read-only)
  2. Manually recreate in new CRM with original created date preserved
  3. Log in MIGRATION.md issue tracker

Archive old CRM access on [Date + 30 days].
Downgrade or cancel old CRM subscription only after parallel period ends.
```

### Step 3f: Team transition checklist

```
TEAM TRANSITION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

For each team (AEs, SDRs, CSMs):
  [ ] New CRM login confirmed for all reps
  [ ] Open deals verified — each rep confirms their pipeline in new CRM
  [ ] Sequencing tool reconnected and sequences re-enrolled
  [ ] Email integration connected (Gmail / Outlook → new CRM)
  [ ] Mobile app installed and logged in
  [ ] Custom views / saved filters recreated
  [ ] Reports and dashboards rebuilt

For RevOps:
  [ ] All integrations confirmed live (checklist above)
  [ ] Stripe reconciliation run and confirmed
  [ ] First /rev:health run and score documented
  [ ] First /rev:forecast run in new CRM
  [ ] MIGRATION.md marked complete with final scores
  [ ] Old CRM set to read-only (admin access only)
```

### Step 3g: Migration complete

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MIGRATION COMPLETE — [Source CRM] → [Destination CRM]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Completed:      [Date]
  Records moved:  [X] companies · [X] contacts · [X] deals
  Data quality:   [X]% (vs. [X]% pre-migration)
  Attribution:    [X]% coverage (vs. [X]% pre-migration)
  Integrations:   [X]/[X] connected

  Old CRM read-only until: [Date + 30 days]
  Cancel old CRM subscription: [Date + 30 days]

  Next steps:
  1. Run /rev:health weekly for 4 weeks — watch for data quality regression
  2. Run /rev:stripe to confirm MRR reconciliation
  3. Run /rev:attribution after 30 days — verify source data is intact
  4. Add migration learnings to LEARNINGS.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Update `workspace.config.md` with new CRM system and edition. Update `CRM.md` with new field structure. Log migration completion in `MIGRATION.md`.

---

## Recovery: Mid-migration chaos

If the user selects "Mid-migration — things are messy":

Ask:
1. What is currently in the new CRM? (Some records / Most records / Everything but broken)
2. Is the old CRM still accessible? (Yes — read-only / Yes — still being used / No — gone)
3. What's broken? (Missing records / Duplicate records / Broken associations / Lost attribution / All of the above)

Then run Phase 3 validation to understand the current state, identify what's missing, and build a recovery plan. If old CRM is still accessible, treat it as the source of truth and re-migrate the missing objects. If old CRM is gone, work from the best available export.
