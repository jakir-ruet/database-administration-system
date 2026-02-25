select
	e.EmpId,
	p.ProjectId,
	e.DeptID,
	e.EmpName,
	p.ProjectName
FROM Employees e
LEFT JOIN Projects p
ON e.DeptID = p.DeptID

select * from Employees;
select * from Projects;
