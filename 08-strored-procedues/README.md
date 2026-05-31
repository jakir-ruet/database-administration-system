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

### Types of Parameters

| Mode     | Meaning                                        |
| -------- | ---------------------------------------------- |
| `IN`     | Read only, value passed to procedure (default) |
| `OUT`    | Write only, value returned to caller           |
| `IN OUT` | Read & write, value passed and returned        |

### Cursor

A cursor is a `private memory (Pointer)` area in Oracle that `holds the result set of a SQL query`. Think of it as a pointer or handle to the result set. When a query returns multiple rows, Oracle uses a cursor to process those rows one at a time.

**Employees Table**
+-------+---------+--------+
| EmpID | Name    | Salary |
+-------+---------+--------+
| 1     | Jakir   | 5000   |
| 2     | John    | 6000   |
| 3     | Alice   | 7000   |
+-------+---------+--------+

> A cursor lets you move through these rows one by one: `Row 1 → Row 2 → Row 3`

**Why Do We Need Cursors?**

Normal SQL works on sets: `SELECT * FROM employees;`

But sometimes business logic requires row-by-row processing:

- Generate individual salary slips
- Send emails to employees
- Calculate bonuses per employee
- Migrate data
- Audit records

> For these cases, cursors are useful.

**Types of Cursors**

| Cursor Type         | Description                                                          | Managed By | Typical Use Case                                               |
| ------------------- | -------------------------------------------------------------------- | ---------- | -------------------------------------------------------------- |
| **Implicit Cursor** | Automatically created by Oracle for DML statements and `SELECT INTO` | Oracle     | Single-row retrieval, INSERT, UPDATE, DELETE                   |
| **Explicit Cursor** | Declared by the programmer to process query results row by row       | Developer  | Multiple rows, reporting, batch processing                     |
| **REF CURSOR**      | Cursor variable that can point to different query result sets        | Developer  | Returning result sets from procedures/packages to applications |

**Cursor Lifecycle**

`OPEN > FETCH > PROCESS > CLOSE`

**Cursor Attributes**

| Attribute | Meaning                  |
| --------- | ------------------------ |
| %FOUND    | Row found                |
| %NOTFOUND | No row found             |
| %ROWCOUNT | Number of rows processed |
| %ISOPEN   | Cursor open?             |
