## More About Me – [Take a Look!](http://www.mjakaria.me)

## Welcome to Database Learning

### Introduction

SQL (Structured Query Language) is the standard programming language used to manage and manipulate relational databases. It allows users to query, insert, update, and delete data stored in a database.

- Installing SQL Server on Windows
- Installing SQL Server on Mac (via Docker or remote access)

> In Oracle Database 21c uses the Multitenant Architecture, where a single **Container Database (CDB)** can contain **multiple Pluggable Databases (PDBs)**.

**High-Level Architecture**

```bash
Oracle Database 21c
│
├── Container Database (CDB)
│
├── Oracle Instance
│   ├── System Global Area (SGA)
│   ├── Program Global Area (PGA)
│   └── Background Processes
│
└── Database Files
    ├── Control Files
    ├── Data Files
    └── Online Redo Logs
```

**Multitenant Architecture**

```bash
Container Database (CDB)
│
├── CDB$ROOT
│   ├── Oracle system metadata
│   ├── Data dictionary
│   └── Common users (C##USER)
│
├── PDB$SEED
│   └── Read-only template used to create new PDBs
│
├── XEPDB1
│   ├── Application users
│   ├── Tables
│   ├── Views
│   └── Procedures
│
└── Additional PDBs (Optional)
```

**CDB$ROOT vs PDB$SEED vs XEPDB1**

