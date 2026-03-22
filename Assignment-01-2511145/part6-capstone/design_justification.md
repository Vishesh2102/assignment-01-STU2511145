# Part 6: AI-Powered Hospital Data System Design

## Storage Systems
To meet the four diverse goals of the hospital network, I have implemented a **Polyglot Persistence** strategy:

1.  **Goal 1 (Readmission Risk) & Goal 3 (Management Reports):** I chose **Snowflake (Cloud Data Warehouse)**. Snowflake is ideal for **OLAP (Online Analytical Processing)**. It allows us to aggregate years of historical treatment data and department costs to train ML models and generate complex monthly reports without impacting the performance of live hospital systems.
2.  **Goal 2 (Plain English Queries):** I implemented a **Vector Database (Pinecone)** alongside a **Relational DB (PostgreSQL)**. By using a **RAG (Retrieval-Augmented Generation)** architecture, we can index patient histories as "embeddings." This allows a Large Language Model (LLM) to retrieve specific context (e.g., "cardiac events") and answer doctors' queries in natural language while maintaining clinical accuracy.
3.  **Goal 4 (Real-time ICU Vitals):** I chose **TimescaleDB (Time-series Database)**. ICU devices generate high-frequency telemetry data. TimescaleDB is built on PostgreSQL but optimized for massive write speeds and "time-bucket" queries, allowing doctors to view real-time trends in heart rates or oxygen levels instantly.

---

## OLTP vs. OLAP Boundary
The boundary in this architecture is defined by the **Change Data Capture (CDC)** and **Streaming Pipeline**.

* **OLTP (Transactional) Side:** This includes the primary Electronic Health Records (EHR) and the ICU monitoring ingest. These systems are optimized for **low-latency writes** and high concurrency to ensure patient data is recorded safely during live care.
* **The Boundary:** We use **Apache Kafka** as the message bus. Data is "pushed" from the transactional side into the analytical side in near real-time.
* **OLAP (Analytical) Side:** This begins at the **Snowflake Data Warehouse**. Once data crosses this boundary, it is transformed from its raw, normalized state into denormalized schemas (like Star Schemas) specifically designed for deep AI training and management reporting.

---

## Trade-offs: Complexity vs. Performance
A significant trade-off in this design is the **increased architectural complexity** of maintaining multiple specialized databases (Relational, Time-series, and Vector) instead of a single "all-in-one" database. 

**The Risk:** This increases the "maintenance surface area" and requires a more specialized engineering team to manage the data sync between Pinecone, Snowflake, and PostgreSQL. 

**The Mitigation:** To mitigate this, I have utilized **managed cloud services** (SaaS). By using Snowflake and Pinecone as managed services, the hospital reduces the operational burden of server patching and scaling. We also implement a **centralized Data Catalog** (like DataHub or Alation) to ensure that a patient record in the Vector DB is always perfectly synced with the master record in the EHR, preventing "data silos" where different departments see different versions of a patient's history.