---
name: gtm:switch
description: Switch active workspace and reload all context
argument-hint: "<workspace-name>"
---
<objective>
Switch to a different workspace. Unload current context, load new workspace, display summary.

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // SWITCHING >>`
2. Confirm the target workspace exists in workspaces/
3. If not found, list available workspaces and prompt for selection
4. Load all source-of-truth files from the new workspace:
   - ICP.md, PERSONA.md, BRIEFING.md, TOV.md
   - RULES.md, TOOLS.md, WORKFLOW.md, COSTS.md
   - workspace.config.md
   - context/INDEX.md (then read priority files)
5. Check .env for active tool API keys
6. Display workspace header:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  WORKSPACE: {Name}                                         ┃
┃  CAMPAIGN:  {Active campaign}                              ┃
┃  STATUS:    {active/paused}         TOOLS: {tool list}     ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```
7. Show context summary:
   - Who we are targeting (company + persona)
   - Active campaign angle
   - Approval chain
   - Tools ready
   - Current spend vs budget
   - Any missing keys or constraints

8. Confirm: `>> Ready. What would you like to do?`
</process>
