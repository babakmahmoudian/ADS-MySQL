/*  Preparing the database to be used:
        1. Creating a new empty database in case it does not already exist
        2. Activating the database
    */

CREATE DATABASE IF NOT EXISTS ads_db;
USE ads_db

-- Disabling the foreign key constraints
SET FOREIGN_KEY_CHECKS=0;

/*  Creating the customers_nationalities table:
        * nationality_id: a unique auto-incremental identifier serving
          as the table's PK
        * nationality: lists all the nationalities of each and every
          customer.
    */
CREATE TABLE IF NOT EXISTS customer_nationalities (
    nationality_id TINYINT UNSIGNED AUTO_INCREMENT,
    nationality VARCHAR(15) NOT NULL UNIQUE,
    PRIMARY KEY (nationality_id)
);

/*  Creating the customers table:
        * customer_id: a unique identifier which acts as the table's
          PK and has the form of D##-###
        * name: the customer's name
        * nationality: a foreign key referencing to customer_nationalities
          table denoting each customer's nationality.
        * email: the customer's email address
        * phoneno: the phone no. of the customer
    */
CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(7) NOT NULL,
    name varchar(50) NOT NULL UNIQUE,
    nationality_id TINYINT UNSIGNED NOT NULL,
    email VARCHAR(255),
    phoneno VARCHAR(15),
    PRIMARY KEY (customer_id),
    FOREIGN KEY (nationality_id) REFERENCES customer_nationalities(nationality_id)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
    CONSTRAINT CHECK (NOT(email IS NULL and phoneno IS NULL))
);

/*  Creating the ports table:
        * port_id: a unique incremental identifier as the table's PK
        * name: the name of the port
        * email: the email address of the port
        * phoneno: the phone number of the port
        * docking places: the total number of docking places available
          on the port
    */
CREATE TABLE IF NOT EXISTS ports (
    port_id TINYINT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255),
    phoneno VARCHAR(16),
    docking_places TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (port_id),
    CONSTRAINT CHECK (NOT(email IS NULL and phoneno IS NULL))
);

/*  Creating the yacht_typemodels table:
        * typemodel_id: the PK of the table which is a unique
          auto-autoincremental number
        * type: the type of the yacht
        * model: the model of the yacht
    */
CREATE TABLE IF NOT EXISTS yacht_typemodels (
    typemodel_id TINYINT UNSIGNED AUTO_INCREMENT,
    type VARCHAR(15) NOT NULL,
    model VARCHAR(20) NOT NULL,
    PRIMARY KEY (typemodel_id),
    UNIQUE (type, model)
);

/*  Creating the yachts table:
        * yacht_id: a unique auto-incremental number as the table's PK
        * name: the name of the yacht
        * typemodel_id: FK referencing a type/model pair in
          yacht_typemodels table
        * homeport_id: yacht's home port; FK referencing a row in the
          ports table.
        * berths: the total number of berths that the yacht contains
        * cost: the total cost of renting the yacht per hour
        * inactive_since: the date that the yacht became inactive or
          null (active)
    */
CREATE TABLE IF NOT EXISTS yachts (
    yacht_id TINYINT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    typemodel_id TINYINT UNSIGNED NOT NULL,
    homeport_id TINYINT UNSIGNED NOT NULL,
    berths TINYINT UNSIGNED NOT NULL,
    cost DECIMAL(6, 2) NOT NULL,
    inactive_since DATE DEFAULT NULL,
    PRIMARY KEY (yacht_id),
    FOREIGN KEY (typemodel_id) REFERENCES yacht_typemodels(typemodel_id)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
    FOREIGN KEY (homeport_id) REFERENCES ports(port_id)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);

/*  Creating the charters table
        * charter_id: The unique ID of each charter in the form of CH-###
        * customer_id: FK referencing a customer in the customers table
        * yacht_id: ID of the booked yacht; FK referencing a yacht in
          yachts table
        * start_date: the starting date of the charter
        * duration: number of the days that the charter lasts
    */
CREATE TABLE IF NOT EXISTS charters (
    charter_id VARCHAR(7) NOT NULL,
    customer_id VARCHAR(7) NOT NULL,
    yacht_id TINYINT UNSIGNED DEFAULT NULL,
    start_date DATE NOT NULL,
    duration TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (charter_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (yacht_id) REFERENCES yachts(yacht_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

/*  Creating the visits table:
        * visit_id: uniquely identifies each visit in the form of
          a V### code
        * charter_id: FK referencing a specific charter that the
          visit belongs to
        * port_id: FK referencing the port that the visit is headed to
        * date_of_arrival: the date in which the visit reaches the
          destined port
        * length_of_stay: the period of the stay at the port (in days)
    */
CREATE TABLE IF NOT EXISTS visits (
    visit_id VARCHAR(7) NOT NULL,
    charter_id VARCHAR(7) NOT NULL,
    port_id TINYINT UNSIGNED NOT NULL,
    date_of_arrival DATE NOT NULL,
    length_of_stay TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (visit_id),
    FOREIGN KEY (charter_id) REFERENCES charters (charter_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (port_id) REFERENCES ports (port_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Reenabling the foreign key constraints
SET FOREIGN_KEY_CHECKS=1;