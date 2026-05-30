### Functions in Oracle 21c

A function in Oracle SQL is a predefined or user-defined program unit that takes input, processes it, and returns a single value or result.

**Types of Functions in Oracle**

| Type                         | Description                                                        | Input                      | Output                        | Key Purpose                                               | Example                                   |
| ---------------------------- | ------------------------------------------------------------------ | -------------------------- | ----------------------------- | --------------------------------------------------------- | ----------------------------------------- |
| **Scalar (Single-Row)**      | Operate on each row individually and return a single value per row | Single row value           | Single value                  | Data transformation, formatting, calculations             | `UPPER(name)`, `ROUND(salary,2)`          |
| **Aggregate (Multiple-Row)** | Work on multiple rows and return one summarized value              | Multiple rows              | Single value                  | Reporting, summarization                                  | `SUM(salary)`, `AVG(salary)`, `COUNT(*)`  |
| **Table**                    | Return a collection (rows like a table) that can be queried in SQL | Single or multiple inputs  | Set of rows (table)           | Return complex datasets, often used in pipelines or joins | `TABLE(my_function)`                      |
| **Pipelined Table**          | Stream rows one by one instead of returning full result at once    | Rows processed iteratively | Streaming rows (table output) | High-performance data processing, ETL pipelines           | `PIPELINED FUNCTION ... RETURN TABLE`     |
| **Deterministic**            | Always return the same result for same input                       | Same input repeatedly      | Same output consistently      | Performance optimization, caching, indexed function calls | `DETERMINISTIC FUNCTION calc_tax(salary)` |

- A Table Function is a PL/SQL function that returns a collection of rows (like a table) instead of a single value.

**Quick Understanding**

| Type                     | Input                       | Output                      | Think Like             |
| ------------------------ | --------------------------- | --------------------------- | ---------------------- |
| Scalar (Single-Row)      | 1 row                       | 1 value                     | `One cell calculation` |
| Aggregate (Multiple-Row) | Many rows                   | 1 value                     | `Report summary`       |
| Table Function           | Input values or query       | Many rows (table)           | `Returns a dataset`    |
| Pipeline Function        | Rows processed continuously | Many rows (streaming table) | `Streaming dataset`    |
| Deterministic Function   | Same input                  | Same output                 | `Predictable function` |

### PL/SQL/User-Defined Function (UDF)

A User-Defined Function (UDF) is a custom function written in PL/SQL to perform business logic and return a single value. **PL/SQL** PL/SQL (Procedural Language/SQL) is Oracle’s extension of SQL that allows you to write:

- Logic (IF, LOOP)
- Variables
- Conditions
- Procedures & functions

> **In simple words:**
>
> - SQL = data query
> - PL/SQL = programming with SQL

**Key Characteristics**

| Feature     | Description                            |
| ----------- | -------------------------------------- |
| Return type | Must return a single value             |
| Usage       | Can be used in SELECT, WHERE, ORDER BY |
| Language    | PL/SQL                                 |
| Purpose     | Business logic / calculations          |
| Execution   | Runs row-by-row if used in SQL         |

### SQL vs PL/SQL

| SQL                     | PL/SQL                       |
| ----------------------- | ---------------------------- |
| Declarative             | Procedural                   |
| One statement at a time | Block of code                |
| Only query data         | Logic + query + control flow |

### PL/SQL Block Structure -  Every PL/SQL program has 3 sections

```sql
DECLARE
   -- variables (optional)
BEGIN
   -- logic (mandatory)
EXCEPTION
   -- error handling (optional)
END;
/
```

1. **Scalar (Single-Row)**

A Scalar Function works on `one row at a time and returns one value per row`.

- It does NOT group rows
- It processes each row independently

**Example**

| Input | Output  |
| ----- | ------- |
| 1 row | 1 value |

**Types of Scalar Function**

| Category             | Examples                                        |
| -------------------- | ----------------------------------------------- |
| String Functions     | `UPPER`, `LOWER`, `LENGTH`, `SUBSTR`, `REPLACE` |
| Numeric Functions    | `ROUND`, `TRUNC`, `ABS`, `MOD`                  |
| Date Functions       | `SYSDATE`, `ADD_MONTHS`, `MONTHS_BETWEEN`       |
| Conversion Functions | `TO_CHAR`, `TO_NUMBER`, `TO_DATE`               |
| Null Functions       | `NVL`, `COALESCE`, `NVL2`                       |

**Types of Conversion Functions**

| Function  | Purpose                        |
| --------- | ------------------------------ |
| TO_CHAR   | Convert number/date → string   |
| TO_NUMBER | Convert string → number        |
| TO_DATE   | Convert string → date          |
| CAST      | Convert between any data types |

**Aggregate Functions**

| Function | Purpose        |
| -------- | -------------- |
| COUNT    | Number of rows |
| SUM      | Total value    |
| AVG      | Average value  |
| MAX      | Highest value  |
| MIN      | Lowest value   |

### Function vs Procedure

| Feature        | Function        | Procedure          |
| -------------- | --------------- | ------------------ |
| Returns value  | YES             | Optional           |
| Used in SELECT | YES             | NO                 |
| Purpose        | Calculation     | Action/Process     |
| Example        | tax calculation | insert/update data |
