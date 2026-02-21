-- How many employees in Dhaka City
SELECT COUNT(*) AS Employees_in_Dhaka
FROM Employees
WHERE City = 'Dhaka';

-- Show all records of employees
SELECT *
FROM Employees;

-- How many employees in IT department
SELECT COUNT(*) AS In_IT_Dept
FROM Employees
WHERE Department = 'IT';

-- What is the MAX salary of employees
SELECT MAX(Salary) AS Max_Salary
FROM Employees;

-- What is the MIN salary of employees
SELECT MIN(Salary) AS Min_Salary
FROM Employees;

-- What is the SUM of salaries of employees
SELECT SUM(Salary) AS Sum_of_Salaries
FROM Employees;

-- What is the average salary of employees
SELECT AVG(Salary) AS Avg_Salary
FROM Employees;

-- Show all records of employees
SELECT *
FROM Employees;

-- Group employees by Id and count total employees
SELECT Id, COUNT(*) AS Total_Employees
FROM Employees
GROUP BY Id;

-- Group employees by Department and count total employees in each department
SELECT Department, COUNT(*) AS Total_Employees
FROM Employees
GROUP BY Department;

-- Group employees by Department and calculate the average salary in each department
SELECT Department, AVG(Salary) AS Avg_Salary
FROM Employees
GROUP BY Department
HAVING AVG(Salary) > 45000;
