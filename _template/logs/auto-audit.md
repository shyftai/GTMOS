# Auto-Mode Audit Log — [Workspace Name]

All actions taken in auto-mode are logged here. This is the black box — trace exactly what happened and why.

**Append-only. Never truncate or overwrite. Rotate monthly to `logs/auto-audit-YYYY-MM.md`.**

---

## Log format

```
## [ISO timestamp]
- **Action:** what was done (e.g. "Enriched 47 leads via Apollo")
- **Tool:** which tool/API was called
- **Input:** key parameters (endpoint, record count, query)
- **Output:** result summary (records returned, status, errors)
- **Cost:** credits/units consumed
- **Files changed:** which files were created or modified
- **Auto-approved gate?** yes/no — if yes, which gate was skipped
```

---

<!-- Log entries below — newest first -->
