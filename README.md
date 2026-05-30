## More About Me – [Take a Look!](http://www.mjakaria.me)

## Welcome to Database Learning

### Introduction

1. What is SQL?
   SQL (Structured Query Language) is the standard programming language used to manage and manipulate relational databases. It allows users to query, insert, update, and delete data stored in a database.
2. Installing SQL Server on Windows
3. Installing SQL Server on Mac (via Docker or remote access)

### Welcome to Oracle Database 21c

![Architecture of Oracle](/img/oracle-architecture-simplified.png)

### Core Definition

An Oracle Database system consists of **two** main components:

- Instance (Memory + Background Processes)
- Database (Physical Files on Disk)

> **Key Distinction:**
>
> - An instance can mount and open only one database.
> - A database can be mounted and opened by one or more instances (Real Application Clusters/RAC).

### The instance

The instance is the software layer that manages the database. It exists in volatile memory (RAM) and comprises:

#### **System Global Area (SGA)**

A group of shared memory structures that contain data and control information for the instance. All server and background processes share the SGA.

| Component                 | Standard Purpose                                                       | Mandatory? |
| ------------------------- | ---------------------------------------------------------------------- | ---------- |
| **Shared Pool**           | Caches SQL/PLSQL and data dictionary (execution plans + metadata).     | Yes        |
| **Database Buffer Cache** | Stores data blocks read from datafiles for fast access.                | Yes        |
| **Redo Log Buffer**       | Stores change records (redo) for recovery before writing to redo logs. | Yes        |
| **Large Pool**            | Used for RMAN, parallel queries, shared server memory.                 | No         |
| **Java Pool**             | Memory for Oracle JVM (Java stored procedures).                        | No         |
| **Streams Pool**          | Used for replication (Streams / GoldenGate support).                   | No         |
| **Fixed SGA**             | Internal Oracle control structures and runtime metadata.               | Yes        |

#### **Background Processes**

Processes that run continuously to manage I/O, monitor other processes, and perform maintenance.

Mandatory Background Processes

| Process  | Full Name       | Standard Function                                        |
| -------- | --------------- | -------------------------------------------------------- |
| **DBWn** | Database Writer | Writes dirty buffers from buffer cache → datafiles       |
| **LGWR** | Log Writer      | Writes redo buffer → online redo logs (commit / timeout) |
| **CKPT** | Checkpoint      | Updates datafiles & control files with checkpoint info   |
| **SMON** | System Monitor  | Instance recovery + cleanup of temporary segments        |
| **PMON** | Process Monitor | Cleans failed sessions, releases locks, frees resources  |
| **RECO** | Recoverer       | Resolves distributed transaction failures (2PC)          |
| **MMON** | Memory Monitor  | Collects AWR stats and triggers ADDM                     |

Optional Background Processes

| Process  | Full Name                       | Standard Function                                                                    |
| -------- | ------------------------------- | ------------------------------------------------------------------------------------ |
| **ARCn** | Archiver Process                | Copies online redo log files to archive destinations (ARCHIVELOG mode)               |
| **CJQn** | Job Queue Coordinator           | Manages and schedules database jobs                                                  |
| **MMAN** | Memory Manager                  | Dynamically manages and resizes SGA memory (Automatic Memory Management)             |
| **RVWR** | Recovery Writer                 | Writes flashback data to flashback logs (Flashback Database)                         |
| **VKRM** | Virtual Kernel Resource Manager | Manages resource allocation via Oracle Resource Manager (also used in 23ai features) |

#### **Program Global Area (PGA)**

A private memory region for each server process. Not shared. Contains:

- Sort area (ORDER BY, GROUP BY)
- Session-specific information
- Cursor state
- Hash join area

> **Standard rule:**
>
> - PGA = Process-specific,
> - SGA = Shared across all processes.

### The Database

The database is the physical storage layer on persistent disk. It consists of at least three mandatory file types. Mandatory Files (required to open the database):

#### Control Files

