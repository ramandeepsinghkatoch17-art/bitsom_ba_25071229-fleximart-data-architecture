# FlexiMart Star Schema Design Documentation

## Section 1: Schema Overview

### FACT TABLE: fact_sales

**Grain:** One row per product per order line item

**Business Process:** Sales transactions

#### Measures (Numeric Facts)
| Measure | Description |
|---------|-------------|
| `quantity_sold` | Number of units sold |
| `unit_price` | Price per unit at time of sale |
| `discount_amount` | Discount applied to the line item |
| `total_amount` | Final amount (quantity × unit_price - discount) |

#### Foreign Keys
| Foreign Key | References | Purpose |
|-------------|------------|---------|
| `date_key` | dim_date | Links to the date dimension for time-based analysis |
| `product_key` | dim_product | Links to the product dimension for product analysis |
| `customer_key` | dim_customer | Links to the customer dimension for customer analysis |

---

### DIMENSION TABLE: dim_date

**Purpose:** Date dimension for time-based analysis

**Type:** Conformed dimension (can be used across multiple fact tables)

**Attributes:**
| Attribute | Data Type | Description |
|-----------|-----------|-------------|
| `date_key` (PK) | INT | Surrogate key in format YYYYMMDD (e.g., 20240115) |
| `full_date` | DATE | Actual calendar date |
| `day_of_week` | VARCHAR(10) | Day name (Monday, Tuesday, etc.) |
| `day_of_month` | INT | Day of the month (1-31) |
| `month` | INT | Month number (1-12) |
| `month_name` | VARCHAR(10) | Full month name (January, February, etc.) |
| `quarter` | VARCHAR(2) | Fiscal quarter (Q1, Q2, Q3, Q4) |
| `year` | INT | Year (2024, 2025, etc.) |
| `is_weekend` | BOOLEAN | Flag indicating weekend days |

---

### DIMENSION TABLE: dim_product

**Purpose:** Product dimension for product-related analysis

**Type:** Slowly Changing Dimension Type 2 (SCD Type 2) - tracks product changes over time

**Attributes:**
| Attribute | Data Type | Description |
|-----------|-----------|-------------|
| `product_key` (PK) | INT | Surrogate key (auto-incrementing) |
| `product_id` | VARCHAR(20) | Natural key from source system |
| `product_name` | VARCHAR(100) | Full product name |
| `category` | VARCHAR(50) | Product category (Electronics, Fashion, Home & Kitchen) |
| `subcategory` | VARCHAR(50) | More specific product classification |
| `unit_price` | DECIMAL(10,2) | Current or historical product price |

---

### DIMENSION TABLE: dim_customer

**Purpose:** Customer dimension for customer-related analysis

**Type:** Slowly Changing Dimension Type 1 (SCD Type 1) - overwrites old values

**Attributes:**
| Attribute | Data Type | Description |
|-----------|-----------|-------------|
| `customer_key` (PK) | INT | Surrogate key (auto-incrementing) |
| `customer_id` | VARCHAR(20) | Natural key from source system |
| `customer_name` | VARCHAR(100) | Full customer name |
| `city` | VARCHAR(50) | Customer's city of residence |
| `state` | VARCHAR(50) | Customer's state |
| `customer_segment` | VARCHAR(20) | Customer segment (Retail, Corporate, etc.) |

---

## Section 2: Design Decisions

### 1. Why Transaction Line-Item Level Granularity?

The grain (granularity) of the fact_sales table is set to **one row per product per order line item** for several compelling business reasons:

- **Maximum Analytical Flexibility**: Line-item level granularity allows for the most detailed analysis. You can aggregate up to any level (order, day, month, category, customer) but cannot drill down below this level. Starting with more detail provides more options.

- **Preservation of Transaction Details**: Individual line items have different products, quantities, and potentially different discounts. If we aggregated at the order level, we would lose the ability to analyze product-specific patterns.

- **Accurate Revenue Attribution**: Line-item granularity ensures that revenue, quantity, and discount metrics are accurately attributed to specific products. This is essential for product performance analysis and inventory management.

- **Support for Business Requirements**: Product managers need to know which products are selling well, marketing needs customer purchase patterns, and finance needs accurate revenue recognition—all of which require line-item level data.

### 2. Why Surrogate Keys Instead of Natural Keys?

Surrogate keys (system-generated integer keys) are used instead of natural keys (business-provided identifiers) for the following reasons:

- **Performance**: Integer surrogate keys are smaller and faster to index and join compared to VARCHAR or composite natural keys. This significantly improves query performance, especially for large fact tables with millions of rows.

