## More About Me – [Take a Look!](http://www.mjakaria.me)

## Welcome to Database Learning

### Introduction

1. What is SQL?
   SQL (Structured Query Language) is the standard programming language used to manage and manipulate relational databases. It allows users to query, insert, update, and delete data stored in a database.
2. Installing SQL Server on Windows
3. Installing SQL Server on Mac (via Docker or remote access)

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

#### Difference Between DBMS and RDBMS

Although both DBMS and RDBMS are used to store information in a physical database, there are significant differences between them. Below is a comparison of the main differences:

| No. | DBMS                                                                     | RDBMS                                                                                                              |
| --- | ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| 1   | DBMS applications store data as files.                                   | RDBMS applications store data in a tabular form.                                                                   |
| 2   | Data is generally stored in hierarchical or navigational form.           | Data is stored in tables with identifiers called primary keys.                                                     |
| 3   | Normalization is not present in DBMS.                                    | Normalization is present in RDBMS.                                                                                 |
| 4   | DBMS does not apply any security regarding data manipulation.            | RDBMS defines integrity constraints to ensure ACID properties (Atomicity, Consistency, Isolation, and Durability). |
| 5   | DBMS uses a file system, so there is no relationship between tables.     | RDBMS stores data in tables with relationships between them.                                                       |
| 6   | DBMS provides uniform methods to access data.                            | RDBMS supports a tabular structure and relationships for accessing stored information.                             |
| 7   | DBMS does not support distributed databases.                             | RDBMS supports distributed databases.                                                                              |
| 8   | DBMS is suited for small organizations with single users and small data. | RDBMS is designed to handle large data and support multiple users.                                                 |
| 9   | Examples: File systems, XML, etc.                                        | Examples: MySQL, PostgreSQL, SQL Server, Oracle, etc.                                                              |

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

### Retrieving Data from a Single Table

1. The SELECT Statement
2. The SELECT Clause
3. The WHERE Clause
4. The AND, OR, and NOT Operators
5. The IN Operator
6. The BETWEEN Operator
7. The LIKE Operator
8. The PATINDEX & LIKE Operator for Pattern Matching
9. The IS NULL Operator
10. The ORDER BY Clause
11. The TOP Clause (instead of LIMIT)

### Retrieving Data from Multiple Tables

1. Inner Joins
2. Joining Across Databases
3. Self Joins
4. Joining Multiple Tables
5. Compound Join Conditions
6. Implicit Join Syntax
7. Outer Joins
8. Outer Join Between Multiple Tables
9. Self-Outer Joins
10. The USING Clause (Not applicable in MSSQL, use ON instead)
11. Natural Joins (MSSQL does not have Natural Joins, use explicit join conditions)
12. Cross Joins
13. Unions

### Inserting, Updating, and Deleting Data

1. Column Attributes
2. Inserting a Row
3. Inserting Multiple Rows
4. Inserting Hierarchical Rows
5. Creating a Copy of a Table (via `SELECT INTO` or `INSERT INTO`)
6. Updating a Single Row
7. Updating Multiple Rows
8. Using Subqueries in Updates
9. Deleting Rows
10. Restoring Databases

### Summarizing Data

1. Aggregate Functions (SUM, AVG, COUNT, etc.)
2. The GROUP BY Clause
3. The HAVING Clause
4. The ROLLUP Operator (also, CUBE in MSSQL)

### Writing Complex Queries

1. Introduction
2. Subqueries
3. The IN Operator
4. Subqueries vs Joins
5. The ALL Keyword
6. The ANY Keyword
7. Correlated Subqueries
8. The EXISTS Operator
9. Subqueries in the SELECT Clause
10. Subqueries in the FROM Clause

### Essential SQL Server Functions

1. Numeric Functions
2. String Functions
3. Date Functions in SQL Server
4. Formatting Dates and Times
5. Calculating Dates and Times
6. The ISNULL and COALESCE Functions
7. The IIF Function (instead of CASE)
8. The CASE Expression

### Views

1. Creating Views
2. Altering or Dropping Views
3. Updatable Views
4. The WITH CHECK OPTION Clause

### . Other Benefits of Views

5. Stored Procedures

### What are Stored Procedures?

1. Creating a Stored Procedure
2. Creating Procedures Using SQL Server Management Studio (SSMS)
3. Dropping Stored Procedures
4. Parameters
5. Parameters with Default Value
6. Parameter Validation
7. Output Parameters
8. Variables
9. Functions
10. Other Conventions

### Triggers and Events

1. Triggers
2. Viewing Triggers
3. Dropping Triggers
4. Using Triggers for Auditing
5. Events (SQL Server Agent Jobs)
6. Viewing, Dropping, and Altering Jobs/Events

### Transactions and Concurrency

1. Transactions
2. Creating Transactions
3. Concurrency and Locking
4. Concurrency Problems
5. Transaction Isolation Levels (Read Uncommitted, Read Committed, Repeatable Read, Serializable)
6. Handling Deadlocks

### Data Types

#### SQL Server String Data Type

