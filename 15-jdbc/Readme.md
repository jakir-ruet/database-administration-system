### JDBC (Java Database Connectivity)

It's a standard Java API that allows Java applications to interact with relational databases like MySQL, PostgreSQL, and Oracle. It provides methods to connect, execute SQL queries, and process results

![JDBC Architecture](/img/jdbc-architecture.png)

#### JDBC Core Components - Important classes/interfaces

| Interface/Class   | Purpose             |
| ----------------- | ------------------- |
| DriverManager     | Creates connections |
| Connection        | Database connection |
| Statement         | Executes SQL        |
| PreparedStatement | Precompiled SQL     |
| CallableStatement | Stored procedures   |
| ResultSet         | Query results       |
| SQLException      | Database errors     |

### Prerequisites

- Download Oracle 21c XE (Free version)
- Download Oracle JDBC Driver (ojdbc17.jar)
- [Driver](https://www.oracle.com/database/technologies/appdev/jdbc.html)

### Maven Dependency

```bash
<dependency>
    <groupId>com.oracle.database.jdbc</groupId>
    <artifactId>ojdbc17</artifactId>
    <version>21.9.0.0</version>
</dependency>
```

### Driver Types - Oracle 21c supports Type 4 and Type 2

| Type   | Driver Name             | Oracle Support                           | Status             |
| ------ | ----------------------- | ---------------------------------------- | ------------------ |
| Type 1 | JDBC-ODBC Bridge Driver | Not supported in modern Oracle JDBC      | Deprecated/Removed |
| Type 2 | Native-API Driver       | Oracle OCI Driver                        | Supported          |
| Type 3 | Network Protocol Driver | Historically possible through middleware | Rarely used        |
| Type 4 | Pure Java Driver        | Oracle Thin Driver                       | Recommended        |

> Oracle Thin Driver URL

```bash
jdbc:oracle:thin:@hostname:port:SID
jdbc:oracle:thin:@//hostname:port/service_name
```

### Thin Driver vs OCI Driver

| Feature              | Thin Driver | OCI Driver |
| -------------------- | ----------- | ---------- |
| Pure Java            | Yes         | No         |
| Oracle Client Needed | No          | Yes        |
| Platform Independent | Yes         | No         |
| Easy Deployment      | Yes         | No         |
| Docker Friendly      | Yes         | No         |
| Kubernetes Friendly  | Yes         | No         |
| Cloud Friendly       | Yes         | No         |
| Performance          | Excellent   | Excellent  |
| Recommended Today    | Yes         | Usually No |

### 7 Standard JDBC Steps

The 7 standard JDBC steps are the fundamental workflow for any database operation in Java. Here's a comprehensive guide with Oracle 21c examples:

1. Import JDBC packages
2. Load and register the JDBC driver
3. Establish connection to database
4. Create statement object
5. Execute SQL query
6. Process result set
7. Close connection (clean up resources)

### JDBC Best Practices (Refined & Professional)

| Step       | Best Practice                                                         | Why It Matters                                                                               |
| ---------- | --------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| **Step 2** | Don’t explicitly load JDBC driver in JDBC 4+                          | Driver auto-registration via SPI (`META-INF/services`) removes boilerplate code              |
| **Step 3** | Use `try-with-resources`                                              | Ensures automatic closing of `Connection`, `Statement`, `ResultSet` even on exceptions       |
| **Step 4** | Prefer `PreparedStatement` over `Statement`                           | Prevents SQL injection + supports query pre-compilation + better performance                 |
| **Step 5** | Use correct execution method                                          | `executeQuery()` → SELECT, `executeUpdate()` → INSERT/UPDATE/DELETE, `execute()` → mixed/DDL |
| **Step 6** | Always close `ResultSet` explicitly (if not using try-with-resources) | Frees DB cursor and avoids memory + cursor leaks                                             |
| **Step 7** | Close resources in reverse order                                      | Ensures dependent resources are released safely: ResultSet → Statement → Connection          |

### Complete Working Example - All 7 Steps

```bash
import java.sql.*;
import java.math.BigDecimal;

public class SevenJDBCStepsDemo {

    private static final String URL = "jdbc:oracle:thin:@localhost:1521/XEPDB1";
    private static final String USER = "hr";
    private static final String PASSWORD = "hr";

    public static void main(String[] args) {
        // Step 1: Import - Already done via imports

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Step 2: Load and register driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("✓ Step 2: Driver loaded");

            // Step 3: Establish connection
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✓ Step 3: Connection established");

            // Step 4: Create statement
            String sql = "SELECT employee_id, first_name, last_name, salary " +
                        "FROM employees WHERE salary > ? ORDER BY salary DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setBigDecimal(1, new BigDecimal("50000"));
            System.out.println("✓ Step 4: Statement created");

            // Step 5: Execute query
            rs = pstmt.executeQuery();
            System.out.println("✓ Step 5: Query executed");

            // Step 6: Process result set
            System.out.println("\n✓ Step 6: Processing results");
            System.out.println("=================================");

            int count = 0;
            while (rs.next()) {
                int id = rs.getInt("employee_id");
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                BigDecimal salary = rs.getBigDecimal("salary");

                System.out.printf("ID: %d | Name: %s %s | Salary: $%,.2f%n",
                                 id, firstName, lastName, salary);
                count++;
            }
            System.out.println("=================================");
            System.out.println("Total records: " + count);

        } catch (ClassNotFoundException e) {
            System.err.println("Step 2 Failed: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            System.err.println("Oracle Error Code: " + e.getErrorCode());
        } finally {
            // Step 7: Close resources
            try {
                if (rs != null) {
                    rs.close();
                    System.out.println("\n✓ Step 7: ResultSet closed");
                }
                if (pstmt != null) {
                    pstmt.close();
                    System.out.println("✓ Step 7: Statement closed");
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                    System.out.println("✓ Step 7: Connection closed");
                }
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
    }
}
```

### RowSet

RowSet is a JDBC interface that extends the ResultSet interface, providing additional features such as `scrollability`, `updatability`, `serialization`, and the ability to work in a disconnected environment.

#### Types of RowSet

| RowSet Type        | Connection Status | Primary Use Case                                                                              |
| ------------------ | ----------------- | --------------------------------------------------------------------------------------------- |
| **JdbcRowSet**     | Connected         | Acts like a wrapper around `ResultSet`, supports scrolling + updating with live DB connection |
| **CachedRowSet**   | Disconnected      | Works offline; fetch data once, modify, and sync later (useful in desktop/mobile apps)        |
| **WebRowSet**      | Disconnected      | Supports XML representation for data exchange between systems/web services                    |
| **JoinRowSet**     | Disconnected      | Combines multiple RowSets (like SQL JOIN) without requiring DB connection                     |
| **FilteredRowSet** | Disconnected      | Applies client-side filtering without modifying SQL queries                                   |

### Connection Pooling

Connection Pooling is a technique where database connections are created in advance, stored in a "pool" (cache), and reused by multiple clients instead of creating a new connection for each request. `Connection Pooling = Pre-created connections + Reuse + Management`

#### Key Benefits

| Aspect               | Without Pool                              | With Connection Pool              |
| -------------------- | ----------------------------------------- | --------------------------------- |
| Connection Time      | 1–3 seconds                               | 1–10 milliseconds                 |
| Resource Usage       | High (new connection each request)        | Low (reuses existing connections) |
| Max Concurrent Users | Limited by DB connection limit            | Much higher scalability           |
| Overhead             | TCP handshake + authentication every time | Done once at startup              |
| Performance          | Slow under load                           | High throughput                   |

### ACID Properties

ACID is a set of guarantees that ensures database transactions are reliable, consistent, and safe even under failure or concurrency.

#### Core Properties

- A - Atomicity   → All or nothing
- C - Consistency → Valid state always maintained
- I - Isolation   → No interference between transactions
- D - Durability  → Changes survive crashes

### Copy Database

Copy Database is the process of duplicating all or part of a database from one location (source) to another (target), including schema structure, data, indexes, constraints, stored procedures, and other database objects.

#### Types of Database Copy

| Type                                  | Description                                                                             | Use Case                                                |
| ------------------------------------- | --------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| **Schema Copy**                       | Copies database structure including tables, indexes, constraints, views, triggers, etc. | Creating a development/test environment from production |
| **Full Database Copy**                | Copies entire database including all schemas, structure, and data                       | Disaster recovery, full backup, system replication      |
| **Partial Copy**                      | Copies selected tables or filtered data from database                                   | Reporting systems, analytics, data warehousing          |
| **Structure Only (Schema-Only Copy)** | Copies only database schema without any data                                            | Creating empty staging or testing environments          |
| **Data Only Copy**                    | Copies only data into an existing schema without changing structure                     | Data migration, bulk data refresh                       |
