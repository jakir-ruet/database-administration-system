### Stored Procedure

A Stored Procedure is a named PL/SQL program stored inside the Oracle database that:

- Executes business logic
- Can accept parameters
- Can perform INSERT, UPDATE, DELETE, SELECT
- Can be reused by applications (Java, .NET, Python, etc.)

> Think of it as a backend function inside the database, can be reused by applications (Java, Python, APIs, etc.)

**Why Use Stored Procedures?**

- Faster execution (precompiled)
- Reusable logic
- Secure (no direct table access needed)
- Reduces network traffic
- Centralized business rules

#### Basic Syntax

```sql
DECLARE
    -- variables
BEGIN
    -- logic
EXCEPTION
    -- error handling
END;
/
```

```sql
CREATE [OR REPLACE] PROCEDURE procedure_name
    (parameter1 [IN|OUT|IN OUT] datatype,
     parameter2 [IN|OUT|IN OUT] datatype)
IS | AS
    -- Declaration section
    variable_name datatype;
    cursor_name CURSOR IS;
BEGIN
    -- Executable section
    NULL; -- Placeholder
EXCEPTION
    -- Exception handling section
    WHEN exception_name THEN
        -- Handle exception
END procedure_name;
/
```

### Parameter

A parameter is a named variable declared in the header of a `procedure` or `function`. It is used to pass data into the procedure/function, return data from it, or do both.

### Types of Parameters

| Mode     | Meaning                                        | Direction          |
| -------- | ---------------------------------------------- | ------------------ |
| `IN`     | Read only, value passed to procedure (default) | Caller → Procedure |
| `OUT`    | Write only, value returned to caller           | Procedure → Caller |
| `IN OUT` | Read & write, value passed and returned        | Caller ↔ Procedure |

> A caller is any program, block, procedure, function, trigger, or application that invokes (calls) another procedure or function.
> A procedure is a named PL/SQL program (block) that performs a specific task.

### Cursor

A cursor is a **private memory area (pointer)** where Oracle **stores the result of a SQL query**. Think of it as a pointer or handle to the result set. When a query returns multiple rows, Oracle uses a cursor to process those rows **one at a time.**

```bash
Employees Table

+-------+---------+--------+
| EmpID | Name    | Salary |
+-------+---------+--------+
| 1     | Jakir   | 5000   |
| 2     | John    | 6000   |
| 3     | Alice   | 7000   |
+-------+---------+--------+

Cursor
   |
   V
+-------+---------+--------+
| 1     | Jakir   | 5000   |
+-------+---------+--------+
        |
        V
+-------+---------+--------+
| 2     | John    | 6000   |
+-------+---------+--------+
        |
        V
+-------+---------+--------+
| 3     | Alice   | 7000   |
+-------+---------+--------+
```

> A cursor lets you move through these rows one by one: `Row 1 → Row 2 → Row 3`

**Why Do We Need Cursors?**

Normal SQL works on sets: `SELECT * FROM employees;`

But sometimes business logic requires **row-by-row** processing:

- Generate individual salary slips
- Send emails to employees
- Calculate bonuses per employee
- Migrate data
- Audit records

> For these cases, cursors are useful.

**Types of Cursors**

**1. Implicit Cursor** An Implicit Cursor is a cursor that is automatically created and managed by Oracle whenever you execute a DML statement (INSERT, UPDATE, DELETE, MERGE) or a SELECT ... INTO statement that returns a single row.

- Managed by: Oracle
- Declaration: Not required
- Used for: Single-row queries and DML operations

```bash
DECLARE
    v_name employees.name%TYPE;
BEGIN
    SELECT name
    INTO v_name
    FROM employees
    WHERE empid = 1;

    DBMS_OUTPUT.PUT_LINE(v_name);
END;
/
```

```bash
OPEN
 ↓
FETCH
 ↓
CLOSE
```

**2. Explicit Cursor** An Explicit Cursor is a cursor that is declared and controlled by the programmer to process the rows returned by a query one at a time. It is mainly used when a query returns multiple rows.

