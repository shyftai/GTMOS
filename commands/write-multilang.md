# Command: Write Multi-Language Outbound Sequence

## Trigger
"Write a sequence in [language]" or "Draft outbound copy in French/German/etc for [campaign]"

## Supported languages
| Code | Language | Status |
|------|----------|--------|
| en | English | Default — use write-sequence.md |
| fr | French | Supported |
| de | German | Supported |
| nl | Dutch | Supported |
| es | Spanish | Supported |
| it | Italian | Supported |
| pt | Portuguese | Supported |
| sv | Swedish | Supported |
| da | Danish | Supported |
| no | Norwegian | Supported |
| fi | Finnish | Supported |
| pl | Polish | Supported |

Other languages available on request. If the workspace needs a language not listed here, the same principles apply — just flag it in TOV.md and confirm formality conventions before writing.

---

## When to use

Use this command instead of `write-sequence.md` when targeting prospects in non-English markets where the local language performs better.

**Rule of thumb:** if the prospect's LinkedIn profile AND company website are in a local language, write in that language. If either is in English, default to English.

Scenarios where local language wins:
- Mid-market companies in France, Germany, Netherlands, Nordics, Southern Europe
- Roles that operate locally (HR, Finance, Operations, Legal)
- Industries with low English adoption (construction, manufacturing, local services, public sector)

Scenarios where English is safer:
- Global/US-headquartered companies with EU offices
- Tech/SaaS companies where English is the working language
- C-suite at international companies
- Mixed-language signals (English LinkedIn, local website, or vice versa)

---

## Language detection

Before writing, determine the correct language using three signals:

1. **Prospect's LinkedIn profile language** — check the Crispy `locale` field. If it returns `fr_FR`, `de_DE`, `nl_NL`, etc., that is the strongest signal.
2. **Company website language** — use Firecrawl to check the primary language of the company homepage. If it is in a local language, that confirms the prospect operates in that language.
3. **Location** — prospect's city/country from enrichment data. Supporting signal, not definitive on its own.

**Decision logic:**
- LinkedIn locale + website both local language = write in local language
- LinkedIn locale local + website English = default to English (likely international company)
- LinkedIn locale English + website local = default to English (prospect may prefer English)
- All signals mixed or unclear = default to English
- Workspace override in TOV.md = always follow the override

---

## Writing process

All GTM:OS copy principles from cold-email-skill.md still apply without exception:
- Peer voice — write as a colleague, not a salesperson
- Observation-led — open with something specific about them
- Ruthless brevity — adapted word limits per language (see table below)
- Interest-based CTA — ask if they want to learn more, never ask to book/buy
- Subject lines — short, lowercase, no punctuation, adapted to target language
- Angle rotation — each follow-up uses a different angle

### Native writing, not translation

**Do NOT translate English copy into the target language.** Translated cold emails feel mechanical and are immediately recognized as spam. Every touch must be written natively — as a native speaker of that language would actually write a one-to-one message to a colleague.

This means:
- Sentence structure follows the target language's natural patterns, not English syntax
- Idioms, expressions, and phrasing are native to that language
- Cultural tone matches what that market expects in professional communication
- Merge fields like {{first_name}} and {{company}} work naturally within the grammar

### Formality: formal vs informal

Cold outreach defaults to the formal register unless TOV.md specifies otherwise:

| Language | Formal | Informal | Default for cold outreach |
|----------|--------|----------|--------------------------|
| French | vous | tu | vous |
| German | Sie | du | Sie |
| Dutch | u | je/jij | u |
| Spanish | usted | tu | usted |
| Italian | Lei | tu | Lei |
| Portuguese | o senhor/a senhora | voce/tu | voce (BR) / o senhor (PT) |
| Swedish | — | du | du (Swedish has largely dropped formal "ni") |
| Danish | — | du | du (formal "De" is rare in modern Danish) |
| Norwegian | — | du | du (formal "De" is rare in modern Norwegian) |
| Finnish | — | sina | sina (Finnish rarely uses formal address in business) |
| Polish | Pan/Pani | ty | Pan/Pani |

If the workspace's TOV.md contains a `## Language rules` section, follow those overrides.

### Subject lines

Same rules as English — short, lowercase, no punctuation — adapted to the target language:
- French: `petite question`, `votre equipe`, `re: croissance`
- German: `kurze frage`, `ihr team`, `re: wachstum`
- Dutch: `kort iets`, `jullie team`, `re: groei`
- Spanish: `una pregunta`, `su equipo`, `re: crecimiento`

Avoid translating English subject lines literally. Write subject lines that feel natural in the target language.

### Cultural norms and touch structure

Different markets have different expectations for how quickly you get to the point:

- **France, Germany, Poland:** Prospects expect slightly more context before the ask. Touch 1 can include an additional sentence of context. The observation needs to demonstrate genuine familiarity, not just a scraped data point.
- **Netherlands, Nordics (Sweden, Denmark, Norway, Finland):** Very direct cultures. Get to the point fast. Less preamble is better. Dutch prospects in particular appreciate bluntness.
- **Spain, Italy, Portugal:** Relationship-oriented. Warmth matters more. Touch 1 can be slightly warmer in tone while still maintaining peer voice. Avoid being overly transactional.