- `Content:` Database name, timestamp, data file locations, redo log file locations, current log sequence number, checkpoint information.
- `Count:` Minimum 2 (Oracle recommends 3 on separate disks).
- `Size:` Typically 10–100 MB.

#### Data Files

- `Content:` Actual table rows, index blocks, LOBs, undo data (if undo tablespace).
- `Count:` At least 1 (system tablespace).
- `Format:` Oracle proprietary format (not readable by OS directly).

#### Online Redo Log Files

- `Content:` Redo entries recording all changes to the database.
- `Configuration:` Minimum 2 groups (Oracle recommends 3+ groups).
- `Behavior:` Circular writing – when one group fills, Oracle switches to the next.

Optional but Standard Files

| File Type                         | Standard Purpose                                                 |
| --------------------------------- | ---------------------------------------------------------------- |
| **Parameter File (SPFILE/PFILE)** | Stores initialization parameters (memory, processes, file paths) |
| **Password File**                 | Enables remote SYSDBA / SYSOPER authentication                   |
| **Archived Redo Logs**            | Copies of redo logs for media recovery                           |
| **Flashback Logs**                | Supports Flashback Database (point-in-time recovery)             |

The Three Opening Stages (Oracle Startup Stages)

| Stage       | Command              | What Happens                                               | Access           |
| ----------- | -------------------- | ---------------------------------------------------------- | ---------------- |
| **NOMOUNT** | STARTUP NOMOUNT      | Instance starts, SGA allocated, background processes start | No DB access     |
| **MOUNT**   | ALTER DATABASE MOUNT | Control file read, DB associated with instance             | DBA only         |
| **OPEN**    | ALTER DATABASE OPEN  | Datafiles + redo logs opened                               | Full user access |

### Oracle System Users and Their Functions

| Category              | Users       | Function / Purpose                                                         | Real Example Use                           |
| --------------------- | ----------- | -------------------------------------------------------------------------- | ------------------------------------------ |
| Core DBA              | SYS         | Full database owner, controls data dictionary and internal database engine | `STARTUP; SHUTDOWN IMMEDIATE;`             |
|                       | SYSTEM      | General administrative user for database management tasks                  | `CREATE USER app_user IDENTIFIED BY pass;` |
| Monitoring            | DBSNMP      | Used by Oracle Enterprise Manager (OEM) for database monitoring            | OEM health monitoring dashboards           |
|                       | APPQOSSYS   | Oracle Quality of Service (QoS) monitoring for performance tracking        | Tracks workload and DB performance         |
| Application Framework | APEX_XXXXXX | Oracle APEX schema used for web-based applications                         | Running APEX dashboards and low-code apps  |
| Application Framework | FLOWS_FILES | Stores uploaded files for Oracle APEX applications                         | File upload/download in APEX apps          |
|                       | ANONYMOUS   | Enables HTTP/XML DB access for web services                                | REST/XML web service access                |
| XML & Search          | XDB         | XML Database engine for storing and querying XML data                      | Storing XML documents in database          |
|                       | CTXSYS      | Oracle Text engine for full-text search indexing                           | Full-text search using `CONTAINS()`        |
| Spatial & Analytics   | MDSYS       | Oracle Spatial engine for GIS and location-based data                      | Maps, GPS, geospatial queries              |
|                       | OLAPSYS     | OLAP cube processing engine for analytics                                  | Data warehouse reporting and analytics     |
| Multimedia (Legacy)   | ORDSYS      | Multimedia metadata system (legacy feature)                                | Image/video metadata handling              |
|                       | ORDPLUGINS  | Multimedia processing plugins (legacy feature)                             | File format conversion                     |
|                       | OUTLN       | Stores SQL execution outlines (deprecated feature)                         | Query optimization plan storage            |
| Replication           | GGSYS       | Oracle GoldenGate system user for data replication                         | Real-time data sync between databases      |

#### Difference Between DBMS and RDBMS

Although both DBMS and RDBMS are used to store information in a physical database, there are significant differences between them. Below is a comparison of the main differences:

