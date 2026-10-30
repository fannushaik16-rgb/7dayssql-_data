use sql7challenge;
-- Q1 total customers
SELECT COUNT(*) AS total_customers
FROM customers;
--- Q2 customers by city
SELECT 
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;
-- Q3 top 10 customers by order count
SELECT c.customer_id, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id
ORDER BY order_count DESC
LIMIT 10;
-- Q4 total spending per customer
SELECT
    c.customer_id,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id
ORDER BY total_orders DESC
LIMIT 10;
---- 	Q5 average spending for customer
SELECT
    c.customer_id,
    COUNT(o.order_id) AS total_orders
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id
ORDER BY total_orders DESC
LIMIT 10;
---- Q6 customers with more than 5 orders 
SELECT
    c.customer_id,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id
ORDER BY total_orders DESC
LIMIT 10;
---- Q7 ---customer segment analysis
SELECT
    segment,
    COUNT(*) AS total_customers
FROM customers
GROUP BY segment
ORDER BY total_customers DESC;
--- Q8 average orders per customer
SELECT 
    AVG(order_count) AS average_orders_per_customer
FROM (
    SELECT 
        c.customer_id,
        COUNT(o.order_id) AS order_count
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
        AND o.status <> 'Cancelled'
    GROUP BY c.customer_id
) AS customer_orders;
-- Q9 top 10 customers by spending
SELECT
    o.customer_id,
    SUM(oi.quantity * oi.price) AS total_spending
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status <> 'Cancelled'
GROUP BY o.customer_id
ORDER BY total_spending DESC
LIMIT 10;
-- Q10 customer signups by month
SELECT 
    DATE_FORMAT(signup_date, '%Y-%m') AS signup_month,
    COUNT(*) AS total_signups
FROM customers
GROUP BY DATE_FORMAT(signup_date, '%Y-%m')
ORDER BY signup_month ASC;