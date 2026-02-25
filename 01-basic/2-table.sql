-- Create a new database named sunitdb
CREATE DATABASE sunitdb;
drop database sunitdb;
USE sunitdb;

-- Create a new table named Employees with various columns
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10, 2),
    DeptID INT
);

-- Insert sample data into the Employees table
INSERT INTO Employees VALUES
(1, 'Jakir', 5000.00, 10),
(2, 'Rahim', 5500.00, 20),
(3, 'Karim', 6000.00, 30),
(4, 'Sadek', 6500.00, 40),
(5, 'Tania', 7000.00, 50);

-- Create a new table named Projects with various columns
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    DeptID INT
);

-- Insert sample data into the Projects table
INSERT INTO Projects VALUES
(101, 'Website Redesign', 10),
(102, 'CRM Implementation', 20),
(103, 'Marketing Campaign', 30),
(104, 'Recruitment Drive', 40),
(105, 'Server Upgrade', 60);

UPDATE Projects
SET ProjectName = 'Recruitment Drive'
WHERE ProjectID = 105;

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

-- Delete the Employees and Projects tables
drop table Employees;
drop table Projects;