| No. | DBMS                                                                     | RDBMS                                                                                                                     |
| --- | ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------- |
| 1   | DBMS applications store data as files.                                   | RDBMS applications store data in a tabular form.                                                                          |
| 2   | Data is generally stored in hierarchical or navigational form.           | Data is stored in tables with identifiers called primary keys.                                                            |
| 3   | Normalization is not present in DBMS.                                    | Normalization is present in RDBMS.                                                                                        |
| 4   | DBMS does not apply any security regarding data manipulation.            | RDBMS defines integrity constraints to ensure ACID properties (AtomiProjectName, Consistency, Isolation, and Durability). |
| 5   | DBMS uses a file system, so there is no relationship between tables.     | RDBMS stores data in tables with relationships between them.                                                              |
| 6   | DBMS provides uniform methods to access data.                            | RDBMS supports a tabular structure and relationships for accessing stored information.                                    |
| 7   | DBMS does not support distributed databases.                             | RDBMS supports distributed databases.                                                                                     |
| 8   | DBMS is suited for small organizations with single users and small data. | RDBMS is designed to handle large data and support multiple users.                                                        |
| 9   | Examples: File systems, XML, etc.                                        | Examples: MySQL, PostgreSQL, SQL Server, Oracle, etc.                                                                     |

### Database Languages

A database system provides various languages for defining, manipulating, and controlling data. These include the

- **Data Definition Language (DDL)**,
- **Data Manipulation Language (DML)**,
- **Data Control Language (DCL)**, and
- **Transaction Control Language (TCL)**.

In practice, these languages are not separate but form parts of a single database language, such as **SQL**.

#### Data Definition Language (DDL)

DDL is used to specify the database schema. It is used for creating and altering database structures such as tables, schemas, indexes, and constraints. The following operations are part of DDL:

| **Operation** | **Description**                                                       | **Example**                                            |
| ------------- | --------------------------------------------------------------------- | ------------------------------------------------------ |
| CREATE        | To create a database instance or objects like tables, schemas, etc.   | `CREATE TABLE Employees (ID INT, Name VARCHAR(100));`  |
| ALTER         | To alter the structure of the database or database objects.           | `ALTER TABLE Employees ADD COLUMN Age INT;`            |
| DROP          | To drop database instances or objects (e.g., tables, schemas).        | `DROP TABLE Employees;`                                |
| TRUNCATE      | To delete all records from a table without removing the table itself. | `TRUNCATE TABLE Employees;`                            |
| RENAME        | To rename a database object (e.g., a table, column, etc.).            | `RENAME TABLE Employees TO Staff;`                     |
| COMMENT       | To add comments to database objects (e.g., tables, columns).          | `COMMENT ON COLUMN Employees.Name IS 'Employee Name';` |

Since these commands define or update the schema, they are categorized as part of **Data Definition Language**.

#### Data Manipulation Language (DML)

DML is used for accessing and manipulating data stored in a database. The following operations are part of DML:

| Command    | Description                              | Example                                                      |
| ---------- | ---------------------------------------- | ------------------------------------------------------------ |
| **SELECT** | To read records from one or more tables. | `SELECT * FROM Employees;`                                   |
| **INSERT** | To insert records into tables.           | `INSERT INTO Employees (Name, Age) VALUES ('John Doe', 30);` |
| **UPDATE** | To update existing data in a table.      | `UPDATE Employees SET Age = 31 WHERE Name = 'John Doe';`     |
| **DELETE** | To delete records from a table.          | `DELETE FROM Employees WHERE Name = 'John Doe';`             |

#### Data Control Language (DCL)

DCL is used for granting and revoking access to the database. The main DCL operations are:

| Command    | Description                              | Example                                      |
| ---------- | ---------------------------------------- | -------------------------------------------- |
| **GRANT**  | To give access privileges to a user.     | `GRANT SELECT ON Employees TO user_name;`    |
| **REVOKE** | To remove access privileges from a user. | `REVOKE SELECT ON Employees FROM user_name;` |

