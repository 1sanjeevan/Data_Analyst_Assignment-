CREATE DATABASE IF NOT EXISTS hotel_db;
USE hotel_db;

CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50)
);

CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2)
);

INSERT INTO users VALUES 
('21wrcxuy-67erfn','John Doe','9700000000','john@example.com','XX Street');

INSERT INTO items VALUES 
('itm-a9e8-q8fu','Tawa Paratha',18),
('itm-a07vh-aer8','Mix Veg',89),
('itm-w978-23u4','Dal Fry',120);

INSERT INTO bookings VALUES 
('bk-09f3e-95hj','2021-11-05 07:36:48','rm-bhf9-aerjn','21wrcxuy-67erfn');

INSERT INTO booking_commercials VALUES 
('q34r-3q4o8-q34u','bk-09f3e-95hj','bl-0a87y-q340','2021-11-05 12:03:22','itm-a9e8-q8fu',3),
('q3o4-ahf32-o2u4','bk-09f3e-95hj','bl-0a87y-q340','2021-11-05 12:03:22','itm-a07vh-aer8',1);