---
name: gtm:domain-recovery
description: Recover a damaged sending domain
argument-hint: "<workspace-name> [domain]"
---
<objective>
Walk through the domain recovery playbook when deliverability is compromised. Pause, diagnose, clean up, warm back, ramp.

Workspace and domain: $ARGUMENTS
</objective>

<execution_context>
@./commands/domain-recovery.md
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // DOMAIN RECOVERY >>`
2. Load INFRASTRUCTURE.md and identify the affected domain
3. Phase 1 — Stop: pause all cold sending, document current state, identify cause
4. Phase 2 — Clean: remove bounces, fix DNS, re-validate lists
5. Phase 3 — Warm back: warmup-only for 7-14 days, seed test
6. Phase 4 — Ramp: resume at 25%, increase gradually over 14 days
7. If no recovery after 28 days: guide domain retirement and replacement
8. Update INFRASTRUCTURE.md throughout
</process>
