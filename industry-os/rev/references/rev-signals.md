# REV:OS — Revenue Operations Signals

Signals to monitor continuously. Each signal has an urgency rating, detection method, and recommended action.

Signals fall into three categories:
- **Data signals** — CRM/data quality degrading
- **Pipeline signals** — pipeline health changing
- **Revenue signals** — churn, expansion, or forecast risk emerging

---

## Data Signals

### 🔴 CRITICAL — Immediate action

**Stripe ↔ CRM ARR mismatch (> 5%)**
- **What:** The ARR in CRM accounts does not match Stripe subscription data
- **Detection:** Monthly reconciliation script; revenue field comparison
- **Why it matters:** Board and finance are working from different numbers; forecasting on wrong base
- **Action:** Run `/rev:stripe` reconciliation; identify mismatch source; resolve before next board report

**Duplicate accounts > 5% of total**
- **What:** Multiple CRM accounts for the same company
- **Detection:** Fuzzy match on company name + domain; duplicate detection in `/rev:health`
- **Why it matters:** Pipeline appears larger than it is; reps contact same account from different records; attribution breaks
- **Action:** Run `/rev:dedupe` for accounts; prioritize ICP accounts and active deals

**Opportunity owner field blank on active deals**
- **What:** Open deals with no assigned owner
- **Detection:** CRM report: open deals where owner = null or system user
- **Why it matters:** No one is working the deal; will not be in rep forecast
- **Action:** Assign immediately; investigate how the deal became ownerless

**Close date not updated in > 14 days on active deals**
- **What:** Deals with close dates that have passed or are > 14 days stale
- **Detection:** CRM report: deals where close_date_last_modified < 14 days ago
- **Why it matters:** Forecast is inflated with phantom deals; pipeline reviews waste time
- **Action:** Flag in pipeline review; require rep to update or mark lost

---

### 🟡 WARNING — Address this week

**Enrichment decay: contacts missing email > 20% in active pipeline**
- **What:** Contacts attached to open deals with no valid email address
- **Detection:** Join deal contact to email field; count missing
- **Why it matters:** Reps can't reach contacts; deals stall
- **Action:** Run enrichment on affected contacts via waterfall

**CRM field completion rate dropping below 70% on key fields**
- **What:** Fields like Industry, Employee Count, or Company LinkedIn URL dropping in completeness
- **Detection:** Weekly field audit in `/rev:health`
- **Why it matters:** ICP scoring breaks; segmentation becomes unreliable
- **Action:** Run enrichment batch; review data entry standards with team

**Lead routing errors: leads unassigned > 24 hours**
- **What:** New inbound leads sitting without assignment
- **Detection:** CRM report: leads created > 24h ago where owner = unassigned
- **Why it matters:** Inbound response time directly correlates with conversion; leads go cold
- **Action:** Fix routing rule; manually assign backlog; set up alert for future

**Duplicate contacts > 8%**
- **What:** Same person appearing in CRM twice or more
- **Detection:** Match on email + name; `/rev:dedupe` output
- **Why it matters:** Sequences hit the same person twice; suppression lists fail; attribution double-counts
- **Action:** Dedupe contacts; start with ICP accounts and active deal contacts

---

### 🟢 MONITOR — Track weekly

**Enrichment cache nearing 30-day expiry on active deals**
- **What:** Enrichment data on key accounts/contacts approaching staleness threshold
- **Detection:** Enrichment date field vs. today; flag where > 25 days
- **Action:** Schedule re-enrichment batch before expiry

**New CRM users not following field entry standards**
- **What:** Recently added users creating records with missing or non-standard field values
- **Detection:** Filter new records created by users in last 30 days; check field completeness
- **Action:** Targeted training; reinforce field standards documentation

---

## Pipeline Signals

### 🔴 CRITICAL — Immediate action

**Deal stalled > 21 days in same stage**
- **What:** Open deal has been in the same stage without activity for 21+ days
- **Detection:** Stage last modified date; no activity (email, call, meeting) in same window
- **Why it matters:** Stale deals inflate forecast; usually indicate no champion or lost interest
- **Action:** Flag in pipeline review; rep must produce a next-steps plan or deal is marked at-risk

**No next meeting scheduled on deals > $50K in evaluation stage**
- **What:** High-value deals in evaluation with no future meeting booked
- **Detection:** Deal value + stage + calendar check (via CRM activity)
- **Why it matters:** No meeting = no momentum = likely lost
- **Action:** Escalate to manager; immediate outreach plan required

