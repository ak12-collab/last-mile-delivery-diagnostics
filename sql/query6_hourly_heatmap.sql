USE delivery_db;

SELECT
    dispatch_hour,
    day_of_week,
    COUNT(*)                                               AS total_deliveries,
    ROUND(AVG(delay_mins), 1)                              AS avg_delay,
    ROUND(SUM(sla_breach_flag)*100.0/COUNT(*), 2)          AS breach_rate
FROM raw_trips
GROUP BY dispatch_hour, day_of_week
ORDER BY dispatch_hour,
        FIELD(day_of_week,'Monday','Tuesday','Wednesday',
            'Thursday','Friday','Saturday','Sunday');