CREATE DATABASE IF NOT EXISTS SmartCity_EV_DBMS;
USE SmartCity_EV_DBMS;

-- 1. Stations Table
CREATE TABLE Stations (
    station_id INT PRIMARY KEY AUTO_INCREMENT,
    location_name VARCHAR(100) NOT NULL,
    capacity_kw INT DEFAULT 220, -- Based on 220 KV substation context
    status ENUM('Active', 'Maintenance', 'Inactive') DEFAULT 'Active'
);

-- 2. Charging Points Table
CREATE TABLE Charging_Points (
    point_id INT PRIMARY KEY AUTO_INCREMENT,
    station_id INT,
    is_occupied BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (station_id) REFERENCES Stations(station_id) ON DELETE CASCADE
);


-- 3. Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- 4. Vehicles Table
CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    model_name VARCHAR(100),
    battery_capacity_kwh DECIMAL(5, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- 5. Charging Sessions Table
CREATE TABLE Charging_Sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    vehicle_id INT,
    point_id INT,
    start_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    end_time DATETIME,
    energy_consumed_kwh DECIMAL(10, 2),
    total_cost DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
    FOREIGN KEY (point_id) REFERENCES Charging_Points(point_id)
);
-- 6. Maintenance Table
CREATE TABLE Maintenance_Logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    point_id INT,
    maintenance_date DATE,
    issue_description TEXT,
    parts_replaced VARCHAR(255),
    cost DECIMAL(10, 2),
    FOREIGN KEY (point_id) REFERENCES Charging_Points(point_id)
);

-- 7. Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount_paid DECIMAL(10, 2),
    payment_method ENUM('Wallet', 'Credit Card', 'UPI', 'RFID Card'),
    payment_status ENUM('Success', 'Failed', 'Pending') DEFAULT 'Success',
    FOREIGN KEY (session_id) REFERENCES Charging_Sessions(session_id)
);
