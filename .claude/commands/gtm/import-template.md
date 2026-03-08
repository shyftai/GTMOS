---
name: gtm:import-template
description: Import a sequence template from a file, URL, or paste
argument-hint: "[file-path | URL | --paste]"
---
<objective>
Import a sequence template from an external source — a file, a URL, or pasted text. Parse it into GTM:OS template format, validate, and save to global/templates/.

Source: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/cold-email-skill.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // IMPORT TEMPLATE >>`

## Input sources
2. Determine input source from $ARGUMENTS:

**File path** — read the file directly
- Supports: .md, .txt, .csv, .json, .html
- Parse the content to extract sequence touches

**URL** — fetch and parse
- Scrape the page using Firecrawl (if available) or direct fetch
- Extract sequence content from the page
- Works with: blog posts sharing templates, Google Docs, Notion pages

**--paste** — ask user to paste
- "Paste your sequence below. Include subject lines and email bodies."
- Parse the pasted content

## Parsing
3. Parse the imported content and identify:
   - Number of touches
   - Subject lines (if email)
   - Body copy per touch
   - Timing/spacing between touches (if specified)
   - Channel (email / LinkedIn / multi-channel)
   - Personalization variables used

4. Display what was parsed:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  IMPORT PREVIEW                                              ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                              ┃
┃  Detected: {n}-touch {channel} sequence                      ┃
┃  Source: {file/URL/paste}                                    ┃
┃                                                              ┃
┃  Touch 1: "{subject line}"                                   ┃
┃  Touch 2: "{subject line}"                                   ┃
┃  ...                                                         ┃
┃                                                              ┃
┃  Variables found: {{first_name}}, {{company}}                 ┃
┃  Timing: {if detected, else "not specified — defaults apply"} ┃
┃                                                              ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

## Quality check
5. Run against GTM:OS quality standards:
   - Cold email skill validation (peer voice, observation-led, interest-based CTA)
   - Subject line rules (length, no spam triggers)
   - Copy rules (no "I", no "just checking in", no feature dumps)
   - Flag issues but don't reject — imports may have different style

6. Display quality assessment:
```
  Quality check:
  [x] Touch count: {n} (reasonable)
  [!] Touch 1 opener uses "I" — rewrite when adapting
  [x] Subject lines within length limits
  [x] No spam trigger words

  Quality score: {n}/10
```

## Save
7. Ask for template name and metadata:
   - Template name (e.g. "saas-cold-4touch")
   - Campaign type
   - Channel
   - Source (where it came from)
   - Notes (when to use it)

8. Convert to GTM:OS template format:
   - Generalize specific references → placeholders
   - Standardize personalization variables
   - Add timing defaults if not specified
   - Add annotation comments

9. Save to global/templates/{template-name}.md

10. Display confirmation:
```
  Template imported: {template-name}
  Quality: {n}/10
  Saved to: global/templates/{template-name}.md

  >> Use it: /gtm:use-template {ws} {template-name}
  >> Browse: /gtm:templates
```
</process>
</content>
