-- 1. Remove 'connector_type' from Charging_Points
ALTER TABLE Charging_Points 
DROP COLUMN connector_type;

-- 2. Remove 'wallet_balance' from Users
ALTER TABLE Users 
DROP COLUMN wallet_balance;

-- 3. Remove 'license_plate' and 'connector_type' from Vehicles
ALTER TABLE Vehicles 
DROP COLUMN license_plate,
DROP COLUMN connector_type;

-- 4. Remove 'technician_name' from Maintenance_Logs
ALTER TABLE Maintenance_Logs 
DROP COLUMN technician_name;

INSERT INTO Stations (location_name, capacity_kw, status) VALUES 
('Savarkundla 220KV Substation Hub', 220, 'Active'),
('Damnagar Sardar Chowk', 150, 'Active'),
('Amreli Highway Junction', 400, 'Maintenance');
 SELECT * FROM Stations;


INSERT INTO Charging_Points (station_id, is_occupied) VALUES 
(1, FALSE), -- Point at Savarkundla 220KV Hub Ready for use
(1, TRUE),  -- Point at Savarkundla 220KV Hub (Currently in use) total 2 points 
(2, FALSE), -- Point at Damnagar Sardar Chowk
(2, FALSE), -- Point at Damnagar Sardar Chowk Both are ready to use
(3, TRUE);  -- Point at Amreli Highway Junction (Occupied)
 SELECT * FROM Charging_Points;

 
INSERT INTO Users (user_name, email) VALUES 
('Krish Patel', 'krishp@gmail.com'),
('Tapan Makadiya', 'tapanmakadiya@gmail.com'),
('Ravi Kumar', 'rkumar.getco@gmail.com'),
('Daksh Bhingradiya', 'dbhingradiya@gmail.com' ),
('Arnav Jain', 'ajain@gmail.com');
SELECT * FROM Users;


INSERT INTO Vehicles (user_id, model_name, battery_capacity_kwh) VALUES 
(1, 'Tata Nexon EV', 30.20),
(2, 'MG ZS EV', 50.30),
(3, 'Hyundai Kona Electric', 39.20),
(4, 'Mahindra XUV400', 34.50),
(5, 'BYD Atto 3', 60.48);
SELECT * FROM Vehicles;


INSERT INTO Charging_Sessions (user_id, vehicle_id, point_id, start_time, end_time, energy_consumed_kwh, total_cost) VALUES 
-- Session at Savarkundla Hub (1st point)
(1, 1, 6, '2026-05-04 08:30:00', '2026-05-04 09:45:00', 18.20, 182.00),

-- Session at Savarkundla Hub (2nd point)
(2, 2, 7, '2026-05-04 11:00:00', '2026-05-04 13:00:00', 45.50, 455.00),

-- Session at Damnagar Sardar Chowk (1st point)
(3, 3, 8, '2026-05-04 14:15:00', '2026-05-04 15:30:00', 12.00, 120.00),

-- A heavy session at Damnagar Sardar Chowk (2nd point)
(4, 4, 9, '2026-05-04 18:00:00', '2026-05-04 20:30:00', 55.75, 557.50),

-- Late night charging session at Amreli Highway Junction
(5, 5, 10, '2026-05-04 22:00:00', '2026-05-05 02:00:00', 60.00, 600.00);
SELECT * FROM Charging_Sessions;

INSERT INTO Maintenance_Logs (point_id, maintenance_date, issue_description, parts_replaced, cost)
VALUES 
(6, '2024-01-10', 'Routine annual inspection', 'None', 75.00),
(6, '2024-01-15', 'Cable insulation wear detected', '5m Charging Cable', 210.00),
(6, '2024-02-02', 'Communication error with network', 'Internal Wi-Fi Module', 85.50),
(7, '2024-02-14', 'Emergency stop button stuck', 'E-Stop Switch Assembly', 62.25),
(7, '2024-03-01', 'Lightning strike surge damage', 'Surge Protector & Controller Board', 540.00),
(7, '2024-03-12', 'LED indicator lights failed', 'LED Strip', 15.00),
(7, '2024-03-25', 'Ground fault detected', 'Grounding Wire', 45.00),
(8, '2024-04-05', 'Payment terminal unresponsive', 'NFC Card Reader', 125.00),
(9, '2024-04-18', 'Enclosure lock broken', 'Mechanical Door Lock', 35.00),
(10, '2024-05-01', 'Overheating during peak usage', 'Cooling System Thermal Paste', 25.00);

SET SQL_SAFE_UPDATES = 0;

UPDATE  Maintenance_Logs
SET maintenance_date = NOW() where issue_description = 'Overheating during peak usage';
SET SQL_SAFE_UPDATES = 1;

UPDATE Maintenance_Logs 
SET maintenance_date = DATE_ADD(maintenance_date, INTERVAL 2 YEAR)
WHERE YEAR(maintenance_date) != 2026;

SELECT * FROM Maintenance_Logs;

INSERT INTO Payments (session_id, amount_paid, payment_method, payment_status)
VALUES 
(1, 450.50, 'UPI', 'Success'),
(2, 120.00, 'Wallet', 'Success'),
(3, 890.00, 'Credit Card', 'Failed'),
(4, 340.25, 'RFID Card', 'Success'),
(5, 560.00, 'UPI', 'Pending');
SELECT * FROM Payments;
