-- Migration 003: Contact lifecycle fields
-- Adds last_touch_date, touch_count, reply_confidence, ooo_return_date
-- These fields are required for re-engagement eligibility and reply handling.

-- ============================================================
-- pipeline_contacts — lifecycle tracking fields
-- ============================================================

-- Track the most recent touch sent to a contact.
-- Re-engagement eligibility uses this, not first_touch_date.
-- Set by /gtm:ship at initial send. Updated on subsequent campaign touches
-- by polling the sending tool API during /gtm:health or /gtm:signals.
alter table public.pipeline_contacts
  add column if not exists last_touch_date timestamptz,
  add column if not exists last_touch_channel text,
  add column if not exists touch_count integer not null default 0;

-- Index for re-engagement queries ("find contacts where last_touch >= 60 days ago")
create index if not exists idx_pipeline_last_touch
  on public.pipeline_contacts(workspace_id, last_touch_date);

-- ============================================================
-- reply_queue — classification confidence and OOO return date
-- ============================================================

-- Confidence level assigned during /gtm:replies classification.
-- Uncertain replies block auto-drafting and require human review.
alter table public.reply_queue
  add column if not exists reply_confidence text
    check (reply_confidence in ('high', 'medium', 'uncertain')),
  add column if not exists ooo_return_date date;

-- Update classification constraint to include 'future_opportunity'
-- (was missing from original schema — only 7 types were listed)
alter table public.reply_queue
  drop constraint if exists reply_queue_classification_check;

alter table public.reply_queue
  add constraint reply_queue_classification_check
    check (classification in (
      'positive', 'negative', 'objection', 'referral',
      'ooo', 'unsubscribe', 'competitor', 'future_opportunity'
    ));

-- Index for OOO re-touch queries ("find OOO replies where return date has passed")
create index if not exists idx_replies_ooo
  on public.reply_queue(workspace_id, ooo_return_date)
  where classification = 'ooo';
