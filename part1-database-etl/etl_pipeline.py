import pandas as pd
import mysql.connector
import re
from datetime import datetime

# DB Connection
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Raman@508",
    database="fleximart"
)
cursor = conn.cursor()

# Helper functions
def clean_phone(phone):
    if pd.isna(phone):
        return None
    digits = re.sub(r'\D', '', phone)
    return f"+91-{digits[-10:]}" if len(digits) >= 10 else None

def clean_date(date):
    for fmt in ("%Y-%m-%d", "%d/%m/%Y", "%m-%d-%Y", "%m/%d/%Y"):
        try:
            return datetime.strptime(date, fmt).date()
        except:
            pass
    return None

# ----------------- EXTRACT -----------------
customers = pd.read_csv("data/customers_raw.csv")
products = pd.read_csv("data/products_raw.csv")
sales = pd.read_csv("data/sales_raw.csv")

# ----------------- TRANSFORM -----------------
customers.drop_duplicates(subset="customer_id", inplace=True)
customers["email"] = customers.apply(
    lambda x: x["email"] if pd.notna(x["email"])
    else f"{x['first_name'].lower()}.{x['last_name'].lower()}@unknown.com",
    axis=1
)
customers["phone"] = customers["phone"].apply(clean_phone)
customers["registration_date"] = customers["registration_date"].apply(clean_date)
customers["city"] = customers["city"].str.title()

products["category"] = products["category"].str.strip().str.capitalize()
products["price"].fillna(products["price"].mean(), inplace=True)
products["stock_quantity"].fillna(0, inplace=True)

sales.drop_duplicates(subset="transaction_id", inplace=True)
sales.dropna(subset=["customer_id", "product_id"], inplace=True)
sales["transaction_date"] = sales["transaction_date"].apply(clean_date)

# ----------------- LOAD -----------------
# Clear existing data to avoid duplicate key errors
cursor.execute("DELETE FROM orders")
cursor.execute("DELETE FROM customers")
cursor.execute("DELETE FROM products")
conn.commit()

customer_map = {}
for _, r in customers.iterrows():
    cursor.execute("""
        INSERT INTO customers (first_name, last_name, email, phone, city, registration_date)
        VALUES (%s,%s,%s,%s,%s,%s)
    """, tuple(r[1:7]))
    customer_map[r["customer_id"]] = cursor.lastrowid

product_map = {}
for _, r in products.iterrows():
    cursor.execute("""
        INSERT INTO products (product_name, category, price, stock_quantity)
        VALUES (%s,%s,%s,%s)
    """, tuple(r[1:5]))
    product_map[r["product_id"]] = cursor.lastrowid

for _, r in sales.iterrows():
    total = r["quantity"] * r["unit_price"]
    cursor.execute("""
        INSERT INTO orders (customer_id, order_date, total_amount, status)
        VALUES (%s,%s,%s,%s)
    """, (customer_map[r["customer_id"]], r["transaction_date"], total, r["status"]))

conn.commit()
cursor.close()
conn.close()
print("ETL Completed Successfully")
