-- Sorting and Limiting Results
SELECT Name, Salary
FROM Employees
ORDER BY Salary DESC;

-- Fetching only the top 5 highest paid employees
SELECT TOP 5 *
FROM Employees
ORDER BY Salary DESC;

-- OFFSET-FETCH clause (SQL Server)
SELECT *
FROM Employees
ORDER BY Salary DESC
OFFSET 2 ROWS
FETCH NEXT 5 ROWS ONLY; -- Skip 2, fetch 5
