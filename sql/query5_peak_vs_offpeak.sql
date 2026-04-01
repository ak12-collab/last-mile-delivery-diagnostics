USE delivery_db;

SELECT
    time_window,
    day_type,
    COUNT(*)                                               AS total_deliveries,
    ROUND(SUM(sla_breach_flag)*100.0/COUNT(*), 2)          AS breach_rate_pct,
    ROUND(AVG(delay_mins), 1)                              AS avg_delay_mins,
    ROUND(AVG(duration_mins), 1)                           AS avg_delivery_mins
FROM raw_trips
GROUP BY time_window, day_type
ORDER BY breach_rate_pct DESC;