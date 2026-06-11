import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random

# Random Seed
random.seed(42)
np.random.seed(42)

#lists
cities = [
    "Hyderabad",
    "Bangalore",
    "Chennai",
    "Mumbai",
    "Pune",
    "Delhi",
    "Kolkata",
    "Visakhapatnam",
    "Ahmedabad",
    "Jaipur"
]

customer_types = [
    "Individual",
    "Business"
]

payment_modes = [
    "UPI",
    "Card",
    "Net Banking",
    "COD"
]

product_categories = [
    "Electronics",
    "Furniture",
    "Clothing",
    "Food",
    "Healthcare",
    "Automotive"
]

#states mapping 
state_mapping = {
    "Hyderabad": "Telangana",
    "Bangalore": "Karnataka",
    "Chennai": "Tamil Nadu",
    "Mumbai": "Maharashtra",
    "Pune": "Maharashtra",
    "Delhi": "Delhi",
    "Kolkata": "West Bengal",
    "Visakhapatnam": "Andhra Pradesh",
    "Ahmedabad": "Gujarat",
    "Jaipur": "Rajasthan"
}

#customer names 
first_names = [
    "Ravi", "Anil", "Karthik", "Suresh", "Rahul",
    "Priya", "Sneha", "Pooja", "Divya", "Neha",
    "Arjun", "Vikram", "Rohit", "Amit", "Deepak",
    "Lavanya", "Meena", "Swathi", "Keerthi", "Nisha"
]

last_names = [
    "Kumar", "Reddy", "Sharma", "Patel", "Singh",
    "Rao", "Verma", "Gupta", "Agarwal", "Mehta"
]

#empty list 
customers_data = []
#customer generation 
for i in range(1, 501):

    customer_id = f"CUST{i:03d}"

    customer_name = (
        random.choice(first_names)
        + " "
        + random.choice(last_names)
    )

    city = random.choice(cities)

    state = state_mapping[city]

    customer_type = np.random.choice(
        customer_types,
        p=[0.7, 0.3]
    )

    registration_date = (
        datetime(2023, 1, 1)
        + timedelta(
            days=random.randint(0, 1095)
        )
    ).date()

    customers_data.append([
        customer_id,
        customer_name,
        city,
        state,
        customer_type,
        registration_date
    ])
customers_df = pd.DataFrame(
    customers_data,
    columns=[
        "customer_id",
        "customer_name",
        "city",
        "state",
        "customer_type",
        "registration_date"
    ]
)

print(customers_df.head())
print(customers_df.info())
print("\nTotal Customers:", len(customers_df))

customers_df.to_csv(
    r"C:\logistics-supply-chain-analytics\datasets\customers.csv",
    index=False
)
print("Customers dataset generated successfully!")

# orders generation

orders_data = []

for i in range(1, 5001):

    order_id = f"ORD{i:04d}"

    customer_id = random.choice(
        customers_df["customer_id"].tolist()
    )

    order_date = (
        datetime(2024, 1, 1)
        + timedelta(
            days=random.randint(0, 730)
        )
    ).date()

    category = random.choice(
        product_categories
    )

    # order value

    if category == "Electronics":
        order_value = random.randint(5000, 50000)

    elif category == "Furniture":
        order_value = random.randint(3000, 30000)

    elif category == "Clothing":
        order_value = random.randint(1000, 8000)

    elif category == "Food":
        order_value = random.randint(500, 3000)

    elif category == "Healthcare":
        order_value = random.randint(1000, 15000)

    else:
        order_value = random.randint(2000, 25000)

    payment_mode = np.random.choice(
        payment_modes,
        p=[0.45, 0.25, 0.10, 0.20]
    )

    orders_data.append([
        order_id,
        customer_id,
        order_date,
        category,
        order_value,
        payment_mode
    ])

orders_df = pd.DataFrame(
    orders_data,
    columns=[
        "order_id",
        "customer_id",
        "order_date",
        "product_category",
        "order_value",
        "payment_mode"
    ]
)
print("\nOrders Sample:")
print(orders_df.head())
print("\nTotal Orders:", len(orders_df))
orders_df.to_csv(
    r"C:\logistics-supply-chain-analytics\datasets\orders.csv",
    index=False
)

print("Orders dataset generated successfully!")

