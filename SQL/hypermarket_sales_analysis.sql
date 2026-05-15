USE case_study
GO

-- View Tables
SELECT * FROM customer;
SELECT * FROM Data_Dictionary;
SELECT * FROM product;
SELECT * FROM transactions;

------------------------------------------------------------
-- 1. Total Sales Amount by Merchant Location
------------------------------------------------------------

SELECT 
    p.merchant_location,
    SUM(t.sale_amount) AS total_sales
FROM transactions AS t
JOIN (
    SELECT DISTINCT merchant_id, merchant_location
    FROM product
) AS p
ON t.merchant_id = p.merchant_id
GROUP BY p.merchant_location;

------------------------------------------------------------
-- 2. Total Customers Between July 2012 and December 2012
------------------------------------------------------------

SELECT 
    COUNT(DISTINCT user_id) AS total_customers
FROM transactions
WHERE order_time BETWEEN '2012-07-01' AND '2012-12-31';

------------------------------------------------------------
-- 3. Average Transaction Value by Top 10 Customers
------------------------------------------------------------

SELECT TOP 10
    customer_id,
    customer_total_value,
    customer_total_value / total_orders AS average_transaction_value
FROM customer
ORDER BY customer_total_value DESC;

------------------------------------------------------------
-- 4. Third and Fourth Top Product Categories by Sales
------------------------------------------------------------

WITH sales_cte AS (
    SELECT 
        p.sub_category_name,
        SUM(t.sale_amount) AS total_sales
    FROM transactions AS t
    JOIN (
        SELECT DISTINCT merchant_id, sub_category_name
        FROM product
    ) AS p
    ON t.merchant_id = p.merchant_id
    GROUP BY p.sub_category_name
)

SELECT
    sub_category_name,
    total_sales,
    DENSE_RANK() OVER (ORDER BY total_sales DESC) AS sales_rank,
    (total_sales * 100.0 / SUM(total_sales) OVER()) AS percentage_contribution
FROM sales_cte;

------------------------------------------------------------
-- 5. Merchant Location with Highest Discount Percentage
------------------------------------------------------------

SELECT
    p.merchant_location,
    
    SUM((p.avg_price * t.quantity) - t.sale_amount) AS total_discount,

    (
        SUM((p.avg_price * t.quantity) - t.sale_amount)
        / NULLIF(SUM(p.avg_price * t.quantity), 0)
    ) * 100 AS discount_percentage

FROM transactions AS t

JOIN (
    SELECT 
        merchant_id,
        merchant_location,
        AVG(cost_price) AS avg_price
    FROM product
    GROUP BY merchant_id, merchant_location
) AS p

ON t.merchant_id = p.merchant_id

GROUP BY p.merchant_location

ORDER BY discount_percentage DESC;