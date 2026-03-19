---
name: agency:brief
description: Create a project or campaign brief for a client — structured intake that produces a complete, work-ready brief
argument-hint: "<workspace-name> <client-name> [brief-type]"
---

<objective>
Guide the creation of a complete, validated project brief for a specific client. At the end, a brief is written to the client's DELIVERABLES.md, indexed in BRIEFS.md, and ready to assign to the team.
</objective>

<execution_context>
@./AGENCYOS.md
@./references/brief-templates.md
@./references/delivery-standards.md
@./_template/clients/_client-template/CLIENT-BRIEF.md
</execution_context>

<process>

1. Display header:
```
<< AGENCY:OS // BRIEF >>
Client: {client-name}
```

2. Load `clients/{client-name}/CLIENT-BRIEF.md` and `clients/{client-name}/SOW.md`.

3. If brief-type not provided in the command argument, ask:
   "What type of brief is this?"
   - Campaign (paid search, paid social, email, outbound)
   - Content (SEO article, blog post, website copy)
   - Ad Creative (static ads, video scripts, creative concepts)
   - Report (weekly update, monthly report, QBR deck)
   - Project (strategy doc, audit, onboarding deliverable)
   - Other

4. Load the matching template from `references/brief-templates.md`.

5. Ask brief context in one block:
   - What is this for? (Brief description of the deliverable)
   - What is the goal? What metric does this need to move?
   - What is the deadline for the finished, approved deliverable?
   - Who on the client side will approve this?
   - Any specific constraints, angles, or things to avoid?

6. Pre-fill known fields from CLIENT-BRIEF.md: audience, budget, goals, communication contacts, constraints.

7. Walk through any remaining required fields from the brief template that have not been answered. Ask only for what is genuinely missing.

8. Run the brief quality gate — a brief is not valid without:
   - [ ] Goal with a metric
   - [ ] Audience defined
   - [ ] Deadline confirmed
   - [ ] Approval contact named
   - [ ] Scope clear (inclusions and exclusions)

   If any are missing: flag the specific gap and ask before proceeding. Do not create a brief with incomplete mandatory fields.

9. Generate the complete brief using the template from brief-templates.md, filled with the information gathered.

10. Show the brief to the user and ask: "Does this look right? Any changes before I save it?"

11. After confirmation:
    - Write the brief to `clients/{client-name}/DELIVERABLES.md` as a new active item with status "In Progress"
    - Add to `BRIEFS.md` index with client, type, owner (if assigned), status, and due date

12. Suggest next steps:
    - If this is a new engagement without an SOW: `/agency:sow {workspace} {client-name}` — formalize the scope
    - If the scope is already agreed: "Brief is ready. Assign to your team and track progress via `/agency:deliver {workspace} {client-name}`."

</process>
