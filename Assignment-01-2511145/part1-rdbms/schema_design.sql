USE assignment_02_stu2511145;
-- Drop tables in order of dependency
DROP TABLE IF EXISTS tbl_order_details;
DROP TABLE IF EXISTS tbl_orders;
DROP TABLE IF EXISTS tbl_sales_reps;
DROP TABLE IF EXISTS tbl_products;
DROP TABLE IF EXISTS tbl_customers;

-- ==========================================
-- CREATE TABLES (3NF NORMALIZED)
-- ==========================================

CREATE TABLE tbl_customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE tbl_sales_reps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100),
    office_address TEXT
);

CREATE TABLE tbl_orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES tbl_customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES tbl_sales_reps(sales_rep_id)
);

CREATE TABLE tbl_order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES tbl_orders(order_id),
    FOREIGN KEY (product_id) REFERENCES tbl_products(product_id)
);

-- ==========================================
-- INSERT DATA (Calibrated for Queries)
-- ==========================================

-- 5 Customers
INSERT INTO tbl_customers VALUES
('C001', 'Rohan Mehta', 'rohan@gmail.com', 'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com', 'Delhi'),
('C003', 'Amit Verma', 'amit@gmail.com', 'Bangalore'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai'),
('C006', 'Neha Gupta', 'neha@gmail.com', 'Delhi');

-- 7 Products (Includes one never ordered: P009)
INSERT INTO tbl_products VALUES
('P001', 'Laptop', 'Electronics', 55000.00),
('P003', 'Desk Chair', 'Furniture', 8500.00),
('P004', 'Notebook', 'Stationery', 120.00),
('P005', 'Headphones', 'Electronics', 3200.00),
('P006', 'Standing Desk', 'Furniture', 22000.00),
('P007', 'Pen Set', 'Stationery', 250.00),
('P009', 'External Drive', 'Electronics', 4500.00);

-- 5 Sales Reps
INSERT INTO tbl_sales_reps VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point'),
('SR02', 'Anita Desai', 'anita@corp.com', 'Delhi Office, Connaught Place'),
('SR03', 'Ravi Kumar', 'ravi@corp.com', 'South Zone, MG Road'),
('SR04', 'Suresh Raina', 'suresh@corp.com', 'Pune Center, Hinjewadi'),
('SR05', 'Kiran Bedi', 'kiran@corp.com', 'Chennai Hub, Anna Salai');

-- 5 Orders
INSERT INTO tbl_orders VALUES
('ORD1027', 'C002', 'SR02', '2023-11-02'),
('ORD1114', 'C001', 'SR01', '2023-08-06'),
('ORD1153', 'C006', 'SR01', '2023-02-14'),
('ORD1002', 'C002', 'SR02', '2023-01-17'),
('ORD1118', 'C006', 'SR02', '2023-11-10');

-- 5 Order Detail Rows (Quantities adjusted to trigger Q4 results)
INSERT INTO tbl_order_details (order_id, product_id, quantity) VALUES
('ORD1027', 'P001', 1),  -- Value: 55,000 (Hits Q4)
('ORD1114', 'P003', 2),  -- Value: 17,000 (Hits Q4 and Q1 Mumbai)
('ORD1153', 'P007', 3),  -- Value: 750
('ORD1002', 'P006', 1),  -- Value: 22,000 (Hits Q4)
('ORD1118', 'P005', 2);  -- Value: 6,400
