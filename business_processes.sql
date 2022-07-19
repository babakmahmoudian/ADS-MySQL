-- Changing the MySQL's delimiter from ; to //
DELIMITER //

/*  Business process 1: Adding a new customer and booking an open charter
        * in_customer_id: the customer's ID
        * in_name: the customer's name
        * in_nationality: the customer's nationality
        * in_email: the customer's email
        * in_phoneno: the customer's phone no.
        * in_charter_id: the ID of the charter
        * in_start_date: the start date of the charter
        * in_duration: the duration of the charter
    */
CREATE PROCEDURE addCustomerAndCharter(
    in_customer_id VARCHAR(7),
    in_name VARCHAR(50),
    in_nationality VARCHAR(15),
    in_email VARCHAR(255),
    in_phoneno VARCHAR(15),
    in_charter_id VARCHAR(7),
    in_start_date DATE,
    in_duration TINYINT UNSIGNED)
BEGIN
    /*  Adding the new customer's info into the DB:
        Note: the nationality_id is retrieved from CustomerNationalities table.
        */
    INSERT INTO customers (customer_id, name, nationality_id, email, phoneno) VALUES (
        in_customer_id,
        in_name,
        get_nationality_id(in_nationality),
        in_email,
        in_phoneno
    );

    /*  Inserting a new charter which references the above customer:
        Note: the yacht_id is retrieved from Yachts table.
        */
    INSERT INTO charters (charter_id, customer_id, start_date, duration) VALUES (
        in_charter_id,
        in_customer_id,
        in_start_date,
        in_duration
    );
END//

-- Reverting the delimiter back to ;
DELIMITER ;
    
-- Changing the MySQL's delimiter from ; to //
DELIMITER //

-- Business Process 2: Getting the total length of stay at each port in a given interval
CREATE PROCEDURE printPortsTotalStay(in_begin_date DATE, in_end_date DATE)
BEGIN
    SELECT ports.name, SUM(visits.length_of_stay)
        FROM ports JOIN visits USING (port_id)
        WHERE visits.date_of_arrival >= in_begin_date AND
            visits.date_of_arrival <= in_end_date
        GROUP BY ports.name;
END//

-- Reverting the delimiter back to ;
DELIMITER ;

-- Changing the MySQL's delimiter from ; to //
DELIMITER //

-- Business Process 3: Getting a list of yachts visiting their home ports between two dates
CREATE PROCEDURE printYachtsVisitingHome()
BEGIN
    SELECT yachts.name as "yacht_name", visits.date_of_arrival, visits.length_of_stay
        FROM yachts JOIN charters USING (yacht_id)
            JOIN visits USING (charter_id)
        WHERE yachts.homeport_id = visits.port_id
            AND visits.date_of_arrival BETWEEN '2018-07-01' AND '2018-07-31';
END//

-- Reverting the delimiter back to ;
DELIMITER ;

-- Changing the MySQL's delimiter from ; to //
DELIMITER //

-- Business Process 4: Retrieving the list of ports visited by a given customer
CREATE PROCEDURE printPortsByCustomer(in_name VARCHAR(50))
BEGIN
    SELECT ports.name as "port_name", visits.date_of_arrival, visits.length_of_stay
        FROM customers JOIN charters USING (customer_id)
            JOIN visits USING (charter_id)
            JOIN ports USING (port_id)
        WHERE customers.name = in_name
        ORDER BY visits.date_of_arrival;
END//

-- Reverting the delimiter back to ;
DELIMITER ;

-- Changing the MySQL's delimiter from ; to //
DELIMITER //

/*  Business Process 5: Temporarily removing a yacht and getting a list of inactive yachts
        * in_name: the name of the yacht to deactivate
    */
CREATE PROCEDURE setYachtInactive(in_name VARCHAR(50))
BEGIN
    -- Deactivating the given yacht
    UPDATE yachts SET inactive_since = (SELECT CURDATE()) WHERE name = in_name;

    -- Getting the list of the inactive yachts
    SELECT name, inactive_since FROM yachts WHERE inactive_since IS NOT NULL;
END//

-- Reverting the delimiter back to ;
DELIMITER ;

CALL addCustomerAndCharter(
    "D18-23", "Marlon Brando", "American", "Don.Corleone@gmail.com", "+15417543010",
    "CH-046", "2022-07-09", 11
    );

CALL printPortsTotalStay("2018-07-11", "2018-07-21");

CALL printYachtsVisitingHome();

CALL printPortsByCustomer("John Wayne");

CALL setYachtInactive("Serenity");