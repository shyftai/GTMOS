---
name: agency:new-business
description: Launch a new business development campaign for the agency
argument-hint: "<workspace-name> [campaign-name]"
---
<objective>
Launch an agency new business campaign from signal detection through copy approval. Covers campaign type selection, list brief, copy drafting, and validation.

Workspace and campaign name: $ARGUMENTS
</objective>

<execution_context>
@./references/agency-campaigns.md
@./references/agency-personas.md
@./references/agency-signals.md
@./../../.claude/gtmos/references/ui-brand.md
@./../../.claude/gtmos/references/cold-email-skill.md
</execution_context>

<process>
1. Display mode header: `<< AGENCY:OS // NEW BUSINESS >>`

2. Load workspace files:
   - `ICP.md` — confirm target company profile
   - `PERSONA.md` — buyer personas available
   - `SERVICE-LINES.md` — what we can pitch
   - `CASE-STUDIES.md` — what proof points are available
   - `CLIENTS.md` — **HARD GATE: check for client conflicts before proceeding**
   - `SUPPRESSION.md`

3. **Client conflict check (hard gate):**
   Confirm: "I've checked CLIENTS.md. No existing clients will be targeted in this campaign."
   If workspace has clients listed: explicitly verify no overlap with proposed target segment.
   If overlap detected: STOP — do not proceed. Flag the conflict and ask for guidance.

4. Ask campaign type:
   ```
   What type of campaign?
   1. Cold Outbound — New Business (primary channel)
   2. Signal-Triggered — New CMO/VP Hired (highest conversion)
   3. Signal-Triggered — Funding Round (time-sensitive)
   4. Competitor Displacement (empathy-led)
   5. Referral Activation (existing clients)
   6. Win-Back — Lapsed Client
   ```
   Load the selected campaign type details from agency-campaigns.md.

5. Ask target persona:
   ```
   Who is the primary buyer?
   1. CMO — C-suite, strategic, board-facing (80 word max)
   2. VP Marketing / Head of Marketing — execution-focused, day-to-day buyer (100 word max)
   3. Founder / CEO (acting CMO) — operator, speed-first (60 word max)
   ```
   Load persona details from agency-personas.md for selected persona.

6. Ask for ICP filter:
   - Industry / vertical (must match ICP.md)
   - Company size range (employees)
   - Geography
   - Specific buying signal to target (required for signal-triggered types, optional for cold)
   - Any additional filters (e.g. recently funded, hiring for specific role)

7. Run list brief (embedded):
   Produce a list brief following GTM:OS `/gtm:list-brief` format:
   - Source recommendation (Apollo / LinkedIn / Crunchbase based on signal type)
   - Filters to apply
   - Target record count (match to inbox send capacity)
   - Required fields: company, contact name, title, email, signal field if applicable
   - Validation criteria from ICP.md

8. Ask for campaign angle:
   ```
   What angle do you want to lead with?
   1. Audit Open — "Ran a quick audit on [channel]. Found [observation]."
   2. Case Study Match — "Worked with [similar company]. They went from X to Y."
   3. Signal Reference — "Saw [trigger]. Usually means [implication]."
   4. Custom — describe your angle
   ```
   Load pitch-frameworks.md for the selected angle.

9. Check case study availability:
   Scan CASE-STUDIES.md for relevant proof points matching:
   - The target vertical
   - The relevant service line
   - The persona type
   If no relevant case study exists: flag the gap before writing. "No case study found for [vertical/service]. Proceeding with available proof points — recommend adding one before launch."

10. Draft sequence:
    Load `../../.claude/gtmos/references/cold-email-skill.md` before writing.

    Write full sequence based on selected campaign type structure:
    - Email touches (subject + body per touch)
    - LinkedIn touches (connection note + message per touch)
    - Angle rotation across touches — no repeated hooks

    Apply persona word limits strictly:
    - CMO: 80 words max (touch 1), 50 words max (follow-ups)
    - VP Marketing: 100 words max (touch 1), 60 words (follow-ups)
    - Founder: 60 words max on every touch

11. Run copy validation — five checks:
    ```
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    COPY VALIDATION
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    [x] ICP fit — targets correct company profile and signals
    [x] Persona fit — language, length, and CTA match selected persona
    [x] Service line fit — only references services in SERVICE-LINES.md
    [x] Voice fit — peer voice, no banned phrases, matches TOV.md
    [x] Client conflict — no existing clients in target segment
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ```
    If any check fails: revise before presenting. Never show a draft that fails its own brief.

12. Write campaign to workspace:
    Save to: `workspaces/{workspace}/campaigns/{campaign-name}/`
    Files: `BRIEFING.md`, `copy/sequence.md`, `campaign.config.md`

13. Suggest next steps:
    ```
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      >> Next: /gtm:list-brief {workspace} {campaign}
         Then: /gtm:enrich {workspace} {campaign}
         Then: /gtm:ship {workspace} {campaign}
         Also: /agency:pitch {workspace} {company} — for interested replies

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ```
</process>
