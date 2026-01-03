-- ============================================================================
-- FlexiMart Data Warehouse - Sample Data
-- Database: fleximart_dw
-- ============================================================================

-- ============================================================================
-- DIMENSION: dim_date (30 dates: January-February 2024)
-- Includes both weekdays and weekends for realistic patterns
-- ============================================================================

INSERT INTO dim_date (date_key, full_date, day_of_week, day_of_month, month, month_name, quarter, year, is_weekend) VALUES
-- January 2024 (16 weekdays, 7 weekend days)
(20240101, '2024-01-01', 'Monday', 1, 1, 'January', 'Q1', 2024, true),
(20240102, '2024-01-02', 'Tuesday', 2, 1, 'January', 'Q1', 2024, false),
(20240103, '2024-01-03', 'Wednesday', 3, 1, 'January', 'Q1', 2024, false),
(20240104, '2024-01-04', 'Thursday', 4, 1, 'January', 'Q1', 2024, false),
(20240105, '2024-01-05', 'Friday', 5, 1, 'January', 'Q1', 2024, false),
(20240106, '2024-01-06', 'Saturday', 6, 1, 'January', 'Q1', 2024, true),
(20240107, '2024-01-07', 'Sunday', 7, 1, 'January', 'Q1', 2024, true),
(20240108, '2024-01-08', 'Monday', 8, 1, 'January', 'Q1', 2024, false),
(20240109, '2024-01-09', 'Tuesday', 9, 1, 'January', 'Q1', 2024, false),
(20240110, '2024-01-10', 'Wednesday', 10, 1, 'January', 'Q1', 2024, false),
(20240111, '2024-01-11', 'Thursday', 11, 1, 'January', 'Q1', 2024, false),
(20240112, '2024-01-12', 'Friday', 12, 1, 'January', 'Q1', 2024, false),
(20240113, '2024-01-13', 'Saturday', 13, 1, 'January', 'Q1', 2024, true),
(20240114, '2024-01-14', 'Sunday', 14, 1, 'January', 'Q1', 2024, true),
(20240115, '2024-01-15', 'Monday', 15, 1, 'January', 'Q1', 2024, false),
(20240116, '2024-01-16', 'Tuesday', 16, 1, 'January', 'Q1', 2024, false),
(20240117, '2024-01-17', 'Wednesday', 17, 1, 'January', 'Q1', 2024, false),
(20240118, '2024-01-18', 'Thursday', 18, 1, 'January', 'Q1', 2024, false),
(20240119, '2024-01-19', 'Friday', 19, 1, 'January', 'Q1', 2024, false),
(20240120, '2024-01-20', 'Saturday', 20, 1, 'January', 'Q1', 2024, true),
(20240121, '2024-01-21', 'Sunday', 21, 1, 'January', 'Q1', 2024, true),
(20240122, '2024-01-22', 'Monday', 22, 1, 'January', 'Q1', 2024, false),
(20240123, '2024-01-23', 'Tuesday', 23, 1, 'January', 'Q1', 2024, false),
(20240124, '2024-01-24', 'Wednesday', 24, 1, 'January', 'Q1', 2024, false),
(20240125, '2024-01-25', 'Thursday', 25, 1, 'January', 'Q1', 2024, false),
(20240126, '2024-01-26', 'Friday', 26, 1, 'January', 'Q1', 2024, false),
(20240127, '2024-01-27', 'Saturday', 27, 1, 'January', 'Q1', 2024, true),
(20240128, '2024-01-28', 'Sunday', 28, 1, 'January', 'Q1', 2024, true),
(20240129, '2024-01-29', 'Monday', 29, 1, 'January', 'Q1', 2024, false),
(20240130, '2024-01-30', 'Tuesday', 30, 1, 'January', 'Q1', 2024, false),
(20240131, '2024-01-31', 'Wednesday', 31, 1, 'January', 'Q1', 2024, false),
-- February 2024 (21 weekdays, 8 weekend days, leap year)
(20240201, '2024-02-01', 'Thursday', 1, 2, 'February', 'Q1', 2024, false),
(20240202, '2024-02-02', 'Friday', 2, 2, 'February', 'Q1', 2024, false),
(20240203, '2024-02-03', 'Saturday', 3, 2, 'February', 'Q1', 2024, true),
(20240204, '2024-02-04', 'Sunday', 4, 2, 'February', 'Q1', 2024, true),
(20240205, '2024-02-05', 'Monday', 5, 2, 'February', 'Q1', 2024, false),
(20240206, '2024-02-06', 'Tuesday', 6, 2, 'February', 'Q1', 2024, false),
(20240207, '2024-02-07', 'Wednesday', 7, 2, 'February', 'Q1', 2024, false),
(20240208, '2024-02-08', 'Thursday', 8, 2, 'February', 'Q1', 2024, false),
(20240209, '2024-02-09', 'Friday', 9, 2, 'February', 'Q1', 2024, false),
(20240210, '2024-02-10', 'Saturday', 10, 2, 'February', 'Q1', 2024, true),
(20240211, '2024-02-11', 'Sunday', 11, 2, 'February', 'Q1', 2024, true),
(20240212, '2024-02-12', 'Monday', 12, 2, 'February', 'Q1', 2024, false),
(20240213, '2024-02-13', 'Tuesday', 13, 2, 'February', 'Q1', 2024, false),
(20240214, '2024-02-14', 'Wednesday', 14, 2, 'February', 'Q1', 2024, false),
(20240215, '2024-02-15', 'Thursday', 15, 2, 'February', 'Q1', 2024, false),
(20240216, '2024-02-16', 'Friday', 16, 2, 'February', 'Q1', 2024, false),
(20240217, '2024-02-17', 'Saturday', 17, 2, 'February', 'Q1', 2024, true),
(20240218, '2024-02-18', 'Sunday', 18, 2, 'February', 'Q1', 2024, true),
(20240219, '2024-02-19', 'Monday', 19, 2, 'February', 'Q1', 2024, false),
(20240220, '2024-02-20', 'Tuesday', 20, 2, 'February', 'Q1', 2024, false),
(20240221, '2024-02-21', 'Wednesday', 21, 2, 'February', 'Q1', 2024, false),
(20240222, '2024-02-22', 'Thursday', 22, 2, 'February', 'Q1', 2024, false),
(20240223, '2024-02-23', 'Friday', 23, 2, 'February', 'Q1', 2024, false),
(20240224, '2024-02-24', 'Saturday', 24, 2, 'February', 'Q1', 2024, true),
(20240225, '2024-02-25', 'Sunday', 25, 2, 'February', 'Q1', 2024, true),
(20240226, '2024-02-26', 'Monday', 26, 2, 'February', 'Q1', 2024, false),
(20240227, '2024-02-27', 'Tuesday', 27, 2, 'February', 'Q1', 2024, false),
(20240228, '2024-02-28', 'Wednesday', 28, 2, 'February', 'Q1', 2024, false),
(20240229, '2024-02-29', 'Thursday', 29, 2, 'February', 'Q1', 2024, false);

