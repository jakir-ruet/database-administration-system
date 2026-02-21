## Query for database

1. List all databases - SQL Server instance

```bash
SELECT name
FROM sys.databases;
```

2. List all databases - shows detailed information

```bash
SELECT *
FROM sys.databases;
```

3. List all databases - system stored procedure

```bash
EXEC sp_databases;
```

4. List all databases - excluding system databases (database_id > 4)

```bash
SELECT name
FROM sys.databases
WHERE database_id > 4;
```

5. Get the name of the current database

```bash
SELECT DB_NAME() AS CurrentDatabase;
```

6. Switch to the master database

```bash
USE master;
```

## Query for table

1. Create a new database named COMPANYDB

```bash
CREATE DATABASE COMPANYDB;
USE COMPANYDB;
```

2. Create a new table named Employees with various columns

```bash
CREATE TABLE Employees (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100),
    Department NVARCHAR(50),
    Salary INT,
    City NVARCHAR(50),
    Age INT
);
```

3. Insert sample data into the Employees table

```bash
INSERT INTO Employees (Name, Department, Salary, City, Age) VALUES
('Rahim','IT',60000,'Dhaka',30),
('Karim','HR',45000,'Rajshahi',28),
('Sumon','IT',70000,'Dhaka',35),
('Jamal','Accounts',40000,'Khulna',40),
('Nayeem','IT',65000,NULL,27),
('Sakib','HR',48000,'Dhaka',29);
```

4. List all tables in the current database

```bash
SELECT name
FROM sys.tables;
```

5. Alternatively, you can use the INFORMATION_SCHEMA to list all tables

```bash
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
```

6. To list all tables along with their schema, you can use the following query

```bash
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
```

7. To list tables specifically in the 'dbo' schema

```bash
SELECT name
FROM sys.tables
WHERE schema_id = SCHEMA_ID('dbo');
```

8. To list all tables in the database using system stored procedure

```bash
EXEC sp_tables;
```

9. To list all tables in the current database using a simple query

```bash
SELECT DB_NAME() AS CurrentDatabase;
SELECT name FROM sys.tables;
```
