-- Customer Orders
SELECT
c.customer_id,
c.customer_name,
o.order_id,
o.order_value,
o.product_category
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- customer spending analysis
SELECT
c.customer_id,
c.customer_name,
COUNT(o.order_id) AS total_orders,
ROUND(SUM(o.order_value),2) AS total_spent
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.customer_name
ORDER BY total_spent DESC;

-- shipment details with route 
SELECT
s.shipment_id,
r.source_city,
r.destination_city,
r.distance_km,
s.shipping_cost,
s.status
FROM shipments s
INNER JOIN routes r
ON s.route_id = r.route_id;

-- shipment and warehouse
SELECT
s.shipment_id,
w.warehouse_name,
w.city,
s.shipping_cost,
s.status
FROM shipments s
INNER JOIN warehouses w
ON s.warehouse_id = w.warehouse_id;

-- shipment and driver
SELECT
s.shipment_id,
d.driver_name,
d.experience_years,
s.status
FROM shipments s
INNER JOIN drivers d
ON s.driver_id = d.driver_id;

-- shipment and vehicle
SELECT
s.shipment_id,
v.vehicle_type,
v.capacity_kg,
s.shipment_weight
FROM shipments s
INNER JOIN vehicles v
ON s.vehicle_id = v.vehicle_id;

-- complete shipment tracking 
SELECT
s.shipment_id,
o.order_id,
c.customer_name,
w.warehouse_name,
d.driver_name,
v.vehicle_type,
r.source_city,
r.destination_city,
s.shipping_cost,
s.status
FROM shipments s
INNER JOIN orders o
ON s.order_id = o.order_id
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN warehouses w
ON s.warehouse_id = w.warehouse_id
INNER JOIN drivers d
ON s.driver_id = d.driver_id
INNER JOIN vehicles v
ON s.vehicle_id = v.vehicle_id
INNER JOIN routes r
ON s.route_id = r.route_id;

-- driver workload
SELECT
d.driver_name,
COUNT(s.shipment_id) AS total_shipments
FROM drivers d
INNER JOIN shipments s
ON d.driver_id = s.driver_id
GROUP BY d.driver_name
ORDER BY total_shipments DESC;

-- warehouse perfomance 
SELECT
w.warehouse_name,
COUNT(s.shipment_id) AS shipment_count,
ROUND(SUM(s.shipping_cost),2) AS revenue
FROM warehouses w
INNER JOIN shipments s
ON w.warehouse_id = s.warehouse_id
GROUP BY w.warehouse_name
ORDER BY revenue DESC;

-- vehicle utilization
SELECT
v.vehicle_type,
COUNT(s.shipment_id) AS total_shipments
FROM vehicles v
INNER JOIN shipments s
ON v.vehicle_id = s.vehicle_id
GROUP BY v.vehicle_type
ORDER BY total_shipments DESC;

-- customers without orders ( left join example)
SELECT
c.customer_id,
c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- route perfomance 
SELECT
r.source_city,
r.destination_city,
COUNT(s.shipment_id) AS shipment_count,
ROUND(AVG(s.shipping_cost),2) AS avg_cost
FROM routes r
INNER JOIN shipments s
ON r.route_id = s.route_id
GROUP BY
r.source_city,
r.destination_city
ORDER BY shipment_count DESC;