-- ============================================================================
-- DIMENSION: dim_product (15 products across 3 categories)
-- Categories: Electronics (5), Fashion (5), Home & Kitchen (5)
-- Prices range from ₹150 to ₹1,50,000
-- ============================================================================

INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
-- Electronics (5 products)
('ELEC001', 'Smartphone Pro Max 256GB', 'Electronics', 'Mobile Phones', 89999.00),
('ELEC002', 'Laptop Ultra 15"', 'Electronics', 'Laptops', 125000.00),
('ELEC003', 'Wireless Earbuds Pro', 'Electronics', 'Audio', 2499.00),
('ELEC004', 'Smart Watch Series 5', 'Electronics', 'Wearables', 15999.00),
('ELEC005', 'Tablet Air 11-inch', 'Electronics', 'Tablets', 45000.00),
-- Fashion (5 products)
('FASH001', 'Premium Cotton Shirt', 'Fashion', 'Men Clothing', 2499.00),
('FASH002', 'Designer Denim Jeans', 'Fashion', 'Men Clothing', 3999.00),
('FASH003', 'Women Floral Dress', 'Fashion', 'Women Clothing', 4999.00),
('FASH004', 'Running Shoes Ultra', 'Fashion', 'Footwear', 5999.00),
('FASH005', 'Leather Handbag Classic', 'Fashion', 'Accessories', 8500.00),
-- Home & Kitchen (5 products)
('HOME001', 'Air Purifier HEPA', 'Home & Kitchen', 'Home Appliances', 12500.00),
('HOME002', 'Robot Vacuum Cleaner', 'Home & Kitchen', 'Home Appliances', 28500.00),
('HOME003', 'Instant Pot 6L', 'Home & Kitchen', 'Kitchen Appliances', 7500.00),
('HOME004', 'Air Fryer XXL 5L', 'Home & Kitchen', 'Kitchen Appliances', 8500.00),
('HOME005', 'Robot Coffee Maker', 'Home & Kitchen', 'Kitchen Appliances', 15000.00);

