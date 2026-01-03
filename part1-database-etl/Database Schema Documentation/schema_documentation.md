

 ENTITY: customers
Purpose: Stores customer information for the Fleximart e-commerce platform

Attributes:
| Attribute | Data Type | Constraints | Description |
|-----------|-----------|-------------|-------------|
| customer_id | INT | PRIMARY KEY AUTO_INCREMENT | Unique identifier for each customer |
| first_name | VARCHAR(50) | NOT NULL | Customer's first name |
| last_name | VARCHAR(50) | NOT NULL | Customer's last name |
| email | VARCHAR(100) | UNIQUE, NOT NULL | Customer's email address (used for login and notifications) |
| phone | VARCHAR(20) | NULLABLE | Customer's contact phone number |
| city | VARCHAR(50) | NULLABLE | Customer's city of residence |
| registration_date | DATE | NULLABLE | Date when customer registered on the platform |

Relationships:
 One customer can place MANY orders
---

 ENTITY: products
Purpose: Stores product catalog information available for sale

**Attributes:**
| Attribute | Data Type | Constraints | Description |
|-----------|-----------|-------------|-------------|
| product_id | INT | PRIMARY KEY AUTO_INCREMENT | Unique identifier for each product |
| product_name | VARCHAR(100) | NOT NULL | Name of the product |
| category | VARCHAR(50) | NOT NULL | Product category (Electronics, Fashion, Groceries, etc.) |
| price | DECIMAL(10,2) | NOT NULL | Unit price of the product |
| stock_quantity | INT | DEFAULT 0 | Current inventory count |

**Relationships:**
- One product can appear in **MANY** order_items
---

# ENTITY: orders
**Purpose:** Stores customer order information

**Attributes:**
| Attribute | Data Type | Constraints | Description |
|-----------|-----------|-------------|-------------|
| order_id | INT | PRIMARY KEY AUTO_INCREMENT | Unique identifier for each order |
| customer_id | INT | NOT NULL, FOREIGN KEY | Reference to the customer who placed the order |
| order_date | DATE | NOT NULL | Date when the order was placed |
| total_amount | DECIMAL(10,2) | NOT NULL | Total order value |
| status | VARCHAR(20) | DEFAULT 'Pending' | Order status (Pending, Completed, Cancelled, etc.) |

**Relationships:**
- One customer can have **MANY** orders (M:1 with customers table)
- One order can contain **MANY** order_items (1:M with order_items table)

---

### ENTITY: order_items
**Purpose:** Stores individual items within each order (junction table for orders and products)

**Attributes:**
| Attribute | Data Type | Constraints | Description |
|-----------|-----------|-------------|-------------|
| order_item_id | INT | PRIMARY KEY AUTO_INCREMENT | Unique identifier for each order line item |
| order_id | INT | NOT NULL, FOREIGN KEY | Reference to the parent order |
| product_id | INT | NOT NULL, FOREIGN KEY | Reference to the ordered product |
| quantity | INT | NOT NULL | Number of units ordered |
| unit_price | DECIMAL(10,2) | NOT NULL | Price per unit at time of order |
| subtotal | DECIMAL(10,2) | NOT NULL | Calculated line item total (quantity × unit_price) |

**Relationships:**
- One order can have **MANY** order_items (1:M with orders table)
- One product can appear in **MANY** order_items (1:M with products table)

---

## Entity-Relationship Diagram (Text Format)

```
┌─────────────┐         ┌─────────────┐         ┌─────────────┐
│  customers  │         │    orders   │         │  order_items│
├─────────────┤         ├─────────────┤         ├─────────────┤
│ customer_id │1   M    │ order_id    │1   M    │order_item_id│
│ first_name  │────────│ customer_id │─────────│ order_id    │
│ last_name   │        │ order_date  │         │ product_id  │
│ email       │        │ total_amount│         │ quantity    │
│ phone       │        │ status      │         │ unit_price  │
│ city        │        └─────────────┘         │ subtotal    │
│ reg_date    │                               └──────┬──────┘
└─────────────┘                                      │
                                                    │
                                                    │ M   1
                                                    ▼
                                            ┌─────────────┐
                                            │  products   │
                                            ├─────────────┤
                                            │ product_id  │
                                            │ product_name│
                                            │ category    │
                                            │ price       │
                                            │ stock_qty   │
                                            └─────────────┘
```

