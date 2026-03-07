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
- Subject line: max 8 words, no question marks in cold outreach, no clickbait
- Line 1: no "I", no company name, must earn relevance immediately
- Body: max 75 words for first touch
- CTA: one ask only, make it low-friction
- Never use: buzzwords, excessive punctuation, ALL CAPS, generic openers

### LinkedIn
- Connection note: max 300 characters, no pitch in the note
- Follow-up message: reference something specific, never generic
