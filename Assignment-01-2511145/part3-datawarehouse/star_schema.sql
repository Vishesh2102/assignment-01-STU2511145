CREATE DATABASE IF NOT EXISTS dw_assignment;
USE dw_assignment;

-- Drop tables
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;

-- ========================
-- DIMENSION TABLES
-- ========================

CREATE DATABASE IF NOT EXISTS dw_assignment;
USE dw_assignment;

-- Drop tables in order of dependency
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;

-- ========================
-- DIMENSION TABLES
-- ========================

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL
);

CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

-- ========================
-- FACT TABLE
-- ========================

CREATE TABLE fact_sales (
    transaction_id VARCHAR(50) PRIMARY KEY,
    date_id INT NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    revenue DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- ========================
-- CLEANED DATA (FROM CSV)
-- ========================

-- dim_date: Standardized to YYYY-MM-DD
INSERT INTO dim_date VALUES
(1, '2023-01-15', 1, 2023),
(2, '2023-02-05', 2, 2023),
(3, '2023-02-20', 2, 2023),
(4, '2023-03-31', 3, 2023),
(5, '2023-08-09', 8, 2023),
(6, '2023-08-15', 8, 2023),
(7, '2023-08-29', 8, 2023),
(8, '2023-10-26', 10, 2023),
(9, '2023-12-08', 12, 2023),
(10, '2023-12-12', 12, 2023);

-- dim_store: Standardized city names
INSERT INTO dim_store VALUES
(1, 'Chennai Anna', 'Chennai'),
(2, 'Delhi South', 'Delhi'),
(3, 'Bangalore MG', 'Bangalore'),
(4, 'Pune FC Road', 'Pune');

-- dim_product: Standardized categories (e.g., electronics -> Electronics)
INSERT INTO dim_product VALUES
(1, 'Speaker', 'Electronics'),
(2, 'Tablet', 'Electronics'),
(3, 'Phone', 'Electronics'),
(4, 'Smartwatch', 'Electronics'),
(5, 'Atta 10kg', 'Groceries'),
(6, 'Jeans', 'Clothing'),
(7, 'Biscuits', 'Groceries');

-- fact_sales: Cleaned fact rows (TXN5000 to TXN5009)
INSERT INTO fact_sales VALUES
('TXN5000', 7, 1, 1, 3, 147788.34),
('TXN5001', 10, 1, 2, 11, 255487.32),
('TXN5002', 2, 1, 3, 20, 974067.80),
('TXN5003', 3, 2, 2, 14, 325165.68),
('TXN5004', 1, 1, 4, 10, 588510.10),
('TXN5005', 5, 3, 5, 12, 629568.00),
('TXN5006', 4, 4, 4, 6, 353106.06),
('TXN5007', 8, 4, 6, 16, 37079.52),
('TXN5008', 9, 3, 7, 9, 247229.91),
('TXN5009', 6, 3, 4, 3, 176553.03);