-- Total rows
SELECT COUNT(*) FROM events;

-- Purchases view sanity checks
-- (run after views are created if needed)
SELECT COUNT(*) FROM purchases;
SELECT MIN(purchase_date), MAX(purchase_date) FROM purchases;

-- First purchase cohort coverage
SELECT COUNT(*) AS buyers FROM user_first_purchase;
SELECT MIN(cohort_date), MAX(cohort_date) FROM user_first_purchase;

-- Example cohort check (D0..)
SELECT *
FROM cohort_retention_daily
WHERE cohort_date = '2019-11-01'
ORDER BY day_number;
