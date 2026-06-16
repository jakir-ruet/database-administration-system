CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    ManagerID INT,
    Designation VARCHAR(50)
);

INSERT INTO Employees VALUES (1, 'Hasan', 10, NULL, 'CEO');
INSERT INTO Employees VALUES (2, 'Rahim', 10, 1, 'Manager');
INSERT INTO Employees VALUES (3, 'Karim', 10, 1, 'Manager');

INSERT INTO Employees VALUES (4, 'Sakib', 10, 2, 'Software Engineer');
INSERT INTO Employees VALUES (5, 'Tania', 10, 2, 'QA Engineer');
INSERT INTO Employees VALUES (6, 'Rafi', 10, 3, 'DevOps Engineer');
INSERT INTO Employees VALUES (7, 'Nadia', 10, 3, 'DBA');

-- Show each employee with their direct manager name
SELECT
    e.EmpID,
    e.EmpName AS Employee,
    e.Designation,
    m.EmpName AS Manager
FROM Employees e
LEFT JOIN Employees m
    ON e.ManagerID = m.EmpID
ORDER BY e.EmpID;

-- Manager with their team size
SELECT
    m.EmpName AS Manager,
    COUNT(e.EmpID) AS TeamSize
FROM Employees e
JOIN Employees m
    ON e.ManagerID = m.EmpID
GROUP BY m.EmpName;

-- Show org structure level 2 (Manager → Employee → Sub-Employee)
SELECT
    e.EmpName AS Employee,
    m.EmpName AS Manager,
    m2.EmpName AS TopManager
FROM Employees e
LEFT JOIN Employees m
    ON e.ManagerID = m.EmpID
LEFT JOIN Employees m2
    ON m.ManagerID = m2.EmpID;