Although DDL, DML, and DCL are often considered separate languages, they are actually components of a single database language like SQL.

#### Transaction Control Language (TCL)

TCL commands manage changes to the database that are made using DML. These changes can either be committed (saved) or rolled back (undone) using TCL commands:

| Command      | Description                                                         | Example     |
| ------------ | ------------------------------------------------------------------- | ----------- |
| **COMMIT**   | To save all changes made by DML commands (INSERT, UPDATE, DELETE).  | `COMMIT;`   |
| **ROLLBACK** | To undo changes made by DML commands and revert the database state. | `ROLLBACK;` |

### DELETE vs TRUNCATE vs DROP

| Feature                  | DELETE                 | TRUNCATE         | DROP               |
| ------------------------ | ---------------------- | ---------------- | ------------------ |
| Type                     | DML                    | DDL              | DDL                |
| Removes rows             | Yes                    | Yes              | Yes                |
| Removes table structure  | No                     | No               | Yes                |
| WHERE clause allowed     | Yes                    | No               | No                 |
| Rollback possible        | Yes                    | No (auto commit) | No (auto commit)   |
| Trigger fires            | Yes (`DELETE` trigger) | No               | No                 |
| Transaction logging      | Fully logged           | Minimal logging  | Metadata operation |
| Speed                    | Slower                 | Faster           | Fastest            |
| Space released           | Usually No             | Yes              | Yes                |
| Table remains            | Yes                    | Yes              | No                 |
| Index remains            | Yes                    | Yes              | Removed            |
| Constraints remain       | Yes                    | Yes              | Removed            |
| Grants/privileges remain | Yes                    | Yes              | Removed            |
| Recreate table needed    | No                     | No               | Yes                |
| Used in production       | Very common            | Common           | Risky/Dangerous    |

### Datatype

```bash
Oracle Datatypes
│
├── Character Datatypes
│   │
│   ├── CHAR(size)
│   │      → Fixed-length text
│   │      → Use: Gender, Country Code, Status
│   │
│   ├── VARCHAR2(size)
│   │      → Variable-length text
│   │      → Use: Name, Email, Address
│   │
│   ├── NCHAR(size)
│   │      → Fixed Unicode text
│   │      → Use: Multilingual fixed values
│   │
│   ├── NVARCHAR2(size)
│   │      → Variable Unicode text
│   │      → Use: Bangla, Arabic, Japanese text
│   │
│   └── CLOB / NCLOB
│          → Large text data
│          → Use: Articles, Logs, Documents
│
├── Numeric Datatypes
│   │
│   ├── NUMBER(p,s)
│   │      → Integer/Decimal numbers
│   │      → Use: ID, Salary, Price, Quantity
│   │
│   ├── FLOAT
│   │      → Approximate decimal values
│   │      → Use: Scientific calculations
│   │
│   ├── BINARY_FLOAT
│   │      → 32-bit floating-point number
│   │      → Use: Fast mathematical operations
│   │
│   └── BINARY_DOUBLE
│          → 64-bit floating-point number
│          → Use: High-precision scientific data
│
├── Date & Time Datatypes
│   │
│   ├── DATE
│   │      → Stores date and time
│   │      → Use: Order date, Joining date
│   │
│   ├── TIMESTAMP
│   │      → Precise date and time
│   │      → Use: Audit logs, Event tracking
│   │
│   ├── TIMESTAMP WITH TIME ZONE
│   │      → Time with timezone info
│   │      → Use: Global applications
│   │
│   ├── INTERVAL YEAR TO MONTH
│   │      → Year/month duration
│   │      → Use: Subscription period
│   │
│   └── INTERVAL DAY TO SECOND
│          → Day/time duration
│          → Use: Time difference calculations
│
├── Large Object (LOB) Datatypes
│   │
│   ├── BLOB
│   │      → Binary large object
│   │      → Use: Images, PDFs, Videos
│   │
│   ├── CLOB
│   │      → Character large object
│   │      → Use: Large descriptions, XML
│   │
│   ├── NCLOB
│   │      → Unicode large text
│   │      → Use: Multilingual documents
│   │
│   └── BFILE
│          → External binary file
│          → Use: Files stored outside database
│
├── RAW & Binary Datatypes
│   │
│   ├── RAW(size)
│   │      → Binary/raw data
│   │      → Use: Encryption keys, Hash values
│   │
│   └── LONG RAW
│          → Large binary data (legacy)
│          → Use: Old systems compatibility
│
└── Row Identifier Datatypes
    │
    ├── ROWID
    │      → Physical row address
    │      → Use: Fast row access
    │
    └── UROWID
           → Universal row identifier
           → Use: Advanced storage structures
```

