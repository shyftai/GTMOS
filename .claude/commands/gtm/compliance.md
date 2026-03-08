---
name: gtm:compliance
description: Configure privacy and anti-spam regulation toggles for a workspace
argument-hint: "<workspace-name> [--auto-detect | --show | --set <regulation> on/off]"
---
<objective>
Configure which privacy and anti-spam regulations apply to this workspace. Auto-detect from target geography or manually toggle regulations on/off. Active regulations are enforced during launch check.

Workspace and options: $ARGUMENTS
</objective>

<execution_context>
@./commands/compliance.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/sending-calendar.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // COMPLIANCE >>`
2. Load SUPPRESSION.md — check for existing `## Active regulations` section
3. Load ICP.md — check target geographies
4. If `--auto-detect` or no regulations configured yet:
   - Map target countries to regulations
   - Display detected regulations with ON/OFF recommendations
   - Ask user to confirm or adjust
   - Save to SUPPRESSION.md
5. If `--show`:
   - Display current regulation status table
   - Show which launch checks each active regulation adds
6. If `--set <regulation> on/off`:
   - Toggle the specified regulation
   - Update SUPPRESSION.md
   - Show updated status
7. Display compliance summary:
   - Active regulations
   - Required footer elements
   - Data retention rules
   - Missing documentation (legitimate interest, consent records, etc.)
8. If GDPR is ON and legitimate interest is not documented, prompt user to document it
9. If CASL is ON, warn about consent tracking requirements
</process>
