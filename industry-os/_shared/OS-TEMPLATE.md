# [INDUSTRY]:OS Template

Template for building industry-specific operating systems on top of GTM:OS. AGENCY:OS was built using this template — it's the reference implementation.

---

## What an industry OS is

An industry OS is a vertical context layer that sits on top of GTM:OS. It adds:

- Industry-specific ICP and buyer personas (pre-filled, not blank)
- Buying signals relevant to that industry
- Objection playbook for common pushbacks in that vertical
- Campaign types that work in that specific sales context
- Any industry-specific workflows beyond standard outbound (e.g. retention, proposals, RFPs)

**What it is NOT:** A replacement for GTM:OS. All execution happens through GTM:OS commands. The industry OS is the context layer that makes those commands more targeted and more effective.

---

## What to inherit from GTM:OS (do not recreate)

These exist in GTM:OS and should be referenced, not duplicated:

- All GTM:OS commands (`/gtm:*`)
- All reference files in `.claude/gtmos/references/`
  - `cold-email-skill.md` — copy writing principles
  - `enrichment-waterfall.md` — data enrichment logic
  - `lead-scoring.md` — ICP scoring
  - `campaign-types.md` — base campaign templates
  - `sending-calendar.md` — holiday blackouts
  - `report-template.md` — reporting formats
  - `ui-brand.md` — visual standards
  - `scrape-cache.md` — API caching rules
  - `tool-pricing.md` — per-unit costs
  - `defaults.md` — sensible defaults
- `RULES-GLOBAL.md` — compliance framework
- Sending infrastructure and campaign management
- Enrichment waterfall and data layer
- Attribution and reporting

Reference these with relative paths: `../../.claude/gtmos/references/`

---

## What to customise per industry

### 1. Define the primary buying context

Answer these questions before building the industry OS:

- **Who is the customer?** What kind of company buys this offering?
- **Who is the buyer?** Job title(s), seniority level, what they care about
- **What do they buy?** Service lines, products, offerings — what the industry OS is selling
- **What are the buying signals?** Events, triggers, contexts that indicate readiness
- **What are the objections?** Common reasons they say no
- **What is the sales cycle?** Length, stakeholders, typical process
- **What are the campaign types?** How does outreach actually work in this vertical?

### 2. Replace all [INDUSTRY] placeholders

- `[INDUSTRY]:OS` → e.g. `RECRUITER:OS`, `SAAS:OS`, `PROPERTY:OS`
- `[INDUSTRY]OS.md` → the core system definition file
- All banner ASCII art
- All persona names and descriptions
- All campaign type names

### 3. Pre-fill workspace templates with industry defaults

The _template/ folder should feel ready to use, not blank. Pre-fill:
- `ICP.md` — with typical company profiles in this industry
- `PERSONA.md` — with real buyer personas for this industry
- `TOV.md` — with industry-appropriate tone defaults
- `SERVICE-LINES.md` — with typical offerings sold in this context
- `PIPELINE.md` — with industry-appropriate pipeline stages

The goal: a new user should be able to deploy the industry OS and start without a blank page.

---

## File structure to create

Copy AGENCY:OS structure exactly. Replace all content with industry-specific equivalents.

