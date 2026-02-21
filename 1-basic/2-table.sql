-- Create a new database named COMPANYDB
CREATE DATABASE COMPANYDB;
USE COMPANYDB;

-- Create a new table named Employees with various columns
CREATE TABLE Employees (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100),
    Department NVARCHAR(50),
    Salary INT,
    City NVARCHAR(50),
    Age INT
);

-- Insert sample data into the Employees table
INSERT INTO Employees (Name, Department, Salary, City, Age) VALUES
('Rahim','IT',60000,'Dhaka',30),
('Karim','HR',45000,'Rajshahi',28),
('Sumon','IT',70000,'Dhaka',35),
('Jamal','Accounts',40000,'Khulna',40),
('Nayeem','IT',65000,NULL,27),
('Sakib','HR',48000,'Dhaka',29);

-- List all tables in the current database
SELECT name
FROM sys.tables;

-- Alternatively, you can use the INFORMATION_SCHEMA to list all tables
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- To list all tables along with their schema, you can use the following query
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- To list tables specifically in the 'dbo' schema
SELECT name
FROM sys.tables
WHERE schema_id = SCHEMA_ID('dbo');

-- To list all tables in the database using system stored procedure
EXEC sp_tables;

-- To list all tables in the current database using a simple query
SELECT DB_NAME() AS CurrentDatabase;
SELECT name FROM sys.tables;