Adjust the touch structure accordingly — this does not mean abandoning brevity, but rather shifting where the weight of the message falls.

### Merge fields

Ensure all personalization variables work correctly in the target language:
- {{first_name}} — verify it renders correctly with local character sets (accents, umlauts, etc.)
- {{company}} — use the local company name if it differs from the English name
- Other merge fields should be tested for grammatical fit (e.g., German word order may place {{company}} differently in a sentence)

### Compliance

Include the correct unsubscribe/opt-out text in the target language:

| Region | Regulation | Unsubscribe language |
|--------|-----------|---------------------|
| EU (all) | GDPR | Unsubscribe text in the prospect's language |
| Canada | CASL | English + French unsubscribe if targeting Quebec |
| Brazil | LGPD | Portuguese unsubscribe text |

The unsubscribe line must be in the same language as the email body. Never use English opt-out text in a non-English email.

---

## Per-language adjustments

| Language | Formality default | Word limit adjustment | Cultural notes |
|----------|------------------|----------------------|---------------|
| French | vous | +10% (T1: ~83 words, T2+: ~55 words) | More context before the ask. Avoid anglicisms where French terms exist. Professional tone is expected. |
| German | Sie | +15-20% (T1: ~88 words, T2+: ~58 words) | Compound words inflate count. More context expected. Precision and specificity valued over casualness. |
| Dutch | u | +10-15% (T1: ~85 words, T2+: ~56 words) | Very direct — get to the point. Informality creeping into business culture; check TOV.md. Avoid overly formal language. |
| Spanish | usted | +10% (T1: ~83 words, T2+: ~55 words) | Warmer tone acceptable. Distinguish between Spain (ES) and Latin America (LATAM) conventions. |
| Italian | Lei | +10% (T1: ~83 words, T2+: ~55 words) | Relationship-first culture. Warmth matters. Avoid being overly transactional in touch 1. |
| Portuguese | voce (BR) / o senhor (PT) | +10% (T1: ~83 words, T2+: ~55 words) | Distinguish Brazil (BR) vs Portugal (PT). BR is more informal. PT is more formal. |
| Swedish | du | Same as English | Very direct. Informal is fine. Avoid corporate jargon. Plain language preferred. |
| Danish | du | Same as English | Similar to Swedish. Direct and informal. Avoid overselling. |
| Norwegian | du | Same as English | Similar to Swedish/Danish. Direct and understated. |
| Finnish | sina | +5% (T1: ~79 words, T2+: ~53 words) | Finnish text can run slightly longer due to agglutination. Very direct culture. No small talk. |
| Polish | Pan/Pani | +10-15% (T1: ~85 words, T2+: ~56 words) | Formal by default. Use gendered address (Pan for men, Pani for women). More context expected. |

Word limits include seniority adjustments from cold-email-skill.md. If targeting C-suite in German, apply both the seniority cap (50 words) and the +15-20% language adjustment (~58-60 words).

---

## Extended quality checklist

The standard 10-point checklist from cold-email-skill.md applies to every touch. For multi-language sequences, add four additional checks:

| # | Check | Pass criteria |
|---|-------|--------------|
| 1 | Peer voice | Reads like a colleague, not a salesperson |
| 2 | Under word limit | Adjusted word limit for target language and seniority |
| 3 | No "I" opener | First word is not "I" or company name (in any language) |
| 4 | Observation-led | Opens with something specific about them |
| 5 | Single CTA | One ask, interest-based, low friction |
| 6 | No spam words | No "excited", "thrilled", "game-changing" or their equivalents in the target language |
| 7 | Subject line | Short, lowercase, no punctuation — natural in target language |
| 8 | Angle rotation | Each touch uses a different angle than the previous |
| 9 | Specificity | At least one specific detail (company name, role, signal, metric) |
| 10 | Brevity | No filler sentences, no throat-clearing, no preamble |
| 11 | Language match | Language matches prospect's detected locale |
| 12 | Formality level | Correct formal/informal register for the language and context |
| 13 | No unnecessary loanwords | Native terms used where they exist — English loanwords only when industry-standard (e.g., "SaaS", "CRM", "pipeline" are acceptable; "awesome", "cool", "leverage" are not) |
| 14 | Compliance text | Unsubscribe/opt-out language in the correct language and regulation |

---

## TOV.md language extension

Workspaces can add per-language overrides by including a `## Language rules` section in their TOV.md file:

```markdown
## Language rules

### French
- Use tu instead of vous (brand is informal)
- Avoid: "solution", "optimiser" — use "outil", "ameliorer"
- Preferred CTA style: question format ("Ca vous dit d'en discuter ?")

### German
- Use du instead of Sie (startup/tech audience)
- Avoid: "Herausforderung" — use "Problem" (more direct)
- Preferred CTA style: short and direct ("Lohnt sich ein Blick?")
```

When a `## Language rules` section exists, its rules override the defaults in this command. Always check TOV.md before writing.
