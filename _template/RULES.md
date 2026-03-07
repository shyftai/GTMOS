# Quality Rules — [Workspace Name]

## List quality

### Required fields
- [ ] First name
- [ ] Last name
- [ ] Company name
- [ ] Job title (verified against ICP)
- [ ] LinkedIn URL
- [ ] Work email (verified, or catch-all flagged)
- [ ] Company website

### Enrichment fields (populate where available)
- Company size (employees)
- Industry (standardized label)
- HQ location
- Relevant signal (event, hiring, funding, tech, etc.)

### Rejection rules
- Personal email domain (gmail, hotmail, etc.) → reject
- Job title outside ICP persona → reject
- Company outside ICP industry → reject
- Duplicate in this campaign → reject
- Unverifiable email with no LinkedIn → reject

### Scoring rubric
- 3: All required fields, strong ICP match, verified email, clear signal present
- 2: All required fields, solid ICP match, catch-all email or no signal
- 1: Missing 1-2 fields, or weak ICP signal — flag for manual review
- 0: Reject

## Copy quality

### Email
- Subject line: 2-4 words, lowercase, no punctuation — must feel like an internal forward
- Line 1: no "I", no company name — open with an observation about them
- Body: max 75 words for first touch, max 50 words for follow-ups
- CTA: one ask only, interest-based ("Worth a look?" not "Book a demo")
- Voice: peer-to-peer — write as a colleague sharing something useful, not a marketer pitching
- Each follow-up must use a different angle than the previous touch
- Never use: "excited", "thrilled", "game-changing", "synergy", "leverage", "unlock", buzzwords, excessive punctuation, ALL CAPS, generic openers
- No compliment openers ("Love what you're doing at...")
- No performance language ("I'm reaching out because...")
- Calibrate brevity to seniority: C-suite max 50 words, Director max 65, Manager/IC max 75

### LinkedIn
- Connection note: max 300 characters, no pitch in the note
- Follow-up message: max 50 words, reference something specific, never generic
- No links or attachments in first message
- Use Crispy for LinkedIn automation — supports MCP integration with Claude Code
