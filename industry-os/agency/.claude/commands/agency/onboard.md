---
name: agency:onboard
description: First-time setup — onboard the agency into AGENCY:OS, create workspace, populate core files
argument-hint: "<workspace-name>"
---

<objective>
Guide the agency operator through a structured onboarding to create a complete, usable AGENCY:OS workspace. At the end, the agency's identity, service lines, clients, team, and targets should all be in their workspace files.
</objective>

<execution_context>
@./AGENCYOS.md
@./_template/workspace.config.md
@./_template/SERVICE-LINES.md
@./_template/ICP.md
@./_template/PERSONA.md
@./_template/CLIENTS.md
@./_template/PIPELINE.md
@./_template/TEAM.md
@./_template/FINANCE.md
@./_template/PRICING.md
@./_template/CASE-STUDIES.md
@./_template/COMPETITORS.md
@./_template/TOOLS.md
@./_template/ROADMAP.md
@./_template/LEARNINGS.md
@./_template/DELIVERABLES.md
@./_template/BRIEFS.md
</execution_context>

<process>

1. Display AGENCY:OS banner (from AGENCYOS.md).

2. Display header:
```
<< AGENCY:OS // ONBOARDING >>
Let's get your agency set up. This will take 10–20 minutes.
You can stop at any point and continue later with /agency:onboard {workspace}.
```

3. **Resume check:** Before asking anything, check if `workspaces/{workspace-name}/workspace.config.md` exists.
   - If it does: read it. If `onboard_status` is set, display:
     ```
     Resuming onboard for {workspace-name}.
     Last completed: Block {X} — {name}
     Continuing from Block {X+1}.
     ```
     Skip all completed blocks and resume from the next one.
   - If it doesn't exist: proceed with fresh setup.

4. Ask: "Quick setup (5 essential blocks, ~10 min) or Full setup (all blocks, ~20 min)?"

5. Create workspace folder structure at `workspaces/{workspace-name}/`:
   - Copy all files from `_template/` to `workspaces/{workspace-name}/`
   - Create `workspaces/{workspace-name}/clients/` directory
   - Create `workspaces/{workspace-name}/logs/` with `auto-log.md` and `workspace-log.md`
   - Create `workspaces/{workspace-name}/cache/signals/` directory
   - Set `onboard_status: block_1_complete` in workspace.config.md after each block finishes

---

**BLOCK 1 — Agency identity** (both modes)

Ask in one block:
- What is your agency's name?
- What type of agency are you? (performance marketing / creative / full-service / SEO and content / social media / email and lifecycle / specialized — which?)
- Where are you based, and what geographies do you primarily serve?
- How long have you been operating, and how many people are on the team?

Create `workspaces/{workspace-name}/AGENCY.md` with this information.

---

**BLOCK 2 — Service lines** (both modes)

Ask:
- What services do you offer? (List them — be as specific as possible: "Google Ads management" not just "paid media")
- For each service, what is the typical monthly retainer price?
- For each service, what is the key result you deliver? (e.g. "We typically reduce CPL by 20–40% in the first 90 days")

In quick mode: capture names and prices. Note "details to add later" in SERVICE-LINES.md.
In full mode: fill in the full SERVICE-LINES.md structure per service.

---

**BLOCK 3 — Ideal client** (both modes)

Ask:
- What type of company do you work best with? (Industry, company size, growth stage, geography)
- Who is the buyer at that company — what is their title and what do they care about?
- What is the typical trigger or reason a company decides to hire an agency like you?
- Who is NOT a good fit for you?

Fill ICP.md and PERSONA.md with this information.

---

**BLOCK 4 — Current clients** (both modes)

Ask:
- How many active clients do you have right now?
- For each (or the top 5 if many): name, primary service, monthly retainer value, contract end date, health status (Green / Yellow / Red)

Fill CLIENTS.md with active client roster.

For each client: create `workspaces/{workspace-name}/clients/{client-name}/` folder from `_template/clients/_client-template/`.

Ask if there are any prospects currently in the pipeline. Add to PIPELINE.md.

---

**BLOCK 5 — Team** (both modes)

Ask:
- Who is on your team? (Name, role, hours per week available)
- Are there any freelancers you work with regularly? (Name, specialty, availability)

Fill TEAM.md with roster and capacity.

---

**BLOCK 6 — Finance** (full mode only)

Ask:
- What is your current total MRR?
- When do you invoice each client (1st of month / project milestones)?
- What are your MRR targets for this quarter and this year?

Fill FINANCE.md MRR snapshot and ROADMAP.md quarterly targets.

---

**BLOCK 7 — Tools** (full mode only)

Ask:
- What tools are you currently using? (CRM, project management, design, analytics, email, social scheduling)
- Do you have any outbound tools set up? (Apollo for prospecting / Instantly or Lemlist for sending / Crispy for LinkedIn)

Fill TOOLS.md. If outbound tools confirmed: note in workspace.config.md that optional GTM:OS tool references are available.

---

**BLOCK 8 — Competitors** (full mode only)

Ask:
- Who are the agencies you compete with most often?
- What is your differentiation — why do clients choose you over them?

Fill COMPETITORS.md.

---

**BLOCK 9 — Execution mode** (full mode only)

Ask:
- Execution mode: Interactive (approval at every decision) or Auto (auto-approves drafts and research, stops at hard gates)?
- Collaboration mode: Solo (just you) or Team (multiple operators)?

Set in workspace.config.md.

---

**After all blocks complete:**

6. Display completion message:
```
┌─ ONBOARDING COMPLETE ─────────────────────────────────────────┐
│                                                               │
│  Workspace: {workspace name}                                  │
│  Clients loaded: {count}                                      │
│  Service lines: {list}                                        │
│  Team: {count} members                                        │
│  MRR: ${X}                                                    │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

   Set `onboard_status: complete` in workspace.config.md.

7. Suggest first actions based on what was entered:
- Always: `/agency:today {workspace}` — see what needs attention first
- If active deliverables mentioned: `/agency:deliver {workspace}` — set up your deliverables tracker
- If no pipeline: `/agency:new-business {workspace}` — start building new business pipeline
- If pipeline has prospects: `/agency:signals {workspace}` — scan for buying signals on existing prospects
- If any client health flagged as Yellow or Red: `/agency:qbr-prep {workspace} {client}`
- If new client just signed: `/agency:client-onboard {workspace} {client}`

</process>
