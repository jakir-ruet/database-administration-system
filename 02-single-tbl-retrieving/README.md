### Retrieving Data from a Single Table

1. **Data Retrieval Basics**

- SELECT - `specifies columns to fetch.`
- FROM - `specifies the table`
- AS (Alias) - `Aliases rename columns (or tables) for readability.`
- DISTINCT - `Removes duplicate values from the result set.`

2. **Filtering Data**

- WHERE Clause
- Comparison Operators (=, <>, <, >)
- AND/OR/NOT
- IN Operator
- BETWEEN Operator
- LIKE Operator
- PATINDEX alternative (REGEXP)
- IS NULL/IS NOT NULL

3. **Aggregation**

- COUNT()
- MAX()
- MIN()
- AVG()
- GROUP BY
- HAVING - Combine with HAVING to filter aggregated results

4. **Sorting & Limiting**

- ORDER BY
- TOP/OFFSET-FETCH (LIMIT equivalent)

# Even though we write SQL differently, SQL Server processes queries logically in this order

1. FROM
2. WHERE
3. GROUP BY
4. SELECT
5. DISTINCT
6. ORDER BY
7. TOP/OFFSET-FETCH
