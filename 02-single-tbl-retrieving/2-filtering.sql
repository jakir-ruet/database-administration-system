-- Filtering Data
SELECT *
FROM Employees;

-- To filter data by Id
SELECT *
FROM Employees
WHERE EmpId = 5;

-- To filter data by Salary using AND operator
SELECT *
FROM Employees
WHERE EmpName = 'Jakir' AND Salary = 5000.00;

-- To filter data by Salary using OR operator
SELECT *
FROM Employees
WHERE Salary > 5500.00 OR EmpName = 'CRM Implementation';

-- To filter data by Salary using NOT operator
SELECT *
FROM Employees
WHERE NOT Salary > 6000.00;

-- To filter data by Name using LIKE operator
SELECT *
FROM Projects
WHERE ProjectName LIKE 'CRM%';  -- Starts with CRM

SELECT *
FROM Projects
WHERE ProjectName LIKE '%n';  -- Ends with n

SELECT *
FROM Projects
WHERE ProjectName LIKE '%Imp%'; -- Contains Imp

-- To filter data by Name using PATINDEX function (REGEXP alternative)
SELECT *
FROM Projects
WHERE PATINDEX('%ar%', ProjectName) > 0;

-- To filter data by Name using IN operator
SELECT *
FROM Projects
WHERE ProjectName IN ('Website Redesign', 'Recruitment Drive');

-- To filter data by Name using BETWEEN operator
SELECT *
FROM Employees
WHERE Salary BETWEEN 5000.00 AND 6000.00;

-- To filter data by Name using IS NULL operator
SELECT *
FROM Employees
WHERE Salary IS NULL;

-- To filter data by Name using IS NOT NULL operator
SELECT *
FROM Employees
WHERE Salary IS NOT NULL;
