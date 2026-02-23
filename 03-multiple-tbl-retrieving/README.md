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
