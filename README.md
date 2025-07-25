# 🛍️ Online Retail Sales Database Design

## 📌 Objective

Design and implement a **normalized SQL database schema** for an e-commerce platform. The schema supports core functionalities including product catalog management, customer registration, order placement, and payment processing.

---

## 🛠️ Tools & Technologies

- **Database**: MySQL / PostgreSQL
- **Diagram Tool**: [dbdiagram.io](https://dbdiagram.io)
- **IDE**: MySQL Workbench / pgAdmin
- **Languages**: SQL

---

## 🧱 Key Entities

- `Customer`: Stores user profile and contact information.
- `Product`: Stores product catalog details.
- `Order`: Tracks orders made by customers.
- `Order_Item`: Line items (products per order).
- `Payment`: Payment status and methods per order.

---

## 🔧 Database Design Features

- Fully **normalized to 3NF** (Third Normal Form)
- **Referential integrity** enforced via foreign keys
- Handles **many-to-many** product-order relationships
- Supports reporting via **JOINs** and **Views**

---

## 📐 ER Diagram

Created using [dbdiagram.io](https://dbdiagram.io).

![ER Diagram](https://github.com/your-username/online-retail-db/blob/main/assets/er-diagram.png)

> *(Replace the above image link with your actual ER diagram image.)*

---


## 📜 Sample DDL (MySQL)

```sql
CREATE TABLE customer (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(15),
  address TEXT,
  city VARCHAR(100),
  state VARCHAR(100),
  zip_code VARCHAR(10),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- More tables: product, orders, order_item, payment...
📥 Sample Data
sql
Copy
Edit
INSERT INTO customer (first_name, last_name, email, phone, city, state)
VALUES ('Alice', 'Smith', 'alice@example.com', '1234567890', 'New York', 'NY');
📊 Example Queries
1. Total Sales by Product

SELECT 
  p.name,
  SUM(oi.quantity) AS total_sold,
  SUM(oi.total_price) AS revenue
FROM order_item oi
JOIN product p ON oi.product_id = p.product_id
GROUP BY p.name;
2. Daily Sales Summary View


CREATE VIEW daily_sales_summary AS
SELECT 
  DATE(order_date) AS day,
  COUNT(order_id) AS total_orders,
  SUM(total_amount) AS revenue
FROM orders
GROUP BY DATE(order_date);



