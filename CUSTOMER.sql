CREATE DATABASE sales_order_processing;
USE sales_order_processing;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50) NOT NULL,
    customer_email VARCHAR(50) UNIQUE,
    customer_phone VARCHAR(15)
);

CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE sales_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE order_item (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES sales_order(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO customer (customer_name, customer_email, customer_phone)
VALUES
('Amit Shah', 'amit@gmail.com', '9876543210'),
('Neha Verma', 'neha@gmail.com', '9123456789');

INSERT INTO product (product_name, price, stock)
VALUES
('Laptop', 55000, 10),
('Printer', 12000, 5),
('Mouse', 500, 50);

START TRANSACTION;

SELECT stock
FROM product
WHERE product_id = 1
FOR UPDATE;

INSERT INTO sales_order (customer_id, order_date, total_amount)
VALUES (1, CURDATE(), 55000);

INSERT INTO order_item (order_id, product_id, quantity, price)
VALUES (1, 1, 1, 55000);

UPDATE product
SET stock = stock - 1
WHERE product_id = 1;

COMMIT;

START TRANSACTION;

INSERT INTO sales_order (customer_id, order_date, total_amount)
VALUES (2, CURDATE(), 12000);

ROLLBACK;

SELECT * FROM customer;

SELECT * FROM product;

SELECT * FROM sales_order;

SELECT o.order_id, c.customer_name, o.order_date, o.total_amount
FROM sales_order o
JOIN customer c ON o.customer_id = c.customer_id;

SELECT o.order_id, p.product_name, oi.quantity, oi.price
FROM order_item oi
JOIN product p ON oi.product_id = p.product_id
JOIN sales_order o ON oi.order_id = o.order_id;

SELECT product_name, stock
FROM product
WHERE stock > 0;