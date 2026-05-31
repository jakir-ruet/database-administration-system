### SQL JOINs and UNIONs – Complete Guide

![Join Infographic](/img/join.png)

**Employee Table**

| EmpID | EmpName | Salary | DeptID |
| ----- | ------- | ------ | ------ |
| 1     | Jakir   | 5000   | 10     |
| 2     | Rahim   | 5500   | 20     |
| 3     | Karim   | 6000   | 30     |
| 4     | Sadek   | 6500   | 40     |
| 5     | Tania   | 7000   | 50     |

**Project Table**

| ProjectID | ProjectName        | DeptID |
| --------- | ------------------ | ------ |
| 101       | Website Redesign   | 10     |
| 102       | CRM Implementation | 20     |
| 103       | Marketing Campaign | 30     |
| 104       | Recruitment Drive  | 40     |
| 105       | Server Upgrade     | 60     |

**Matching and Not Matching DeptIDs**

```bash
Employees           Projects

10  ✓ Match         10
20  ✓ Match         20
30  ✓ Match         30
40  ✓ Match         40
50  ✗ No Match
60 ✗ No Match
```

#### Inner Join

Returns only rows that have matching values in both tables.

> Mathematical Concept: `A ∩ B` (Intersection)

**Inner Join Table**

| DeptID | EmpID | EmpName | ProjectName        | ProjectID |
| ------ | ----- | ------- | ------------------ | --------- |
| 10     | 1     | Jakir   | Website Redesign   | 101       |
| 20     | 2     | Rahim   | CRM Implementation | 102       |
| 30     | 3     | Karim   | Marketing Campaign | 103       |
| 40     | 4     | Sadek   | Recruitment Drive  | 104       |

**Explanation** - Only matching records appear.

```bash
10 ✓
20 ✓
30 ✓
40 ✓
Returned only matches
```

> `Tania (50)` and `Server Upgrade (60)` are excluded.

#### Left Join (Left Outer Join)

**Returns:**

- All rows from the left table
- Matching rows from the right table
- If no match exists, NULL is returned

> Mathematical Concept: `A + (A ∩ B)`

**Left Join (Left Outer Join) Table**

| DeptID | EmpID | EmpName | ProjectName        | ProjectID |
| ------ | ----- | ------- | ------------------ | --------- |
| 10     | 1     | Jakir   | Website Redesign   | 101       |
| 20     | 2     | Rahim   | CRM Implementation | 102       |
| 30     | 3     | Karim   | Marketing Campaign | 103       |
| 40     | 4     | Sadek   | Recruitment Drive  | 104       |
| 50     | 5     | Tania   | NULL               | NULL      |

**Explanation**

```bash
Employees (Keep All)

Jakir  -> Website Redesign
Rahim  -> CRM Implementation
Karim  -> Marketing Campaign
Sadek  -> Recruitment Drive
Tania  -> NULL
```

> **Why NULL?**
>
> - `Tania` belongs to DeptID 50.
> - DeptID = 50, No project exists for DeptID 50.

#### Right Join (Right Outer Join)

**Returns:**

- All rows from the right table
- Matching rows from the left table
- Non-matching values from the left side become NULL

> Mathematical Concept: `B + (A ∩ B)`

**Right Join (Right Outer Join Table)**

| DeptID | EmpID | EmpName | ProjectName        | ProjectID |
| ------ | ----- | ------- | ------------------ | --------- |
| 10     | 1     | Jakir   | Website Redesign   | 101       |
| 20     | 2     | Rahim   | CRM Implementation | 102       |
| 30     | 3     | Karim   | Marketing Campaign | 103       |
| 40     | 4     | Sadek   | Recruitment Drive  | 104       |
| NULL   | NULL  | NULL    | Server Upgrade     | 105       |

**Explanation**

```bash
Projects (Keep All)

Website Redesign      <- Jakir
CRM Implementation    <- Rahim
Marketing Campaign    <- Karim
Recruitment Drive     <- Sadek
Server Upgrade        <- NULL
```

> **Why NULL?**
>
> - `Server Upgrade` belongs to DeptID 60.
> - Project DeptID = 60, No employee exists in DeptID 60.
> - Therefore EmployeeName becomes NULL.

#### Full Outer Join

Returns all rows from both tables.

> Mathematical Concept: `A ∪ B` (Union)

**Full Outer Join Table**

| DeptID | EmpID | EmpName | ProjectName        | ProjectID |
| ------ | ----- | ------- | ------------------ | --------- |
| 10     | 1     | Jakir   | Website Redesign   | 101       |
| 20     | 2     | Rahim   | CRM Implementation | 102       |
| 30     | 3     | Karim   | Marketing Campaign | 103       |
| 40     | 4     | Sadek   | Recruitment Drive  | 104       |
| 50     | 5     | Tania   | NULL               | NULL      |
| NULL   | NULL  | NULL    | Server Upgrade     | 105       |

**Explanation**

```bash
Matches
-------
Jakir  <-> Website Redesign
Rahim  <-> CRM Implementation
Karim  <-> Marketing Campaign
Sadek  <-> Recruitment Drive

Employee Only
-------------
Tania (Dept 50)

Project Only
------------
Server Upgrade (Dept 60)
```

- All records from Employees and Projects are included.

### Easy Memory Diagram

```bash
INNER JOIN
=================
10 20 30 40

LEFT JOIN
=================
10 20 30 40 + Tania

RIGHT JOIN
=================
10 20 30 40 + Server Upgrade

FULL JOIN
=================
10 20 30 40
+ Tania
+ Server Upgrade
```

### Union (Removes Duplicates - Combine Employees + Projects logically)

UNION combines results and automatically `removes duplicate` rows. UNION works only when both SELECTs return the `same number of columns` with `compatible datatypes`.

**Key behavior:**

- Combines multiple SELECT queries
- Removes duplicate rows (like DISTINCT)
- Slower than UNION ALL (extra processing required)

**Right now:**

- Employees → (EmpID, EmpName, Salary, DeptID)
- Projects → (ProjectID, ProjectName, DeptID)

> So we need to align structure before using UNION.

### Union All Example (Keeps Duplicates)

**Result behavior:**

- All employees + all projects appear
- No filtering of duplicates
- Faster execution

> **Important Observation from your data**

**We have:**

- Employees DeptIDs	: 10, 20, 30, 40, 50
- Projects DeptIDs	: 10, 20, 30, 40, 60
- DeptID = 50 exists only in Employees
- DeptID = 60 exists only in Projects

> So UNION results will naturally mix departments differently.

### Real-world use case (VERY IMPORTANT)

> UNION is used for:
>
> - Combining different business entities into a single report
> - Employees + Contractors
> - Orders + Archived Orders
> - Active + Inactive users

### Self Join

Employee Attendance Approval System

In real companies:

- Employees request leave
- A manager approves it
- Manager is also an employee → stored in same table
- So we model everything in one table

> **Real Self Join (Employee → Manager)**
>
> - Business Requirement: Show each employee with their direct manager name
