drop database if exists ads_db;

-- Creating the DB and the tables
source ./create_tables.sql

-- Seeding sample data into DB
source ./seed_tables.sql

-- Implementing and executing the business processes
source ./business_processes.sql