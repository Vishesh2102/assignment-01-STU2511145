# Relational Database Analysis

## Anomaly Analysis

### Insert Anomaly
**Problem:** In the current denormalized `orders_flat.csv`, it is physically impossible to record a new entity (like a Customer or Sales Representative) until an actual transaction occurs. 
**Specific Example:** If the company hires a new Sales Representative, `SR05 - Kiran Bedi`, we cannot add her to the database without also inventing a fake `order_id` and `product_id`. This creates "ghost data" that can corrupt inventory reports. In a normalized system, Kiran would simply be added to `tbl_sales_reps` independently of any sales.

### Update Anomaly
**Problem:** Redundant data requires multiple updates for a single real-world change, leading to data drift.
**Specific Example:** Look at **Deepak Joshi (SR01)**. In Row 2, his office is listed as *"Mumbai HQ, Nariman Point"*, but in Row 38, it is listed as *"Mumbai HQ, Nariman Pt"*. Because the address is typed manually for every order, small typos have already created inconsistencies. If the office moved, we would have to search and replace hundreds of rows. In a 3NF schema, we update the address once in the `tbl_sales_reps` table, and every order automatically reflects the change.

### Delete Anomaly
**Problem:** Removing a transaction results in the permanent loss of non-transactional metadata.
**Specific Example:** If we decide to purge old orders from early 2023, and we delete the only row containing **Headphones (P005)**, we don't just lose the sale record; we lose the knowledge that Headphones cost 3,200 and belong to the Electronics category. The product effectively vanishes from our catalog because its existence was solely dependent on that one order row.

---

## Normalization Justification

The manager’s claim that a single-table design is "simpler" is a dangerous oversimplification that confuses **ease of initial setup** with **operational reliability**. While one table is easier for a non-technical user to view in Excel, it fails as a professional database for several reasons identified in `orders_flat.csv`.

First, **Storage Inefficiency and Performance**: The provided dataset repeats long strings like "Delhi Office, Connaught Place, New Delhi - 110001" for every single order handled by Anita Desai (SR02). As the company scales to 100,000 orders, the database will swell with redundant text, slowing down queries and increasing costs. By moving this to a `tbl_sales_reps` table, we store that string exactly once, using a small 4-byte ID to link it to orders.

Second, **Data Integrity (The "Single Source of Truth")**: In the flat file, a customer like **Rohan Mehta (C001)** has his email and city repeated across dozens of rows. If Rohan moves from Mumbai to Delhi, an employee might update the first five rows they see and miss the next ten. This creates a "split-brain" database where the system thinks Rohan lives in two places at once. Normalization to 3NF ensures that every piece of data has one home.

Third, **Business Logic Flexibility**: Normalization allows for features that a flat file cannot support. For example, a 3NF schema allows us to track "Products Never Ordered" (using a `LEFT JOIN` where the `order_id` is NULL). In the manager’s flat-table approach, a product that has never been ordered **cannot even exist** in the system. By defending normalization, we are not over-engineering; we are building a foundation that allows the business to actually manage its inventory and staff effectively.