| Data Type      | Description                                | Max Size                       |
| -------------- | ------------------------------------------ | ------------------------------ |
| `char(n)`      | Fixed width character string data type.    | Up to 8000 characters          |
| `varchar(n)`   | Variable width character string data type. | Up to 8000 characters          |
| `varchar(max)` | Variable width character string data type. | Up to 1,073,741,824 characters |
| `text`         | Variable width character string data type. | Up to 2GB of text data         |
| `nchar`        | Fixed width Unicode string data type.      | Up to 4000 characters          |
| `nvarchar`     | Variable width Unicode string data type.   | Up to 4000 characters          |
| `ntext`        | Variable width Unicode string data type.   | Up to 2GB of text data         |
| `binary(n)`    | Fixed width Binary string data type.       | Up to 8000 bytes               |
| `varbinary`    | Variable width Binary string data type.    | Up to 8000 bytes               |
| `image`        | Variable width Binary string data type.    | Up to 2GB                      |

#### SQL Server Numeric Data Types

| Data Type  | Description                                                                                                                          | Range                                                   |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------- |
| `bit`      | Integer that can be 0, 1 or null.                                                                                                    | 0, 1, NULL                                              |
| `tinyint`  | Whole numbers from 0 to 255.                                                                                                         | 0 to 255                                                |
| `smallint` | Whole numbers between -32,768 and 32,767.                                                                                            | -32,768 to 32,767                                       |
| `int`      | Whole numbers between -2,147,483,648 and 2,147,483,647.                                                                              | -2,147,483,648 to 2,147,483,647                         |
| `bigint`   | Whole numbers between -9,223,372,036,854,775,808 and 9,223,372,036,854,775,807.                                                      | -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807 |
| `float(n)` | Floating precision number data from -1.79E+308 to 1.79E+308. The `n` parameter indicates whether the field should hold 4 or 8 bytes. | -1.79E+308 to 1.79E+308                                 |
| `real`     | Floating precision number from -3.40E+38 to 3.40E+38.                                                                                | -3.40E+38 to 3.40E+38                                   |
| `money`    | Monetary data from -922,337,233,685,477.5808 to 922,337,203,685,477.5807.                                                            | -922,337,233,685,477.5808 to 922,337,203,685,477.5807   |

#### SQL Server Date and Time Data Type

| Data Type   | Description                                                                                                          | Range                                |
| ----------- | -------------------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| `datetime`  | Date and time combination, supports range from January 1, 1753 to December 31, 9999 with 3.33 milliseconds accuracy. | January 1, 1753 to December 31, 9999 |
| `datetime2` | Date and time combination, supports range from January 1, 0001 to December 31, 9999 with 100 nanoseconds accuracy.   | January 1, 0001 to December 31, 9999 |
| `date`      | Stores date only.                                                                                                    | January 1, 0001 to December 31, 9999 |
| `time`      | Stores time only with 100 nanoseconds accuracy.                                                                      | N/A                                  |
| `timestamp` | Stores a unique number when a new row gets created or modified, based on an internal clock.                          | N/A                                  |

#### SQL Server Other Data Types

| Data Type          | Description                                                                                         | Max Size         |
| ------------------ | --------------------------------------------------------------------------------------------------- | ---------------- |
| `sql_variant`      | Used for various data types except for text, timestamp, and ntext. Stores up to 8000 bytes of data. | Up to 8000 bytes |
| `XML`              | Stores XML formatted data.                                                                          | Maximum 2GB      |
| `cursor`           | Stores a reference to a cursor used for database operations.                                        | N/A              |
| `table`            | Stores result set for later processing.                                                             | N/A              |
| `uniqueidentifier` | Stores GUID (Globally Unique Identifier).                                                           | N/A              |

### Designing Databases

1. Introduction
2. Data Modeling
3. Conceptual Models
4. Logical Models
5. Physical Models
6. Primary Keys
7. Foreign Keys
8. Foreign Key Constraints
9. Normalization
10. 1NF- First Normal Form
11. Link Tables
12. 2NF- Second Normal Form
13. 3NF- Third Normal Form
14. My Pragmatic Advice
15. Don't Model the Universe
16. Forward Engineering a Model (From SSMS or Data Tools)
17. Synchronizing a Model with a Database
18. Reverse Engineering a Database (Using SSMS or Visual Studio)
19. Project- Flight Booking System
20. Solution- Conceptual Model
21. Solution- Logical Model
22. Project - Video Rental Application
23. Solution- Conceptual Model
24. Solution- Logical Model
25. Creating and Dropping Databases
26. Creating Tables
27. Altering Tables
28. Creating Relationships
29. Altering Primary and Foreign Key Constraints
30. Character Sets and Collations
31. Storage Engines (SQL Server has one engine)

### Indexing for High Performance

1. Introduction
2. Indexes
3. Creating Indexes
4. Viewing Indexes
5. Prefix Indexes
6. Full-text Indexes
7. Composite Indexes
8. Order of Columns in Composite Indexes
9. When Indexes are Ignored
10. Using Indexes for Sorting
11. Covering Indexes
12. Index Maintenance
13. Performance Best Practices

### Securing Databases

1. Introduction
2. Creating a User
3. Viewing Users
4. Dropping Users
5. Changing Passwords
6. Granting Permissions
7. Viewing Permissions
8. Revoking Permissions

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
