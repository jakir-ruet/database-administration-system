### Complex Queries

A complex query in SQL is a query that goes beyond simple SELECT-FROM-WHERE statements. It may include:

- Subqueries (nested queries)
- Joins
- Aggregate functions
- Conditional operators (IN, EXISTS, ANY, ALL)
- Derived tables (subqueries in FROM)

> Complex queries allow you to retrieve highly specific and meaningful data from relational databases.

#### Subqueries

A subquery is a query nested inside another SQL query.

#### The IN Operator

The IN operator is used when a subquery returns multiple values.

#### Subqueries vs Joins

| Subqueries                 | Joins                        |
| -------------------------- | ---------------------------- |
| Nested inside main query   | Combine tables horizontally  |
| Easier to read (sometimes) | Often faster in performance  |
| Can be less efficient      | Preferred for large datasets |

#### The ALL Keyword

ALL compares a value to all values returned by a subquery.

#### The ANY Keyword

ANY (or SOME) compares a value to any value returned by a subquery.

#### Correlated Subqueries

A correlated subquery depends on the outer query for its values. It runs once for each row processed by the outer query.

#### The EXISTS Operator

EXISTS checks whether a subquery returns any rows.

#### Subqueries in the SELECT Clause

Subqueries can be used to compute derived values in the result.

#### Subqueries in the FROM Clause

A subquery in the FROM clause is called a derived table.

#### Advantages of Subqueries

- Makes complex queries easier to write
- Helps perform step-by-step filtering
- Useful for aggregate comparisons
- Improves readability in some cases
