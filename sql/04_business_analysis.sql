-- Total Shipping Revenue

SELECT
ROUND(SUM(shipping_cost),2) AS total_shipping_revenue
FROM shipments;

-- TOTAL ORDERS
SELECT
COUNT(*) AS total_orders
FROM orders;

-- TOTAL CUSTOMERS
SELECT
COUNT(*) AS total_customers
FROM customers;

-- AVERAGE ORDER VALUE 
SELECT
ROUND(AVG(order_value),2) AS avg_order_value
FROM orders;

-- TOP 10 CUSTOMERS BY ORDER VALUE 
SELECT
c.customer_id,
c.customer_name,
ROUND(SUM(o.order_value),2) AS total_order_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.customer_name
ORDER BY total_order_value DESC
LIMIT 10;

-- ORDER BY PRODUCT CATEGORY 
SELECT
product_category,
COUNT(*) AS total_orders
FROM orders
GROUP BY product_category
ORDER BY total_orders DESC;

-- REVENUE BY PAYMENT MODE
SELECT
payment_mode,
ROUND(SUM(order_value),2) AS revenue
FROM orders
GROUP BY payment_mode
ORDER BY revenue DESC;

-- SHIPMENT STATUS DISTRIBUTION 
SELECT
status,
COUNT(*) AS shipment_count
FROM shipments
GROUP BY status
ORDER BY shipment_count DESC;

-- DELIVERY TYPE ANALYSIS
SELECT
delivery_type,
COUNT(*) AS shipment_count
FROM shipments
GROUP BY delivery_type;

-- TOP ROUTES BY SHIPMENT COUNT 
DESC routes;

SELECT
r.route_id,
r.source_city,
r.destination_city,
COUNT(*) AS total_shipments
FROM routes r
JOIN shipments s
ON r.route_id = s.route_id
GROUP BY
r.route_id,
r.source_city,
r.destination_city
ORDER BY total_shipments DESC
LIMIT 10;

-- Top Warehouses by Shipment Volume
SELECT
w.warehouse_name,
COUNT(*) AS total_shipments
FROM warehouses w
JOIN shipments s
ON w.warehouse_id = s.warehouse_id
GROUP BY w.warehouse_name
ORDER BY total_shipments DESC;

-- MOST EXPENSIVE SHIPMENTS
SELECT
shipment_id,
shipping_cost
FROM shipments
ORDER BY shipping_cost DESC
LIMIT 10;

-- Average Shipping Cost by Delivery Type
SELECT
delivery_type,
ROUND(AVG(shipping_cost),2) AS avg_shipping_cost
FROM shipments
GROUP BY delivery_type;

-- DRIVER PERFOMANCE
SELECT
driver_id,
COUNT(*) AS total_shipments
FROM shipments
GROUP BY driver_id
ORDER BY total_shipments DESC
LIMIT 10;

-- vehicle utilization
SELECT
vehicle_id,
COUNT(*) AS total_shipments
FROM shipments
GROUP BY vehicle_id
ORDER BY total_shipments DESC;