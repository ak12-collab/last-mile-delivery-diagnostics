USE delivery_db;

SELECT 
    route_id,
    COUNT(*)                                           AS total_deliveries,
    SUM(sla_breach_flag)                               AS total_breaches,
    ROUND(SUM(sla_breach_flag) * 100.0 / COUNT(*), 2) AS breach_rate_pct,
    RANK() OVER (ORDER BY SUM(sla_breach_flag) * 100.0 
    / COUNT(*) DESC)             AS breach_rank
FROM raw_trips
GROUP BY route_id
HAVING COUNT(*) > 50
ORDER BY breach_rate_pct DESC
LIMIT 20;