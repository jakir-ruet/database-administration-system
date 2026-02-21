-- List all databases - SQL Server instance
select name
from sys.databases;

-- List all databases - shows detailed information
select *
from sys.databases;

-- List all databases - system stored procedure
EXEC sp_databases;

-- List all databases - excluding system databases (database_id > 4)
select name
from sys.databases
where database_id > 4;

-- Get the name of the current database
select DB_NAME() AS CurrentDatabase;

-- Switch to the master database
use master;
drop database sunitdb;
