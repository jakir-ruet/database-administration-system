CREATE TABLE Employees
(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DepartmentID INT,
    Salary MONEY,
    HireDate DATE
);
GO  -- Batch ends here

INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, HireDate)
VALUES
('John', 'Doe', 1, 50000, '2020-01-15'),
('Jane', 'Smith', 2, 60000, '2019-06-20'),
('Alice', 'Johnson', 1, 70000, '2021-03-10'),
('Bob', 'Brown', 3, 55000, '2022-07-05');
GO  -- Batch ends here
