# Part 3: Data Warehouse & Analytics

## Overview

This part of the FlexiMart Data Architecture project implements a star schema data warehouse for analytical reporting and business intelligence. It includes dimension modeling, fact table design, and complex analytical queries.

## Project Structure

```
part3-datawarehouse/
├── warehouse_schema.sql    # Star schema DDL definitions
├── warehouse_data.sql      # Sample dimension and fact data
├── analytics_queries.sql   # Analytical SQL queries
├── star_schema_design.md   # Detailed design documentation
└── README.md               # This file
```

## Star Schema Design

### Fact Table: fact_sales

**Grain:** One row per product per order line item

| Column | Data Type | Description |
|--------|-----------|-------------|
| sale_key | INT | Surrogate key |
| date_key | INT | FK to dim_date |
| product_key | INT | FK to dim_product |
| customer_key | INT | FK to dim_customer |
| quantity_sold | INT | Units sold |
| unit_price | DECIMAL | Price at time of sale |
| discount_amount | DECIMAL | Discount applied |
| total_amount | DECIMAL | Final amount |

### Dimension Tables

| Table | Purpose | Key Attributes |
|-------|---------|----------------|
| dim_date | Time dimension | date_key, year, quarter, month, day_of_week |
| dim_product | Product catalog | product_key, category, subcategory, price |
| dim_customer | Customer profiles | customer_key, city, state, segment |

## Schema Diagram

```
     ┌─────────────┐
     │ dim_date    │
     ├─────────────┤
     │ date_key PK │◄────────┐
     │ year        │        │
     │ quarter     │        │
     │ month       │        │
     └─────────────┘        │
                           │
     ┌─────────────┐        │
     │ dim_product │        │
     ├─────────────┤        │
     │ product_key PK│◄───────┤
     │ category    │        │
     │ subcategory │        │
     └─────────────┘        │
                           │
     ┌─────────────┐        │
     │dim_customer │        │
     ├─────────────┤        │
     │customer_key PK│◄──────┤
     │ city        │        │
     │ state       │        │
     └─────────────┘        │
                           │
     ┌─────────────┐        │
     │ fact_sales  │        │
     ├─────────────┤        │
     │ sale_key PK │        │
     │ date_key FK─┼────────┤
     │ product_key FK┼───────┤
     │ customer_key FK┼─────┤
     │ quantity    │        │
     │ total_amount│        │
     └─────────────┘        │
```

## Analytical Queries

### Query 1: Time-Based Analysis (Drill-Down)
- Yearly Summary, Quarterly Breakdown, Monthly Trends
- Uses GROUP BY with ROLLUP for hierarchical aggregation

### Query 2: Top Products by Revenue
- Ranked list of products by revenue contribution
- Calculates revenue percentage of total

### Query 3: Customer Segmentation
- Classifies customers by value (High/Medium/Low)
- Aggregates spending by segment

### Additional Analyses
- Weekend vs Weekday Sales
- Category by Quarter
- Top Customers Ranking

## Key Design Decisions

**1. Line-Item Granularity**
- Maximum analytical flexibility
- Preserves transaction details
- Accurate revenue attribution

**2. Surrogate Keys**
- Integer keys for performance
- Isolation from source changes
- Supports SCD Type 2 tracking

**3. Dimension Attributes**
- Denormalized for simplified queries
- Hierarchical attributes enable drill-down
- Pre-computed time hierarchies

## SCD Types Implemented

| Dimension | SCD Type | Description |
|-----------|----------|-------------|
| dim_product | Type 2 | Tracks historical product changes |
| dim_customer | Type 1 | Overwrites old customer values |

## Setup & Usage

```bash
# Create database and schema
mysql -u root -p < warehouse_schema.sql

# Load sample data
mysql -u root -p < warehouse_data.sql

# Run analytical queries
mysql -u root -p < analytics_queries.sql
```

## Comparison with Previous Parts

| Aspect | Part 1 (OLTP) | Part 2 (NoSQL) | Part 3 (Data Warehouse) |
|--------|--------------|----------------|-------------------------|
| Purpose | Transactional | Product Catalog | Analytics & Reporting |
| Schema | 3NF Normalized | Flexible Documents | Star Schema Denormalized |
| Query Type | CRUD Operations | Document Queries | Aggregations & Rollups |

