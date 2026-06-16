<swarm_architecture>

## Agent Swarm — Optional Parallel Execution

GTMOS supports optional agent swarms for high-volume operations. Swarms are never the default —
they activate only when explicitly requested via the `--swarm` flag or the `/gtm:swarm` command.

### When to use swarms

- Personalizing outreach for 50+ leads at once
- Researching 10+ target companies in parallel
- Processing a batch of replies across multiple campaigns
- Running health checks across multiple campaigns simultaneously

### Execution mode — Claude Code vs API

For large-scale operations, ask the user how they want to run it:

```
  How do you want to run this?

  >> Claude Code (default) — runs here, you see results in real time
     Best for: <50 contacts, interactive review, first-time runs

  >> API (faster, more scale) — runs via Anthropic API in the background
     Best for: 50-500+ contacts, batch processing, overnight runs
     Requires: ANTHROPIC_API_KEY in .env
```

**Claude Code mode:** Uses agent swarm within the current session. Interactive, real-time review, but limited by session context.

**API mode:** Spawns work via the Anthropic API (Claude) or Supabase Edge Functions. Results saved to files, user reviews when ready. Handles 100-500+ contacts without session limits. Requires API key.

Always ask before choosing — never default to API mode without user consent.

### When NOT to use swarms

- Single lead or small batch (<10) — sequential is faster
- Tasks requiring human approval at every step — swarm overhead is not worth it
- First campaign for a workspace — get the workflow right sequentially first

---

## Swarm Architecture

```
                    ORCHESTRATOR
                   (stays lean — coordinates only)
                         │
              ┌──────────┼──────────┐
              │          │          │
           WAVE 1     WAVE 2     WAVE 3
           (parallel)  (after 1)  (after 2)
              │
    ┌─────────┼─────────┐
    │         │         │
  Agent A   Agent B   Agent C
  (lead 1-10) (lead 11-20) (lead 21-30)
```

**Orchestrator role:**
- Loads workspace context once
- Splits work into batches
- Spawns agents per batch
- Collects results
- Presents unified output for approval
- Never executes lead-level work itself

**Agent role:**
- Receives batch of leads + full workspace context paths
- Reads context fresh (ICP, PERSONA, BRIEFING, TOV)
- Processes each lead in its batch
- Returns structured results
- Never sends or pushes anything — returns drafts only

---

## Batch Sizing

| Operation | Default batch size | Max parallel agents |
|-----------|-------------------|---------------------|
| Personalize outreach | 10 leads per agent | 5 |
| Company research | 5 companies per agent | 4 |
| Reply handling | 10 replies per agent | 5 |
| List validation | 50 records per agent | 4 |
| Signal scanning | 20 contacts per agent | 3 |

---

## Swarm Output Format

Every agent returns a structured result. Orchestrator collects all results and presents them
in a single unified view for approval.

```
<< GTMOS // SWARM COMPLETE >>

  ┌─ SWARM RESULTS ───────────────────────────────┐
  │                                                │
  │  Agents spawned:  4                            │
  │  Leads processed: 38                           │
  │  Drafts ready:    35                           │
  │  Flagged:         3 (need manual review)       │
  │  Errors:          0                            │
  │                                                │
  └────────────────────────────────────────────────┘
```

Then each draft is presented sequentially for approval — or if the user trusts the output,
they can batch-approve with `>> Approve all` (only available after reviewing at least 3 samples).

---

## Safety Rules

1. **Swarm agents never send anything** — they draft only. All sending requires human approval.
2. **Credit checks happen once at orchestrator level** before spawning — not per agent.
3. **Every swarm run is logged** in logs/decisions.md with agent count, batch sizes, and approval status.
4. **Batch-approve requires sample review** — user must review at least 3 drafts before `Approve all` unlocks.
5. **TOV and five-check validation runs per draft** — agents validate individually, orchestrator spot-checks.

---

## Approval-loop convergence (personalization)

For per-lead personalization (`/gtm:personalize`, or any skill generating `situation_line` / `value_line` / `cta_soft` style fields), do not fan out across the whole list before the prompt is proven. Tune on a few, then scale. This is the default loop for personalization swarms.

**Round 0 — sample on 1 lead.** Pick one lead with a rich `company_description`. Show the user the source data and what you would generate. Ask: "Does this feel right? Edit it and I'll re-tune."

**Rounds 1-N — batch of 10 with approval.** Spawn one agent with the current prompt + 10 leads. Display all 10 in a table (lead, each generated field). Ask for edits by row. If the user has edits, fold them into the prompt as rules (e.g. "never use the word X") and re-run a fresh batch of 10.

**Stop rule — converged.** The prompt is locked when the user gives **zero edits for 2 consecutive rounds**, or says "lock it, scale up." If an edit lands after two clean rounds, the counter resets and the loop continues.

**Scale — full fan-out.** Once locked, split the remaining leads into batches of 10-20 and run the standard swarm (max parallel agents per `Batch Sizing`). Merge by `lead_id`.

**Output discipline:**
- Default to **3 fields maximum** per variant — fewer fields, less to go wrong.
- For A/B/C angle testing, run one agent per variant per batch (Variant A leads with an observation, B with a transition, C with a question) — 3× the data from one list.
- Every generated field is still subject to `spam-words.md`, `TOV.md`, and the five-check. Never ship a field containing placeholder text like "cannot be generated" — mark the lead `personalization_status: skipped` and fall back to static copy.
- Save the locked prompt to the workspace (e.g. `context/personalization-prompt.md`) so later campaigns reuse it instead of re-tuning from scratch.

**When not to loop:** under ~10-20 leads, personalize inline in the main conversation — fan-out overhead isn't worth it. For static copy (same email to everyone), skip personalization entirely.

</swarm_architecture>
