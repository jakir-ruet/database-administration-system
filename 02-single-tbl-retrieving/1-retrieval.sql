-- Retrieve all columns and rows from the employees table
SELECT *
FROM employees;

-- Retrieve only the Name and Salary columns from the employees table
SELECT Name AS EmployeeName, Salary AS EmployeeSalary
FROM employees;

-- Retrieve distinct cities from the employees table
SELECT DISTINCT City
FROM employees;
