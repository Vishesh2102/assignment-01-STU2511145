// Use database
use assignment_02_STU2511145;

// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    "product_id": "P201",
    "product_name": "Galaxy S23 Ultra",
    "category": "Electronics",
    "price": 95000,
    "technical_specs": { "ram": "12GB", "storage": "256GB" },
    "warranty": { "duration_months": 24 }
  },
  {
    "product_id": "P202",
    "product_name": "Organic Whole Milk",
    "category": "Groceries",
    "price": 75,
    "details": { "expiry_date": ISODate("2024-12-20T00:00:00Z") },
    "nutritional_info": { "fat": "3.5g", "protein": "3.2g" }
  },
  {
    "product_id": "P203",
    "product_name": "Dri-FIT Running Tee",
    "category": "Clothing",
    "price": 1800,
    "attributes": { "sizes_available": ["S", "M", "L", "XL"], "material": "Polyester" }
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({
  "category": "Electronics",
  "price": { "$gt": 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  "category": "Groceries",
  "details.expiry_date": { "$lt": ISODate("2025-01-01T00:00:00Z") }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { "product_id": "P201" },
  { "$set": { "discount_percent": 15 } }
);

// OP5: createIndex() — create an index on category field
// Indexing the 'category' field is essential because e-commerce platforms 
// frequently filter by category (as seen in OP2 and OP3). This converts 
// O(N) collection scans into O(log N) index lookups, drastically reducing 
// query latency as the product catalog grows to millions of items.
db.products.createIndex({ "category": 1 });
