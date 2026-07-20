#Smart City EV Charging Network (DBMS Project)
Description
This project is a relational database management system designed to monitor and analyze a smart electric vehicle (EV) charging network, featuring substation infrastructure tracking, session management, billing, and maintenance logging.

Features
Station & Substation Management: Track hub capacities, operational statuses, and infrastructure details.

Charging Point Operations: Monitor individual charging bays and real-time occupancy.

User & Vehicle Registry: Manage EV owners and vehicle battery specifications.

Session & Energy Tracking: Log power consumption, timestamps, and session durations.

Payment Processing: Handle billing methods, transaction amounts, and payment statuses.

Maintenance & Repair Logging: Record service history, replaced parts, and repair expenditures.

Technologies Used
SQL (MySQL)

C++ (Planned Frontend Integration)

Database Design
ER Diagram conceptualized for smart grid infrastructure

Normalized relational schema optimized for data integrity

Primary Keys, Foreign Keys, and Cascading Deletes implemented

SQL Operations
INSERT, UPDATE, DELETE for data manipulation

WHERE clause for precise filtering

Complex JOIN operations across multiple entities

GROUP BY & HAVING for aggregations and cost analysis

ORDER BY for ranking users and maintenance costs

Subqueries & CTEs for advanced reporting and session duration analysis

Future Roadmap & Enhancements
C++ Frontend Interface: Develop a C++ application utilizing MySQL Connector/C++ for a driver portal and operator dashboard.

Advanced Query Optimization: Implement indexing strategies, evaluate execution plans with EXPLAIN, and optimize heavy analytical queries.
