--
select DeptID, EmpName, Salary
from Employees
WHERE DeptID in (10, 20, 30, 40, 50, 60);

select DeptID, EmpName, Salary
from Employees
where DeptID not in (50, 60, 70);

select * from Projects;

select *
from Projects
where ProjectName in ('CRM Implementation');

select *
from Projects
where ProjectName like 'CRM%';

select *
from Employees
where DeptID in (
    select DeptID
    from Projects
    where ProjectName = 'Website Redesign'
);

select *
from Employees
where DeptID in (
    select DeptID
    from Projects
    where ProjectName = 'Website Redesign'
);
