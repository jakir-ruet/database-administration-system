### Transaction (COMMIT, ROLLBACK, SAVEPOINT)

A transaction is a group of SQL statements that Oracle treats as a single unit of work.

```bash
UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE account_id = 2;

COMMIT;
```

> **This represents one business operation:**
>
> - Transfer 1000 from Account 1 to Account 2
> - Both updates must succeed together.

#### ACID Properties

Every Oracle transaction follows ACID.

**A — Atomicity** - All or nothing.

```bash
Transfer money
    ↓
Both updates succeed
OR
Both fail
```

**C — Consistency** - Database remains valid.

```bash
Balance cannot become negative
Primary key remains unique
```

**I — Isolation** - Multiple users do not interfere with each other.

**D — Durability** - After COMMIT:

```bash
Power failure
Server crash
Restart
```

> Data remains saved.

### Concurrency

Multiple users accessing the database simultaneously.

```bash
HR User
Manager
Payroll System
Web Application
```

> All access the Employees table at the same time.

#### Oracle Concurrency Control

```bash
MVCC
(Multi-Version Concurrency Control)
```

> This is one of Oracle's biggest strengths.
