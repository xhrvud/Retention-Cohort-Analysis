-- Index for retention queries (purchase events only)
CREATE INDEX IF NOT EXISTS idx_events_purchase_user_time
ON events (user_id, event_time)
WHERE event_type = 'purchase';
