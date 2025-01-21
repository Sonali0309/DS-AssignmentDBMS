# DS-AssignmentDBMS
DBMS assignment including ER diagram and SQL queries

Overview
This repository contains the ER diagrams, database schemas, normalization process, SQL scripts, and written explanations for the given DBMS assignment. The assignment involves modeling databases for two applications:
1. Food Delivery App (like Swiggy/Zomato)
2. Bus Booking Management System (like RedBus)

Contents
1. ER Diagrams
   - foodDeliveryER.png → Entity-Relationship (ER) diagram for the food delivery app.
   - BusBooking.png → ER diagram for the bus booking system.

2. Database Schema & Normalization
   - queriesForAllPart.sql → SQL script to create tables for the bus booking system.
   - partCRationale.txt → Explanation of normalization with justifications.

3. Data Population (SQL Scripts)
   - queriesForAllPart.sql → Sample data insertion for bus booking tables and its usage.
   - airportdbQueries.sql → for airport database related queries.

4. Screenshots
  - screenshots of output after running airport database related queries.


Key Features of the Database Design
Food Delivery App
- Supports restaurants, menus, orders, payments, delivery tracking, and discounts.
- Order tracking is designed to ensure real-time updates.
- Payments table supports multiple payment methods efficiently.

Bus Booking System
- Covers trip scheduling, ticket booking, bus tracking, and passenger check-ins.
- Uses separate tables for Users, Bookings, Payments, and Bus Operators.
- Bus tracking is denormalized for faster location updates.
- Ensures data consistency while optimizing query performance.

How to Use
Run SQL Scripts
1. Set up a MySQL/PostgreSQL database.
2. Download airport database from airport-db.zip .
3. Run the schema script:
   source airportdbQueries.sql;
   source queriesForAllPart.sql;


Contributors
- Sonali Sharma (NIT Raipur)




