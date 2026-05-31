-- Make Union between Employees and Projects tables based on DeptID
SELECT
    EmpID AS ID,
    EmpName AS Name,
    'Employee' AS Type,
    DeptID
FROM Employees

UNION

SELECT
    ProjectID AS ID,
    ProjectName AS Name,
    'Project' AS Type,
    DeptID
FROM Projects;
