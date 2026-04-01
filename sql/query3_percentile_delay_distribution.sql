USE delivery_db;

SELECT
    time_window,
    day_type,
    COUNT(*)                                              AS total_deliveries,
    ROUND(AVG(delay_mins), 1)                             AS avg_delay,
    MAX(CASE WHEN pct_rank <= 0.50
        THEN delay_mins END)                              AS p50_delay,
    MAX(CASE WHEN pct_rank <= 0.90
        THEN delay_mins END)                              AS p90_delay,
    MAX(CASE WHEN pct_rank <= 0.95
        THEN delay_mins END)                              AS p95_delay
FROM (
    SELECT *,
        PERCENT_RANK() OVER (
            PARTITION BY time_window, day_type
            ORDER BY delay_mins
        ) AS pct_rank
    FROM raw_trips
    WHERE (ABS(CRC32(route_id)) % 10) = 0
) ranked
GROUP BY time_window, day_type
ORDER BY avg_delay DESC;