**Pipeline coverage below 2.5× quota for current quarter**
- **What:** The total pipeline value in commit + best case is insufficient to hit the number
- **Detection:** Sum of pipeline by close quarter vs. quota; in `/rev:forecast`
- **Why it matters:** Math says you can't hit the number without a pipeline generation push
- **Action:** Immediate pipeline generation response; surface to CRO

---

### 🟡 WARNING — Address this week

**Win rate dropping > 5 points QoQ for a segment or territory**
- **What:** Win rate for a specific rep, team, segment, or product declining
- **Detection:** Win/loss data by segment; quarter-over-quarter comparison
- **Why it matters:** Leading indicator of competitive or positioning problem
- **Action:** Run win/loss analysis on affected segment; interview reps

**Average sales cycle lengthening > 20% vs. prior quarter**
- **What:** Deals taking longer to close across the board
- **Detection:** Average age at close by close quarter
- **Why it matters:** Cash flow and forecast timing both affected; may indicate economic pressure or process issues
- **Action:** Segment by deal size, rep, and industry; identify where the slowdown is happening

**Multi-threaded deal contacts dropping (< 2 contacts on deals > $50K)**
- **What:** Large deals only have one contact attached in CRM
- **Detection:** Contact count on deals over ACV threshold
- **Why it matters:** Single-threaded deals are high churn risk; champion may leave or lose internal support
- **Action:** Coach reps on multi-threading; enrich to find additional stakeholders

---

### 🟢 MONITOR — Track weekly

**New pipeline creation below 4× quota pace for next quarter**
- **What:** The rate of new deals being added to next-quarter pipeline is below target
- **Detection:** New deal creation this week × weeks remaining vs. 4× quota target
- **Action:** Flag to SDR and marketing; adjust pipeline generation plans

**Forecast call variance from prior week > 10%**
- **What:** The forecast number changed significantly from last week's call
- **Detection:** Compare current forecast to prior week's commit
- **Action:** Require explanation of what moved; prevent unexplained volatility

---

## Revenue Signals

### 🔴 CRITICAL — Immediate action

**Gross monthly churn > 2%**
- **What:** More than 2% of MRR churned in a single month
- **Detection:** Stripe/billing data; churn events vs. opening MRR
- **Why it matters:** At this rate, you're losing 24%+ of revenue annually — unsustainable
- **Action:** Immediate account-by-account churn review; root cause analysis; escalate to CRO and CS leadership

**NRR dropping below 100%**
- **What:** Revenue from existing customers is contracting (downgrades + churn exceeds expansion)
- **Detection:** MRR movement analysis: (expansion − contraction − churn) / opening MRR
- **Why it matters:** Growth engine is stalling; company is running to stand still
- **Action:** Identify top 10 contracting accounts; expansion motion audit; pricing review

**Customer not logged in to product for > 30 days (active subscription)**
- **What:** A customer with an active subscription has had zero product activity for 30+ days
- **Detection:** Product analytics joined to billing data
- **Why it matters:** This is the strongest leading indicator of churn
- **Action:** CS immediate outreach; executive sponsor engagement

---

### 🟡 WARNING — Address this week

**Account executive change at key customer account**
- **What:** Primary contact or economic buyer at a key account has changed jobs
- **Detection:** LinkedIn monitoring; CRM contact update; enrichment decay flag
- **Why it matters:** Champion departure is one of the top 3 causes of enterprise churn
- **Action:** Identify new contact; immediate relationship-building outreach

**Renewal within 60 days without renewal conversation started**
- **What:** An account renews in < 60 days and no renewal activity is logged in CRM
- **Detection:** Contract end date vs. today; activity log check
- **Why it matters:** 60 days is minimum lead time for enterprise renewals
- **Action:** Assign renewal owner; start renewal workflow immediately

**NPS score drop > 15 points for any account**
- **What:** A customer's NPS score dropped significantly in recent survey
- **Detection:** NPS survey results feed in CRM or CS platform
- **Action:** CSM to schedule immediate call; flag as churn risk; escalate if no response

---

### 🟢 MONITOR — Track weekly

**Expansion opportunity: customer at usage limit on current plan**
- **What:** A customer is hitting usage caps or seat limits
- **Detection:** Product usage data; usage field in CRM
- **Action:** Flag to CSM for expansion conversation; prioritize highest-ACV accounts

**Competitor mention in recent call transcripts**
- **What:** A competitor is mentioned in Gong/Chorus call recordings for accounts in renewal or evaluation
- **Detection:** Gong/Chorus keyword monitoring
- **Action:** Share competitive intelligence; prepare CS team with battlecard talking points