#### Most use case in Enterprise Applications

```bash
Enterprise Applications
│
├── Primary Key           → NUMBER
├── Username              → VARCHAR2
├── Password Hash         → VARCHAR2 / RAW
├── Email                 → VARCHAR2
├── Mobile Number         → VARCHAR2
├── Amount / Salary       → NUMBER(10,2)
├── Created Date          → DATE
├── Audit Timestamp       → TIMESTAMP
├── Profile Picture       → BLOB
├── Product Description   → CLOB
└── Multilingual Content  → NVARCHAR2/NCLOB
```

### Types of SQL Statements in Oracle Database

```bash
SQL Statements
│
├── DDL (Data Definition Language)
│   │
│   ├── CREATE
│   ├── ALTER
│   ├── DROP
│   ├── TRUNCATE
│   └── RENAME
│
├── DML (Data Manipulation Language)
│   │
│   ├── INSERT
│   ├── UPDATE
│   ├── DELETE
│   └── MERGE
│
├── DQL (Data Query Language)
│   │
│   └── SELECT
│
├── TCL (Transaction Control Language)
│   │
│   ├── COMMIT
│   ├── ROLLBACK
│   └── SAVEPOINT
│
└── DCL (Data Control Language)
    │
    ├── GRANT
    └── REVOKE
```

```bash
docker logout container-registry.oracle.com
docker login container-registry.oracle.com # Token `PDZbBJkFDDKLIhtm6v=`
```

```bash
docker run -d \
  --name oracle-xe \
  -p 1521:1521 \
  -e ORACLE_PASSWORD=Sql054003 \
  gvenzl/oracle-xe:21-slim
```

```bash
docker run -d --name oracle-xe \
  -p 1521:1521 \
  -e ORACLE_PASSWORD=Sql054003 \
  gvenzl/oracle-xe:21-slim
```

```bash
curl -I https://container-registry.oracle.com/v2/
```

```bash
docker exec -it oracle-xe sqlplus system/Sql054003@localhost:1521/XEPDB1
```