| Feature           | CDB$ROOT                       | PDB$SEED                       | XEPDB1                            |
| ----------------- | ------------------------------ | ------------------------------ | --------------------------------- |
| Type              | Root Container                 | Seed Pluggable Database        | User Pluggable Database           |
| Purpose           | Manages entire CDB system      | Template for creating new PDBs | Application/database for users    |
| Role              | System administration          | Copy source for new PDBs       | Working database                  |
| Data Dictionary   | Full global dictionary         | Minimal template dictionary    | Local dictionary (PDB-level view) |
| User Type Allowed | Common users only (C##)        | No users allowed (read-only)   | Local users allowed               |
| Example Users     | C##ADMIN, C##DBA               | Not applicable                 | JAKIR, HR, APP_USER               |
| Read/Write        | Read + system control          | Read-only                      | Read + write                      |
| Modifiable        | Yes (DBA operations only)      | No (locked template)           | Yes (normal operations)           |
| Creation Purpose  | Created automatically with CDB | Auto-created with CDB          | Created from SEED or manually     |
| Usage             | Internal DB management         | Cloning new PDBs               | Application development           |

> **Visual Structure**

```bash
CDB (Container Database)
│
├── CDB$ROOT   → System brain (DBA only) like Control room of a building
│
├── PDB$SEED   → Template (read-only) like Blueprint of apartments
│
└── XEPDB1     → Working database (YOU use this) like Actual apartment where people live
```

**Database Architecture Layer - Modern**

| Layer                 | Component                | Description                                           |
| --------------------- | ------------------------ | ----------------------------------------------------- |
| Database Architecture | Container Database (CDB) | Root structure that contains all pluggable databases  |
| Database Architecture | CDB$ROOT                 | Stores Oracle system metadata and common users        |
| Database Architecture | PDB$SEED                 | Read-only template used to create new PDBs            |
| Database Architecture | PDB (e.g., XEPDB1)       | User/application database containing schemas and data |

**Multitenant Structure - Modern**

| Container | Type           | Purpose                                 |
| --------- | -------------- | --------------------------------------- |
| CDB$ROOT  | Root Container | Stores system metadata and common users |
| PDB$SEED  | Seed PDB       | Template for creating new PDBs          |
| XEPDB1    | Pluggable DB   | Application database for users and data |

**User Types - Modern**

| User Type   | Location     | Naming Rule           | Example  |
| ----------- | ------------ | --------------------- | -------- |
| Common User | CDB$ROOT     | Must start with `C##` | C##ADMIN |
| Local User  | PDB (XEPDB1) | No prefix required    | JAKIR    |

**traditional Oracle architecture**

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
|                       | FLOWS_FILES | Stores uploaded files for Oracle APEX applications                         | File upload/download in APEX apps          |
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

### IN vs ANY vs ALL

| Feature         | IN                       | ANY                         | ALL                    |
| --------------- | ------------------------ | --------------------------- | ---------------------- |
| Comparison type | Equality only (=)        | Flexible (>, <, =)          | Flexible (>, <, =)     |
| Logic           | OR                       | OR (at least one true)      | AND (all must be true) |
| Strength        | Simple                   | Medium                      | Strict                 |
| Best for        | Fixed lists              | Subquery comparisons        | Boundary filtering     |
| Null handling   | Can be tricky (`NOT IN`) | Safer than IN in many cases | Safe in most cases     |

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

### Keys in Relational Databases

A key is a column or set of columns used to identify records and establish relationships between tables.

#### Primary Key

A Primary Key uniquely identifies each row in a table.

**Rules**

- Must be unique
- Cannot contain NULL
- One primary key per table

```bash
CREATE TABLE STUDENTS (
    STUDENT_ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(100),
    EMAIL VARCHAR2(100)
);
```

> `STUDENT_ID` is the Primary Key, because each `STUDENT_ID` is Unique.

**Primary Key vs Unique Key**

| Primary Key    | Unique Key       |
| -------------- | ---------------- |
| Cannot be NULL | Can contain NULL |
| One per table  | Multiple allowed |

**Primary Key vs Foreign Key**

| Primary Key              | Foreign Key            |
| ------------------------ | ---------------------- |
| Uniquely identifies rows | Creates relationships  |
| Unique                   | May contain duplicates |

#### Alternate Key

Candidate keys not selected as Primary Key.

```bash
Primary Key = ID
Alternate Key = EMAIL
```

#### Surrogate Key

A Surrogate Key is an artificial identifier created by the database or application solely to uniquely identify a row. It has no business meaning and is typically an auto-generated number.

| EMP_ID | NAME  | EMAIL           |
| ------ | ----- | --------------- |
| 1      | Jakir | jakir@gmail.com |
| 2      | Rahim | rahim@gmail.com |

> `EMP_ID` is a Surrogate Key because:
> It is generated by the system
> It does not describe the employee
> It is used only for identification

**Why is it Called "Surrogate"?** A surrogate means a substitute.

Instead of using a real business value:

```bash
NID
PASSPORT_NO
EMAIL
PHONE
EMPLOYEE_CODE
```

we use a generated value:

```bash
1
2
3
4
5
```

#### Candidate Key

A column that can uniquely identify records.

| ID  | EMAIL           |
| --- | --------------- |
| 1   | jakir@gmail.com |
| 2   | rahim@gmail.com |

> - `ID` & `EMAIL` can uniquely identify rows.
> - Therefore both are Candidate Keys.
> - One Candidate Key becomes the Primary Key.

```bash
Candidate Keys
│
├── EMP_ID
├── EMPLOYEE_CODE
└── EMAIL
      │
      ▼
Choose EMP_ID
      │
      ▼
Primary Key = EMP_ID
      │
      ▼
Alternate Keys
├── EMPLOYEE_CODE
└── EMAIL
```

```bash
CREATE TABLE EMPLOYEE (
    EMP_ID NUMBER PRIMARY KEY,
    EMPLOYEE_CODE VARCHAR2(20) UNIQUE,
    EMAIL VARCHAR2(100) UNIQUE,
    EMP_NAME VARCHAR2(100)
);
```

| Column        | Key Type      |
| ------------- | ------------- |
| EMP_ID        | Primary Key   |
| EMPLOYEE_CODE | Alternate Key |
| EMAIL         | Alternate Key |

**Primary Key vs Alternate Key**

| Feature               | Primary Key     | Alternate Key                                                     |
| --------------------- | --------------- | ----------------------------------------------------------------- |
| Purpose               | Main identifier | Backup unique identifier                                          |
| NULL Allowed          | No              | Usually depends on DBMS, but typically unique and may allow NULLs |
| Count per Table       | Only one        | Multiple                                                          |
| Automatically Indexed | Yes             | Usually yes via UNIQUE constraint                                 |
| Used in Foreign Keys  | Commonly        | Possible but less common                                          |

#### Super Key

A Super Key is a column or a combination of columns that can uniquely identify each row in a table.

A Super Key may contain **extra unnecessary columns** in addition to the columns required for uniqueness.

| EMP_ID | EMAIL           | NAME  |
| ------ | --------------- | ----- |
| 1      | jakir@gmail.com | Jakir |
| 2      | rahim@gmail.com | Rahim |

**Valid Super Keys** The following can uniquely identify a row:

```bash
EMP_ID
EMAIL
EMP_ID + NAME
EMAIL + NAME
EMP_ID + EMAIL
EMP_ID + EMAIL + NAME
```

> All of the above are Super Keys because each combination uniquely identifies a record.

**A Super Key vs A Candidate Key**

| Super Key                 | Candidate Key             |
| ------------------------- | ------------------------- |
| Uniquely identifies a row | Uniquely identifies a row |
| May contain extra columns | Contains no extra columns |
| Not necessarily minimal   | Minimal                   |
| Many can exist            | One or more can exist     |

> **Formula**

```bash
Candidate Key ⊂ Super Key
Every Candidate Key is a Super Key,
but every Super Key is NOT a Candidate Key.
```

```bash
EMP_ID                  → Candidate Key
EMAIL                   → Candidate Key

EMP_ID + NAME           → Super Key
EMAIL + NAME            → Super Key
EMP_ID + EMAIL          → Super Key
```

#### Composite Key

A Primary Key consisting of multiple columns.

```bash
CREATE TABLE STUDENT_COURSE (
    STUDENT_ID NUMBER,
    COURSE_ID NUMBER,
    PRIMARY KEY (STUDENT_ID, COURSE_ID)
);
```

| STUDENT_ID | COURSE_ID |
| ---------- | --------- |
| 1          | 101       |
| 1          | 102       |

- Neither column alone is unique.
- Together they are unique.

#### Foreign Key (FK)

Used to create relationships between tables.

**Parent Table**

```bash
CREATE TABLE DEPARTMENT (
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50)
);
```

**Child Table**

```bash
CREATE TABLE EMPLOYEE (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(100),
    DEPT_ID NUMBER,
    FOREIGN KEY (DEPT_ID)
        REFERENCES DEPARTMENT(DEPT_ID)
);
```

#### Unique Key

Prevents duplicate values. Allows NULL (Oracle allows multiple NULLs).

```bash
CREATE TABLE USERS (
    ID NUMBER PRIMARY KEY,
    EMAIL VARCHAR2(100) UNIQUE
);
```

### Relationships - Mapping Cardinality

Mapping cardinality defines the number of relationships between entities in a relational database.

| **Relationship** | **Description**                                                                                                                               | **Example**                                                                                      |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| **One to One**   | An entity in set A can be associated with at most one entity in set B, and vice versa.                                                        | `A person can have one passport, and a passport can belong to one person.`                       |
| **One to Many**  | An entity in set A can be associated with multiple entities in set B, but an entity in set B can only be associated with one entity in set A. | `A department can have multiple employees, but an employee can belong to only one department.`   |
| **Many to One**  | An entity in set A can only be associated with one entity in set B, but an entity in set B can be associated with multiple entities in set A. | `Many employees can belong to one department, but each employee belongs to only one department.` |
| **Many to Many** | An entity in set A can be associated with multiple entities in set B, and vice versa.                                                         | `Students can enroll in multiple courses, and each course can have multiple students.`           |

- One-to-One (1:1) - `Employee ↔ Passport`
- One-to-Many (1:N) - `Department → Employees`
- Many-to-Many (M:N) - `Students ↔ Courses`

#### One-to-One (1:1) - `Employee ↔ Passport`

##### Approach 1: Foreign Key with UNIQUE constraint (Most Common)

EMPLOYEE (Parent)

```bash
CREATE TABLE EMPLOYEE (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(100) NOT NULL
);
```

PASSPORT (Child)

```bash
CREATE TABLE PASSPORT (
    PASSPORT_ID VARCHAR2(20) PRIMARY KEY,
    EMP_ID NUMBER UNIQUE,
    ISSUE_DATE DATE,
    EXPIRY_DATE DATE,
    FOREIGN KEY (EMP_ID)
        REFERENCES EMPLOYEE(EMP_ID)
);
```

##### Approach 2: Shared Primary Key (Best Normalized Design)

EMPLOYEE (Parent)

```bash
CREATE TABLE EMPLOYEE (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(100)
);
```

PASSPORT (Child (Same PK = FK))

```bash
CREATE TABLE PASSPORT (
    EMP_ID NUMBER PRIMARY KEY,
    PASSPORT_NUMBER VARCHAR2(20) UNIQUE,
    ISSUE_DATE DATE,
    EXPIRY_DATE DATE,
    FOREIGN KEY (EMP_ID)
        REFERENCES EMPLOYEE(EMP_ID)
);
```

##### Approach 3: Single Table (Optional Design)

```bash
CREATE TABLE EMPLOYEE (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(100),
    PASSPORT_NUMBER VARCHAR2(20) UNIQUE,
    ISSUE_DATE DATE,
    EXPIRY_DATE DATE
);
```

**JPA Mapping**

```bash
@Entity
public class Employee {
    @Id
    private Long id;

    private String name;

    @OneToOne(mappedBy = "employee")
    private Passport passport;
}
```

```bash
@Entity
public class Passport {
    @Id
    private Long empId;

    @OneToOne
    @MapsId
    private Employee employee;

    private String passportNumber;
}
```

**Comparison of Approaches**

| Approach     | Pros               | Cons              |
| ------------ | ------------------ | ----------------- |
| FK + UNIQUE  | Simple, flexible   | Slight redundancy |
| Shared PK    | Best normalization | Slight complexity |
| Single Table | Fast, simple       | Poor separation   |

#### One-to-Many (1:N) - `Department → Employees`

Parent Table: DEPARTMENT

```bash
CREATE TABLE DEPARTMENT (
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(100) NOT NULL
);
```

Child Table: EMPLOYEE

```bash
CREATE TABLE EMPLOYEE (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(100) NOT NULL,
    DEPT_ID NUMBER,
    FOREIGN KEY (DEPT_ID)
        REFERENCES DEPARTMENT(DEPT_ID)
);
```

**JPA Mapping**

```bash
@Entity
public class Department {
    @Id
    private Long id;

    private String name;

    @OneToMany(mappedBy = "department")
    private List<Employee> employees;
}
```

```bash
@Entity
public class Employee {
    @Id
    private Long id;

    private String name;

    @ManyToOne
    @JoinColumn(name = "dept_id")
    private Department department;
}
```

#### Many-to-Many (M:N) - `Students ↔ Courses`

```bash
CREATE TABLE STUDENT (
    STUDENT_ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(100) NOT NULL
);
```

```bash
CREATE TABLE COURSE (
    COURSE_ID NUMBER PRIMARY KEY,
    COURSE_NAME VARCHAR2(100) NOT NULL
);
```

```bash
CREATE TABLE ENROLLMENT (
    STUDENT_ID NUMBER,
    COURSE_ID NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,

    PRIMARY KEY (STUDENT_ID, COURSE_ID),

    FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT(STUDENT_ID),

    FOREIGN KEY (COURSE_ID)
        REFERENCES COURSE(COURSE_ID)
);
```

**JPA Mapping**

```bash
@Entity
public class Student {
    @Id
    private Long id;

    private String name;

    @ManyToMany
    @JoinTable(
        name = "enrollment",
        joinColumns = @JoinColumn(name = "student_id"),
        inverseJoinColumns = @JoinColumn(name = "course_id")
    )
    private List<Course> courses;
}
```

```bash
@Entity
public class Course {
    @Id
    private Long id;

    private String name;

    @ManyToMany(mappedBy = "courses")
    private List<Student> students;
}
```

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

```bash
CREATE TABLE STUDENT (
    ROLL_NO INT NOT NULL,
    STU_NAME VARCHAR(35) NOT NULL,
    STU_AGE INT NOT NULL,
    STU_ADDRESS VARCHAR(235),
    PRIMARY KEY (ROLL_NO)
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
