USE delivery_db;

WITH route_stats AS (
    SELECT
        route_id,
        COUNT(*)                                          AS total_trips,
        ROUND(AVG(delay_mins), 1)                         AS avg_delay,
        ROUND(AVG(duration_mins), 1)                      AS avg_duration,
        SUM(sla_breach_flag)                              AS total_breaches,
        ROUND(SUM(sla_breach_flag)*100.0/COUNT(*), 2)     AS breach_rate
    FROM raw_trips
    GROUP BY route_id
    HAVING COUNT(*) > 100
),
ranked_routes AS (
    SELECT *,
           NTILE(4) OVER (ORDER BY breach_rate DESC)      AS performance_quartile
    FROM route_stats
)
SELECT
    route_id,
    total_trips,
    avg_delay,
    breach_rate,
    performance_quartile,
    CASE performance_quartile
        WHEN 1 THEN 'Critical - immediate action'
        WHEN 2 THEN 'At risk - monitor closely'
        WHEN 3 THEN 'Acceptable - routine review'
        WHEN 4 THEN 'Healthy - benchmark standard'
    END AS operational_status
FROM ranked_routes
ORDER BY breach_rate DESC
LIMIT 20;