USE CUSTOMER_DB;
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

CREATE TABLE product (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  description TEXT,
  price DECIMAL(10,2),
  stock_quantity INT,
  category VARCHAR(100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(50),
  total_amount DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE order_item (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  unit_price DECIMAL(10,2),
  total_price DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE payment (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  payment_method VARCHAR(50),
  amount DECIMAL(10,2),
  status VARCHAR(50),
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
-- Customers
INSERT INTO customer (first_name, last_name, email, phone, address, city, state, zip_code)
VALUES 
('Alice', 'Smith', 'alice@example.com', '1234567890', '123 Maple St', 'New York', 'NY', '10001'),
('Bob', 'Jones', 'bob@example.com', '9876543210', '456 Oak St', 'Los Angeles', 'CA', '90001');

-- Products
INSERT INTO product (name, description, price, stock_quantity, category)
VALUES 
('Laptop', 'Gaming laptop', 1200.00, 10, 'Electronics'),
('Mouse', 'Wireless Mouse', 20.00, 100, 'Accessories');

-- Order
INSERT INTO orders (customer_id, status, total_amount)
VALUES (1, 'Confirmed', 1240.00);

-- Order Items
INSERT INTO order_item (order_id, product_id, quantity, unit_price, total_price)
VALUES 
(1, 1, 1, 1200.00, 1200.00),
(1, 2, 2, 20.00, 40.00);

-- Payment
INSERT INTO payment (order_id, payment_method, amount, status)
VALUES (1, 'Credit Card', 1240.00, 'Paid');

Table customer {
  customer_id int [pk, increment]
  first_name varchar(100)
  last_name varchar(100)
  email varchar(100) [unique]
  phone varchar(15)
  address text
  city varchar(100)
  state varchar(100)
  zip_code varchar(10)
  created_at datetime
}

Table product {
  product_id int [pk, increment]
  name varchar(100)
  description text
  price decimal(10,2)
  stock_quantity int
  category varchar(100)
  created_at datetime
}

Table orders {
  order_id int [pk, increment]
  customer_id int [ref: > customer.customer_id]
  order_date datetime
  status varchar(50)
  total_amount decimal(10,2)
}

Table order_item {
  order_item_id int [pk, increment]
  order_id int [ref: > orders.order_id]
  product_id int [ref: > product.product_id]
  quantity int
  unit_price decimal(10,2)
  total_price decimal(10,2)
}

Table payment {
  payment_id int [pk, increment]
  order_id int [ref: > orders.order_id]
  payment_date datetime
  payment_method varchar(50)
  amount decimal(10,2)
  status varchar(50)
}

SELECT 
  p.name AS product_name,
  SUM(oi.quantity) AS total_quantity_sold,
  SUM(oi.total_price) AS total_sales
FROM order_item oi
JOIN product p ON oi.product_id = p.product_id
GROUP BY p.name;

SELECT 
  o.order_id,
  c.first_name,
  c.last_name,
  o.order_date,
  o.total_amount,
  p.payment_method,
  p.status AS payment_status
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
LEFT JOIN payment p ON o.order_id = p.order_id;

CREATE VIEW daily_sales_summary AS
SELECT 
  DATE(order_date) AS order_day,
  COUNT(order_id) AS total_orders,
  SUM(total_amount) AS total_revenue
FROM orders
GROUP BY DATE(order_date);
