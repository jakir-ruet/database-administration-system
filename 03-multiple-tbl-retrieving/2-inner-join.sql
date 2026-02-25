select * from Employees;

select * from Projects;

-- Inner join
-- select e.EmpName, p.ProjectName
-- from Employees e
-- inner join Projects p
-- on e.DeptId = p.DeptId;

select
	e.EmpId,
	p.ProjectId,
	e.DeptID,
	e.EmpName,
	p.ProjectName
from
Employees e
inner join Projects p
on e.DeptId = p.DeptId;

-- Intersection (A ∩ B)
-- Returns only matching rows from both tables.
-- Match DeptIds > 10, 20, 30, 40
