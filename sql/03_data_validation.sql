SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM warehouses;
SELECT COUNT(*) FROM vehicles;
SELECT COUNT(*) FROM drivers;
SELECT COUNT(*) FROM routes;
SELECT COUNT(*) FROM shipments;

TRUNCATE TABLE shipments;

/*Row Count Validation*/

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT COUNT(*) AS total_warehouses
FROM warehouses;

SELECT COUNT(*) AS total_vehicles
FROM vehicles;

SELECT COUNT(*) AS total_drivers
FROM drivers;

SELECT COUNT(*) AS total_routes
FROM routes;

SELECT COUNT(*) AS total_shipments
FROM shipments;

-- Sample Records

SELECT *
FROM customers
LIMIT 5;

SELECT *
FROM orders
LIMIT 5;

SELECT *
FROM shipments
LIMIT 5;

-- NULL Checks

SELECT *
FROM customers
WHERE customer_id IS NULL;

SELECT *
FROM orders
WHERE order_id IS NULL;

-- duplicate validation
-- customers
SELECT customer_id,
COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- orders
SELECT order_id,
COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- shipments
SELECT shipment_id,
COUNT(*) AS duplicate_count
FROM shipments
GROUP BY shipment_id
HAVING COUNT(*) > 1;

-- Foreign Key Validation
-- orders  customers 
SELECT o.order_id
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- shipments orders
SELECT s.shipment_id
FROM shipments s
LEFT JOIN orders o
ON s.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Status Validation
SELECT status,
COUNT(*) AS total_shipments
FROM shipments
GROUP BY status;

-- Delivery Type Validation
SELECT delivery_type,
COUNT(*) AS total_shipments
FROM shipments
GROUP BY delivery_type;
