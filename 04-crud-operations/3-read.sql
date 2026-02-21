SELECT * FROM Employees;

-- Specific column
SELECT EmpName, Salary
FROM Employees;

-- Filter
SELECT *
FROM Employees
WHERE Department = 'IT'

SELECT *
FROM Employees
ORDER by Salary DESC;
