---
name: gtm:ship
description: Ship approved list and sequence to the sending tool
argument-hint: "<workspace-name> <campaign-name>"
---
<objective>
Push the approved list and sequence to the configured sending tool. Run final pre-flight checks before shipping.

Workspace and campaign: $ARGUMENTS
</objective>

<execution_context>
@./commands/validate-copy.md
@./commands/validate-list.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/collaboration.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // SHIP >>`
2. Load workspace context — TOOLS.md, INFRASTRUCTURE.md, SUPPRESSION.md, MULTICHANNEL.md, COSTS.md
3. Load campaign context — campaign.config.md, BRIEFING.md, AB-TESTS.md
4. Load sending calendar — `.claude/gtmos/references/sending-calendar.md`
5. Check send date against each contact's country — flag any contacts whose send date falls on a local holiday
4. Identify the sending tool from campaign.config.md (Lemlist / Instantly / Smartlead / Crispy)
5. Identify assigned inboxes from campaign.config.md

## Pre-flight checklist
Run and display all checks before shipping:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  PRE-FLIGHT — {campaign}                   ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                            ┃
┃  List                                      ┃
┃  [x] Validated list exists in lists/validated/
┃  [x] Suppression list checked — 0 matches  ┃
┃  [x] No duplicates against other campaigns ┃
┃  [x] All emails verified                   ┃
┃  [x] Record count: {n}                     ┃
┃                                            ┃
┃  Copy                                      ┃
┃  [x] Approved sequence in copy/approved/   ┃
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
┃  Compliance                                ┃
┃  [x] Physical address set                  ┃
┃  [x] Unsubscribe mechanism active          ┃
┃  [x] GDPR basis documented                 ┃
┃                                            ┃
┃  Budget                                    ┃
┃  [x] Estimated cost: {n} x {rate} = {total}┃
┃  [x] Within campaign budget                ┃
┃                                            ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

6. If ANY check fails, stop and show what needs fixing — do not ship
7. If all checks pass, show the shipping summary:
   - Tool: {sending tool}
   - Contacts: {count}
   - Sequence: {touch count} touches over {days} days
   - Inboxes: {list}
   - Send window: {times}
   - Estimated daily volume: {n} per inbox
   - Estimated cost: {amount}

8. Display approval gate:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  APPROVE TO SHIP?                          ┃
┃  This will push {n} contacts and {n}-touch ┃
┃  sequence to {tool}.                       ┃
┃                                            ┃
┃  >> approve / reject / edit                ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

9. On approval:
   - Push contacts to sending tool
   - Push sequence to sending tool
   - Configure send timing and inbox rotation
   - Apply credit behaviour from TOOLS.md
   - Log cost transaction in COSTS.md
   - Update campaign.config.md status to "active"
   - Update PIPELINE.md — move all contacts to "Contacted" stage
   - Log ship event in logs/decisions.md
   - Copy shipped list to lists/shipped/

10. Display confirmation and suggest next actions:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Shipped. {n} contacts, {n} touches via {tool}.

  >> Next: /gtm:health {workspace} {campaign}
     Also: /gtm:replies {workspace}
     Also: /gtm:signals {workspace}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
