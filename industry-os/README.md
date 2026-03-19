# Industry OS

Industry OSes are vertical operating systems built on the same architecture as GTM:OS. Each one gives you a complete operating layer for running a specific type of business — with its own startup sequence, workspace structure, commands, and references tailored to that industry's workflows.

---

## What an Industry OS is

A standard GTM:OS workspace covers outbound prospecting, campaign execution, and pipeline management. An Industry OS adds the full operational context on top of that — delivery, client management, financial tracking, retention, and everything specific to how that industry operates.

Industry OSes are **standalone**. They do not require GTM:OS to run. GTM:OS tools (Apollo, Crispy, Instantly) are available as optional integrations for outbound work, but every workflow runs without them.

---

## Available Industry OSes

| OS | Version | Three-loop model | Commands | Directory |
|----|---------|-----------------|----------|-----------|
| **AGENCY:OS** | v2.0.0 | Win / Deliver / Retain | 20 (`/agency:*`) | `industry-os/agency/` |
| **ECOMMERCE:OS** | v1.0.0 | Acquire / Convert / Retain | 14 (`/ecom:*`) | `industry-os/ecommerce/` |

---

## Quick start

1. Navigate to the OS directory:
   ```
   cd industry-os/agency/       # for AGENCY:OS
   cd industry-os/ecommerce/    # for ECOMMERCE:OS
   ```

2. Run onboarding:
   ```
   /agency:onboard {workspace-name}
   /ecom:onboard {workspace-name}
   ```

3. Start your daily session:
   ```
   /agency:today {workspace-name}
   /ecom:today {workspace-name}
   ```

Onboarding can be stopped and resumed at any time — progress is saved after each block.

---

## How Industry OSes work

Each OS has the same structural components:

| Component | What it does |
|-----------|-------------|
| `{OS}.md` | Core system definition — loops, hard gates, circuit breakers, quality gates, startup sequence |
| `CLAUDE.md` | Startup instructions — role, references, rules |
| `_template/` | Workspace scaffolding — copied to `workspaces/{name}/` on onboard |
| `references/` | Knowledge library — loaded on demand by commands |
| `.claude/commands/{prefix}/` | All slash commands for this OS |
| `workspaces/{name}/` | Your live workspace — all data files live here |

---

## Shared architecture

All Industry OSes share these mechanisms:

- **Execution modes** — Interactive (approval at every gate) or Auto (auto-approves drafts; hard gates always require approval)
- **Hard gates** — Non-negotiable stops before high-risk actions (sending, invoicing, marking deliverables complete, launching OOS products)
- **Circuit breakers** — Auto mode safety valves that halt and ask when thresholds are exceeded (API calls, records modified, spend)
- **LEARNINGS.md** — Persistent memory loaded every session; updated after every significant event
- **ROADMAP.md** — Strategic growth plan; updated when health checks surface strategic implications
- **Quality gates** — Pre-output checklists run before every campaign, deliverable, or client communication
- **SCRAPE-JOURNAL.md** — Audit trail for every API call
- **COSTS.md** — Every tool spend logged, no exceptions

---

## Adding a new Industry OS

Use `_shared/OS-TEMPLATE.md` as the starting point. It defines the required structure and mechanisms every OS must implement to be consistent with this architecture.

Planned: REALESTATE:OS, SAAS:OS
