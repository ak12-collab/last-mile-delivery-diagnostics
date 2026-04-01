# 🚚 Last-Mile Delivery Failure Diagnostics System

![Python](https://img.shields.io/badge/Python-3.14-blue?logo=python)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange?logo=mysql)
![PowerBI](https://img.shields.io/badge/PowerBI-Dashboard-yellow?logo=powerbi)
![SQL](https://img.shields.io/badge/SQL-Advanced-green)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

> 🔍 Identifying operational inefficiencies across routes, time windows,
> and regions using **3.5M+ NYC taxi records** as a last-mile delivery network proxy.

---

## 📌 Project Overview

This project simulates a real-world last-mile delivery analytics system.
NYC taxi trips are reframed as delivery operations:

| 🚕 Taxi Domain | 📦 Delivery Domain |
|---|---|
| Pickup location | Seller / Warehouse (First Mile) |
| Drop-off location | Customer (Last Mile) |
| Trip duration | Delivery time |
| Pickup timestamp | Dispatch time |
| Trip distance | Delivery distance |

A **SQL-driven diagnostics system** identifies SLA breaches, overloaded
zones, and high-risk time windows generating actionable recommendations
for operations leadership.

---

## 📊 Key Findings

| 📈 Metric | 🔢 Value |
|---|---|
| Total deliveries analyzed | 3,504,776 |
| ✅ On-time delivery rate | 81.66% |
| ❌ Overall SLA breach rate | 18.34% |
| 🚨 Total SLA breaches | 642,723 |
| 💀 Worst route breach rate | 100% (Route 76_140) |
| 🔴 Most overloaded zone | Zone 117 — 72.47% breach rate |
| ⏰ Worst time window | Thursday/Friday 3PM — 32%+ breach rate |

---

## 🧠 Business Recommendations

### 1️⃣ Zone Capacity Reallocation
> Add dispatch capacity to **Zones 117, 86, and 222** immediately.
> These zones show 70%+ breach rates across 1,000+ daily dispatches.
> Estimated **15-20% network-wide improvement** from reallocation.

### 2️⃣ Peak Hour Surge Staffing
> Introduce surge staffing for **peak weekday slots (7-10AM and 5-8PM)**.
> Current breach rate of 21.41% is nearly **2x the off-peak weekend rate** of 11.06%.

### 3️⃣ Thursday/Friday Afternoon Audit
> Breach rates consistently exceed **32% on Thursday and Friday afternoons**.
> Investigate whether this reflects driver shortage, route complexity,
> or traffic congestion patterns.

---

## 🗄️ SQL Queries (8 Advanced Queries)

| # | 📄 Query File | 🛠️ Techniques Used |
|---|---|---|
| 1 | `query1_breach_rate_by_route.sql` | RANK() window function |
| 2 | `query2_moving_average_delays.sql` | Moving average, window frame |
| 3 | `query3_percentile_delay_distribution.sql` | PERCENT_RANK(), PARTITION BY |
| 4 | `query4_worst_routes_cte.sql` | CTE chain, NTILE() quartiles |
| 5 | `query5_peak_vs_offpeak.sql` | GROUP BY, CASE WHEN |
| 6 | `query6_hourly_heatmap.sql` | 168 hour × day combinations |
| 7 | `query7_capacity_reallocation.sql` | CTE, CASE classification |
| 8 | `query8_executive_kpi_summary.sql` | Aggregations, on-time rate |

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| 🐍 Python (pandas, sqlalchemy) | Data loading and transformation |
| 🗄️ MySQL 8.0 | Database and SQL analysis |
| 📊 Power BI | Interactive dashboard |
| 🔍 SQL | Advanced analytics (CTEs, window functions) |

---

## 📁 Project Structure
```
📦 delivery_analytics/
├── 📂 data/           # Raw parquet file (excluded from repo)
├── 📂 sql/            # 8 advanced SQL query files
├── 📂 notebooks/      # Python scripts (explore, load, report)
├── 📂 dashboard/      # Power BI dashboard (.pbix)
└── 📂 docs/           # Insight report (Word + Markdown)
```

---

## 📋 Dashboard Preview

4-panel Power BI dashboard including:

- 🔢 **KPI Cards** — on-time rate, total breaches, total deliveries
- 📋 **Top Routes Table**  ranked by SLA breach rate
- 📊 **Time Window Chart**  breach rate by peak/off-peak and weekday/weekend
- 🌡️ **Hour × Day Heatmap** 168-cell breach rate matrix with conditional formatting

---

## 📂 Dataset

- **Source:** NYC TLC Yellow Taxi Trip Records [January 2026]
- **Link:** https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page
- **Raw records:** 3,724,889
- **After cleaning:** 3,504,776

---

## 👤 Author

**Akshay Dusane**  
📧 Data Analyst | Python · SQL · Power BI  
💻 [GitHub](https://github.com/ak12-collab)

---

⭐ *If you found this project useful, give it a star!*
