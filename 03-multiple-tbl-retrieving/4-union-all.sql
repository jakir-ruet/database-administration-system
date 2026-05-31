-- Make Union All between Employees and Projects tables based on DeptID
SELECT
    EmpID AS ID,
    EmpName AS Name,
    'Employee' AS Type,
    DeptID
FROM Employees

UNION ALL

SELECT
    ProjectID AS ID,
    ProjectName AS Name,
    'Project' AS Type,
    DeptID
FROM Projects;
