-- Create Employees table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary NUMBER(10,2),
    DeptID INT,
    ManagerID INT,
    Status VARCHAR(10)
);

--	Insert sample data into Employees
INSERT INTO Employees VALUES (1, 'Hasan', 9000, 10, NULL, 'ACTIVE');
INSERT INTO Employees VALUES (2, 'Rahim', 7000, 10, 1, 'ACTIVE');
INSERT INTO Employees VALUES (3, 'Karim', 6500, 10, 1, 'ACTIVE');
INSERT INTO Employees VALUES (4, 'Sakib', 5000, 10, 2, 'ACTIVE');
INSERT INTO Employees VALUES (5, 'Tania', 4800, 10, 2, 'INACTIVE');
INSERT INTO Employees VALUES (6, 'Rafi', 5200, 10, 3, 'ACTIVE');

SELECT * FROM Employees;

-- Create a view to show only active employees

CREATE OR REPLACE VIEW vw_active_employees AS
SELECT
    EmpID,
    EmpName,
    Salary,
    DeptID
FROM Employees
WHERE Status = 'ACTIVE';

SELECT * FROM vw_active_employees;

-- Managers can see employees but NOT salary
CREATE OR REPLACE VIEW vw_employee_public AS
SELECT
    EmpID,
    EmpName,
    DeptID,
    ManagerID
FROM Employees;

SELECT * FROM vw_employee_public;

-- Show employee with manager name
CREATE OR REPLACE VIEW vw_employee_manager AS
SELECT
    e.EmpID,
    e.EmpName AS Employee,
    e.Salary,
    m.EmpName AS Manager,
    e.DeptID
FROM Employees e
LEFT JOIN Employees m
    ON e.ManagerID = m.EmpID;

SELECT * FROM vw_employee_manager;

-- Show department-wise salary summary
-- Aggregated View (Department Report)

CREATE OR REPLACE VIEW vw_dept_salary_summary AS
SELECT
    DeptID,
    COUNT(*) AS TotalEmployees,
    SUM(Salary) AS TotalSalary,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DeptID;

SELECT * FROM vw_dept_salary_summary;

-- Show only active employees + manager + salary grade
-- Complex View (Real Production Dashboard)
CREATE OR REPLACE VIEW vw_hr_dashboard AS
SELECT
    e.EmpID,
    e.EmpName,
    e.Salary,
    CASE
        WHEN e.Salary >= 8000 THEN 'HIGH'
        WHEN e.Salary >= 5000 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS SalaryGrade,
    m.EmpName AS Manager
FROM Employees e
LEFT JOIN Employees m
    ON e.ManagerID = m.EmpID
WHERE e.Status = 'ACTIVE';

SELECT * FROM vw_hr_dashboard;