- Managed by: Developer
- Declaration: Required
- Used for: Multi-row processing

```bash
DECLARE
    CURSOR c_emp IS
        SELECT empid, name, salary
        FROM employees;

    v_emp employees%ROWTYPE;

BEGIN
    OPEN c_emp;

    LOOP
        FETCH c_emp INTO v_emp;

        EXIT WHEN c_emp%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(v_emp.name);
    END LOOP;

    CLOSE c_emp;
END;
/
```

```bash
OPEN
 ↓
FETCH
 ↓
PROCESS
 ↓
CLOSE
```

**3. REF CURSOR** A REF CURSOR is a cursor variable that can point to different SQL query result sets at runtime. Unlike an explicit cursor, which is tied to one fixed query, a REF CURSOR can be opened for different queries and is commonly used to return result sets from stored procedures or packages to applications.

- Managed by: Developer
- Declaration: Required
- Used for: Returning query results dynamically

```bash
DECLARE
    TYPE emp_ref IS REF CURSOR;

    c_emp emp_ref;

    v_name employees.name%TYPE;
    v_salary employees.salary%TYPE;

BEGIN
    OPEN c_emp FOR
        SELECT name, salary
        FROM employees;

    LOOP
        FETCH c_emp INTO v_name, v_salary;

        EXIT WHEN c_emp%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(v_name || ' ' || v_salary);
    END LOOP;

    CLOSE c_emp;
END;
/
```

> The query is supplied when the cursor is opened, making it flexible.

| Feature                  | Implicit Cursor                             | Explicit Cursor                             | REF CURSOR                                                      |
| ------------------------ | ------------------------------------------- | ------------------------------------------- | --------------------------------------------------------------- |
| **Definition**           | Automatically created by Oracle             | Declared by the programmer                  | A cursor variable that can point to different query result sets |
| **Managed By**           | Oracle                                      | Developer                                   | Developer                                                       |
| **Declaration Required** | No                                          | Yes                                         | Yes                                                             |
| **Query Type**           | Fixed (executed directly)                   | Fixed (declared with the cursor)            | Dynamic (assigned when opened)                                  |
| **Rows Processed**       | Usually one row (`SELECT INTO`) or DML      | Multiple rows                               | Multiple rows                                                   |
| **OPEN Required**        | No                                          | Yes                                         | Yes                                                             |
| **FETCH Required**       | No                                          | Yes                                         | Yes                                                             |
| **CLOSE Required**       | No                                          | Yes                                         | Yes                                                             |
| **Typical Use**          | `INSERT`, `UPDATE`, `DELETE`, `SELECT INTO` | Batch processing, reports, row-by-row logic | Returning result sets from procedures/packages                  |

| Cursor              | Best For                                                                       |
| ------------------- | ------------------------------------------------------------------------------ |
| **Implicit Cursor** | Simple SQL statements and single-row retrieval                                 |
| **Explicit Cursor** | Processing multiple rows one by one                                            |
| **REF CURSOR**      | Returning dynamic result sets from procedures/functions to client applications |

**Easy way to remember**

- `Implicit Cursor `= Oracle does everything automatically.
- `Explicit Cursor` = You control everything (OPEN → FETCH → CLOSE).
- `REF CURSOR` = A cursor variable that can be opened for different queries and passed between programs.

**Cursor Lifecycle**

`OPEN > FETCH > PROCESS > CLOSE`

#### Cursor Attributes in Oracle

Cursor attributes are special properties that tell you the status of a cursor during execution. They are mainly used to monitor row processing in PL/SQL. They work with explicit cursors and implicit cursors (SQL% attributes).

| Attribute      | Used With             | Meaning                       |
| -------------- | --------------------- | ----------------------------- |
| `%FOUND`       | Explicit Cursor       | Last fetch returned row       |
| `%NOTFOUND`    | Explicit Cursor       | No row returned               |
| `%ROWCOUNT`    | Explicit Cursor / SQL | Number of rows processed      |
| `%ISOPEN`      | Explicit Cursor       | Cursor is open or not         |
| `SQL%ROWCOUNT` | Implicit Cursor       | Rows affected by DML          |
| `SQL%FOUND`    | Implicit Cursor       | DML affected at least one row |

