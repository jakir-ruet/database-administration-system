-- Filtering Data
SELECT *
FROM Employees;

-- To filter data by Id
SELECT *
FROM Employees
WHERE Id = 5;

-- To filter data by Salary using AND operator
SELECT *
FROM Employees
WHERE Salary > 50000 AND Department = 'IT';

-- To filter data by Salary using OR operator
SELECT *
FROM Employees
WHERE Salary > 50000 OR Department = 'HR';

-- To filter data by Salary using NOT operator
SELECT *
FROM Employees
WHERE NOT Salary > 50000;

-- To filter data by Name using LIKE operator
SELECT *
FROM employees
WHERE Name LIKE 'J%';  -- Starts with J

SELECT *
FROM employees
WHERE Name LIKE '%n';  -- Ends with n

SELECT *
FROM employees
WHERE Name LIKE '%ar%'; -- Contains ar

-- To filter data by Name using PATINDEX function (REGEXP alternative)
SELECT *
FROM employees
WHERE PATINDEX('%ar%', Name) > 0;

-- To filter data by Name using IN operator
SELECT *
FROM Employees
WHERE Department IN ('IT', 'HR');

-- To filter data by Name using BETWEEN operator
SELECT *
FROM Employees
WHERE Salary BETWEEN 40000 AND 60000;

-- To filter data by Name using IS NULL operator
SELECT *
FROM Employees
WHERE City IS NULL;

-- To filter data by Name using IS NOT NULL operator
SELECT *
FROM Employees
WHERE City IS NOT NULL;
