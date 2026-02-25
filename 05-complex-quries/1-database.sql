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

-- Create a new table named Departments with various columns
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    DeptID INT
);

-- Insert sample data into the Departments table
INSERT INTO Projects VALUES
(101, 'Website Redesign', 10),
(102, 'CRM Implementation', 20),
(103, 'Marketing Campaign', 30),
(104, 'Recruitment Drive', 40),
(105, 'CRM Implementation', 40),
(106, 'Server Upgrade', 60);

UPDATE Projects
SET ProjectName = 'Recruitment Drive'
WHERE ProjectID = 105;

-- List all tables in the current database
SELECT name
FROM sys.tables;

select * from Employees;
select * from Projects;
