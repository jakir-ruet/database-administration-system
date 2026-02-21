USE master

SELECT Gender, Age, COUNT(Gender) AS TotalEmployee
FROM dbo.EmployeeInfo
WHERE Age <= 35
GROUP BY Gender, Age