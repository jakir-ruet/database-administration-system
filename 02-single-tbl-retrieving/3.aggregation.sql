-- How many employees name Jakir
SELECT COUNT(*) AS Employees_Name
FROM Employees
WHERE EmpName = 'Jakir';

-- Show all records of employees
SELECT *
FROM Employees;

-- How many employees in IT department
SELECT COUNT(*) AS Employees_Name
FROM Employees
WHERE EmpName = 'Rahim';

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

-- Group employees by EmpId and count total employees
SELECT EmpId, COUNT(*) AS Total_Employees
FROM Employees
GROUP BY EmpId;

-- Group employees by Salary and count total employees salary
SELECT Salary, COUNT(*) AS Total_Employees
FROM Employees
GROUP BY Salary;

-- Group employees by Department and calculate the average salary in each department
SELECT DeptID, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DeptID
HAVING SUM(Salary) > 6000;

select * from Employees;