-- ============================================================================
-- DIMENSION: dim_customer (12 customers across 4 cities)
-- Cities: Mumbai, Delhi, Bangalore, Chennai
-- Segments: Retail, Corporate, Premium
-- ============================================================================

INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('CUST001', 'Rahul Sharma', 'Mumbai', 'Maharashtra', 'Premium'),
('CUST002', 'Priya Patel', 'Mumbai', 'Maharashtra', 'Retail'),
('CUST003', 'Amit Kumar', 'Delhi', 'Delhi', 'Corporate'),
('CUST004', 'Sneha Reddy', 'Bangalore', 'Karnataka', 'Premium'),
('CUST005', 'Vikram Singh', 'Delhi', 'Delhi', 'Retail'),
('CUST006', 'Ananya Gupta', 'Chennai', 'Tamil Nadu', 'Premium'),
('CUST007', 'Rohan Mehta', 'Mumbai', 'Maharashtra', 'Corporate'),
('CUST008', 'Kavitha Nair', 'Bangalore', 'Karnataka', 'Retail'),
('CUST009', 'Arjun Pillai', 'Chennai', 'Tamil Nadu', 'Corporate'),
('CUST010', 'Neha Joshi', 'Delhi', 'Delhi', 'Premium'),
('CUST011', 'Suresh Babu', 'Bangalore', 'Karnataka', 'Corporate'),
('CUST012', 'Meera Das', 'Mumbai', 'Maharashtra', 'Retail');

-- ============================================================================
-- FACT: fact_sales (40 sales transactions)
-- Realistic patterns: higher sales on weekends, varied quantities
-- Mix of products across all categories
-- ============================================================================

-- Weekend transactions (Saturdays and Sundays have more transactions)
-- January 6-7, 13-14, 20-21, 27-28 (4 weekend pairs in January)
-- February 3-4, 10-11, 17-18, 24-25 (4 weekend pairs in February)

-- January 2024 Transactions

-- Week 1 (Jan 1-7)
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240101, 1, 1, 1, 89999.00, 0.00, 89999.00),      -- Mon: Smartphone
(20240101, 3, 2, 2, 2499.00, 0.00, 4998.00),        -- Mon: Earbuds
(20240102, 2, 3, 1, 125000.00, 5000.00, 120000.00), -- Tue: Laptop
(20240102, 4, 4, 1, 15999.00, 0.00, 15999.00),      -- Tue: Smart Watch
(20240103, 5, 5, 2, 45000.00, 5000.00, 85000.00),   -- Wed: Tablets
(20240104, 6, 6, 3, 2499.00, 500.00, 6997.00),      -- Thu: Shirts
(20240105, 7, 7, 2, 3999.00, 0.00, 7998.00),        -- Fri: Jeans
(20240105, 10, 8, 1, 8500.00, 500.00, 8000.00),     -- Fri: Handbag
(20240106, 8, 9, 2, 5999.00, 1000.00, 10998.00),    -- Sat: Shoes
(20240106, 1, 10, 1, 89999.00, 2000.00, 87999.00),  -- Sat: Smartphone
(20240107, 2, 11, 1, 125000.00, 5000.00, 120000.00),-- Sun: Laptop
(20240107, 3, 12, 4, 2499.00, 0.00, 9996.00);       -- Sun: Earbuds

