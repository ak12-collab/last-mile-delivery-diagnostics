USE delivery_db;

WITH daily_avg AS (
    SELECT
        DATE(dispatch_time)       AS delivery_date,
        ROUND(AVG(delay_mins), 2) AS avg_delay
    FROM raw_trips
    GROUP BY DATE(dispatch_time)
)
SELECT
    delivery_date,
    avg_delay,
    ROUND(AVG(avg_delay) OVER (
        ORDER BY delivery_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2) AS rolling_7day_avg_delay
FROM daily_avg
ORDER BY delivery_date;