- **Isolation from Source System Changes**: Natural keys from source systems can change (e.g., product ID format changes, customer ID migration). Surrogate keys remain stable, protecting the data warehouse from upstream changes.

- **Handling Slowly Changing Dimensions**: Surrogate keys enable SCD Type 2 tracking where historical versions of dimension records can coexist. Each change creates a new dimension row with a new surrogate key, preserving historical accuracy.

- **Consistent Key Structure**: Surrogate keys provide a uniform key structure (INT AUTO_INCREMENT) across all dimensions, simplifying ETL processes and data modeling.

- **Handling Duplicate/Natural Keys**: Some natural keys might have duplicates or nulls in source data. Surrogate keys guarantee uniqueness and non-nullability.

### 3. How This Design Supports Drill-Down and Roll-Up Operations

The star schema design is specifically optimized for hierarchical analysis operations:

**Drill-Down Operations:**
- From Year → Quarter → Month → Day: Using dim_date attributes (year → quarter → month_name → full_date)
- From Category → Subcategory → Product: Using dim_product attributes (category → subcategory → product_name)
- From Region → City → Customer: Using dim_customer attributes (state → city → customer_name)

**Roll-Up Operations:**
- Aggregating from detailed transaction data up to any level of summarization
- Grouping by multiple dimension attributes at different hierarchical levels
- Computing totals, subtotals, and grand totals

**Why Star Schema Excels at These Operations:**
- **Denormalized Dimensions**: Each dimension table contains all relevant attributes for analysis in a single table, eliminating complex joins during aggregation.
- **Single-Table Fact Access**: All measures are in one fact table, making aggregation straightforward and efficient.
- **Bitmap Index Efficiency**: Foreign key joins are optimized through star schema-specific query execution plans.
- **Pre-computed Hierarchies**: Dimension attributes encode hierarchies (month belongs to quarter, quarter belongs to year) enabling natural hierarchical roll-up.

---

## Section 3: Sample Data Flow

### Source Transaction Example

**Original Source System Transaction:**

| Order # | Customer | Product | Quantity | Unit Price | Discount |
|---------|----------|---------|----------|------------|----------|
| 101 | John Doe | Laptop | 2 | ₹50,000 | ₹0 |

**Date of Transaction:** January 15, 2024

---

### Data Flow to Data Warehouse

#### Step 1: Dimension Lookup/Insertion

**dim_date - Date Dimension Record:**
```json
{
  "date_key": 20240115,
  "full_date": "2024-01-15",
  "day_of_week": "Monday",
  "day_of_month": 15,
  "month": 1,
  "month_name": "January",
  "quarter": "Q1",
  "year": 2024,
  "is_weekend": false
}
```

**dim_product - Product Dimension Record:**
```json
{
  "product_key": 5,
  "product_id": "ELEC-001",
  "product_name": "Laptop Pro 15",
  "category": "Electronics",
  "subcategory": "Computers",
  "unit_price": 50000.00
}
```

**dim_customer - Customer Dimension Record:**
```json
{
  "customer_key": 12,
  "customer_id": "CUST-012",
  "customer_name": "John Doe",
  "city": "Mumbai",
  "state": "Maharashtra",
  "customer_segment": "Retail"
}
```

#### Step 2: Fact Table Record Creation

**fact_sales - Sales Fact Record:**
```json
{
  "sale_key": 1001,
  "date_key": 20240115,
  "product_key": 5,
  "customer_key": 12,
  "quantity_sold": 2,
  "unit_price": 50000.00,
  "discount_amount": 0.00,
  "total_amount": 100000.00
}
```

---

### ETL Process Summary

1. **Extract**: The source transaction is extracted from the operational orders table (orders + order_items joined)

2. **Transform**:
   - Lookup or insert corresponding dimension records
   - Get/assign surrogate keys (date_key, product_key, customer_key)
   - Calculate derived measures (total_amount = quantity × unit_price - discount)

3. **Load**: Insert the fact record with all foreign keys and measures

---

### Analytical Queries This Record Enables

After loading, this single transaction row enables numerous analytical queries:

| Query Type | Example |
|------------|---------|
| **Time Analysis** | Total sales on January 15, 2024 |
| **Product Analysis** | Revenue from Laptop Pro 15 |
| **Customer Analysis** | Total purchases by John Doe |
| **Cross-dimensional** | Sales by category per month |
| **Trend Analysis** | Daily/Monthly/Quarterly sales trends |

