# Part 1: Database Design & ETL Pipeline

## Overview

This part of the FlexiMart Data Architecture project focuses on designing a normalized relational database schema and implementing an ETL (Extract, Transform, Load) pipeline to populate the database from raw CSV files.

## Project Structure

```
part1-database-etl/
├── Mysql.session.sql          # MySQL database schema definitions
├── etl_pipeline.py            # Python ETL pipeline script
├── requirements.txt           # Python dependencies
├── schema_documentation.md    # Detailed schema documentation
├── business_queries.sql       # Sample analytical SQL queries
├── data_quality_report.txt    # ETL data quality report
└── README.md                  # This file
```

## Database Schema

The FlexiMart database follows **Third Normal Form (3NF)** and consists of 4 tables:

### 1. customers
Stores customer information for the FlexiMart e-commerce platform.

| Attribute | Data Type | Constraints |
|-----------|-----------|-------------|
| customer_id | INT | PRIMARY KEY AUTO_INCREMENT |
| first_name | VARCHAR(50) | NOT NULL |
| last_name | VARCHAR(50) | NOT NULL |
| email | VARCHAR(100) | UNIQUE, NOT NULL |
| phone | VARCHAR(20) | NULLABLE |
| city | VARCHAR(50) | NULLABLE |
| registration_date | DATE | NULLABLE |

### 2. products
Stores product catalog information available for sale.

| Attribute | Data Type | Constraints |
|-----------|-----------|-------------|
| product_id | INT | PRIMARY KEY AUTO_INCREMENT |
| product_name | VARCHAR(100) | NOT NULL |
| category | VARCHAR(50) | NOT NULL |
| price | DECIMAL(10,2) | NOT NULL |
| stock_quantity | INT | DEFAULT 0 |

### 3. orders
Stores customer order information.

| Attribute | Data Type | Constraints |
|-----------|-----------|-------------|
| order_id | INT | PRIMARY KEY AUTO_INCREMENT |
| customer_id | INT | FOREIGN KEY REFERENCES customers |
| order_date | DATE | NOT NULL |
| total_amount | DECIMAL(10,2) | NOT NULL |
| status | VARCHAR(20) | DEFAULT 'Pending' |

### 4. order_items
Junction table for orders and products (many-to-many relationship).

| Attribute | Data Type | Constraints |
|-----------|-----------|-------------|
| order_item_id | INT | PRIMARY KEY AUTO_INCREMENT |
| order_id | INT | FOREIGN KEY REFERENCES orders |
| product_id | INT | FOREIGN KEY REFERENCES products |
| quantity | INT | NOT NULL |
| unit_price | DECIMAL(10,2) | NOT NULL |
| subtotal | DECIMAL(10,2) | NOT NULL |

## Entity Relationships

```
customers <-- 1:M --> orders <-- 1:M --> order_items <-- M:1 --> products
```

## ETL Pipeline

The ETL pipeline (etl_pipeline.py) performs the following operations:

### Extract
- Reads raw data from CSV files:
  - data/customers_raw.csv
  - data/products_raw.csv
  - data/sales_raw.csv

### Transform
- Customers: Removes duplicates, generates emails for missing values, standardizes phone numbers, cleans dates, capitalizes city names
- Products: Standardizes categories, fills missing prices with mean value, fills missing stock with 0
- Sales: Removes duplicates, drops records with missing customer/product IDs, converts date formats

### Load
- Clears existing data to avoid duplicate key errors
- Inserts cleaned customer, product, and order data into MySQL database

## Data Quality Summary

| Table | Records Processed | Issues Resolved | Records Loaded |
|-------|------------------|-----------------|----------------|
| customers | 25 | 6 | 24 |
| products | 20 | 4 | 20 |
| sales | 40 | 6 | 34 |

ETL Status: SUCCESS

## Business Queries

Three analytical queries are provided in business_queries.sql:

1. Customer Purchase History - Identifies repeat customers with high spending (>5000, 2+ orders)
2. Product Sales Analysis - Revenue breakdown by category (top performers >10000)
3. Monthly Sales Trend - Monthly order counts and cumulative revenue for 2024

## Setup & Installation

### 1. Create Virtual Environment
python3 -m venv .venv
source .venv/bin/activate

### 2. Install Dependencies
pip3 install -r requirements.txt

### 3. Setup MySQL Database
mysql -u root -p < Mysql.session.sql

### 4. Run ETL Pipeline
python3 etl_pipeline.py

### 5. Execute Business Queries
mysql -u root -p fleximart < business_queries.sql

## Dependencies

- pandas>=1.3.0 - Data manipulation and CSV processing
- mysql-connector-python>=8.0.0 - MySQL database connectivity

## Key Features

- Normalized schema in 3NF with proper foreign key relationships
- Comprehensive data cleaning (phone formatting, date parsing, deduplication)
- Error handling for various date formats and data anomalies
- Audit logging via data quality report
- Analytical business queries for insights


