SELECT EmpName
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);
