-- Query 1A: Yearly Summary (Top Level)
SELECT
    d.year,
    SUM(f.total_amount) AS total_sales,
    SUM(f.quantity_sold) AS total_quantity
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
WHERE d.year = 2024
GROUP BY d.year
ORDER BY d.year;

-- Query 1B: Quarterly Breakdown (Drill Down to Quarter)
SELECT
    d.year,
    d.quarter,
    SUM(f.total_amount) AS total_sales,
    SUM(f.quantity_sold) AS total_quantity
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
WHERE d.year = 2024
GROUP BY d.year, d.quarter
ORDER BY d.year, d.quarter;

-- Query 1C: Monthly Breakdown (Full Drill-Down)
SELECT 
    d.year,
    d.quarter,
    d.month,
    d.month_name,
    ROUND(SUM(f.total_amount), 2) AS total_sales,
    SUM(f.quantity_sold) AS total_quantity
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
WHERE d.year = 2024
GROUP BY d.year, d.quarter, d.month, d.month_name
ORDER BY d.year, d.quarter, d.month;

-- Query 1D: Complete Hierarchical Drill-Down (Single Query with ROLLUP)
SELECT
    COALESCE(d.month_name, COALESCE(d.quarter, CAST(d.year AS CHAR))) AS time_period,
    d.year,
    d.quarter,
    d.month,
    d.month_name,
    ROUND(SUM(f.total_amount), 2) AS total_sales,
    SUM(f.quantity_sold) AS total_quantity
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
WHERE d.year = 2024
GROUP BY d.year, d.quarter, d.month, d.month_name WITH ROLLUP
ORDER BY d.year, d.quarter, d.month;

-- Query 2: Top 10 Products by Revenue

SELECT
    p.product_name,
    p.category,
    SUM(f.quantity_sold) AS units_sold,
    ROUND(SUM(f.total_amount), 2) AS revenue,
    ROUND(
        (SUM(f.total_amount) / 
            (SELECT SUM(total_amount) FROM fact_sales WHERE date_key BETWEEN 20240101 AND 20240229)
        ) * 100, 2
    ) AS revenue_percentage
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_key, p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;

-- Alternative using CTE and window function for percentage
WITH product_revenue AS (
    SELECT
        p.product_name,
        p.category,
        SUM(f.quantity_sold) AS units_sold,
        ROUND(SUM(f.total_amount), 2) AS revenue,
        SUM(f.total_amount) AS raw_revenue
    FROM fact_sales f
    JOIN dim_product p ON f.product_key = p.product_key
    GROUP BY p.product_key, p.product_name, p.category
),
total_revenue AS (
    SELECT SUM(raw_revenue) AS total FROM product_revenue
)
SELECT
    product_name,
    category,
    units_sold,
    revenue,
    ROUND((raw_revenue / (SELECT total FROM total_revenue)) * 100, 2) AS revenue_percentage
FROM product_revenue
ORDER BY revenue DESC
LIMIT 10;


-- Query 3: Customer Segmentation Analysis



SELECT
    customer_segment,
    customer_count,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(avg_revenue_per_customer, 2) AS avg_revenue
FROM (
    SELECT
        CASE
            WHEN customer_total >= 50000 THEN 'High Value'
            WHEN customer_total >= 20000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment,
        COUNT(*) AS customer_count,
        SUM(customer_total) AS total_revenue,
        AVG(customer_total) AS avg_revenue_per_customer
    FROM (
        SELECT 
            c.customer_key,
            c.customer_name,
            c.customer_segment AS original_segment,
            COALESCE(SUM(f.total_amount), 0) AS customer_total
        FROM dim_customer c
        LEFT JOIN fact_sales f ON c.customer_key = f.customer_key
        GROUP BY c.customer_key, c.customer_name, c.customer_segment
    ) customer_totals
    GROUP BY
        CASE
            WHEN customer_total >= 50000 THEN 'High Value'
            WHEN customer_total >= 20000 THEN 'Medium Value'
            ELSE 'Low Value'
        END
) segments
ORDER BY avg_revenue DESC;

-- Alternative using CTE for clearer structure
WITH customer_spending AS (
    SELECT
        c.customer_key,
        c.customer_name,
        c.customer_segment,
        COALESCE(SUM(f.total_amount), 0) AS total_spent
    FROM dim_customer c
    LEFT JOIN fact_sales f ON c.customer_key = f.customer_key
    GROUP BY c.customer_key, c.customer_name, c.customer_segment
),
segmented_customers AS (
    SELECT
        customer_key,
        customer_name,
        customer_segment AS original_segment,
        total_spent,
        CASE
            WHEN total_spent > 50000 THEN 'High Value'
            WHEN total_spent >= 20000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS value_segment
    FROM customer_spending
)
SELECT
    value_segment AS customer_segment,
    COUNT(*) AS customer_count,
    ROUND(SUM(total_spent), 2) AS total_revenue,
    ROUND(AVG(total_spent), 2) AS avg_revenue
FROM segmented_customers
GROUP BY value_segment
ORDER BY avg_revenue DESC;

--
-- Additional Analysis Queries (Bonus)
--

-- Weekend vs Weekday Sales Analysis
SELECT 
    d.is_weekend,
    CASE WHEN d.is_weekend = 1 THEN 'Weekend' ELSE 'Weekday' END AS day_type,
    COUNT(*) AS transaction_count,
    ROUND(SUM(f.total_amount), 2) AS total_sales,
    ROUND(AVG(f.total_amount), 2) AS avg_order_value
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.is_weekend;

-- Sales by Category and Quarter
SELECT
    p.category,
    d.quarter,
    ROUND(SUM(f.total_amount), 2) AS total_sales,
    SUM(f.quantity_sold) AS units_sold
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_date d ON f.date_key = d.date_key
WHERE d.year = 2024
GROUP BY p.category, d.quarter
ORDER BY p.category, d.quarter;

-- Top Customers by Revenue
SELECT
    c.customer_name,
    c.city,
    c.customer_segment,
    ROUND(SUM(f.total_amount), 2) AS total_revenue,
    SUM(f.quantity_sold) AS total_items
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.customer_name, c.city, c.customer_segment
ORDER BY total_revenue DESC
LIMIT 10;

