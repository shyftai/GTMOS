# Global Suppression — GTM:OS

This file applies across ALL workspaces in this repo. Any contact or company listed here is blocked from being contacted regardless of which workspace or campaign is running.

Use it for: contacts who have unsubscribed at the account level (not specific to one workspace), legal hold contacts, contacts who have made erasure requests, or any person that should never be reached by any campaign you run.

**Checked by:** `/gtm:ship`, `/gtm:validate-list`, `/gtm:preflight`

**Updated by:** `/gtm:compliance --erase`, `/gtm:replies` (on global unsubscribe), `/gtm:onboard` (manual addition during setup)

---

## Global do-not-contact — contacts

| Email | Name | Company | Date added | Reason | Added by |
|-------|------|---------|------------|--------|----------|
| | | | | erasure-request / global-unsubscribe / legal-hold / manual | |

---

## Global do-not-contact — companies

All contacts at these domains are blocked across every workspace.

| Domain | Company name | Date added | Reason | Added by |
|--------|-------------|------------|--------|----------|
| | | | competitor / legal / global-manual | |

---

## Usage rules

1. **All workspaces check this file before shipping** — in addition to their own SUPPRESSION.md
2. **Additions propagate up** — if a contact requests global removal, add them here AND to the workspace SUPPRESSION.md
3. **Never remove entries** — suppression is permanent. If an entry was added in error, add a note column but do not delete the row.
4. **Privacy** — treat this file like the workspace suppression lists: never display match counts or contact details in ship output. Only report pass/fail.
5. **Team mode** — in team mode, sync this file to the `global_suppression` table in Supabase. It becomes the authoritative cross-workspace source.
