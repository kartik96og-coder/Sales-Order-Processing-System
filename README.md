# Sales Order Processing – MySQL Database

A relational database system for managing customers, products, and sales orders with transaction control.

---

## 📁 Database: `sales_order_processing`

---

## 🗂️ Schema Overview

### Tables

| Table | Description |
|---|---|
| `customer` | Stores customer details |
| `product` | Stores product catalog with pricing and stock |
| `sales_order` | Stores order headers linked to customers |
| `order_item` | Stores line items for each order |

---

## 🧱 Table Definitions

### `customer`
| Column | Type | Constraints |
|---|---|---|
| `customer_id` | INT | PRIMARY KEY, AUTO_INCREMENT |
| `customer_name` | VARCHAR(50) | NOT NULL |
| `customer_email` | VARCHAR(50) | UNIQUE |
| `customer_phone` | VARCHAR(15) | |

### `product`
| Column | Type | Constraints |
|---|---|---|
| `product_id` | INT | PRIMARY KEY, AUTO_INCREMENT |
| `product_name` | VARCHAR(50) | NOT NULL |
| `price` | DECIMAL(10,2) | NOT NULL |
| `stock` | INT | NOT NULL |

### `sales_order`
| Column | Type | Constraints |
|---|---|---|
| `order_id` | INT | PRIMARY KEY, AUTO_INCREMENT |
| `customer_id` | INT | FK → `customer(customer_id)` |
| `order_date` | DATE | |
| `total_amount` | DECIMAL(10,2) | |

### `order_item`
| Column | Type | Constraints |
|---|---|---|
| `order_item_id` | INT | PRIMARY KEY, AUTO_INCREMENT |
| `order_id` | INT | FK → `sales_order(order_id)` |
| `product_id` | INT | FK → `product(product_id)` |
| `quantity` | INT | |
| `price` | DECIMAL(10,2) | |

---

## 🔗 Entity Relationship

```
customer (1) ──< sales_order (1) ──< order_item >── (1) product
```

---

## 🌱 Sample Data

**Customers**
- Amit Shah – amit@gmail.com – 9876543210
- Neha Verma – neha@gmail.com – 9123456789

**Products**
| Product | Price | Stock |
|---|---|---|
| Laptop | ₹55,000 | 10 |
| Printer | ₹12,000 | 5 |
| Mouse | ₹500 | 50 |

---

## 💳 Transactions

### Transaction 1 – Successful Order (COMMIT)
- Locks the `Laptop` row using `SELECT ... FOR UPDATE`
- Inserts a `sales_order` for Amit Shah (₹55,000)
- Inserts an `order_item` (1 × Laptop)
- Decrements `Laptop` stock by 1
- **Committed** — changes are permanent

### Transaction 2 – Rolled Back Order
- Inserts a `sales_order` for Neha Verma (₹12,000)
- **Rolled back** — no changes are saved

---

## 🔍 Queries

| Query | Purpose |
|---|---|
| `SELECT * FROM customer` | View all customers |
| `SELECT * FROM product` | View all products |
| `SELECT * FROM sales_order` | View all orders |
| JOIN on `sales_order` + `customer` | View orders with customer names |
| JOIN on `order_item` + `product` + `sales_order` | View order line items with product details |
| `WHERE stock > 0` on `product` | View products currently in stock |

---

## ▶️ How to Run

1. Open your MySQL client (e.g., MySQL Workbench, CLI, or DBeaver).
2. Run the full SQL script to create the database, tables, and insert data.
3. Transactions will execute automatically — Transaction 1 commits, Transaction 2 rolls back.
4. The SELECT queries at the end display the resulting data.

```bash
mysql -u root -p < sales_order_processing.sql
```

---

## 🛠️ Requirements

- MySQL 5.7+ or MySQL 8.x
- InnoDB storage engine (default) for transaction and foreign key support