[Install SQLDeveloper](https://www.oracle.com/database/sqldeveloper/vscode/)

| Setting  | Value     |
| -------- | --------- |
| Host     | localhost |
| Port     | 1521      |
| Service  | XEPDB1    |
| User     | system    |
| Password | Sql054003 |

### CURD Operations

```bash
SELECT username FROM dba_users ORDER BY username;
CREATE USER Jakir IDENTIFIED BY Sql054003;
GRANT CONNECT, RESOURCE TO jakir; # Full developer permissions - Optional
ALTER USER jakir ACCOUNT UNLOCK; # Unlock user if locked
ALTER USER jakir IDENTIFIED BY mypassword; # Reset password
ALTER USER jakir QUOTA UNLIMITED ON users; # Give storage quota
```

```bash
# Login as `system`
docker exec -it oracle-xe sqlplus system/Sql054003@localhost:1521/XEPDB1
GRANT CONNECT, RESOURCE TO jakir; # Full developer permissions - Optional
ALTER USER jakir ACCOUNT UNLOCK; # Unlock user if locked
Exit;
# Login as `jakir`
docker exec -it oracle-xe sqlplus jakir/Sql054003@localhost:1521/XEPDB1
```

```bash
SHOW USER;
SELECT username FROM dba_users; # Show user list
```

### Delete Example

```bash
CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(100),
    department VARCHAR2(50),
    salary NUMBER,
    status VARCHAR2(20)
);
```

```bash
INSERT INTO employees VALUES (1, 'Jakir', 'IT', 50000, 'ACTIVE');
INSERT INTO employees VALUES (2, 'Rahim', 'HR', 40000, 'ACTIVE');
INSERT INTO employees VALUES (3, 'Karim', 'Finance', 45000, 'INACTIVE');
COMMIT;
```

```bash
SELECT * FROM employees;
```

```bash
DELETE FROM employees
WHERE emp_id = 2;
```

```bash
SELECT * FROM employees;
```

| EMP_ID | EMP_NAME | DEPARTMENT | SALARY | STATUS   |
| ------ | -------- | ---------- | ------ | -------- |
| 1      | Jakir    | IT         | 50000  | ACTIVE   |
| 3      | Karim    | Finance    | 45000  | INACTIVE |

```bash
ROLLBACK;
```

```bash
DELETE FROM employees;
```

> `Table structure remains`

### Truncate Example

```bash
INSERT INTO employees VALUES (1, 'Jakir', 'IT', 50000, 'ACTIVE');
INSERT INTO employees VALUES (2, 'Rahim', 'HR', 40000, 'ACTIVE');
COMMIT;
```

```bash
TRUNCATE TABLE employees;
```

```bash
SELECT * FROM employees;
```

> `no rows selected`

### Drop Example

```bash
DROP TABLE employees;
SELECT * FROM employees;
```

> `ORA-00942: table or view does not exist`

### Install on Docker

```bash
docker pull mcr.microsoft.com/mssql/server:2022-latest
```

```bash
mkdir -p ~/mssql_data
mkdir -p ~/mssql_backup
chmod -R 777 ~/mssql_data ~/mssql_backup
```

```bash
docker run -d \
  --name mssql2022 \
  --platform linux/amd64 \
  -e "ACCEPT_EULA=Y" \
  -e "MSSQL_SA_PASSWORD=Sql@054003" \
  -p 1433:1433 \
  -v ~/mssql_data:/var/opt/mssql \
  -v ~/mssql_backup:/var/opt/mssql/backup \
  --restart unless-stopped \
  mcr.microsoft.com/mssql/server:2022-latest
```

### Connect to SQL Server

1. Using `VSCode` `SQL Server Management Studio (SSMS)` or `Azure Data Studio`

| Server    | Authentication | User | Password   | Port  |
| --------- | -------------- | ---- | ---------- | ----- |
| localhost | SQL Login      | sa   | Sql@054003 | 14433 |

2. `SQLCmd` inside container

```bash
brew install sqlcmd
sqlcmd --version
```

```bash
sqlcmd -S localhost,1433 -U sa -P "Sql@054003"
```

```bash
SELECT @@VERSION;
GO
```

```bash
docker exec -it mssql2022 /opt/mssql-tools/bin/sqlcmd \
   -S localhost -U sa -P "Sql@054003"
```

#### Keys in Relational Databases

Keys are essential in relational databases for identifying unique rows and establishing relationships between tables. Here's a breakdown of the different types of keys in a relational database:

##### Primary Key

A **Primary Key** is a column or a set of columns that uniquely identifies each row in a table. It must contain unique values and cannot have `NULL` values.

`Example`

| Roll | Name  | Age |
| ---- | ----- | --- |
| 101  | Steve | 23  |
| 102  | John  | 24  |
Here, `Roll` is the primary key because each roll number is unique.

> Note: Attributes like `Name` or `Age` cannot be primary keys, as they may not be unique.

##### Super Key

A **Super Key** is a set of one or more attributes that can uniquely identify a row in a table. Super keys can contain additional attributes beyond what is necessary for unique identification.

`Example`

| Emp_SSN | Emp_Number | Emp_Name |
| ------- | ---------- | -------- |
| 258963  | 256        | Steve    |
| 258741  | 254        | Robert   |

**Super Keys:**

- {Emp_SSN}
- {Emp_Number}
- {Emp_SSN, Emp_Number}
- {Emp_SSN, Emp_Name}
- {Emp_SSN, Emp_Number, Emp_Name}
- {Emp_Number, Emp_Name}

##### Candidate Key

A **Candidate Key** is a minimal super key, meaning it uniquely identifies rows without any redundant attributes. A table can have multiple candidate keys.

`Example`
For the table above, the following are candidate keys:

- {Emp_SSN}
- {Emp_Number}

Other sets, such as {Emp_SSN, Emp_Name}, contain redundant attributes.

##### Primary Key vs Candidate Key

- All candidate keys are super keys, but not all super keys are candidate keys.
- The **Primary Key** is selected from the set of candidate keys. A database designer or administrator typically chooses the primary key.

##### Alternate Key

An **Alternate Key** is any candidate key that is not selected as the primary key. These keys remain as alternative ways to uniquely identify rows.

`Example`
If `{Emp_SSN}` is selected as the primary key, `{Emp_Number}` becomes the alternate key.

##### Composite Key

A **Composite Key** is a key that consists of more than one attribute to uniquely identify a row. Composite keys are typically used when a single attribute is not sufficient to guarantee uniqueness.

`Example`

| Cust_Id | Order_Id | Product_Code | Product_Count |
| ------- | -------- | ------------ | ------------- |
| 125     | 625      | 352          | 35            |
| 225     | 552      | 356          | 36            |

**Composite Key:**

- {Cust_Id, Product_Code}

##### Foreign Key

A **Foreign Key** is a column in a table that points to the primary key of another table. It establishes relationships between two tables.

`Example`

| Course_Id | Stu_Id |
| --------- | ------ |
| C01       | 101    |
| C02       | 102    |

In the above example, `Stu_Id` is a foreign key in the **Course_enrollment** table that references the **Student** table.

##### Constraints in Databases

Constraints are rules that limit the types of data that can be inserted, updated, or deleted from a table. They ensure data integrity and consistency.

##### Types of Constraints

| **Constraint**  | **Description**                                                           | **Example**                                                                                             |
| --------------- | ------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| **NOT NULL**    | Ensures that a column cannot contain a `NULL` value.                      | `CREATE TABLE Employees (ID INT NOT NULL, Name VARCHAR(100) NOT NULL);`                                 |
| **UNIQUE**      | Ensures that all values in a column are unique.                           | `CREATE TABLE Employees (ID INT UNIQUE, Name VARCHAR(100));`                                            |
| **DEFAULT**     | Provides a default value for a column when no value is specified.         | `CREATE TABLE Employees (ID INT, Name VARCHAR(100) DEFAULT 'John Doe');`                                |
| **CHECK**       | Ensures that values in a column fall within a specific range.             | `CREATE TABLE Employees (Age INT CHECK (Age >= 18));`                                                   |
| **PRIMARY KEY** | Uniquely identifies each record in a table.                               | `CREATE TABLE Employees (ID INT PRIMARY KEY, Name VARCHAR(100));`                                       |
| **FOREIGN KEY** | Ensures that a value in a column corresponds to a value in another table. | `CREATE TABLE Orders (OrderID INT, EmployeeID INT, FOREIGN KEY (EmployeeID) REFERENCES Employees(ID));` |

`Example of Constraints`

```sql
CREATE TABLE STUDENT (
    ROLL_NO INT NOT NULL,
    STU_NAME VARCHAR(35) NOT NULL,
    STU_AGE INT NOT NULL,
    STU_ADDRESS VARCHAR(235),
    PRIMARY KEY (ROLL_NO)
);
```

#### Mapping Cardinality

Mapping cardinality defines the number of relationships between entities in a relational database.

| **Relationship** | **Description**                                                                                                                               | **Example**                                                                                      |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| **One to One**   | An entity in set A can be associated with at most one entity in set B, and vice versa.                                                        | `A person can have one passport, and a passport can belong to one person.`                       |
| **One to Many**  | An entity in set A can be associated with multiple entities in set B, but an entity in set B can only be associated with one entity in set A. | `A department can have multiple employees, but an employee can belong to only one department.`   |
| **Many to One**  | An entity in set A can only be associated with one entity in set B, but an entity in set B can be associated with multiple entities in set A. | `Many employees can belong to one department, but each employee belongs to only one department.` |
| **Many to Many** | An entity in set A can be associated with multiple entities in set B, and vice versa.                                                         | `Students can enroll in multiple courses, and each course can have multiple students.`           |

`Example of One to Many`

```sql
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(20),
    last_name VARCHAR(20)
);

CREATE TABLE Order (
    order_id INT PRIMARY KEY NOT NULL,
    customer_id INT,
    order_details VARCHAR(50),
    CONSTRAINT fk_Customers FOREIGN KEY (customer_id) REFERENCES Customer
);
```

#### Normalization in DBMS

Normalization is a process of organizing data in a database to reduce redundancy and improve data integrity. There are several Normal Forms (NF), each with its own set of rules.

#### Types of Normal Forms

- `1NF (First Normal Form):` Ensures that each column contains atomic (indivisible) values.
- `2NF (Second Normal Form):` Removes partial dependency on a candidate key.
- `3NF (Third Normal Form):` Eliminates transitive dependency.
- `BCNF (Boyce-Codd Normal Form):` A stricter version of 3NF.

Example of First Normal Form (1NF)
If a table contains a column with multiple values (e.g., multiple phone numbers), it violates 1NF. To comply with 1NF, each column should contain only atomic values.

##### Example of Normalization to 1NF

`Before 1NF (Non-compliant)`

| Emp_Id | Emp_Name | Emp_Mobile             |
| ------ | -------- | ---------------------- |
| 102    | Jon      | 8812121212, 9900012222 |
| 103    | Ron      | 7778881212             |

`Explanation:` The `Emp_Mobile` column contains multiple values for Jon, which violates the rule of 1NF that requires columns to have atomic (single) values.

`After 1NF (Compliant)`

| Emp_Id | Emp_Name | Emp_Mobile |
| ------ | -------- | ---------- |
| 102    | Jon      | 8812121212 |
| 102    | Jon      | 9900012222 |
| 103    | Ron      | 7778881212 |

`Explanation:` The `Emp_Mobile` column now contains only a single mobile number per row, ensuring that each attribute holds atomic values, which complies with **1NF**.

- `Example of Second Normal Form (2NF):` A table is in 2NF if it's in 1NF and if there is no partial dependency (i.e., no non-prime attribute depends on a subset of a candidate key).
- `Example of Third Normal Form (3NF):` A table is in 3NF if it’s in 2NF and there is no transitive dependency, meaning non-prime attributes should not depend on other non-prime attributes.
- `Boyce-Codd Normal Form (BCNF):` BCNF is a stricter version of 3NF where, for every functional dependency, the left side must be a super key.

By applying normalization, you can eliminate various types of anomalies (insertion, update, and deletion anomalies) and ensure the database maintains consistency and integrity.

## With Regards, `Jakir`

[![LinkedIn][linkedin-shield-jakir]][linkedin-url-jakir]
[![Facebook-Page][facebook-shield-jakir]][facebook-url-jakir]
[![Youtube][youtube-shield-jakir]][youtube-url-jakir]

### Wishing you a wonderful day! Keep in touch

<!-- Personal profile -->

[linkedin-shield-jakir]: https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white
[linkedin-url-jakir]: https://www.linkedin.com/in/jakir-ruet/
[facebook-shield-jakir]: https://img.shields.io/badge/Facebook-%231877F2.svg?style=for-the-badge&logo=Facebook&logoColor=white
[facebook-url-jakir]: https://www.facebook.com/jakir.ruet/
[youtube-shield-jakir]: https://img.shields.io/badge/YouTube-%23FF0000.svg?style=for-the-badge&logo=YouTube&logoColor=white
[youtube-url-jakir]: https://www.youtube.com/@mjakaria-ruet/featured
