### 1. Retrieving Data from a Single Table

- SELECT statement and SELECT clause
- Filtering with WHERE
- Logical operators: AND, OR, NOT
- IN, BETWEEN, LIKE operators
- Pattern matching (LIKE, PATINDEX)
- Handling NULL values (IS NULL)
- Sorting results (ORDER BY)
- Limiting results (TOP)

### 2. Retrieving Data from Multiple Tables

- INNER JOIN
- OUTER JOIN (LEFT, RIGHT, FULL)
- SELF JOIN
- Multiple table joins
- Compound join conditions
- Implicit joins
- CROSS JOIN
- UNION
- Joining across databases

**Notes:**

- No NATURAL JOIN support (use explicit ON conditions)
- No USING clause (use ON instead)

### 3. Inserting, Updating, and Deleting Data

- Column constraints and attributes
- INSERT (single & multiple rows)
- Hierarchical inserts
- Copy tables (SELECT INTO / INSERT INTO)
- UPDATE (single, multiple, subqueries)
- DELETE operations
- Data recovery concepts

### 4. Summarizing Data

- Aggregate functions (SUM, AVG, COUNT, MIN, MAX)
- GROUP BY clause
- HAVING clause
- ROLLUP and CUBE operations

### 5. Writing Complex Queries

- Subqueries (single & multi-row)
- IN, ANY, ALL operators
- Correlated subqueries
- EXISTS operator
- Subqueries in SELECT & FROM
- Subqueries vs JOIN comparison

### 6. Essential SQL Server Functions

- Numeric functions
- String functions
- Date & time functions
- Date formatting & calculations
- ISNULL & COALESCE
- IIF function
- CASE expressions

### 7. Views

- Create, alter, drop views
- Updatable views
- WITH CHECK OPTION

### 8. Stored Procedures

- Introduction
- Creating procedures (SSMS & scripts)
- Parameters (input, output, default)
- Validation techniques
- Variables & functions
- Best practices

### 9. Triggers and Events

- INSERT, UPDATE, DELETE triggers
- Viewing & managing triggers
- Audit logging
- SQL Server Agent Jobs
- Job management

### 10. Transactions and Concurrency

- COMMIT & ROLLBACK
- Transaction management
- Concurrency control & locking
- Concurrency problems
- Isolation levels:
  - Read Uncommitted
  - Read Committed
  - Repeatable Read
  - Serializable
- Deadlock handling

### 11. Data Types

- String types
- Numeric types
- Date & time types
- Binary types
- Special types (XML, UNIQUEIDENTIFIER, TABLE, CURSOR)

### 12. Database Design

- Data modeling (conceptual, logical, physical)
- Keys (primary, foreign, candidate, composite)
- Relationships & constraints
- Normalization (1NF, 2NF, 3NF, BCNF)
- Schema design principles
- Forward & reverse engineering
- Case studies:
  - Flight booking system
  - Video rental system

### 13. Indexing for Performance

- Introduction to indexes
- Types of indexes
- Composite indexes
- Full-text indexes
- Covering indexes
- Index optimization
- When indexes are ignored
- Performance best practices

### 14. Securing Databases

- User management
- Roles & permissions
- GRANT & REVOKE
- Password policies
- Access control strategies