```
industry-os/[industry]/
├── [INDUSTRY]OS.md              Core system definition
├── CLAUDE.md                    Startup instructions for Claude
├── README.md                    Public docs
├── _template/                   Workspace scaffolding
│   ├── ICP.md
│   ├── PERSONA.md
│   ├── TOV.md
│   ├── RULES.md
│   ├── TOOLS.md
│   ├── SERVICE-LINES.md         (or equivalent: PRODUCTS.md, PACKAGES.md)
│   ├── CASE-STUDIES.md          (or equivalent: CASE-STUDIES.md, PORTFOLIO.md)
│   ├── PRICING.md
│   ├── CLIENTS.md               (or ACCOUNTS.md, PROSPECTS.md)
│   ├── PIPELINE.md
│   ├── COMPETITORS.md
│   ├── COSTS.md
│   ├── SUPPRESSION.md
│   ├── INFRASTRUCTURE.md
│   ├── SCRAPE-JOURNAL.md
│   └── workspace.config.md
├── references/
│   ├── [industry]-campaigns.md  Industry campaign types
│   ├── [industry]-personas.md   Buyer persona profiles
│   ├── [industry]-signals.md    Buying signals
│   ├── [industry]-objections.md Objection handling
│   ├── [industry]-benchmarks.md Industry benchmarks
│   └── [any additional industry-specific references]
└── .claude/commands/[industry]/
    ├── [primary-command].md
    ├── [secondary-command].md
    └── [tertiary-command].md
```

---

## How to build a new industry OS

### Step 1: Define the industry context

Before creating any files, answer:
1. What is the industry name? (e.g. "recruiter", "property", "saas")
2. What does a user of this OS sell or do?
3. Who are the top 2–3 buyer personas?
4. What are the top 5 buying signals?
5. What are the top 5 objections?
6. What campaigns are most effective?
7. What workflows (beyond outbound) does this industry need?

### Step 2: Copy AGENCY:OS structure

```bash
cp -r industry-os/agency/ industry-os/[industry]/
```

Then replace all content — do not edit the structure.

### Step 3: Rewrite the core files

Priority order:
1. `[INDUSTRY]OS.md` — the core system definition. Model after AGENCYOS.md.
2. `CLAUDE.md` — startup instructions. Model after agency/CLAUDE.md.
3. `references/[industry]-personas.md` — the buyer profiles
4. `_template/ICP.md` — the pre-filled ICP
5. `_template/PERSONA.md` — workspace-level persona summary
6. `references/[industry]-campaigns.md` — campaign types
7. `references/[industry]-signals.md` — buying signals
8. `references/[industry]-objections.md` — objection playbook
9. Remaining _template/ files
10. Command files in `.claude/commands/[industry]/`

### Step 4: Test the context

Before deploying:
- Can you load the industry OS and get a useful system status display?
- Does the ICP.md feel pre-filled and useful without customisation?
- Are there at least 3 campaign types defined?
- Are there at least 3 objections handled?
- Are there at least 2–3 buyer personas with copy guidance?

### Step 5: Add to OS-level navigation

Update `industry-os/_shared/INDEX.md` (create if not exists) with the new OS.

---

## Naming conventions

| File | Pattern | Example |
|------|---------|---------|
| Core definition | `[INDUSTRY]OS.md` | `RECRUITEROS.md` |
| Reference files | `[industry]-[topic].md` | `recruiter-signals.md` |
| Commands | `[industry]:[action]` | `recruiter:outreach` |
| Template files | Same names as GTM:OS + agency | `ICP.md`, `CLIENTS.md` |

---

## Quality bar

An industry OS is ready to ship when:

- [ ] Banner and system status display works
- [ ] Startup sequence loads all relevant workspace files
- [ ] ICP.md is pre-filled with real, useful defaults (not blank)
- [ ] PERSONA.md has detailed profiles with copy guidance
- [ ] At least 5 campaign types defined with sequences
- [ ] At least 5 buying signals with detection methods
- [ ] All 6 core objections handled with rebuttals
- [ ] Industry benchmarks available
- [ ] At least 4 commands defined
- [ ] Hard gates defined (industry-specific + GTM:OS inherited)
- [ ] README.md explains the value and quick start

---

## Available industry OSes

| OS | Status | Vertical | Primary buyer |
|----|--------|---------|---------------|
| AGENCY:OS | v1.0.0 — live | Marketing/creative/digital agencies | CMO, VP Marketing, Founder |
| ECOMMERCE:OS | v1.0.0 — live | DTC and ecommerce brands | DTC Founder, Head of Ecommerce, Performance Marketing Manager |
