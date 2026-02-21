### Retrieving Data from a Single Table

**Data Retrieval Basics**

- SELECT
- FROM
- AS (Alias)
- DISTINCT

**Filtering Data**

- WHERE Clause
- Comparison Operators (=, <>, <, >)
- AND/OR/NOT
- IN Operator
- BETWEEN Operator
- LIKE Operator
- REGEXP alternative (PATINDEX)
- IS NULL/IS NOT NULL

**Aggregation**

- COUNT()
- MAX()
- MIN()
- AVG()
- GROUP BY

**Sorting & Limiting**

- ORDER BY
- TOP/OFFSET-FETCH (LIMIT equivalent)

> Even though we write SQL differently, SQL Server processes queries logically in this order

1. FROM
2. WHERE
3. GROUP BY
4. SELECT
5. DISTINCT
6. ORDER BY
7. TOP/OFFSET-FETCH
