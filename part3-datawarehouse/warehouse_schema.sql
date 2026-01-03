
-- FlexiMart Data Warehouse Schema
-- Database: fleximart_dw


-- Drop existing tables if they exist (in reverse order of dependencies)
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_customer;


-- DIMENSION: dim_date
-- Purpose: Date dimension for time-based analysis


CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day_of_week VARCHAR(10),
    day_of_month INT,
    month INT,
    month_name VARCHAR(10),
    quarter VARCHAR(2),
    year INT,
    is_weekend BOOLEAN
);

-
-- DIMENSION: dim_product
-- Purpose: Product dimension for product-related analysis


CREATE TABLE dim_product (
    product_key INT PRIMARY KEY AUTO_INCREMENT,
    product_id VARCHAR(20),
    product_name VARCHAR(100),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    unit_price DECIMAL(10,2)
);


-- DIMENSION: dim_customer
-- Purpose: Customer dimension for customer-related analysis


CREATE TABLE dim_customer (
    customer_key INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    customer_segment VARCHAR(20)
);


-- FACT: fact_sales
-- Purpose: Sales transactions at line-item level grain


CREATE TABLE fact_sales (
    sale_key INT PRIMARY KEY AUTO_INCREMENT,
    date_key INT NOT NULL,
    product_key INT NOT NULL,
    customer_key INT NOT NULL,
    quantity_sold INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key)
);


-- Indexes for Query Optimization


-- Indexes on fact table for common query patterns
CREATE INDEX idx_fact_date ON fact_sales(date_key);
CREATE INDEX idx_fact_product ON fact_sales(product_key);
CREATE INDEX idx_fact_customer ON fact_sales(customer_key);
CREATE INDEX idx_fact_total_amount ON fact_sales(total_amount);

-- Indexes on dimension tables
CREATE INDEX idx_product_category ON dim_product(category);
CREATE INDEX idx_customer_state ON dim_customer(state);
CREATE INDEX idx_customer_segment ON dim_customer(customer_segment);
CREATE INDEX idx_date_year_quarter ON dim_date(year, quarter);

