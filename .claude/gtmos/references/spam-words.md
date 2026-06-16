# Spam & Deliverability Word Guard — GTMOS

Always-on copy guardrails. These rules apply to **every** subject line, opener, second line, follow-up, CTA, and unsubscribe line — whether the user asks for a check or not. They are loaded automatically when writing or QA-ing copy, and they back the `/gtm:spam-check` command.

This is the expanded enforcement layer behind check #6 ("No spam words") in `cold-email-skill.md`. When in doubt, choose the lower-hype rewrite.

---

## When these rules apply

- Subject lines, openers, second lines, follow-ups, CTAs, breakup lines
- Any outbound copy being written, validated, or imported (`/gtm:write`, `/gtm:validate-copy`, `/gtm:import-template`, `/gtm:personalize`)
- If a deliverability checker, spam test, or reviewer flags a word, treat it as banned going forward unless the user explicitly approves an exception (log the exception in `RULES.md`)

A workspace can extend or relax this list under a `## Spam word overrides` section in `RULES.md` — for example, a fintech workspace may need `invoice` or `billing` and accept the risk. Overrides there take precedence; the default is to ban.

---

## Banned single words

Do not use standalone or inside a compound. Punctuation, hyphens, or splits do not make a banned token safe — if the root token is still obvious, it is still banned (`cash-cycle` → `cash`, `invoice-line` → `invoice`, `extra-room` → `extra`).

`get`, `bank`, `credit`, `access`, `open`, `compare`, `problem`, `now`, `billing`, `deal`, `finance`, `financial`, `claims`, `insurance`, `mortgage`, `soon`, `new`, `performance`, `freedom`, `home`, `sales`, `medical`, `urgent`, `life`, `marketing`, `investment`, `diagnostics`, `friend`, `cash`, `invoice`, `extra`, `purchase`

---

## Banned short phrases

`off chance`, `one time`, `all good`, `following up here`, `last note from me here`, `great fit`, `bumping this once`, `just following up once`, `circle back`, `one more quick follow-up`, `keep this open`, `compare notes`, `compare notes live`, `appreciate the reply`

---

## High-risk promotional / pressure wording (banned)

`$$$`, `50% off`, `100% guaranteed`, `100% free`, `100% off`, `100% satisfied`, `access now`, `act fast`, `act immediately`, `act now`, `action required`, `affordable deal`, `amazing`, `amazing deal`, `amazing offer`, `apply here`, `apply now`, `avoid bankruptcy`, `bargain`, `best bargain`, `best deal`, `best offer`, `best price`, `best rates`, `big profit`, `bonus`, `buy now`, `buy today`, `call now`, `can't live without`, `cash bonus`, `cash out`, `claim now`, `claim your discount`, `click`, `click below`, `click here`, `click this link`, `contact us immediately`, `deal ending soon`, `discount`, `don't delete`, `double your money`, `drastically reduced`, `earn`, `earn cash`, `earn extra income`, `earn money`, `easy income`, `exclusive deal`, `expires today`, `extra cash`, `extra income`, `fantastic offer`, `fast cash`, `final call`, `for free`, `free access`, `free consultation`, `free gift`, `free membership`, `free money`, `free quote`, `free trial`, `full refund`, `get it now`, `get out of debt`, `get started now`, `giveaway`, `great news`, `guaranteed results`, `hurry up`, `important information`, `immediately`, `increase revenue`, `increase sales`, `incredible deal`, `instant earnings`, `instant income`, `instant savings`, `investment advice`, `join millions`, `limited time`, `lowest price`, `make money`, `million dollars`, `money-back guarantee`, `must read`, `no catch`, `no cost`, `no obligation`, `no strings attached`, `once in a lifetime`, `only $`, `only available here`, `order now`, `order today`, `please read`, `price protection`, `profits`, `promise`, `pure profit`, `quote`, `risk-free`, `satisfaction guaranteed`, `save $`, `save big money`, `save up to`, `sign up free`, `special invitation`, `special offer`, `special promotion`, `supplies are limited`, `take action now`, `the best`, `this won't last`, `thousands`, `time limited`, `top urgent`, `trial`, `unbeatable offer`, `unbelievable`, `unlimited`, `what are you waiting for?`, `while supplies last`, `why pay more?`, `winner announced`, `you are a winner`

---

## Phishing-style / security-warning language (banned)

`access your account`, `account update`, `activate now`, `change password`, `click to verify`, `confirm your details`, `confidential information`, `data breach`, `download now`, `final notice`, `important update`, `immediate action required`, `install now`, `last warning`, `log in now`, `new login detected`, `password reset`, `payment details needed`, `phishing alert`, `security breach`, `security update`, `update account`, `verify identity`, `warning message`

