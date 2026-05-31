-- Create a new table named Employees with various columns
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10, 2),
    DeptID INT
);

-- Insert sample data into the Employees table
INSERT INTO Employees(EmpID, EmpName, Salary, DeptID)
VALUES (1, 'Jakir', 5000.00, 10);
INSERT INTO Employees(EmpID, EmpName, Salary, DeptID)
VALUES (2, 'Rahim', 5500.00, 20);
INSERT INTO Employees(EmpID, EmpName, Salary, DeptID)
VALUES (3, 'Karim', 6000.00, 30);
INSERT INTO Employees(EmpID, EmpName, Salary, DeptID)
VALUES (4, 'Sadek', 6500.00, 40);
INSERT INTO Employees(EmpID, EmpName, Salary, DeptID)
VALUES (5, 'Tania', 7000.00, 50);

SELECT *
FROM Employees;

-- Create a new table named Departments with various columns
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    DeptID INT
);

-- Insert sample data into the Departments table
INSERT INTO Projects
VALUES (101, 'Website Redesign', 10);
INSERT INTO Projects
VALUES (102, 'CRM Implementation', 20);
INSERT INTO Projects
VALUES (103, 'Marketing Campaign', 30);
INSERT INTO Projects
VALUES (104, 'Recruitment Drive', 40);
INSERT INTO Projects
VALUES (105, 'Server Upgrade', 60);

SELECT *
FROM Projects;

-- Make Inner Join between Employees and Projects tables based on DeptID
SELECT e.DeptID,
       e.EmpID,
       e.EmpName,
       p.ProjectName,
       p.ProjectID
FROM Employees e
INNER JOIN Projects p
ON e.DeptID = p.DeptID;

-- Make Left Join (Left Outer Join) between Employees and Projects tables based on DeptID
SELECT e.DeptID,
       e.EmpID,
       e.EmpName,
       p.ProjectName,
       p.ProjectID
FROM Employees e
LEFT JOIN Projects p
ON e.DeptID = p.DeptID;

-- Make Right Join (Right Outer Join) between Employees and Projects tables based on DeptID
SELECT e.DeptID,
       e.EmpID,
       e.EmpName,
       p.ProjectName,
       p.ProjectID
FROM Employees e
RIGHT JOIN Projects p
ON e.DeptID = p.DeptID;

-- Make Full Join (Full Outer Join) between Employees and Projects tables based on DeptID
SELECT e.DeptID,
       e.EmpID,
       e.EmpName,
       p.ProjectName,
       p.ProjectID
FROM Employees e
FULL OUTER JOIN Projects p
ON e.DeptID = p.DeptID;