```bash
CREATE TABLE employees (
    empid 	NUMBER PRIMARY KEY,
    name 	VARCHAR2(30),
    salary 	NUMBER
);

INSERT INTO employees VALUES (1,'Jakir',5000);
INSERT INTO employees VALUES (2,'John',6000);
INSERT INTO employees VALUES (3,'Alice',7000);

COMMIT;

-- Cursor
--    |
--    V
-- +-------+---------+--------+
-- | 1     | Jakir   | 5000   |
-- +-------+---------+--------+
--         |
--         V
-- +-------+---------+--------+
-- | 2     | John    | 6000   |
-- +-------+---------+--------+
--         |
--         V
-- +-------+---------+--------+
-- | 3     | Alice   | 7000   |
-- +-------+---------+--------+

-- The cursor points to one row at a time.

---------------
-- %FOUND`
---------------
DECLARE
    CURSOR c IS
        SELECT empid, name FROM employees;

    v_id employees.empid%TYPE;
    v_name employees.name%TYPE;
BEGIN
    OPEN c;

    FETCH c INTO v_id, v_name;

    IF c%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Row Found: ' || v_name);
    END IF;

    CLOSE c;
END;
/

-- Means: last FETCH successfully got a row.


---------------
-- %NOTFOUND
---------------
DECLARE
    CURSOR c IS
        SELECT empid, name FROM employees;

    v_id employees.empid%TYPE;
    v_name employees.name%TYPE;
BEGIN
    OPEN c;

    LOOP
        FETCH c INTO v_id, v_name;

        EXIT WHEN c%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(v_name);
    END LOOP;

    CLOSE c;
END;
/
-- Means: no more rows to fetch.


---------------
-- %ROWCOUNT
---------------
DECLARE
    CURSOR c IS
        SELECT empid, name FROM employees;

    v_id employees.empid%TYPE;
    v_name employees.name%TYPE;
BEGIN
    OPEN c;

    LOOP
        FETCH c INTO v_id, v_name;

        EXIT WHEN c%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Row No: ' || c%ROWCOUNT || ' Name: ' || v_name);
    END LOOP;

    CLOSE c;
END;
/

-- Means: how many rows have been fetched so far.

---------------
-- %ISOPEN
---------------
DECLARE
    CURSOR c IS
        SELECT empid, name FROM employees;

BEGIN
    OPEN c;

    IF c%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Cursor is OPEN');
    END IF;

    CLOSE c;

    IF NOT c%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Cursor is CLOSED');
    END IF;
END;
/
```

### Records

A RECORD in PL/SQL is a composite data type that allows you to store multiple related values of different data types in a single variable. Think of a record as one row of a table stored in memory.

```bash
------------------
-- Create Table
------------------
CREATE TABLE employees (
    empid NUMBER PRIMARY KEY,
    name VARCHAR2(30),
    salary NUMBER
);

------------------
-- Insert Data
------------------
INSERT INTO employees VALUES (1,'Jakir',5000);
INSERT INTO employees VALUES (2,'John',6000);
INSERT INTO employees VALUES (3,'Alice',7000);

COMMIT;

------------------
-- Without RECORD
------------------
DECLARE
    v_id     NUMBER;
    v_name   VARCHAR2(30);
    v_salary NUMBER;
BEGIN
    SELECT empid, name, salary
    INTO v_id, v_name, v_salary
    FROM employees
    WHERE empid = 2;

    DBMS_OUTPUT.PUT_LINE(v_id);
    DBMS_OUTPUT.PUT_LINE(v_name);
    DBMS_OUTPUT.PUT_LINE(v_salary);
END;
/

------------------
-- With RECORD:
------------------
DECLARE
    emp_rec employees%ROWTYPE;
BEGIN
    SELECT empid, name, salary
    INTO emp_rec
    FROM employees
    WHERE empid = 1;

    DBMS_OUTPUT.PUT_LINE(emp_rec.empid);
    DBMS_OUTPUT.PUT_LINE(emp_rec.name);
    DBMS_OUTPUT.PUT_LINE(emp_rec.salary);
