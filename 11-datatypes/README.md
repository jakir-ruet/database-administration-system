### ### Datatype

```bash
Oracle Datatypes
│
├── Character Datatypes
│   │
│   ├── CHAR(size)
│   │      → Fixed-length text
│   │      → Use: Gender, Country Code, Status
│   │
│   ├── VARCHAR2(size)
│   │      → Variable-length text
│   │      → Use: Name, Email, Address
│   │
│   ├── NCHAR(size)
│   │      → Fixed Unicode text
│   │      → Use: Multilingual fixed values
│   │
│   ├── NVARCHAR2(size)
│   │      → Variable Unicode text
│   │      → Use: Bangla, Arabic, Japanese text
│   │
│   └── CLOB / NCLOB
│          → Large text data
│          → Use: Articles, Logs, Documents
│
├── Numeric Datatypes
│   │
│   ├── NUMBER(p,s)
│   │      → Integer/Decimal numbers
│   │      → Use: ID, Salary, Price, Quantity
│   │
│   ├── FLOAT
│   │      → Approximate decimal values
│   │      → Use: Scientific calculations
│   │
│   ├── BINARY_FLOAT
│   │      → 32-bit floating-point number
│   │      → Use: Fast mathematical operations
│   │
│   └── BINARY_DOUBLE
│          → 64-bit floating-point number
│          → Use: High-precision scientific data
│
├── Date & Time Datatypes
│   │
│   ├── DATE
│   │      → Stores date and time
│   │      → Use: Order date, Joining date
│   │
│   ├── TIMESTAMP
│   │      → Precise date and time
│   │      → Use: Audit logs, Event tracking
│   │
│   ├── TIMESTAMP WITH TIME ZONE
│   │      → Time with timezone info
│   │      → Use: Global applications
│   │
│   ├── INTERVAL YEAR TO MONTH
│   │      → Year/month duration
│   │      → Use: Subscription period
│   │
│   └── INTERVAL DAY TO SECOND
│          → Day/time duration
│          → Use: Time difference calculations
│
├── Large Object (LOB) Datatypes
│   │
│   ├── BLOB
│   │      → Binary large object
│   │      → Use: Images, PDFs, Videos
│   │
│   ├── CLOB
│   │      → Character large object
│   │      → Use: Large descriptions, XML
│   │
│   ├── NCLOB
│   │      → Unicode large text
│   │      → Use: Multilingual documents
│   │
│   └── BFILE
│          → External binary file
│          → Use: Files stored outside database
│
├── RAW & Binary Datatypes
│   │
│   ├── RAW(size)
│   │      → Binary/raw data
│   │      → Use: Encryption keys, Hash values
│   │
│   └── LONG RAW
│          → Large binary data (legacy)
│          → Use: Old systems compatibility
│
└── Row Identifier Datatypes
    │
    ├── ROWID
    │      → Physical row address
    │      → Use: Fast row access
    │
    └── UROWID
           → Universal row identifier
           → Use: Advanced storage structures
```

#### Most use case in Enterprise Applications

```bash
Enterprise Applications
│
├── Primary Key           → NUMBER
├── Username              → VARCHAR2
├── Password Hash         → VARCHAR2 / RAW
├── Email                 → VARCHAR2
├── Mobile Number         → VARCHAR2
├── Amount / Salary       → NUMBER(10,2)
├── Created Date          → DATE
├── Audit Timestamp       → TIMESTAMP
├── Profile Picture       → BLOB
├── Product Description   → CLOB
└── Multilingual Content  → NVARCHAR2/NCLOB
```

### Types of SQL Statements in Oracle Database

```bash
SQL Statements
│
├── DDL (Data Definition Language)
│   │
│   ├── CREATE
│   ├── ALTER
│   ├── DROP
│   ├── TRUNCATE
│   └── RENAME
│
├── DML (Data Manipulation Language)
│   │
│   ├── INSERT
│   ├── UPDATE
│   ├── DELETE
│   └── MERGE
│
├── DQL (Data Query Language)
│   │
│   └── SELECT
│
├── TCL (Transaction Control Language)
│   │
│   ├── COMMIT
│   ├── ROLLBACK
│   └── SAVEPOINT
│
└── DCL (Data Control Language)
    │
    ├── GRANT
    └── REVOKE
```
