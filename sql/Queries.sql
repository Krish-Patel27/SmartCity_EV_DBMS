SELECT 
    cp.point_id, s.location_name, SUM(ml.cost) AS total_maintenance_cost
FROM Maintenance_Logs ml
JOIN Charging_Points cp ON ml.point_id = cp.point_id
JOIN Stations s ON cp.station_id = s.station_id
GROUP BY cp.point_id, s.location_name
HAVING total_maintenance_cost > 300
ORDER BY total_maintenance_cost DESC;

SELECT 
    u.user_name, u.email, COUNT(p.payment_id) AS failed_attempts
FROM Users u
JOIN Charging_Sessions cs ON u.user_id = cs.user_id
JOIN Payments p ON cs.session_id = p.session_id
WHERE p.payment_status = 'Failed'
GROUP BY u.user_id, u.user_name, u.email
HAVING failed_attempts >= 1
ORDER BY failed_attempts DESC;

WITH SessionDurations AS (
    SELECT 
        point_id, 
        TIMESTAMPDIFF(MINUTE, start_time, end_time) AS duration_minutes
    FROM Charging_Sessions
)
SELECT 
    s.location_name, AVG(sd.duration_minutes) AS avg_session_length
FROM Stations s
JOIN Charging_Points cp ON s.station_id = cp.station_id
JOIN SessionDurations sd ON cp.point_id = sd.point_id
GROUP BY s.location_name;

SELECT 
    s.location_name, s.status AS station_status, COUNT(cp.point_id) AS total_points, SUM(CASE WHEN cp.is_occupied = TRUE THEN 1 ELSE 0 END) AS occupied_points
FROM Stations s
LEFT JOIN Charging_Points cp ON s.station_id = cp.station_id
GROUP BY s.station_id, s.location_name, s.status;

SELECT 
    u.user_name, SUM(cs.energy_consumed_kwh) AS total_energy_kwh
FROM Users u
JOIN Charging_Sessions cs ON u.user_id = cs.user_id
GROUP BY u.user_id, u.user_name
ORDER BY total_energy_kwh DESC;

SELECT 
    point_id, COUNT(log_id) AS maintenance_count, SUM(cost) AS total_maintenance_expenditure
FROM Maintenance_Logs
GROUP BY point_id
HAVING total_maintenance_expenditure > 100
ORDER BY total_maintenance_expenditure DESC;

SELECT 
    s.location_name, SUM(p.amount_paid) AS total_revenue
FROM Stations s
JOIN Charging_Points cp ON s.station_id = cp.station_id
JOIN Charging_Sessions cs ON cp.point_id = cs.point_id
JOIN Payments p ON cs.session_id = p.session_id
WHERE p.payment_status = 'Success'
GROUP BY s.location_name;