-- Week 2 (Jan 8-14)
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240108, 11, 1, 1, 12500.00, 0.00, 12500.00),     -- Mon: Air Purifier
(20240109, 12, 2, 1, 28500.00, 1500.00, 27000.00),  -- Tue: Vacuum
(20240110, 13, 3, 2, 7500.00, 0.00, 15000.00),      -- Wed: Instant Pot
(20240110, 9, 4, 2, 5999.00, 0.00, 11998.00),       -- Wed: Shoes
(20240111, 14, 5, 1, 8500.00, 500.00, 8000.00),     -- Thu: Air Fryer
(20240112, 15, 6, 1, 15000.00, 1000.00, 14000.00),  -- Fri: Coffee Maker
(20240112, 5, 7, 1, 45000.00, 2500.00, 42500.00),   -- Fri: Tablet
(20240113, 1, 8, 2, 89999.00, 5000.00, 174998.00),  -- Sat: Smartphones
(20240113, 8, 9, 1, 5999.00, 0.00, 5999.00),        -- Sat: Shoes
(20240114, 2, 10, 1, 125000.00, 10000.00, 115000.00),-- Sun: Laptop
(20240114, 7, 11, 3, 3999.00, 500.00, 11497.00);    -- Sun: Jeans

-- Week 3 (Jan 15-21)
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240115, 3, 12, 2, 2499.00, 0.00, 4998.00),       -- Mon: Earbuds
(20240116, 4, 1, 2, 15999.00, 1500.00, 30498.00),   -- Tue: Smart Watch
(20240117, 6, 2, 4, 2499.00, 1000.00, 8996.00),     -- Wed: Shirts
(20240117, 10, 3, 1, 8500.00, 0.00, 8500.00),       -- Wed: Handbag
(20240118, 11, 4, 1, 12500.00, 500.00, 12000.00),   -- Thu: Air Purifier
(20240119, 12, 5, 1, 28500.00, 2000.00, 26500.00),  -- Fri: Vacuum
(20240119, 13, 6, 2, 7500.00, 0.00, 15000.00),      -- Fri: Instant Pot
(20240120, 14, 7, 2, 8500.00, 1000.00, 16000.00),   -- Sat: Air Fryer
(20240120, 15, 8, 1, 15000.00, 0.00, 15000.00),     -- Sat: Coffee Maker
(20240121, 1, 9, 1, 89999.00, 3000.00, 86999.00),   -- Sun: Smartphone
(20240121, 5, 10, 1, 45000.00, 2000.00, 43000.00);  -- Sun: Tablet

-- Week 4 (Jan 22-28)
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240122, 2, 11, 1, 125000.00, 8000.00, 117000.00),-- Mon: Laptop
(20240123, 9, 12, 3, 5999.00, 500.00, 17497.00),    -- Tue: Shoes
(20240124, 7, 1, 2, 3999.00, 0.00, 7998.00),        -- Wed: Jeans
(20240125, 8, 2, 2, 5999.00, 500.00, 11498.00),     -- Thu: Shoes
(20240126, 3, 3, 3, 2499.00, 0.00, 7497.00),        -- Fri: Earbuds
(20240126, 10, 4, 1, 8500.00, 500.00, 8000.00),     -- Fri: Handbag
(20240127, 11, 5, 1, 12500.00, 0.00, 12500.00),     -- Sat: Air Purifier
(20240127, 12, 6, 1, 28500.00, 1500.00, 27000.00),  -- Sat: Vacuum
(20240128, 13, 7, 2, 7500.00, 500.00, 14500.00),    -- Sun: Instant Pot
(20240128, 14, 8, 1, 8500.00, 0.00, 8500.00);       -- Sun: Air Fryer

-- February 2024 Transactions (continuing realistic patterns)

-- Week 1 (Feb 1-7)
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240201, 15, 9, 1, 15000.00, 1000.00, 14000.00),  -- Thu: Coffee Maker
(20240201, 1, 10, 1, 89999.00, 0.00, 89999.00),     -- Thu: Smartphone
(20240202, 2, 11, 1, 125000.00, 10000.00, 115000.00),-- Fri: Laptop
(20240202, 4, 12, 2, 15999.00, 2000.00, 29998.00),  -- Fri: Smart Watch
(20240203, 5, 1, 1, 45000.00, 2500.00, 42500.00),   -- Sat: Tablet
(20240203, 6, 2, 5, 2499.00, 1000.00, 11495.00),    -- Sat: Shirts
(20240204, 7, 3, 2, 3999.00, 0.00, 7998.00),        -- Sun: Jeans
(20240204, 8, 4, 2, 5999.00, 500.00, 11498.00),     -- Sun: Shoes
(20240205, 9, 5, 1, 5999.00, 0.00, 5999.00),        -- Mon: Shoes
(20240205, 10, 6, 1, 8500.00, 500.00, 8000.00),     -- Mon: Handbag
(20240206, 11, 7, 1, 12500.00, 0.00, 12500.00),     -- Tue: Air Purifier
(20240207, 12, 8, 1, 28500.00, 2000.00, 26500.00);  -- Wed: Vacuum

