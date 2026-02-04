-- Power BI-friendly view: only D0..D7
CREATE OR REPLACE VIEW cohort_retention_grid_d7 AS
SELECT *
FROM cohort_retention_grid
WHERE day_number BETWEEN 0 AND 7;

-- Optional: only complete cohorts for D7 window
-- Dataset max date is 2019-12-01 -> last complete cohort_date for D7 is 2019-11-24
CREATE OR REPLACE VIEW cohort_retention_grid_d7_complete AS
SELECT *
FROM cohort_retention_grid
WHERE day_number BETWEEN 0 AND 7
  AND cohort_date <= DATE '2019-11-24';
