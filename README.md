# IdolTalaga-SDG8.5-DBMS
Employment Monitoring and Job  Tracking System for SDG 8.5


**UN Sustainable Development Goal:** SDG 8 – Decent Work and Economic Growth (Target 8.5)

## Project Description
This project implements a relational database system designed to support employment monitoring and skills-based job matching. It integrates individual profiles, training programs, job postings, and job applications into a centralized SQL-based system. The database enforces data integrity through constraints, triggers, and ACID-compliant stored procedures to support evidence-based labor analysis aligned with SDG 8.5.

## Technologies Used
- RDBMS: MySQL
- Modeling Tool: draw.io / dbdiagram.io
- Interface: SQL CLI
- Data Generator: Mockaroo / AI
- Version Control: GitHub

## Installation / Setup
1. Open the SQL client (MySQL / MariaDB)
2. Execute scripts in the following order:
   - `1.1_DDL_Schema.sql`
   - `1.2_DML_TestData.sql`
   - `1.3_StoredLogic.sql`


## Usage Instructions
- Use the `ApplyForJob` stored procedure to demonstrate ACID transactions
- Run reporting VIEWS to generate SDG-related reports
- Triggers automatically update employment status upon training completion

## Contributors
- Jamel Macadaub
- Rimuel Loking



## Whats Inside
This project contains all the resources for demonstrating our database and interface work. Below is an overview of what you can find inside each folder:

### 1_SQL_SCRIPTS
This folder contains all the SQL scripts used in the project:
- **1.1_DDL_Schema.sql** – Defines all tables, primary/foreign keys, and constraints.  
- **1.2_DML_TestData.sql** – Sample data inserted into the tables for testing purposes.  
- **1.3_StoredLogic.sql** – Stored procedures, triggers, and views used in the project.

### 2_DEMO_INTERFACE
This folder contains images or screenshots of the CLI, demonstrating how the SQL scripts and database work in practice.

### 3_DOCUMENTATION
All supporting documentation and diagrams are stored here:
- **Final ER Diagrams** – Visual representation of database relationships.  
- **SDAD or Documentation** – System Design and Analysis Document explaining the project flow and features.  
- **transactionflowchart.png** – Flowchart illustrating transaction processes.