---

## Blacklisted categories (never appear in B2B outbound)

`100% natural`, `adult content`, `bet now`, `blackjack`, `casino bonus`, `cure for`, `diet pill`, `doctor recommended`, `fat burner`, `fast weight loss`, `free chips`, `free spins`, `gamble online`, `guaranteed weight loss`, `jackpot`, `lottery winner`, `medical breakthrough`, `miracle cure`, `natural remedy`, `no prescription needed`, `online betting`, `online casino`, `online pharmacy`, `pain relief`, `poker tournament`, `prescription drugs`, `reverse aging`, `risk-free bet`, `safe and effective`, `scientifically proven`, `secret formula`, `slots jackpot`, `spin to win`, `vip offer`, `weight loss`, `winning numbers`, `xxx`

---

## Formatting & style bans

- No em dashes (—) — use periods or commas
- No ALL CAPS
- No multiple exclamation marks
- No greeting prefix before the first name (no "Hi", "Hello", "Hey {{first_name}}") — open with the observation
- No third-person company references (`{{company}} offers`, `{{company}} helps`)
- No fake urgency, misleading subject lines, link stuffing, or promotional formatting

These reinforce the voice rules in `cold-email-skill.md` and `TOV.md`. Where `TOV.md` is stricter, `TOV.md` wins.

---

## Unsubscribe / closeout line rules

Never write a closeout line that promises to stop following up based on **silence**. GTM:OS runs sequences — silence keeps the cadence running. A silence-based promise is misleading and fails to match actual behaviour (and undercuts CAN-SPAM/GDPR honesty expectations).

**Banned (silence = we stop):**
- "I'll take silence as a no"
- "read no reply as a pass"
- "assume no response means no interest"
- "if I don't hear back, I'll leave it there / let this one go / leave you alone"
- any construction where the recipient doing nothing = we stop sending

**Allowed (explicit action = we stop):**
- "a reply of 'no' or 'not for us' is enough and I'll step out of your inbox" (action-conditional)
- "just say the word and I'll stop" (asks for action)
- "feel free to ignore this" (permission, no false promise)
- "happy to try back when timing makes more sense" (defers, doesn't promise to stop)

Rule of thumb: **the recipient must do something explicit for the sequence to stop.** This is separate from the real unsubscribe mechanism, which is always present in the footer per compliance config.

---

## Safe replacement patterns

| Banned / risky | Safe replacement |
|---|---|
| `free consultation` | open to a short conversation |
| `special offer` | what we're seeing in the market |
| `act now` | if relevant, happy to send details |
| `guaranteed results` | this may be relevant depending on your situation |
| `click here` | let me know and I can send it over |
| `limited time` | not sure if this is timely for you |
| `increase revenue` | the precise business outcome (e.g. "help support liquidity") |

---

## Rewriting logic

- Rewrite hype into plain, observational language
- Replace pressure with permission
- Replace promotional wording with specific business language
- If a line reads like an ad, coupon, scam, or phishing message → rewrite it
- If a bump is filler-heavy or vague → replace with a direct next-step question or a clean closeout
- If a value line uses fuzzy wording (`tight`, `fit`, `access`, `problem`) → rewrite so the operational meaning is explicit
- If a sentence sounds AI-polished → simplify until it reads like a person speaking plainly

---

## Banned word inside a company name

A banned token can appear legitimately inside a `{{company}}` value (e.g. "Access Brand Communications"). Do not drop the company reference — rewrite the displayed name so the banned token is removed from standalone form, keeping the name recognisable:

- `Access Brand Communications` → `AB Communications`
- `Calcon Mutual Mortgage` → `Calcon Mutual`
- `Buckeye Insurance` → `Buckeye`

Only abbreviate or compress when removing the token alone would make the name unclear.

---

## QA checklist (run before any copy is approved)

- [ ] Subject line scanned for spam-trigger wording (2-4 words, lowercase, no punctuation — see `cold-email-skill.md`)
- [ ] Body scanned for banned single words, phrases, and high-risk wording
- [ ] Every hype/pressure line rewritten into plain language
- [ ] No em dashes, no ALL CAPS, no fake urgency
- [ ] Closeout line uses an action-conditional, not silence-based, promise
- [ ] Banned tokens inside `{{company}}` values handled
- [ ] Copy reads like a credible person, not a promotion

A flag here is a copy revision, not a ship blocker on its own — but copy that still contains banned wording must not pass the five-check in `GTMOS.md` ("Voice fit" / "Quality fit").