#warehouse data manual
warehouse_data = [
    ["WH001", "Hyderabad Hub", "Hyderabad", "Telangana", 12000],
    ["WH002", "Bangalore Hub", "Bangalore", "Karnataka", 15000],
    ["WH003", "Chennai Hub", "Chennai", "Tamil Nadu", 11000],
    ["WH004", "Mumbai Hub", "Mumbai", "Maharashtra", 18000],
    ["WH005", "Delhi Hub", "Delhi", "Delhi", 20000],
    ["WH006", "Pune Hub", "Pune", "Maharashtra", 10000],
    ["WH007", "Kolkata Hub", "Kolkata", "West Bengal", 13000],
    ["WH008", "Ahmedabad Hub", "Ahmedabad", "Gujarat", 9000],
    ["WH009", "Jaipur Hub", "Jaipur", "Rajasthan", 8000],
    ["WH010", "Visakhapatnam Hub", "Visakhapatnam", "Andhra Pradesh", 9500]
]
warehouses_df = pd.DataFrame(
    warehouse_data,
    columns=[
        "warehouse_id",
        "warehouse_name",
        "city",
        "state",
        "capacity"
    ]
)
print("\nWarehouses Sample:")
print(warehouses_df.head())
warehouses_df.to_csv(
    r"C:\logistics-supply-chain-analytics\datasets\warehouses.csv",
    index=False
)

print("Warehouses dataset generated successfully!")

#vehicle dataset
vehicles_data = []
vehicle_types = [
    "Van",
    "Mini Truck",
    "Truck",
    "Container Truck"
]
fuel_types = [
    "Diesel",
    "Petrol",
    "CNG",
    "Electric"
]
for i in range(1, 21):

    vehicle_id = f"VEH{i:03d}"

    vehicle_type = random.choice(
        vehicle_types
    )

    if vehicle_type == "Van":
        capacity_kg = 500

    elif vehicle_type == "Mini Truck":
        capacity_kg = 1500

    elif vehicle_type == "Truck":
        capacity_kg = 5000

    else:
        capacity_kg = 10000

    fuel_type = random.choice(
        fuel_types
    )

    purchase_year = random.randint(
        2018,
        2024
    )

    vehicles_data.append([
        vehicle_id,
        vehicle_type,
        capacity_kg,
        fuel_type,
        purchase_year
    ])
vehicles_df = pd.DataFrame(
    vehicles_data,
    columns=[
        "vehicle_id",
        "vehicle_type",
        "capacity_kg",
        "fuel_type",
        "purchase_year"
    ]
)
print("\nVehicles Sample:")
print(vehicles_df.head())
vehicles_df.to_csv(
    r"C:\logistics-supply-chain-analytics\datasets\vehicles.csv",
    index=False
)

print("Vehicles dataset generated successfully!")

#drivers dataset
drivers_data = []
license_types = [
    "LMV",
    "HMV"
]
for i in range(1, 51):

    driver_id = f"DRV{i:03d}"

    driver_name = (
        random.choice(first_names)
        + " "
        + random.choice(last_names)
    )

    experience_years = random.randint(
        1,
        15
    )

    license_type = np.random.choice(
        license_types,
        p=[0.4, 0.6]
    )

    joining_date = (
        datetime(2018, 1, 1)
        + timedelta(
            days=random.randint(0, 2555)
        )
    ).date()

    drivers_data.append([
        driver_id,
        driver_name,
        experience_years,
        license_type,
        joining_date
    ])
drivers_df = pd.DataFrame(
    drivers_data,
    columns=[
        "driver_id",
        "driver_name",
        "experience_years",
        "license_type",
        "joining_date"
    ]
)
print("\nDrivers Sample:")
print(drivers_df.head())
drivers_df.to_csv(
    r"C:\logistics-supply-chain-analytics\datasets\drivers.csv",
    index=False
)

print("Drivers dataset generated successfully!")

