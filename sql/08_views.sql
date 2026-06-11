-- customer summary 
CREATE VIEW vw_customer_summary AS
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    c.state,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.order_value),2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.city,
    c.state;
    
SELECT *
FROM vw_customer_summary
LIMIT 10;

-- shipment perfomance 
CREATE VIEW vw_shipment_performance AS
SELECT
    shipment_id,
    shipping_cost,
    shipment_weight,
    status,
    delivery_type
FROM shipments;

SELECT *
FROM vw_shipment_performance
LIMIT 10;

-- warehouse perfomance 
CREATE VIEW vw_warehouse_performance AS
SELECT
    w.warehouse_id,
    w.warehouse_name,
    COUNT(s.shipment_id) AS shipment_count,
    ROUND(SUM(s.shipping_cost),2) AS total_revenue
FROM warehouses w
JOIN shipments s
ON w.warehouse_id = s.warehouse_id
GROUP BY
    w.warehouse_id,
    w.warehouse_name;
    
SELECT *
FROM vw_warehouse_performance;

-- driver perfomance 
CREATE VIEW vw_driver_performance AS
SELECT
    d.driver_id,
    d.driver_name,
    COUNT(s.shipment_id) AS total_shipments
FROM drivers d
JOIN shipments s
ON d.driver_id = s.driver_id
GROUP BY
    d.driver_id,
    d.driver_name;
    
SELECT *
FROM vw_driver_performance;

-- route perfomance
CREATE VIEW vw_route_performance AS
SELECT
    r.route_id,
    r.source_city,
    r.destination_city,
    COUNT(s.shipment_id) AS shipment_count,
    ROUND(AVG(s.shipping_cost),2) AS avg_shipping_cost
FROM routes r
JOIN shipments s
ON r.route_id = s.route_id
GROUP BY
    r.route_id,
    r.source_city,
    r.destination_city;
    
SELECT *
FROM vw_route_performance;

-- complete shipment tracking 
CREATE VIEW vw_complete_shipment_tracking AS
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
JOIN orders o
ON s.order_id = o.order_id
JOIN customers c
ON o.customer_id = c.customer_id
JOIN warehouses w
ON s.warehouse_id = w.warehouse_id
JOIN drivers d
ON s.driver_id = d.driver_id
JOIN vehicles v
ON s.vehicle_id = v.vehicle_id
JOIN routes r
ON s.route_id = r.route_id;

SELECT *
FROM vw_complete_shipment_tracking
LIMIT 20;

-- verifying 
SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';