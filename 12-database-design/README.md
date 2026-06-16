### Core Modules (start small) - Use HYBRID approach

1. Product Management
	- Create product
	- Update product
	- List products
	- Search product
2. Category Management
	CRUD categories
	Assign products
3. Stock Management
	Increase stock (purchase)
	Decrease stock (sales)
4. Track available quantity
5. Sales Module (VERY IMPORTANT)
	Create order
	Order items
	Reduce stock automatically
6. Reports (real enterprise skill)
	Total sales by date
	Top products
	Low stock report

### Tech Stack

1. Java 21
2. Oracle 21c
3. Spring Boot 3.x
4. Spring Data JPA (For CRUD Operations)
5. Spring JDBC (For Complex Reports)
6. Oracle PL/SQL (Stored Procedures for Transactions)

### Why I chose this project? Because it teaches

- Real database relationships
- Transaction handling
- SQL + Java integration
- Business logic (not just CRUD)
- ERP-style thinking

### Create App

1. Project: Maven
2. Language: Java
3. Spring Boot: 3.2.x
4. Group: com.erp
5. Artifact: inventory-system
6. Dependencies:
	- Spring Web
	- Spring Data JPA
	- Spring Boot DevTools
	- Oracle Driver
	- Lombok (optional)
7. Download and extract the zip file.

```bash
src/main/java/com/erp/inventory/
├── config/
│   └── DatabaseConfig.java
├── entity/
│   ├── Category.java
│   ├── Product.java
│   ├── Stock.java
│   ├── StockMovement.java
│   ├── Order.java
│   └── OrderItem.java
├── repository/
│   ├── CategoryRepository.java (JPA)
│   ├── ProductRepository.java (JPA)
│   ├── StockRepository.java (JPA)
│   └── ReportRepository.java (JDBC)
├── service/
│   ├── ProductService.java
│   ├── CategoryService.java
│   ├── StockService.java
│   ├── OrderService.java
│   └── ReportService.java
├── controller/
│   ├── ProductController.java
│   ├── CategoryController.java
│   ├── OrderController.java
│   └── ReportController.java
└── ErpInventoryApplication.java
```

### Key Learning Points Achieved

| Concept                     | Implementation                                                           |
| --------------------------- | ------------------------------------------------------------------------ |
| Real Database Relationships | Foreign keys, composite indexes, constraints                             |
| Transaction Handling        | PL/SQL stored procedure with explicit COMMIT/ROLLBACK                    |
| SQL + Java Integration      | JPA for CRUD, JDBC for complex queries, CallableStatement for procedures |
| Business Logic              | Stock validation, price calculations, order processing                   |
| ERP-style Thinking          | Audit trails (stock_movements), status management, atomic operations     |
