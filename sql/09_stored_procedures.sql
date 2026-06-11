-- get customer orders 
DELIMITER $$

CREATE PROCEDURE GetCustomerOrders(
    IN p_customer_id VARCHAR(10)
)
BEGIN

    SELECT
        order_id,
        order_date,
        product_category,
        order_value
    FROM orders
    WHERE customer_id = p_customer_id;

END $$

DELIMITER ;

CALL GetCustomerOrders('CUST001');

-- warehouse revenue 
DELIMITER $$

CREATE PROCEDURE GetWarehouseRevenue()
BEGIN

    SELECT
        w.warehouse_name,
        ROUND(SUM(s.shipping_cost),2) AS total_revenue
    FROM warehouses w
    JOIN shipments s
    ON w.warehouse_id = s.warehouse_id
    GROUP BY w.warehouse_name
    ORDER BY total_revenue DESC;

END $$

DELIMITER ;

CALL GetWarehouseRevenue();

-- shipment status summary 
DELIMITER $$

CREATE PROCEDURE GetShipmentStatusSummary()
BEGIN

    SELECT
        status,
        COUNT(*) AS shipment_count
    FROM shipments
    GROUP BY status;

END $$

DELIMITER ;

CALL GetShipmentStatusSummary();

-- customer spending 
DELIMITER $$

CREATE PROCEDURE GetCustomerSpending()
BEGIN

    SELECT
        c.customer_name,
        ROUND(SUM(o.order_value),2) AS total_spent
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
    ORDER BY total_spent DESC;

END $$

DELIMITER ;

CALL GetCustomerSpending();

-- route perfomance
DELIMITER $$

CREATE PROCEDURE GetRoutePerformance()
BEGIN

    SELECT
        r.source_city,
        r.destination_city,
        COUNT(s.shipment_id) AS shipment_count
    FROM routes r
    JOIN shipments s
    ON r.route_id = s.route_id
    GROUP BY
        r.source_city,
        r.destination_city
    ORDER BY shipment_count DESC;

END $$

DELIMITER ;

CALL GetRoutePerformance();
