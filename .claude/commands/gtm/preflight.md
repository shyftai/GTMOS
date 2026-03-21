---
name: gtm:preflight
description: Validate workspace readiness before launching a campaign — catches gaps before you're at the ship stage
argument-hint: "<workspace-name> [campaign-name]"
---
<objective>
Run a full workspace and campaign health check. Surfaces missing files, blank required fields, disconnected tools, and compliance gaps before you reach the ship gate. Safe to run at any time — read-only, no changes made.

Workspace and optional campaign: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/defaults.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // PREFLIGHT >>`
2. Load workspace context — all workspace-level files

## Workspace checks

3. Check each required file exists and is filled in (not just headers):

**Identity files:**
- [ ] ICP.md — has target industry, company size, titles, and disqualifiers filled in
- [ ] PERSONA.md — has at least one persona with pain points and objections
- [ ] TOV.md — has tone rules and banned phrases defined
- [ ] RULES.md — has rejection criteria and scoring rubric set

**Operations files:**
- [ ] TOOLS.md — at least one tool is marked `active` (not just listed)
- [ ] COSTS.md — budget is set (monthly or per-campaign)
- [ ] INFRASTRUCTURE.md — at least one outbound domain and inbox configured
- [ ] SUPPRESSION.md — physical address is filled in; suppression list table exists

**Config files:**
- [ ] workspace.config.md — Name, Role, Mode, and Execution mode are set
- [ ] WORKFLOW.md — Approval chain roles are defined
- [ ] .env — exists at repo root

4. Check API keys in .env for tools marked `active` in TOOLS.md:
   - For each active tool: verify its API key environment variable is present and non-empty
   - Flag missing keys by name

5. Check infrastructure:
   - INFRASTRUCTURE.md: are domains listed? SPF/DKIM/DMARC checked?
   - INFRASTRUCTURE.md: are inboxes listed? Warmup status set?
   - If warmup status is unknown: flag — you can't ship cold

6. Check context:
   - context/INDEX.md — is it populated (not empty)?
   - context/BRIEF.md — does it exist? (useful but not blocking)
   - LEARNINGS.md — any learnings logged? (informational — not blocking)

7. Display preflight results — group by severity. Only show WARNING and INFO sections if they have items:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  PREFLIGHT — {workspace}                                   ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                            ┃
┃  BLOCKING — must fix before campaign can ship              ┃
┃  [!] TOV.md — tone rules missing (only has header)         ┃
┃  [!] COSTS.md — no budget set                              ┃
┃  [!] SUPPRESSION.md — physical address not filled in       ┃
┃  [!] LEMLIST_API_KEY — missing                             ┃
┃                                                            ┃
┃  WARNING — suboptimal, won't block                         ┃
┃  [~] WORKFLOW.md — approval chain not defined              ┃
┃                                                            ┃
┃  OK                                                        ┃
┃  [x] ICP.md — complete                                     ┃
┃  [x] PERSONA.md — 2 personas defined                       ┃
┃  [x] RULES.md — scoring rubric set                         ┃
┃  [x] TOOLS.md — 3 active tools                             ┃
┃  [x] INFRASTRUCTURE.md — 2 inboxes, warmup active          ┃
┃  [x] APOLLO_API_KEY — present                              ┃
┃  [x] INSTANTLY_API_KEY — present                           ┃
┃  [x] workspace.config.md — fully configured                ┃
┃  [x] .env — exists                                         ┃
┃                                                            ┃
┃  Status: 4 blocking — not campaign-ready                   ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

INFO items (context/INDEX.md empty, LEARNINGS.md absent, etc.) are **not shown in the main display** — they are informational only and add noise when grouped with actionable issues. Surface them only if all blocking/warning items are resolved.

8. Classify each issue:
   - `[!] BLOCKING` — will prevent a campaign from running or shipping safely
   - `[~] WARNING` — suboptimal but won't block — surface to user to decide
   - INFO — missing but not needed yet — do not display unless no blocking/warning items remain

## Campaign checks (if campaign-name provided)

9. If a campaign was specified, also check:

**Campaign files:**
- [ ] BRIEFING.md — offer, angle, and CTA defined (not just headers)
- [ ] campaign.config.md — sending tool, inboxes, timeline set
- [ ] PERSONALIZATION.md — merge fields defined and match what's in copy drafts
- [ ] AB-TESTS.md — if A/B test is configured, variants are complete

**Lists:**
- [ ] lists/validated/ — at least one validated list file present
- [ ] No records in the validated list that are on the suppression list
- [ ] List is not expired — check `valid_until` column in validated list file. If today > valid_until: flag `[!] BLOCKING — validated list expired on {date}. Re-run /gtm:validate-list before shipping.`
- [ ] Account suppression — check contact domains against `## Do not contact — companies` in SUPPRESSION.md

**Copy:**
- [ ] copy/approved/ — at least one approved sequence present
- [ ] Physical address appears in sequence footer
- [ ] Unsubscribe language present
- [ ] Approval marker present — each file in copy/approved/ must contain `<!-- approved:` marker. If missing: flag `[!] BLOCKING — approved copy is missing its approval marker. Re-approve via /gtm:write.`
- [ ] Copy integrity — check that approved copy files have not been modified after their approval timestamp. If `Last modified` > approval timestamp in the marker: flag `[~] WARNING — approved copy has been edited since approval. Re-approve before shipping.`

10. Add campaign results to the preflight display with a campaign section:
```
┃  Campaign: {name}                                          ┃
┃  [x] BRIEFING.md — angle and CTA defined                  ┃
┃  [!] PERSONALIZATION.md — {{company}} used in copy but    ┃
┃      not listed in PERSONALIZATION.md                      ┃
┃  [x] Validated list present — 247 contacts                 ┃
┃  [x] Copy approved — 4 touches                            ┃
┃  [!] Physical address missing from Touch 1 footer          ┃
```

## Summary and next steps

11. Show a prioritized fix list:
```
  Fix these before you can ship:
  1. Fill in TOV.md tone rules — /gtm:onboard can help, or edit directly
  2. Set campaign budget in COSTS.md
  3. Add physical address to SUPPRESSION.md
  4. Add LEMLIST_API_KEY to .env

  When done, run /gtm:preflight again to confirm, then /gtm:ship.
```

12. If everything passes:
```
  ✓ Workspace is campaign-ready.
  Run /gtm:ship {workspace} {campaign} when you're ready to go.
```
</process>
