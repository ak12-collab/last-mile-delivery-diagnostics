USE delivery_db;

WITH zone_performance AS (
    SELECT
        origin_zone,
        COUNT(*)                                           AS total_dispatches,
        ROUND(AVG(delay_mins), 1)                          AS avg_delay,
        ROUND(SUM(sla_breach_flag)*100.0/COUNT(*), 2)      AS breach_rate,
        ROUND(AVG(distance_miles), 2)                      AS avg_distance
    FROM raw_trips
    GROUP BY origin_zone
    HAVING COUNT(*) > 200
)
SELECT
    origin_zone,
    total_dispatches,
    avg_delay,
    breach_rate,
    avg_distance,
    CASE
        WHEN breach_rate > 30 AND total_dispatches > 500
            THEN 'Overloaded - add capacity'
        WHEN breach_rate < 10 AND total_dispatches < 300
            THEN 'Underutilized - reallocate'
        ELSE 'Balanced'
    END AS capacity_recommendation
FROM zone_performance
ORDER BY breach_rate DESC;