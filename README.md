# FlexiMart Data Architecture Project

**Student Name:** Ramandeep Singh Katoch
**Student ID:**bitsom_ba_25071229
**Email:** ramandeepsinghkatoch17@gmail.com
**Date:** 2 jan 2026

## Project Overview

This comprehensive project demonstrates a complete data architecture implementation for FlexiMart, an e-commerce platform. The project encompasses three major components:

1. **Part 1 - Relational Database & ETL Pipeline**: Designed and implemented a normalized 3NF database schema with an automated ETL pipeline to extract data from CSV files, transform it, and load it into MySQL.
2. **Part 2 - NoSQL Database Analysis**: Implemented MongoDB for product catalog management with document-based modeling and aggregation frameworks for analytics.
3. **Part 3 - Data Warehouse & Analytics**: Built a star schema data warehouse with OLAP analytics queries for business intelligence and reporting.

## Repository Structure

```
├── part1-database-etl/
│   ├── etl_pipeline.py
│   ├── schema_documentation.md
│   ├── business_queries.sql
│   └── data_quality_report.txt
│
├── part2-nosql/
│   ├── nosql_analysis.md
│   ├── mongodb_operations.js
│   └── products_catalog.json
│
├── part3-datawarehouse/
│   ├── star_schema_design.md
│   ├── warehouse_schema.sql
│   ├── warehouse_data.sql
│   └── analytics_queries.sql
│
└── README.md
```

## Technologies Used

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Database** | MySQL 8.0 | Relational database management for OLTP and data warehouse |
| **NoSQL Database** | MongoDB 6.0 | Document-based database for product catalog |
| **Programming** | Python 3.x | ETL pipeline development |
| **Libraries** | pandas, mysql-connector-python | Data processing and database connectivity |
| **Query Language** | SQL, MongoDB Query Language | Database operations and analytics |

## Part 1: Database & ETL Pipeline

### Schema Design
The operational database follows Third Normal Form (3NF) with the following entities:
- **customers**: Customer information and demographics
- **products**: Product catalog with categories and pricing
- **orders**: Order header information
- **order_items**: Line-item details for each order

### Key Files
- `schema_documentation.md`: Complete schema documentation with ER diagrams
- `etl_pipeline.py`: Python-based ETL pipeline using pandas
- `business_queries.sql`: 5 complex business queries demonstrating advanced SQL
- `data_quality_report.txt`: Data validation and quality metrics

### Setup Instructions
```bash
# Create database
mysql -u root -p -e "CREATE DATABASE fleximart;"

# Run ETL pipeline
python part1-database-etl/etl_pipeline.py

# Execute business queries
mysql -u root -p fleximart < part1-database-etl/business_queries.sql
```

## Part 2: NoSQL Database

### MongoDB Implementation
- **Document Model**: Embedded data model for products with specifications and reviews
- **Aggregation Framework**: Complex analytics pipelines for product analysis
- **Indexing Strategy**: Optimized indexes for category, price, and rating queries

### Key Files
- `nosql_analysis.md`: Comprehensive analysis of NoSQL vs SQL approaches
- `mongodb_operations.js`: MongoDB operations including CRUD and aggregations
- `products_catalog.json`: Sample product catalog with embedded reviews

### Setup Instructions
```bash
# Start MongoDB
mongod --dbpath /path/to/data

# Execute operations
mongosh < part2-nosql/mongodb_operations.js

# Import sample data
mongoimport --db fleximart --collection products --file part2-nosql/products_catalog.json --jsonArray
```

## Part 3: Data Warehouse & Analytics

### Star Schema Design
The data warehouse uses a classic star schema pattern optimized for analytical queries:

**Fact Table:**
- `fact_sales`: Sales transactions at line-item level grain
  - Measures: quantity_sold, unit_price, discount_amount, total_amount
  - Foreign Keys: date_key, product_key, customer_key

**Dimension Tables:**
- `dim_date`: Date dimension with hierarchical attributes (year, quarter, month, day)
- `dim_product`: Product dimension with category and subcategory
- `dim_customer`: Customer dimension with geographic and segment information

### Analytics Queries
1. **Monthly Sales Drill-Down Analysis**: Hierarchical aggregation from year → quarter → month
2. **Top 10 Products by Revenue**: Revenue contribution percentage with window functions
3. **Customer Segmentation**: RFM-style segmentation (High/Medium/Low value)

### Setup Instructions
```bash
# Create data warehouse database
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# Run Part 3 - Data Warehouse
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql
```

## Key Learnings

1. **Database Design Principles**: Understanding the trade-offs between normalization (3NF) for OLTP systems versus denormalization (star schema) for analytical workloads.

2. **ETL Pipeline Development**: Learned to build robust ETL pipelines with data validation, error handling, and transformation logic using Python and pandas.

3. **NoSQL Data Modeling**: Gained hands-on experience with document-based data modeling, understanding when to embed vs reference data, and leveraging MongoDB's aggregation framework.

4. **Data Warehouse Architecture**: Mastered star schema design principles, including surrogate key generation, grain selection, and dimensional modeling best practices.

5. **Analytical Querying**: Developed skills in writing complex analytical SQL queries including window functions, CTEs, hierarchical aggregations, and business intelligence reporting.

## Challenges Faced

1. **Challenge**: Maintaining referential integrity during ETL with large datasets
   - **Solution**: Implemented transaction-based loading with rollback capabilities and pre-load validation checks

2. **Challenge**: Designing appropriate granularity for the fact table
   - **Solution**: Analyzed business requirements thoroughly and selected line-item level grain for maximum analytical flexibility while balancing storage requirements

3. **Challenge**: Optimizing MongoDB aggregation pipelines for performance
   - **Solution**: Used $match stages early in pipelines to reduce document flow, created strategic indexes on filter fields, and used $facet for parallel aggregation

4. **Challenge**: Creating realistic test data that demonstrates query patterns
   - **Solution**: Designed data distributions that show realistic business patterns (weekend vs weekday sales, product category performance variations)

## Database Performance Optimization

- **Indexing Strategy**: Created composite indexes on frequently queried columns
- **Query Optimization**: Used EXPLAIN plans to analyze query performance
- **Connection Pooling**: Implemented connection pooling in Python ETL scripts
- **Batch Processing**: Processed data in batches to manage memory efficiently

## Business Intelligence Insights

The analytics queries enable:
- **Executive Dashboards**: High-level KPIs and trend analysis
- **Product Performance**: Identifying top/bottom performing products by revenue
- **Customer Segmentation**: Targeted marketing based on customer value
- **Time-Based Analysis**: Seasonality, monthly trends, and quarterly comparisons

## Conclusion

This project demonstrates end-to-end data architecture capabilities, from operational database design through ETL processing, NoSQL implementation, and finally to data warehousing with business intelligence reporting. The combination of SQL and NoSQL technologies provides a comprehensive understanding of modern data platform architectures.

