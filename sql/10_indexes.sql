-- customer id 
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

-- order date 
CREATE INDEX idx_orders_order_date
ON orders(order_date);

-- shipment status
CREATE INDEX idx_shipments_status
ON shipments(status);

-- warehouse 
CREATE INDEX idx_shipments_warehouse
ON shipments(warehouse_id);

-- driver 
CREATE INDEX idx_shipments_driver
ON shipments(driver_id);

-- composite 
CREATE INDEX idx_orders_customer_date
ON orders(customer_id, order_date);

-- verify 
SHOW INDEX
FROM orders;

SHOW INDEX
FROM shipments;