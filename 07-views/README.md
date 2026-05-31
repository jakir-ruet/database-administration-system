### VIEW

A VIEW is a **virtual** table created from a SQL query.

- It does NOT store data itself
- It shows data from one or more base tables

**Type of View**

| Type              | Description            |
| ----------------- | ---------------------- |
| Simple View       | Based on one table     |
| Complex View      | Joins multiple tables  |
| Materialized View | Stores data physically |

**Why VIEW is used?**

- Simplify complex queries
- Improve security (hide columns)
- Reuse SQL logic
- Provide abstraction layer

### HR Reporting System

You have:

- Employees table (raw data)
- You don’t want users to directly query raw table
- You want clean, secure, reusable reports
- So we create views for HR dashboards

#### Simple View (Active Employees Only)

- Business requirement:
- HR should only see active employees
