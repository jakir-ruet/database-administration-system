CREATE DATABASE COMPANYDB;
USE COMPANYDB;

CREATE TABLE Employees(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL,
	Salary DECIMAL(10, 2) NOT NULL,
);

INSERT INTO Employees (Name, Salary) VALUES ('Fahmid', 5000.00);
INSERT INTO Employees (Name, Salary) VALUES ('Tahmid', 4500.00);
INSERT INTO Employees (Name, Salary) VALUES ('Jakaria', 5500.00);
INSERT INTO Employees (Name, Salary) VALUES ('Afrin', 4800.00);

UPDATE Employees SET Salary = 6000.00 WHERE Id = 3;

SELECT * FROM Employees;

SELECT *
FROM Employees
ORDER BY Salary DESC;

-- find the average salary
SELECT Name, Salary
FROM Employees
GROUP BY Name, Salary
ORDER BY Name DESC;

-- how many employees have the same salary
SELECT Salary, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Salary
having COUNT(*) > 1
ORDER BY Salary DESC;

-- remove duplicate salaries
SELECT DISTINCT Name, Salary
FROM Employees
GROUP BY Name, Salary
ORDER BY Salary DESC;

-- find the highest salary
SELECT MAX(Salary) AS HighestSalary
FROM Employees;

-- TOP 3 highest salaries
SELECT TOP 3 Name, Salary
FROM Employees
ORDER BY Salary DESC;

SELECT name FROM sys.tables;
DROP TABLE Employees;
DROP TABLE Departments;

-- INNER, LEFT, RIGHT, FULL OUTER JOIN
CREATE TABLE Employees(
	Id INT PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL,
	DepartmentId INT
);

INSERT INTO Employees (Id, Name, DepartmentId) VALUES
(1, 'Fahmid', 1),
(2, 'Tahmid', 2),
(3, 'Jakaria', 3),
(4, 'Afrin', NULL);

SELECT * FROM Employees;

CREATE TABLE Departments(
	Id INT PRIMARY KEY,
	DepartmentName NVARCHAR(100)
);

INSERT INTO Departments (Id, DepartmentName) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

SELECT * FROM Employees;
SELECT * FROM Departments;

-- INNER JOIN
SELECT e.Name, d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentId = d.Id;

-- LEFT JOIN
SELECT e.Name, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentId = d.Id;

-- RIGHT JOIN
SELECT e.Name, d.DepartmentName
FROM Employees e
RIGHT JOIN Departments d
ON e.DepartmentId = d.Id;

-- FULL OUTER JOIN
SELECT e.Name, d.DepartmentName
FROM Employees e
FULL OUTER JOIN Departments d
ON e.DepartmentId = d.Id;
