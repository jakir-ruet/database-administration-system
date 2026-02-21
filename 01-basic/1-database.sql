-- List all databases - SQL Server instance
SELECT name
FROM sys.databases;

-- List all databases - shows detailed information
SELECT *
FROM sys.databases;

-- List all databases - system stored procedure
EXEC sp_databases;

-- List all databases - excluding system databases (database_id > 4)
SELECT name
FROM sys.databases
WHERE database_id > 4;

-- Get the name of the current database
SELECT DB_NAME() AS CurrentDatabase;

-- Switch to the master database
USE master;
