CREATE DATABASE IF NOT EXISTS clinic_db;
USE clinic_db;

CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50)
);

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description TEXT,
    amount DECIMAL(10,2),
    datetime DATETIME
);

INSERT INTO clinics VALUES
('cnc-0100001','XYZ Clinic','Mumbai','Maharashtra','India');

INSERT INTO customer VALUES
('cust-001','Jon Doe','9700000000');

INSERT INTO clinic_sales VALUES
('ord-001','cust-001','cnc-0100001',24999,'2021-09-23 12:03:22','online');

INSERT INTO expenses VALUES
('exp-001','cnc-0100001','first-aid supplies',557,'2021-09-23 07:36:48');