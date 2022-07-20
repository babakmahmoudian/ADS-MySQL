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
    
-- Business Process 2: Getting the total length of stay at each port in a given interval
CREATE VIEW ports_total_stays AS
    SELECT ports.name AS port,
           visits.date_of_arrival,
           SUM(visits.length_of_stay) AS total_length_stay
        FROM ports JOIN visits USING (port_id)
        GROUP BY ports.name, visits.date_of_arrival;

-- Business Process 3: Getting a list of yachts visiting their home ports between two dates
CREATE VIEW yachts_visiting_home AS
    SELECT yachts.name as "yacht_name", visits.date_of_arrival, visits.length_of_stay
        FROM yachts JOIN charters USING (yacht_id)
            JOIN visits USING (charter_id)
        WHERE yachts.homeport_id = visits.port_id;

-- Business Process 4: Retrieving the list of ports visited by a given customer
CREATE VIEW ports_visited_by_customers AS
    SELECT customers.name AS customer_name,
           ports.name AS port,
           visits.date_of_arrival,
           visits.length_of_stay
        FROM customers JOIN charters USING (customer_id)
            JOIN visits USING (charter_id)
            JOIN ports USING (port_id)
        ORDER BY visits.date_of_arrival;

-- Changing the MySQL's delimiter from ; to //
DELIMITER //

/*  Business Process 5: Temporarily removing a yacht and getting a list of inactive yachts
        * in_name: the name of the yacht to deactivate
    */
-- This procedure sets a yacht as inactive 
CREATE PROCEDURE inactivateYacht(in_name VARCHAR(50))
BEGIN
    -- Deactivating the given yacht
    UPDATE yachts SET inactive_since = (SELECT CURDATE()) WHERE name = in_name;
END//

-- This procedure sets a yacht as active 
CREATE PROCEDURE activateYacht(in_name VARCHAR(50))
BEGIN
    -- Activating the given yacht
    UPDATE yachts SET inactive_since = NULL WHERE name = in_name;
END//

-- Reverting the delimiter back to ;
DELIMITER ;

-- This view retrieves a list of all the inactive yachts
CREATE VIEW inactive_yachts as
    SELECT * FROM yachts WHERE inactive_since IS NOT NULL;

/*  Calling Business Processes:

    Business Process 1:
    CALL addCustomerAndCharter(
        "D18-23", "Marlon Brando", "American", "Don.Corleone@gmail.com", "+15417543010",
        "CH-046", "2022-07-09", 11
        );

    Business Process 2:
    SELECT * FROM ports_total_stays WHERE date_of_arrival BETWEEN "2018-07-11" AND "2018-07-21";
    
    Business Process 3:
    SELECT * FROM yachts_visiting_home WHERE date_of_arrival BETWEEN "2018-07-11" AND "2018-07-21";

    Business Process 4:
    SELECT port, date_of_arrival, length_of_stay FROM ports_visited_by_customers
        WHERE customer_name = "John Wayne";

    Business Process 5:
    CALL inactivateYacht("Serenity");

    SELECT * FROM inactive_yachts;

    CALL activateYacht("Serenity");

    SELECT * FROM inactive_yachts;
    */