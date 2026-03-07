<swarm_architecture>

## Agent Swarm — Optional Parallel Execution

GTMOS supports optional agent swarms for high-volume operations. Swarms are never the default —
they activate only when explicitly requested via the `--swarm` flag or the `/gtm:swarm` command.

### When to use swarms

- Personalizing outreach for 50+ leads at once
- Researching 10+ target companies in parallel
- Processing a batch of replies across multiple campaigns
- Running health checks across multiple campaigns simultaneously

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

</swarm_architecture>
