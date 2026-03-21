---
name: gtm:ship
description: Ship approved list and sequence to the sending tool
argument-hint: "<workspace-name> <campaign-name>"
---
<objective>
Push the approved list and sequence to the configured sending tool. Run final launch check before shipping.

Workspace and campaign: $ARGUMENTS
</objective>

<execution_context>
@./commands/validate-copy.md
@./commands/validate-list.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/collaboration.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // SHIP >>`
2. Load workspace context — TOOLS.md, INFRASTRUCTURE.md, SUPPRESSION.md, MULTICHANNEL.md, COSTS.md
3. Load campaign context — campaign.config.md, BRIEFING.md, AB-TESTS.md
4. Load compliance config — SUPPRESSION.md `## Active regulations` — determine which regulation checks apply
5. Load sending calendar — `.claude/gtmos/references/sending-calendar.md`
6. Check send date against each contact's country — flag any contacts whose send date falls on a local holiday
7. Identify the sending tool from campaign.config.md (Lemlist / Instantly / Smartlead / Crispy)
8. Identify assigned inboxes from campaign.config.md

## Launch check
Run and display all checks before shipping:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  LAUNCH CHECK — {campaign}                 ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                            ┃
┃  List                                      ┃
┃  [x] Validated list exists in lists/validated/
┃  [x] Suppression check passed (workspace)  ┃
┃  [x] Suppression check passed (global)     ┃
┃  [x] Account suppression passed            ┃
┃  [x] List not expired — valid until {date} ┃
┃  [x] No duplicates against other campaigns ┃
┃  [x] All emails verified                   ┃
┃  [x] Record count: {n}                     ┃
┃                                            ┃
┃  Copy                                      ┃
┃  [x] Approved sequence in copy/approved/   ┃
┃  [x] Approval marker present               ┃
┃  [x] Copy integrity verified (not edited   ┃
┃      since approval)                       ┃
┃  [x] Five-check validation passed          ┃
┃  [x] Personalization variables valid        ┃
┃  [x] Booking link set: {url}               ┃
┃  [x] Unsubscribe link present              ┃
┃  [x] Physical address in footer            ┃
┃                                            ┃
┃  Infrastructure                            ┃
┃  [x] Assigned inboxes: {list}              ┃
┃  [x] All inboxes warmed and live           ┃
┃  [x] DNS auth complete on all domains      ┃
┃  [x] Daily volume within limits            ┃
┃  [x] Send timing configured                ┃
┃                                            ┃
┃  Calendar                                  ┃
┃  [x] No holiday conflicts for send date    ┃
┃  [x] {n} contacts paused for local holiday ┃
┃                                            ┃
┃  Compliance (if enabled)                   ┃
┃  [--] Skipped — no regulations active      ┃
┃  OR (if regulations are ON):               ┃
┃  [x] Active regulations loaded from        ┃
┃      SUPPRESSION.md                        ┃
┃  [x] Physical address set                  ┃
┃  [x] Unsubscribe mechanism active          ┃
┃  If CAN-SPAM: [x] From/Reply-to accurate  ┃
┃  If GDPR: [x] Legitimate interest documented┃
┃  If CASL: [x] Consent recorded per contact ┃
┃                                            ┃
┃  Budget                                    ┃
┃  [x] Estimated cost: {n} x {rate} = {total}┃
┃  [x] Within campaign budget                ┃
┃                                            ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

9. If ANY check fails, stop and show what needs fixing — do not ship
10. If all checks pass, show the shipping summary:
   - Tool: {sending tool}
   - Contacts: {count}
   - Sequence: {touch count} touches over {days} days
   - Inboxes: {list}
   - Send window: {times}
   - Estimated daily volume: {n} per inbox
   - Estimated cost: {amount}

11. Display approval gate (HARD GATE — always stops, even in auto mode):
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  APPROVE TO SHIP?                          ┃
┃  This will push {n} contacts and {n}-touch ┃
┃  sequence to {tool}.                       ┃
┃                                            ┃
┃  >> approve / reject / edit                ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

   **On reject:** Stop. Do not ship. Show a plain message:
   ```
   Ship cancelled. Nothing was sent.

   If you want to make changes:
     Edit copy   → /gtm:write {workspace} {campaign}
     Edit list   → /gtm:validate-list {workspace}
     Check infra → /gtm:preflight {workspace} {campaign}

   Re-run /gtm:ship when ready.
   ```

   **On edit:** Ask what to edit:
   ```
   What needs changing?
     copy    → opens /gtm:write
     list    → opens /gtm:validate-list
     config  → edit campaign.config.md directly
   >>
   ```
   Route to the relevant command. Return to ship when done.

12. On approval:
   - Push contacts to sending tool
   - Push sequence to sending tool
   - Configure send timing and inbox rotation
   - Apply credit behaviour from TOOLS.md
   - Log cost transaction in COSTS.md
   - Update campaign.config.md status to "active"
   - Update PIPELINE.md — move all contacts to "Contacted" stage
   - Log ship event in logs/decisions.md
   - Copy shipped list to lists/shipped/ — add these columns to the shipped CSV:
     - `shipped_at`: ISO datetime of this ship action
     - `sequence_name`: name of the approved sequence used
     - `legitimate_interest_basis`: value from SUPPRESSION.md `## Legitimate interest documentation` — required for GDPR compliance audit. If GDPR is OFF, write "N/A". If GDPR is ON and basis is not documented, block ship.

13. Display confirmation and suggest next actions:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Shipped. {n} contacts, {n} touches via {tool}.

  >> Next: /gtm:health {workspace} {campaign}
     Also: /gtm:replies {workspace}
     Also: /gtm:signals {workspace}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
