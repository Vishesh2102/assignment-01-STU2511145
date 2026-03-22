USE assignment_02_stu2511145;
-- Q1: List all customers from Mumbai along with their total order value
SELECT 
    c.customer_name, 
    SUM(p.unit_price * od.quantity) AS total_order_value
FROM tbl_customers c
JOIN tbl_orders o ON c.customer_id = o.customer_id
JOIN tbl_order_details od ON o.order_id = od.order_id
JOIN tbl_products p ON od.product_id = p.product_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_id, c.customer_name;

-- Q2: Find the top 3 products by total quantity sold
SELECT 
    p.product_name, 
    SUM(od.quantity) AS total_sold
FROM tbl_products p
JOIN tbl_order_details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 3;

-- Q3: List all sales representatives and the number of unique customers they have handled
SELECT 
    s.sales_rep_name, 
    COUNT(DISTINCT o.customer_id) AS unique_customers_handled
FROM tbl_sales_reps s
LEFT JOIN tbl_orders o ON s.sales_rep_id = o.sales_rep_id
GROUP BY s.sales_rep_id, s.sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
SELECT 
    o.order_id, 
    SUM(p.unit_price * od.quantity) AS order_total
FROM tbl_orders o
JOIN tbl_order_details od ON o.order_id = od.order_id
JOIN tbl_products p ON od.product_id = p.product_id
GROUP BY o.order_id
HAVING order_total > 10000
ORDER BY order_total DESC;

-- Q5: Identify any products that have never been ordered
SELECT 
    p.product_id, 
    p.product_name
FROM tbl_products p
LEFT JOIN tbl_order_details od ON p.product_id = od.product_id
WHERE od.order_id IS NULL;