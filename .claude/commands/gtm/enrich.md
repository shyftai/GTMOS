---
name: gtm:enrich
description: Run waterfall enrichment on a list — email, phone, people, or company data
argument-hint: "<workspace-name> <type> [file-path]"
---
<objective>
Run cascading enrichment on a list of contacts or companies. Try the cheapest source first, fall to the next on misses. Track hit rates and costs.

Workspace, enrichment type, and optional file: $ARGUMENTS

Types: email | phone | people | company | people-search | company-search | full
</objective>

<execution_context>
@./.claude/gtmos/references/enrichment-waterfall.md
@./.claude/gtmos/references/api-reference.md
@./.claude/gtmos/references/tool-pricing.md
@./.claude/gtmos/references/csv-format.md
@./.claude/gtmos/references/ui-brand.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // ENRICHMENT >>`
2. Load workspace context — TOOLS.md, RULES.md, COSTS.md
3. Check .env for available API keys — determine which waterfall sources are active

## Determine enrichment type

4. If type not specified in $ARGUMENTS, ask:
```
  What do you need to enrich?

  Data enrichment (have contacts, need more data):
    email          Find + verify business emails
    phone          Find direct dial phone numbers
    people         Enrich known people (title, seniority, location)
    company        Enrich known companies (industry, size, funding, tech)
    full           Run all of the above in sequence

  Search (find new contacts/companies):
    people-search  Find people matching ICP criteria
    company-search Find companies matching ICP firmographics

  >> Which type?
```

## Load and analyze the list

5. If file path provided, load the list. If not, check lists/validated/ and lists/cleaned/ for the most recent file.
6. Analyze what data is present and what's missing:

```
  ┌─ LIST ANALYSIS ─────────────────────────────┐
  │                                               │
  │  Records:           247                       │
  │                                               │
  │  Data coverage:                               │
  │    Name:            247/247  (100%)           │
  │    Company:         247/247  (100%)           │
  │    Title:           198/247  (80%)            │
  │    Email:           120/247  (49%)  ← enrich  │
  │    Phone:            0/247   (0%)             │
  │    LinkedIn:        203/247  (82%)            │
  │    Industry:        185/247  (75%)            │
  │    Company size:    162/247  (66%)            │
  │                                               │
  └───────────────────────────────────────────────┘
```

7. If type is `full`, suggest which enrichment types to run based on gaps.

## Check waterfall overrides

8. Check workspace RULES.md for `## Enrichment waterfall overrides`
   - If found, use custom order and settings
   - If not found, use defaults from enrichment-waterfall.md

9. Check which sources are available (active in TOOLS.md + key in .env)
   - Remove unavailable sources from the waterfall
   - If no sources available for this enrichment type, stop and tell the user what keys are needed

## Show enrichment plan

10. Display the plan with estimated costs:

```
  ┌─ ENRICHMENT PLAN ───────────────────────────┐
  │                                               │
  │  Type:      Email enrichment                  │
  │  Contacts:  127 missing emails                │
  │                                               │
  │  Waterfall:                                   │
  │    1. Apollo        (1 credit/ea)    ~$6.35   │
  │    2. Icypeas       (1 credit/ea)    fallback │
  │    3. Prospeo       (1 credit/ea)    fallback │
  │    4. Verify: ZeroBounce             ~$1.02   │
  │    5. Catch-all: Scrubby             if needed│
  │                                               │
  │  Est. max cost:  $12.70                       │
  │  Budget remaining: $187.30                    │
  │                                               │
  └───────────────────────────────────────────────┘
  >> Proceed? (y/n)
```

11. For phone enrichment, check lead scores first:
    - Default: only enrich phone for lead_score >= 80 (A-tier)
    - Check RULES.md for custom threshold
    - Display how many contacts qualify

## Execute the waterfall

12. Process in batches of 50 contacts per API call
13. For each source in the waterfall:
    a. Send only contacts that are still missing data (not all contacts)
    b. Apply credit behaviour from TOOLS.md (confirm/auto/threshold)
    c. Log each API call in COSTS.md
    d. Report progress after each source:

```
  ── ENRICHMENT PROGRESS ─────────────────────────
  Apollo:     94/127 found  (74%)    94 credits
  Icypeas:    21/33 found   (64%)    21 credits
  Prospeo:    8/12 found    (67%)    8 credits
  Not found:  4 contacts — no email from any source
  ────────────────────────────────────────────────
```

14. For email enrichment — after finding emails, run verification:
    a. ZeroBounce first (or MillionVerifier if ZeroBounce unavailable)
    b. If result is catch-all → run through Scrubby
    c. If Scrubby says risky → flag contact, do not ship
    d. Remove invalid emails from the list

15. For phone enrichment — flag contacts where only a landline/switchboard was found

## Results

16. Display final enrichment results:

```
  ┌─ ENRICHMENT COMPLETE ───────────────────────┐
  │                                               │
  │  Contacts enriched:  123/127  (97%)           │
  │  Not found:          4                        │
  │                                               │
  │  Source breakdown:                             │
  │    Apollo:    94  (76%)     $4.70              │
  │    Icypeas:   21  (17%)     $0.84              │
  │    Prospeo:    8  (7%)      $0.32              │
  │                                               │
  │  Verification:                                │
  │    Valid:      118                             │
  │    Catch-all:   3  (Scrubby: 2 ok, 1 risky)  │
  │    Invalid:     2  (removed)                  │
  │                                               │
  │  Total cost:  $7.12                           │
  │                                               │
  └───────────────────────────────────────────────┘
```

17. Update COSTS.md with actual spend per tool
18. Update enrichment hit rate tracker in TOOLS.md
19. Save enriched list to lists/validated/ (or update in place if already there)
20. Log enrichment decisions in campaign logs/decisions.md

## If type is `full`

Run enrichment types in this order:
1. Company enrichment (cheapest — Apollo org enrich is free)
2. People enrichment (fills title, seniority gaps)
3. Email enrichment (find + verify)
4. Phone enrichment (most expensive — only A-tier leads)

Show a combined summary at the end.

## Next actions

21. Suggest next step:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  >> Next: /gtm:validate-list {workspace} — score and validate the enriched list
     Also: /gtm:write {workspace} — draft outbound sequence

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
</process>