#routes dataset
routes_data = []
route_pairs = [
    ("Hyderabad", "Bangalore"),
    ("Hyderabad", "Chennai"),
    ("Hyderabad", "Mumbai"),
    ("Hyderabad", "Pune"),
    ("Hyderabad", "Visakhapatnam"),

    ("Bangalore", "Chennai"),
    ("Bangalore", "Mumbai"),
    ("Bangalore", "Delhi"),

    ("Mumbai", "Delhi"),
    ("Mumbai", "Ahmedabad"),
    ("Mumbai", "Pune"),

    ("Delhi", "Jaipur"),
    ("Delhi", "Kolkata"),

    ("Chennai", "Visakhapatnam"),
    ("Chennai", "Kolkata"),

    ("Ahmedabad", "Jaipur"),
    ("Pune", "Hyderabad"),
    ("Kolkata", "Delhi"),
    ("Visakhapatnam", "Hyderabad"),
    ("Jaipur", "Mumbai")
]
distance_map = {
    ("Hyderabad", "Bangalore"): 570,
    ("Hyderabad", "Chennai"): 630,
    ("Hyderabad", "Mumbai"): 710,
    ("Hyderabad", "Pune"): 560,
    ("Hyderabad", "Visakhapatnam"): 620,

    ("Bangalore", "Chennai"): 350,
    ("Bangalore", "Mumbai"): 980,
    ("Bangalore", "Delhi"): 2150,

    ("Mumbai", "Delhi"): 1420,
    ("Mumbai", "Ahmedabad"): 530,
    ("Mumbai", "Pune"): 150,

    ("Delhi", "Jaipur"): 280,
    ("Delhi", "Kolkata"): 1530,

    ("Chennai", "Visakhapatnam"): 800,
    ("Chennai", "Kolkata"): 1660,

    ("Ahmedabad", "Jaipur"): 670,
    ("Pune", "Hyderabad"): 560,
    ("Kolkata", "Delhi"): 1530,
    ("Visakhapatnam", "Hyderabad"): 620,
    ("Jaipur", "Mumbai"): 1140
}
for i, route in enumerate(route_pairs, start=1):

    route_id = f"RT{i:03d}"

    source_city = route[0]

    destination_city = route[1]

    distance_km = distance_map[route]

    routes_data.append([
        route_id,
        source_city,
        destination_city,
        distance_km
    ])
routes_df = pd.DataFrame(
    routes_data,
    columns=[
        "route_id",
        "source_city",
        "destination_city",
        "distance_km"
    ]
)
print("\nRoutes Sample:")
print(routes_df.head())
routes_df.to_csv(
    r"C:\logistics-supply-chain-analytics\datasets\routes.csv",
    index=False
)

print("Routes dataset generated successfully!")

#shipments dataset
shipments_data = []
warehouse_ids = warehouses_df["warehouse_id"].tolist()

vehicle_ids = vehicles_df["vehicle_id"].tolist()

driver_ids = drivers_df["driver_id"].tolist()

route_ids = routes_df["route_id"].tolist()
for i in range(1, 5001):
    shipment_id = f"SHP{i:04d}"
    order_id = orders_df.iloc[i - 1]["order_id"]
    warehouse_id = random.choice(
     warehouse_ids
)

    vehicle_id = random.choice(
     vehicle_ids
)

    driver_id = random.choice(
     driver_ids
)

    route_id = random.choice(
     route_ids
)
    dispatch_date = (
    datetime(2024, 1, 1)
    + timedelta(
        days=random.randint(0, 730)
    )
).date()
    expected_delivery_date = (
    dispatch_date
    + timedelta(
        days=random.randint(1, 7)
    )
)
    status = np.random.choice(
    [
        "Delivered",
        "Delayed",
        "In Transit",
        "Returned"
    ],
    p=[0.80, 0.10, 0.05, 0.05]
)
    if status == "Delivered":

     actual_delivery_date = (
        expected_delivery_date
        - timedelta(
            days=random.randint(0, 2)
        )
    )

    elif status == "Delayed":

     actual_delivery_date = (
        expected_delivery_date
        + timedelta(
            days=random.randint(1, 5)
        )
    )

    else:

     actual_delivery_date = expected_delivery_date
    shipment_weight = round(
    random.uniform(5, 1000),
    2
)
    shipping_cost = round(
    shipment_weight * random.uniform(2, 8),
    2
)
    delivery_type = np.random.choice(
    ["Local", "Inter-City"],
    p=[0.30, 0.70]
)
    shipments_data.append([
    shipment_id,
    order_id,
    warehouse_id,
    vehicle_id,
    driver_id,
    route_id,
    dispatch_date,
    expected_delivery_date,
    actual_delivery_date,
    shipment_weight,
    shipping_cost,
    status,
    delivery_type
])
print("Total Shipments:", len(shipments_data))
shipments_df = pd.DataFrame(
    shipments_data,
    columns=[
        "shipment_id",
        "order_id",
        "warehouse_id",
        "vehicle_id",
        "driver_id",
        "route_id",
        "dispatch_date",
        "expected_delivery_date",
        "actual_delivery_date",
        "shipment_weight",
        "shipping_cost",
        "status",
        "delivery_type"
    ]
)
print("\nShipments Sample:")
print(shipments_df.head())
shipments_df.to_csv(
    r"C:\logistics-supply-chain-analytics\datasets\shipments.csv",
    index=False
)

print("Shipments dataset generated successfully!")
