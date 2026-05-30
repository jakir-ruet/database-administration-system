### Stored Procedure

A stored procedure is a named PL/SQL block stored in the database that:

- Performs a specific task
- Can contain SQL + PL/SQL logic
- Can be reused by applications (Java, Python, APIs, etc.)

**It improves:**

- Performance (precompiled)
- Security (controlled access)
- Reusability

```sql
CREATE OR REPLACE PROCEDURE procedure_name
(
    param1 IN  datatype,
    param2 OUT datatype,
    param3 IN OUT datatype
)
IS
    -- variable declarations
BEGIN
    -- SQL / PL/SQL logic
EXCEPTION
    -- error handling
END procedure_name;
/
```

### Types of Parameters

| Mode   | Meaning                |
| ------ | ---------------------- |
| IN     | Input (default)        |
| OUT    | Output (returns value) |
| IN OUT | Both input and output  |
