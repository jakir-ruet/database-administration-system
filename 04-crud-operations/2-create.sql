-- Create Employees table
CREATE TABLE Employees(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	EmpName NVARCHAR(50),
	Department NVARCHAR(50),
	Salary DECIMAL(18, 2),
	JoiningDate DATE
);

-- IDENTITY(1,1) → Auto-increment ID

-- Insert data
INSERT INTO Employees(EmpName, Department, Salary, JoiningDate) VALUES
('Jakir', 'IT', 9000.00, '2020-06-10'),
('Mehedi', 'HR', 8000.00, '2020-06-11'),
('Siam', 'IT', 7000.00, '2020-06-12');

SELECT * FROM Employees;
