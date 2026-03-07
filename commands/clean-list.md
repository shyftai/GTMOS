# Command: Clean List

## Trigger
"Clean this list" or runs automatically as step 1 of validate-list

## Cleaning operations

### 1. Names
- **First name:** Title case. "JAMES" → "James", "sarah" → "Sarah", "jAmEs" → "James"
- **Last name:** Title case, preserve particles. "VAN DER BERG" → "van der Berg", "o'brien" → "O'Brien", "MCDONALD" → "McDonald"
- **Trim whitespace:** Remove leading/trailing spaces, collapse double spaces
- **Remove titles:** Strip "Mr.", "Mrs.", "Dr.", "Prof." from name fields — they don't belong in cold outreach personalization
- **Flag empty names:** If first_name is empty, flag for review — never send "Hey {{first_name}}" with no fallback

### 2. Company names
- **Normalize casing:** "ACME CORP" → "Acme Corp", "acme corp" → "Acme Corp"
- **Preserve known acronyms:** IBM, AWS, SAP, HubSpot, etc. — don't lowercase these
- **Strip legal suffixes for display:** "Acme Corp, Inc." and "Acme Corp Inc" → "Acme Corp" (keep original in a separate column if needed)
- **Deduplicate variants:** "Acme Corp", "Acme Corporation", "ACME" → flag as potential duplicates
- **Trim whitespace**

### 3. Email addresses
- **Lowercase all:** "James@AcmeCorp.com" → "james@acmecorp.com"
- **Trim whitespace**
- **Remove mailto:** Strip "mailto:" prefix if present
- **Flag personal domains:** gmail.com, yahoo.com, hotmail.com, outlook.com, aol.com, icloud.com, protonmail.com → flag, do not auto-reject (might be a founder)
- **Flag role-based:** info@, sales@, support@, admin@, hello@, contact@, team@ → flag for review
- **Flag catch-all domains:** If email verification data is available, flag catch-all
- **Normalize domain:** Strip trailing dots, lowercase

### 4. Domain / website
- **Normalize:** Remove http://, https://, www., trailing slashes
- **Lowercase all**
- **Cross-check:** company domain should match email domain (flag mismatches)
- **Deduplicate:** Multiple contacts at same domain = same company (flag for volume check)

### 5. Job titles
- **Normalize common variants:**
  - "VP" / "Vice President" / "V.P." → standardize to "VP"
  - "Sr." / "Senior" → standardize to "Senior"
  - "Dir." / "Director" → standardize to "Director"
  - "Mgr" / "Manager" → standardize to "Manager"
- **Trim whitespace and punctuation**
- **Flag titles outside ICP persona** (defer to validate step for scoring)

### 6. Location / geography
- **Normalize country:** "US" / "USA" / "United States" / "United States of America" → "United States"
- **Normalize state:** "CA" / "California" → standardize to one format
- **Trim whitespace**

### 7. LinkedIn URLs
- **Normalize:** Strip query parameters, ensure format is `linkedin.com/in/handle`
- **Lowercase**
- **Flag missing:** If no LinkedIn URL, flag — reduces personalization options

### 8. Phone numbers (if present)
- **Strip formatting:** Remove parentheses, dashes, spaces, dots
- **Normalize to E.164 if country code present**
- **Flag if not a valid format**

### 9. Deduplication
- **Exact email match:** Remove duplicates, keep the most complete record
- **Fuzzy company match:** Flag "Acme Corp" + "Acme Corporation" as potential duplicates
- **Cross-campaign check:** Check against other active campaign lists in the workspace
- **Suppression check:** Check against SUPPRESSION.md — remove matches before validation

## Output
- Cleaned CSV saved to lists/raw/ (overwrites or saves as {filename}-cleaned.csv)
- Cleaning report:
  - Records processed
  - Names corrected
  - Emails normalized
  - Companies standardized
  - Duplicates found (exact + fuzzy)
  - Suppressed contacts removed
  - Records flagged for review
