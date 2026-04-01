USE delivery_db;

SELECT
    COUNT(*)                                               AS total_deliveries,
    ROUND(AVG(duration_mins), 1)                           AS avg_delivery_mins,
    ROUND(AVG(delay_mins), 1)                              AS avg_delay_mins,
    ROUND(SUM(sla_breach_flag)*100.0/COUNT(*), 2)          AS overall_breach_rate,
    ROUND(SUM(CASE WHEN sla_breach_flag = 0
                THEN 1 END)*100.0/COUNT(*), 2)          AS on_time_rate,
    SUM(sla_breach_flag)                                   AS total_breaches,
    ROUND(AVG(distance_miles), 2)                          AS avg_distance_miles,
    ROUND(AVG(delivery_cost), 2)                           AS avg_delivery_cost
FROM raw_trips;