---

## Normalization Explanation

### Why This Design is in 3NF (Third Normal Form)

The Fleximart database schema is designed in Third Normal Form (3NF), which ensures that the data is free from transitive dependencies and redundant storage. This design achieves 3NF compliance through several key principles that eliminate data anomalies and ensure data integrity.

### Functional Dependencies

The following functional dependencies exist in the schema:

**customers table:**
- customer_id → first_name, last_name, email, phone, city, registration_date
- email → customer_id (since email is UNIQUE)

**products table:**
- product_id → product_name, category, price, stock_quantity

**orders table:**
- order_id → customer_id, order_date, total_amount, status
- customer_id → (no transitive dependency since customer info is in separate table)

**order_items table:**
- order_item_id → order_id, product_id, quantity, unit_price, subtotal
- (order_id, product_id) → quantity, unit_price, subtotal (composite key dependency)

### How the Design Avoids Anomalies

**Update Anomalies:** The design prevents update anomalies by storing each piece of information in only one place. Customer details are stored solely in the customers table, and product information is stored only in the products table. If a customer changes their phone number or city, we update only one record in the customers table, and this change is reflected across all their orders through foreign key references without any inconsistency.

**Insert Anomalies:** The schema eliminates insert anomalies by allowing partial data entry where appropriate. A new customer can be added without requiring order information (NULL values in optional fields). Similarly, new products can be cataloged before any orders are placed. The use of NULLABLE constraints on non-critical fields like phone, city, and registration_date allows flexibility during data entry without forcing incomplete records to be rejected.

**Delete Anomalies:** The design prevents delete anomalies by maintaining proper separation of concerns. If we delete an order, we only remove the order and its associated order_items, leaving the customer and product records intact. Conversely, deleting a customer removes their orders but does not affect product catalog data. This separation ensures that deleting one entity type does not unintentionally remove data about other entities.

The junction table (order_items) specifically addresses the many-to-many relationship between orders and products, preventing the need to duplicate product details within each order record. This approach ensures that product price changes in the products table do not corrupt historical order data, as order_items stores the unit_price at the time of purchase.

---

# Sample Data Representation

# customers table

| customer_id | first_name | last_name | email | phone | city | registration_date |
|-------------|------------|-----------|-------|-------|------|-------------------|
| C001 | Rahul | Sharma | rahul.sharma@gmail.com | +91-9876543210 | Bangalore | 2023-01-15 |
| C002 | Priya | Patel | priya.patel@yahoo.com | +91-9988776655 | Mumbai | 2023-02-20 |
| C003 | Amit | Kumar | amit.kumar@unknown.com | +91-9765432109 | Delhi | 2023-03-10 |

# products table

| product_id | product_name | category | price | stock_quantity |
|------------|--------------|----------|-------|----------------|
| P001 | Samsung Galaxy S21 | Electronics | 45999.00 | 150 |
| P002 | Nike Running Shoes | Fashion | 3499.00 | 80 |
| P003 | Apple MacBook Pro | Electronics | 52999.00 | 45 |

# orders table

| order_id | customer_id | order_date | total_amount | status |
|----------|-------------|------------|--------------|--------|
| 1 | C001 | 2024-01-15 | 45999.00 | Completed |
| 2 | C002 | 2024-01-16 | 5998.00 | Completed |
| 3 | C003 | 2024-01-15 | 52999.00 | Completed |

# order_items table

| order_item_id | order_id | product_id | quantity | unit_price | subtotal |
|---------------|----------|------------|----------|------------|----------|
| 1 | 1 | P001 | 1 | 45999.00 | 45999.00 |
| 2 | 2 | P004 | 2 | 2999.00 | 5998.00 |
| 3 | 3 | P007 | 1 | 52999.00 | 52999.00 |

---

 Schema Summary

| Table Name | Primary Key | Foreign Keys | Indexes |
|------------|-------------|--------------|---------|
| customers | customer_id | - | email (UNIQUE) |
| products | product_id | - | category |
| orders | order_id | customer_id | customer_id, order_date |
| order_items | order_item_id | order_id, product_id | order_id, product_id |

---


