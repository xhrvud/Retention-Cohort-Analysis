# Retention / Cohort Analysis

## 📌 Project Overview
This project focuses on **user retention analysis** using a daily cohort approach (D0–D7).
The goal is to understand how many users return to the product over time after their **first interaction**, identify early churn patterns, and visualize retention behavior in a clear and interpretable way.

Retention was calculated in **SQL** and visualized in **Power BI**, following common product analytics best practices.

---

## 📊 Dataset
- **Source:** Kaggle (E-commerce Events Dataset)
- **Period:** November 2019
- **Granularity:** User-level event data
- **Key fields used:**
  - `user_id`
  - `event_time`
  - `event_type`
  - `user_session`

The dataset includes user interactions such as views, cart additions, and purchases.

---

## 🧠 Retention Methodology

### Cohort Definition
- A **cohort** is defined by the **date of a user’s first recorded activity**.
- Cohorts are built on a **daily basis**.

### Retention Window
- Retention is measured from **Day 0 to Day 7**:
  - **Day 0** — day of first activity (baseline = 100%)
  - **Day N** — user returned N days after first activity

### Important Assumption
To avoid misleading results:
- **Incomplete cohorts were excluded**
- Only cohorts with a **full D0–D7 observation window** were included

As the dataset ends on `2019-12-01`, the latest cohort included is:
2019-11-24

---

## 🛠 SQL Logic

Retention was fully calculated in SQL using the following steps:

1. Identify each user’s **first activity date**
2. Join all subsequent user events
3. Calculate the number of days since first activity (`day_number`)
4. Count retained users per cohort and day
5. Calculate retention rate as:
   `retention_rate = retained_users / cohort_size`
   
The final output table contains:
- `cohort_date`
- `day_number`
- `retained_users`
- `cohort_users`
- `retention_rate`

---

## 📈 Visualizations (Power BI)

The Power BI dashboard includes:

### 🔹 KPI Cards
- **D1 Retention:** 6.31%
- **D7 Retention:** 2.25%

### 🔹 Cohort Retention Heatmap
- Rows: `cohort_date`
- Columns: `Day 0 – Day 7`
- Color intensity based on **average retention rate**
- Empty cells represent **missing data**, not zero values

### 🔹 Retention Curve
- Average retention across all cohorts
- Shows sharp drop-off after Day 1 and gradual decay afterward

---

## 🧠 Key Insights

- User retention drops significantly after the first day, which is typical for e-commerce products.
- The largest churn occurs between **Day 0 and Day 1**.
- Retention stabilizes after Day 3 at a low but consistent level.
- No abnormal spikes or artificial zero values were observed, confirming correct cohort filtering.

---

## ⚠️ Notes & Limitations

- The analysis focuses on **behavioral retention**, not revenue-based retention.
- No user segmentation (e.g., by acquisition channel or geography) was applied.
- Results are descriptive and not intended for forecasting.

---

## 🛠 Tools Used
- **PostgreSQL** — data preparation and retention calculations
- **Power BI** — cohort visualization and dashboarding
- **SQL** — window functions, aggregations, date arithmetic

---

## 📂 Repository Structure
```
.
├── README.md
├── sql
│ ├── 01_schema.sql
│ ├── 02_indexes.sql
│ ├── 03_sanity_checks.sql
│ ├── 04_retention_calculation.sql
│ └── 05_views.sql
├── dashboards
│ └── screenshots
│ └── retention_dashboard.png
└── notes
└── assumptions.md
```

---

## 👤 Author
Levytskyi Bohdan
Junior Data Analyst

📎 Other projects available on my GitHub profile.
