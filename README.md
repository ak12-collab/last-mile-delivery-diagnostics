# Last-Mile Delivery Failure Diagnostics System

SQL-driven delivery failure diagnostics analyzing 3.5M+ NYC taxi 
records as a last-mile delivery network proxy.

## Tools
Python · MySQL · Power BI · SQL (CTEs, Window Functions)

## Key Findings
- Overall SLA breach rate: 18.34% (642,723 failed deliveries)
- Route 76_140: 100% breach rate — critical failure
- Zone 117 and Zone 86: 70%+ breach rates — overloaded
- Peak weekday worst segment: 21.41% breach rate
- Thursday/Friday 3PM: 32%+ breach rates — staffing gap

## SQL Queries (8 total)
1. SLA breach rate by route — RANK() window function
2. 7-day rolling average delays — moving average
3. Percentile delay distribution — PERCENT_RANK()
4. Worst routes CTE pipeline — NTILE() quartile classification
5. Peak vs off-peak segmentation
6. Hourly heatmap — 168 hour/day combinations
7. Zone capacity reallocation — CASE statements
8. Executive KPI summary

## Project Structure
- sql/ — 8 advanced SQL query files
- notebooks/ — Python data loading scripts
- dashboard/ — Power BI dashboard (.pbix)
- docs/ — Insight report (Word + Markdown)