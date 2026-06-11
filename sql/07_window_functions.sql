-- customer spending rank 
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.order_value) AS total_spent,
    RANK() OVER(
        ORDER BY SUM(o.order_value) DESC
    ) AS spending_rank
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;
    
-- dense rank 
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.order_value) AS total_spent,
    DENSE_RANK() OVER(
        ORDER BY SUM(o.order_value) DESC
    ) AS dense_rank_position
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;
    
-- row number
SELECT
    customer_id,
    order_id,
    order_value,
    ROW_NUMBER() OVER(
        ORDER BY order_value DESC
    ) AS row_num
FROM orders;

-- top customer per state 
SELECT *
FROM
(
    SELECT
        c.state,
        c.customer_name,
        SUM(o.order_value) AS total_spent,
        ROW_NUMBER() OVER(
            PARTITION BY c.state
            ORDER BY SUM(o.order_value) DESC
        ) AS rn
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY
        c.state,
        c.customer_name
) ranked_customers
WHERE rn = 1;

-- monthly revenue trend 
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(order_value) AS monthly_revenue,
    LAG(SUM(order_value))
    OVER(
        ORDER BY
        YEAR(order_date),
        MONTH(order_date)
    ) AS previous_month_revenue
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date);
    
-- revenue difference 
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(order_value) AS monthly_revenue,

    SUM(order_value)
    -
    LAG(SUM(order_value))
    OVER(
        ORDER BY
        YEAR(order_date),
        MONTH(order_date)
    ) AS revenue_difference
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date);
    
-- next month revenue 
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(order_value) AS monthly_revenue,

    LEAD(SUM(order_value))
    OVER(
        ORDER BY
        YEAR(order_date),
        MONTH(order_date)
    ) AS next_month_revenue
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date);
    
-- warehouse shipment rank 
SELECT
    warehouse_id,
    COUNT(*) AS shipment_count,

    RANK() OVER(
        ORDER BY COUNT(*) DESC
    ) AS warehouse_rank
FROM shipments
GROUP BY warehouse_id;

-- driver shipment rank 
SELECT
    driver_id,
    COUNT(*) AS shipment_count,

    DENSE_RANK() OVER(
        ORDER BY COUNT(*) DESC
    ) AS driver_rank
FROM shipments
GROUP BY driver_id;

-- most expensive shipments 
SELECT
    shipment_id,
    shipping_cost,

    ROW_NUMBER() OVER(
        ORDER BY shipping_cost DESC
    ) AS cost_rank
FROM shipments;

-- running revenue 
SELECT
    order_date,
    order_value,

    SUM(order_value)
    OVER(
        ORDER BY order_date
    ) AS cumulative_revenue
FROM orders;

-- moving average 
SELECT
    order_date,
    order_value,

    AVG(order_value)
    OVER(
        ORDER BY order_date
        ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM orders;