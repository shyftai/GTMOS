---
name: gtm:swarm
description: Run a GTM operation with parallel agent swarm for high-volume work
argument-hint: "<operation> <workspace-name> [campaign-name]"
---
<objective>
Run a GTM operation using parallel agent swarms. Orchestrator splits work into batches,
spawns agents, collects results, presents unified output for approval.

Operation and workspace: $ARGUMENTS

Available operations:
- `personalize` — Personalize outreach for every lead in the shipped list
- `research` — Research multiple target companies in parallel
- `replies` — Process a batch of replies across campaigns
- `validate` — Validate a large list in parallel batches
- `signals` — Scan signals across the full shipped list
</objective>

<execution_context>
@./.claude/gtmos/references/swarm.md
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>

## Phase 1: Initialize

1. Display mode header: `<< GTMOS // SWARM >>`
2. Parse operation type from $ARGUMENTS
3. Load workspace context — all source-of-truth files
4. Display workspace header

## Phase 2: Scope the work

Based on operation type, identify the full workload:

**personalize:**
- Load shipped list from lists/shipped/
- Load signal-angles.md for angle options
- Count total leads to personalize
- Display: "{N} leads to personalize across {batches} batches"

**research:**
- Load ICP.md for target segment definition
- Identify companies to research (from list or ICP criteria)
- Display: "{N} companies to research across {batches} batches"

**replies:**
- Pull unprocessed replies from all active tools
- Count total replies
- Display: "{N} replies to process across {batches} batches"

**validate:**
- Load raw CSV from lists/raw/
- Count total records
- Display: "{N} records to validate across {batches} batches"

**signals:**
- Load shipped list
- Load active signal tools from TOOLS.md
- Display: "{N} contacts to scan across {batches} batches"

## Phase 3: Credit check (if applicable)

If the operation involves tool writes:
```
  ┌ CREDIT CHECK ─────────────────────────────────┐
  │ Operation: {type}                              │
  │ Total leads: {N}                               │
  │ Tools involved: {list}                         │
  │ Estimated credits: {estimate}                  │
  │ Rule: {credit behaviour from TOOLS.md}         │
  └────────────────────────────────────────────────┘
  >> Proceed with swarm? (y/n)
```

Wait for approval before spawning any agents.

## Phase 4: Spawn agents

Split workload into batches per the sizing table in swarm.md.

For each batch, spawn an agent with:
```
Agent(
  subagent_type="general-purpose",
  prompt="
    You are a GTMOS swarm agent. Your job is to {operation} for a batch of leads.

    RULES:
    - Draft only — never send, push, or update any external tool
    - Validate every output against the five checks (ICP, Persona, Briefing, Voice, Quality)
    - Return structured results — one entry per lead
    - Flag anything uncertain as [~] for manual review

    WORKSPACE CONTEXT — read these files:
    - ICP: {workspace}/ICP.md
    - PERSONA: {workspace}/PERSONA.md
    - BRIEFING: {workspace}/BRIEFING.md
    - TOV: {workspace}/TOV.md
    - RULES: {workspace}/RULES.md
    {additional context files as needed}

    YOUR BATCH:
    {batch data — lead records, replies, or companies}

    OUTPUT FORMAT:
    Return a markdown table or structured list with one entry per lead.
    Include: lead name, company, action taken, draft content, five-check result, flags.
  ",
  description="{operation} batch {N}"
)
```

Display spawning indicator:
```
  << GTMOS // SWARM >>

  Spawning {N} agents...
    [~] Agent 1: leads 1-10
    [~] Agent 2: leads 11-20
    [~] Agent 3: leads 21-30
    [~] Agent 4: leads 31-38
```

Run agents in parallel where independent. Wait for all to complete.

## Phase 5: Collect and merge results

As each agent completes, update display:
```
    [x] Agent 1: leads 1-10    — 10 drafts, 0 flags
    [x] Agent 2: leads 11-20   — 9 drafts, 1 flag
    [~] Agent 3: leads 21-30
    [~] Agent 4: leads 31-38
```

When all complete, merge results into a unified output.

Display swarm results summary:
```
  ┌─ SWARM RESULTS ───────────────────────────────┐
  │                                                │
  │  Agents spawned:  {N}                          │
  │  Leads processed: {total}                      │
  │  Drafts ready:    {count}                      │
  │  Flagged:         {count} (need manual review) │
  │  Errors:          {count}                      │
  │                                                │
  └────────────────────────────────────────────────┘
```

## Phase 6: Review and approve

1. Show flagged items first — these need manual review
2. Then show 3 sample drafts from the clean batch for spot-checking
3. After user reviews samples:

```
  >> Options:
     1. Review all {N} drafts one by one
     2. Approve all clean drafts, review flagged only
     3. Export all drafts to copy/drafts/ for offline review
```

Option 2 is only available after user has reviewed the 3 samples.

## Phase 7: Save and log

- Save all approved drafts to the appropriate folder (copy/approved/, replies/, etc.)
- Save flagged items separately for manual follow-up
- Log swarm run in logs/decisions.md:
  - Date, operation type, agent count, batch sizes
  - Approval method (individual / batch after sample review)
  - Any flags or issues

Display next action:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Next: {context-appropriate suggestion}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</process>