-- Week 2 (Feb 8-14)
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240208, 13, 9, 2, 7500.00, 500.00, 14500.00),    -- Thu: Instant Pot
(20240209, 14, 10, 1, 8500.00, 0.00, 8500.00),      -- Fri: Air Fryer
(20240209, 15, 11, 1, 15000.00, 1000.00, 14000.00), -- Fri: Coffee Maker
(20240210, 1, 12, 2, 89999.00, 8000.00, 171998.00), -- Sat: Smartphones
(20240210, 3, 1, 4, 2499.00, 0.00, 9996.00),        -- Sat: Earbuds
(20240211, 2, 2, 1, 125000.00, 5000.00, 120000.00), -- Sun: Laptop
(20240211, 5, 3, 2, 45000.00, 3000.00, 87000.00),   -- Sun: Tablets
(20240212, 4, 4, 2, 15999.00, 1000.00, 30998.00),   -- Mon: Smart Watch
(20240213, 6, 5, 3, 2499.00, 500.00, 6997.00),      -- Tue: Shirts
(20240214, 7, 6, 2, 3999.00, 0.00, 7998.00),        -- Wed: Jeans
(20240214, 10, 7, 1, 8500.00, 500.00, 8000.00),     -- Wed: Handbag
(20240214, 8, 8, 2, 5999.00, 500.00, 11498.00);     -- Wed: Shoes (Valentine's Day boost)

-- Week 3 (Feb 15-21)
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240215, 9, 9, 2, 5999.00, 0.00, 11998.00),       -- Thu: Shoes
(20240216, 11, 10, 1, 12500.00, 500.00, 12000.00),  -- Fri: Air Purifier
(20240216, 12, 11, 1, 28500.00, 1500.00, 27000.00), -- Fri: Vacuum
(20240217, 13, 12, 2, 7500.00, 0.00, 15000.00),     -- Sat: Instant Pot
(20240217, 14, 1, 1, 8500.00, 500.00, 8000.00),     -- Sat: Air Fryer
(20240218, 15, 2, 1, 15000.00, 0.00, 15000.00),     -- Sun: Coffee Maker
(20240218, 1, 3, 1, 89999.00, 2000.00, 87999.00),   -- Sun: Smartphone
(20240219, 2, 4, 1, 125000.00, 8000.00, 117000.00), -- Mon: Laptop
(20240220, 3, 5, 3, 2499.00, 0.00, 7497.00),        -- Tue: Earbuds
(20240221, 4, 6, 1, 15999.00, 0.00, 15999.00),      -- Wed: Smart Watch
(20240221, 5, 7, 1, 45000.00, 2000.00, 43000.00);   -- Wed: Tablet

-- Week 4 (Feb 22-29)
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240222, 6, 8, 4, 2499.00, 1000.00, 8996.00),     -- Thu: Shirts
(20240223, 7, 9, 2, 3999.00, 0.00, 7998.00),        -- Fri: Jeans
(20240223, 8, 10, 1, 5999.00, 0.00, 5999.00),       -- Fri: Shoes
(20240224, 9, 11, 3, 5999.00, 1000.00, 16997.00),   -- Sat: Shoes
(20240224, 10, 12, 1, 8500.00, 500.00, 8000.00),    -- Sat: Handbag
(20240225, 11, 1, 1, 12500.00, 0.00, 12500.00),     -- Sun: Air Purifier
(20240225, 12, 2, 1, 28500.00, 2000.00, 26500.00),  -- Sun: Vacuum
(20240226, 13, 3, 2, 7500.00, 500.00, 14500.00),    -- Mon: Instant Pot
(20240227, 14, 4, 1, 8500.00, 0.00, 8500.00),       -- Tue: Air Fryer
(20240228, 15, 5, 1, 15000.00, 1000.00, 14000.00),  -- Wed: Coffee Maker
(20240229, 1, 6, 2, 89999.00, 5000.00, 174998.00),  -- Thu: Smartphones
(20240229, 2, 7, 1, 125000.00, 5000.00, 120000.00); -- Thu: Laptop

