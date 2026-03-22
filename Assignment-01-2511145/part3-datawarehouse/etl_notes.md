## ETL Decisions

### Decision 1 — Date Normalization
**Problem:** The raw CSV contained inconsistent date formats, including `DD/MM/YYYY` (29/08/2023), `DD-MM-YYYY` (12-12-2023), and `YYYY-MM-DD` (2023-01-15).
**Resolution:** During the ETL process, all dates were parsed and converted into the standard SQL `YYYY-MM-DD` format to ensure `dim_date` provides a consistent timeline for time-series analysis.

### Decision 2 — Categorical Casing and Grouping
**Problem:** Product categories were inconsistent in casing (e.g., "electronics" vs "Electronics") and terminology ("Grocery" vs "Groceries").
**Resolution:** I standardized all categories to Title Case and unified naming (e.g., all instances became "Groceries"). This prevents reports from showing duplicate rows for the same logical category.

### Decision 3 — Handling Missing City Data
**Problem:** The `store_city` column in the raw dataset contained several NULL values, which would violate the `NOT NULL` constraint in the `dim_store` table.
**Resolution:** For records where the city was missing, I performed a lookup based on the `store_name` (e.g., "Chennai Anna" is mapped to "Chennai"). If no map was available, a default value of "Unknown" was assigned to maintain data integrity.