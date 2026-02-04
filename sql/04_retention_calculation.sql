-- 1) Purchases facts
CREATE OR REPLACE VIEW purchases AS
SELECT
  user_id,
  event_time::date AS purchase_date,
  price
FROM events
WHERE event_type = 'purchase'
  AND user_id IS NOT NULL
  AND price IS NOT NULL
  AND price > 0;

-- 2) First purchase date = cohort_date
CREATE OR REPLACE VIEW user_first_purchase AS
SELECT
  user_id,
  MIN(purchase_date) AS cohort_date
FROM purchases
GROUP BY user_id;

-- 3) Cohort activity by day_number
CREATE OR REPLACE VIEW cohort_activity_daily AS
SELECT
  u.cohort_date,
  p.purchase_date AS activity_date,
  (p.purchase_date - u.cohort_date) AS day_number,
  COUNT(DISTINCT p.user_id) AS retained_users
FROM purchases p
JOIN user_first_purchase u
  ON p.user_id = u.user_id
GROUP BY
  u.cohort_date,
  p.purchase_date,
  (p.purchase_date - u.cohort_date);

-- 4) Cohort size
CREATE OR REPLACE VIEW cohort_size AS
SELECT
  cohort_date,
  COUNT(*) AS cohort_users
FROM user_first_purchase
GROUP BY cohort_date;

-- 5) Retention rate (D0..D14)
CREATE OR REPLACE VIEW cohort_retention_daily AS
SELECT
  a.cohort_date,
  a.day_number,
  a.retained_users,
  s.cohort_users,
  ROUND(a.retained_users::numeric / s.cohort_users, 4) AS retention_rate
FROM cohort_activity_daily a
JOIN cohort_size s
  ON a.cohort_date = s.cohort_date
WHERE a.day_number BETWEEN 0 AND 14;

-- 6) Grid (fill missing days with 0 for consistent heatmap)
CREATE OR REPLACE VIEW cohort_retention_grid AS
WITH days AS (
  SELECT generate_series(0, 14) AS day_number
),
cohorts AS (
  SELECT cohort_date FROM cohort_size
)
SELECT
  c.cohort_date,
  d.day_number,
  COALESCE(r.retained_users, 0) AS retained_users,
  s.cohort_users,
  COALESCE(r.retention_rate, 0) AS retention_rate
FROM cohorts c
CROSS JOIN days d
JOIN cohort_size s
  ON s.cohort_date = c.cohort_date
LEFT JOIN cohort_retention_daily r
  ON r.cohort_date = c.cohort_date
 AND r.day_number = d.day_number;
