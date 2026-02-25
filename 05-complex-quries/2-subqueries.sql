-- Find average salary
select avg(Salary) as AvgSalary
from Employees;

select *
from Employees;

-- Search EmpName, Salary using SubQuery
select EmpName, Salary
from Employees
where Salary > (
    select avg(Salary)
    from Employees
);

