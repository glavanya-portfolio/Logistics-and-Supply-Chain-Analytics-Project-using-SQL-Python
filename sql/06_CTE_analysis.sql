-- top spending customers
WITH customer_spending AS
(
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(o.order_value) AS total_spent
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.customer_name
)

SELECT *
FROM customer_spending
ORDER BY total_spent DESC
LIMIT 10;

-- high revenue warehouse
WITH warehouse_revenue AS
(
    SELECT
        w.warehouse_name,
        SUM(s.shipping_cost) AS total_revenue
    FROM warehouses w
    JOIN shipments s
    ON w.warehouse_id = s.warehouse_id
    GROUP BY w.warehouse_name
)

SELECT *
FROM warehouse_revenue
ORDER BY total_revenue DESC;

-- driver perfomance 
WITH driver_performance AS
(
    SELECT
        driver_id,
        COUNT(*) AS total_shipments
    FROM shipments
    GROUP BY driver_id
)

SELECT *
FROM driver_performance
ORDER BY total_shipments DESC;

-- delayed shipment analysis
WITH delayed_shipments AS
(
    SELECT *
    FROM shipments
    WHERE status = 'Delayed'
)

SELECT
    COUNT(*) AS delayed_count,
    ROUND(AVG(shipping_cost),2) AS avg_delay_cost
FROM delayed_shipments;

-- category revenue
WITH category_revenue AS
(
    SELECT
        product_category,
        SUM(order_value) AS revenue
    FROM orders
    GROUP BY product_category
)

SELECT *
FROM category_revenue
ORDER BY revenue DESC;

-- route shipment volume
WITH route_volume AS
(
    SELECT
        route_id,
        COUNT(*) AS shipment_count
    FROM shipments
    GROUP BY route_id
)

SELECT *
FROM route_volume
ORDER BY shipment_count DESC;

-- average shipment cost by delivery type
WITH delivery_summary AS
(
    SELECT
        delivery_type,
        AVG(shipping_cost) AS avg_cost
    FROM shipments
    GROUP BY delivery_type
)

SELECT *
FROM delivery_summary;

-- customers above average spending 
WITH customer_spending AS
(
    SELECT
        customer_id,
        SUM(order_value) AS total_spent
    FROM orders
    GROUP BY customer_id
)

SELECT *
FROM customer_spending
WHERE total_spent >
(
    SELECT AVG(total_spent)
    FROM customer_spending
);

-- warehouse shipment ranking 
WITH warehouse_shipments AS
(
    SELECT
        warehouse_id,
        COUNT(*) AS shipment_count
    FROM shipments
    GROUP BY warehouse_id
)

SELECT *
FROM warehouse_shipments
ORDER BY shipment_count DESC;

-- monthly orders
WITH monthly_orders AS
(
    SELECT
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS order_month,
        COUNT(*) AS total_orders
    FROM orders
    GROUP BY
        YEAR(order_date),
        MONTH(order_date)
)

SELECT *
FROM monthly_orders
ORDER BY
    order_year,
    order_month;