END;
/
```

**Where is a RECORD stored after execution?**

A PL/SQL RECORD is stored in the program's memory (PGA - Program Global Area) while the PL/SQL block is executing. It is not stored in the database table unless you explicitly insert or update a table using the record's values.

```bash
DECLARE
    emp employees%ROWTYPE;
BEGIN
    SELECT *
    INTO emp
    FROM employees
    WHERE empid = 1;

    DBMS_OUTPUT.PUT_LINE(emp.name);
END;
/
```

```bash
Database (Disk)

Employees Table
+-------+--------+--------+
| 1     | Jakir  | 5000   |
+-------+--------+--------+
        |
        | SELECT
        V
PGA (Memory)

emp (RECORD)
+------------------------+
| empid  = 1             |
| name   = Jakir         |
| salary = 5000          |
+------------------------+
```

> - The row is read from the database.
> - Oracle copies the column values into the record variable in memory.
> - Your PL/SQL code works with the in-memory copy.

**What happens after the block finishes?**

- When execution reaches the end:

```bash
END;
/
```

- the record variable is `destroyed`.

```bash
Before execution

Memory
--------
(empty)

↓

During execution

Memory
--------
emp
+----------------+
|1 | Jakir|5000 |
+----------------+

↓

After execution

Memory
--------
(empty)
```

> The values are no longer available because local variables exist only for the lifetime of that PL/SQL block.

**Does a RECORD permanently save data?** `No.` A record is just a temporary container in memory.

- If you change the record:

```bash
emp.salary := 9000;
```

- the employees table does not change.

```bash
Database
---------
Salary = 5000

Memory
-------
Salary = 9000
```

> The database still contains 5000.

**How do you save record changes?** You must execute an `UPDATE` or `INSERT`.

```bash
DECLARE
    emp employees%ROWTYPE;
BEGIN
    SELECT *
    INTO emp
    FROM employees
    WHERE empid = 1;

    emp.salary := 9000;

    UPDATE employees
    SET salary = emp.salary
    WHERE empid = emp.empid;

    COMMIT;
END;
/
```

> Now the database row is updated.

**RECORD Lifetime**

| Where?                    | Lifetime                                                       |
| ------------------------- | -------------------------------------------------------------- |
| Inside a PL/SQL block     | Until the block ends                                           |
| Inside a procedure        | Until the procedure returns                                    |
| Inside a function         | Until the function returns                                     |
| Package variable (record) | Remains for the duration of the session (unless reinitialized) |

**RECORD vs TABLE**

| RECORD                                      | TABLE                              |
| ------------------------------------------- | ---------------------------------- |
| Exists in memory (PGA)                      | Stored permanently in the database |
| Temporary                                   | Persistent                         |
| Holds one logical row (or custom fields)    | Holds many rows                    |
| Automatically destroyed when its scope ends | Exists until dropped or modified   |
| Cannot be queried directly with SQL         | Can be queried with `SELECT`       |

**Record ROWTYPE vs Cursor ROWTYPE**

| Feature                            | User-defined RECORD    | `%ROWTYPE`                     | `cursor_name%ROWTYPE`                                     |
| ---------------------------------- | ---------------------- | ------------------------------ | --------------------------------------------------------- |
| Fields defined by                  | Developer              | Table structure                | Cursor query                                              |
| Automatic updates if table changes | No                     | Yes                            | Depends on the cursor query                               |
| Stores one row                     | Yes                    | Yes                            | Yes                                                       |
| Can be used with `SELECT INTO`     | Yes                    | Yes                            | Yes (if the selected columns match the cursor definition) |
| Best use case                      | Custom data structures | Working with entire table rows | Processing cursor results                                 |

### Collections

### BULK Operations

### Packages

#### Specification

#### Body

### Dynamic SQL

### Autonomous Transaction

### Pragma

### Object Types

### LOB Programming

### JSON

### XML

### File Handling

### Email

### Scheduler Jobs

### DBMS Packages
