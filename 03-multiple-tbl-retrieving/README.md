## Inner Join

- Intersection (`A ∩ B`)
- Returns only `matching` rows from both tables.
- Match DeptIds > `10`, `20`, `30`, `40`

## Left Join - Left Outer Join

- ALL rows from left table
- Matching rows from right table
- Non-matches → `NULL`

## Right Join - Right Outer Join

- All departments appear.

## Full Join - Full Outer Join

- LEFT + RIGHT combined.

## Union - Stack rows (no duplicates)

- Duplicate values removed automatically.

## Union All - Stack rows (with duplicates)

- Faster because SQL Server does NOT remove duplicates.
- Column data types must be compatible.

## SQL Join

![SQL Join](/img/join.png)

## The 4 Types of SQL Joins

SQL joins are used to combine data from two or more tables based on a related column between them. Different join types control how matching and non-matching rows are returned.

1. INNER JOIN

Returns only the rows that have matching values in both tables.
Only the common records shared between the tables appear in the result.

2. LEFT JOIN (LEFT OUTER JOIN)

Returns all rows from the left table and the matching rows from the right table.
If a row in the left table has no match in the right table, the columns from the right table will contain NULL values.

3. RIGHT JOIN (RIGHT OUTER JOIN)

Returns all rows from the right table and the matching rows from the left table.
If a row in the right table has no corresponding match in the left table, the columns from the left table will contain NULL values.

4. FULL OUTER JOIN

Returns all rows from both tables.
When there is no match between tables, missing values are filled with NULL on the respective side.
