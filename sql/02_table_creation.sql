/*customers Table*/
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    customer_type VARCHAR(20),
    registration_date DATE
);

/*orders table*/
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    order_date DATE,
    product_category VARCHAR(50),
    order_value DECIMAL(10,2),
    payment_mode VARCHAR(20),

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

SHOW TABLES;

/*warehouses table*/
CREATE TABLE warehouses (
    warehouse_id VARCHAR(10) PRIMARY KEY,
    warehouse_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    capacity INT
);

/*vehicles table*/
CREATE TABLE vehicles (
    vehicle_id VARCHAR(10) PRIMARY KEY,
    vehicle_type VARCHAR(30),
    capacity_kg INT,
    fuel_type VARCHAR(20),
    purchase_year YEAR
);

/*drivers table*/
CREATE TABLE drivers (
    driver_id VARCHAR(10) PRIMARY KEY,
    driver_name VARCHAR(100) NOT NULL,
    experience_years INT,
    license_type VARCHAR(20),
    joining_date DATE
);
SHOW TABLES;

/*routes table*/
CREATE TABLE routes (
    route_id VARCHAR(10) PRIMARY KEY,
    source_city VARCHAR(50),
    destination_city VARCHAR(50),
    distance_km INT
);

/*shipments table*/
CREATE TABLE shipments (
    shipment_id VARCHAR(10) PRIMARY KEY,

    order_id VARCHAR(10),
    warehouse_id VARCHAR(10),
    vehicle_id VARCHAR(10),
    driver_id VARCHAR(10),
    route_id VARCHAR(10),

    dispatch_date DATE,
    expected_delivery_date DATE,
    actual_delivery_date DATE,

    shipment_weight DECIMAL(10,2),
    shipping_cost DECIMAL(10,2),

    status VARCHAR(20),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (warehouse_id)
        REFERENCES warehouses(warehouse_id),

    FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id),

    FOREIGN KEY (driver_id)
        REFERENCES drivers(driver_id),

    FOREIGN KEY (route_id)
        REFERENCES routes(route_id)
);

SHOW TABLES;

/* adding new colum to shipments table*/
ALTER TABLE shipments
ADD COLUMN delivery_type ENUM('Local','Inter-City');

ALTER TABLE shipments
MODIFY status ENUM(
'Delivered',
'Delayed',
'In Transit',
'Returned'
);

DESC shipments;