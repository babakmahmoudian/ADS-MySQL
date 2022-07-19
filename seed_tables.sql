-- Changing the MySQL's delimiter from ; to //
DELIMITER //

/*  This function receives a nationality as input and returns the corresponding
    ID from customer_nationalities table.   */
CREATE FUNCTION get_nationality_id(in_nationality VARCHAR(15))
RETURNS TINYINT UNSIGNED
DETERMINISTIC
BEGIN
    --  Defining a variable to store the result:
    DECLARE out_nationality_id TINYINT UNSIGNED;

    /*  Since only one result is expected, the use of the LIMIT statements will
    lead to performance increase.  */
    SELECT nationality_id INTO out_nationality_id FROM customer_nationalities
    WHERE nationality = in_nationality
    LIMIT 1;

    RETURN out_nationality_id;
END//

-- Reverting the delimiter back to ;
DELIMITER ;

-- Changing the MySQL's delimiter from ; to //
DELIMITER //

-- This function returns the typemodel_id of any given pair of type and model.
CREATE FUNCTION get_typemodel_id(in_type VARCHAR(15), in_model VARCHAR(20))
RETURNS TINYINT UNSIGNED
DETERMINISTIC
BEGIN
    --  Defining a variable to store the result:
    DECLARE out_typemodel_id TINYINT UNSIGNED;

    /*  Since only one result is expected, the use of the LIMIT statements will
    lead to performance increase.  */
    SELECT typemodel_id INTO out_typemodel_id FROM yacht_typemodels
    WHERE type = in_type and model = in_model
    LIMIT 1;

    RETURN out_typemodel_id;
END//

-- Reverting the delimiter back to ;
DELIMITER ;

-- Changing the MySQL's delimiter from ; to //
DELIMITER //

-- This function receives a port's name as input and returns the relative id.
CREATE FUNCTION get_port_id(in_name VARCHAR(15))
RETURNS TINYINT UNSIGNED
DETERMINISTIC
BEGIN
    --  Defining a variable to store the result:
    DECLARE out_port_id TINYINT UNSIGNED;

    /*  Since only one result is expected, the use of the LIMIT statements will
    lead to performance increase.  */
    SELECT port_id INTO out_port_id FROM ports
    WHERE name = in_name
    LIMIT 1;

    RETURN out_port_id;
END//

-- Reverting the delimiter back to ;
DELIMITER ;

-- Changing the MySQL's delimiter from ; to //
DELIMITER //

-- This function receives a yacht's name as input and returns the corresponding id.
CREATE FUNCTION get_yacht_id(in_name VARCHAR(15))
RETURNS TINYINT UNSIGNED
DETERMINISTIC
BEGIN
    --  Defining a variable to store the result:
    DECLARE out_yacht_id TINYINT UNSIGNED;

    /*  Since only one result is expected, the use of the LIMIT statements will
    lead to performance increase.  */
    SELECT yacht_id INTO out_yacht_id FROM yachts
    WHERE name = in_name
    LIMIT 1;

    RETURN out_yacht_id;
END//

-- Reverting the delimiter back to ;
DELIMITER ;


INSERT INTO customer_nationalities (nationality) VALUES
    ("American"),
    ("British"),
    ("French"),
    ("German"),
    ("Irish"),
    ("South African"),
    ("Swedish");

INSERT INTO customers (customer_id, name, nationality_id, email, phoneno) VALUES
    ("D13-101", "Bette Davis", get_nationality_id("American"), "bette.davis@ulster.ac.uk", "41728003"),
    ("D13-203", "Cary Grant", get_nationality_id("British"), "bigcary@yahoo.com", "+44417654321"),
    ("D13-42", "Humphrey Bogart", get_nationality_id("American"), "bogieh@gmail.com", "07782751839"),
    ("D13-51", "Ingrid Bergman", get_nationality_id("Swedish"), "IngridB@hotmail.com", "02890123456"),
    ("D13-R20", "Jean Harlow", get_nationality_id("German"), "jeanh99@gmail.com", "005866419887654"),
    ("D13-R93", "John Wayne", get_nationality_id("South African"), "john.wayne@ulster.ac.uk", "02890112233"),
    ("D14-38", "Katharine Hepburn", get_nationality_id("Irish"), "kath_hep29@hotmail.com", "00447880708090"),
    ("D17-022", "Marilyn Monroe", get_nationality_id("French"), "marilyn@hotmail.com", "+88487618356732"),
    ("D13-306", "William Holden", get_nationality_id("Irish"), "billyho66@yahoo.com", "+38198322843");

INSERT INTO ports (name, email, phoneno, docking_places) VALUES
    ("Athens", "paays7@athensport.gr", "+3014936640", 106),
    ("Barcelona", "harbourmaster@barcelona_marina.com", "+34(0)8892436767", 211),
    ("Bodrum", "", "+9099264831", 89),
    ("Cadiz", "", "+34(0)18128403", 90),
    ("Cagliari", "ettwu7@gmail.com", "+3963660326", 40),
    ("Cannes", "cannes.marina@yahoo.com", "+3366295633", 148),
    ("Cartagena", "", "+34(0)62045005", 21),
    ("Dénia", "denia_port@denia_port.com", "+90229453883", 31),
    ("Genoa", "genoa667@genoaadmin.co.it", "+3984774025", 160),
    ("Heraklion", "herp@heraklioncity.co.gr", "", 85),
    ("Izmir", "", "009062602105", 93),
    ("Kusadasi", "Kusadasi_harbour@hotmail.co.tr", "+9045204295", 96),
    ("Lisbon", "", "0035144700212", 79),
    ("Magaluf", "maghar@maghar.com", "", 88),
    ("Malaga", "harbour_master@malagaport.com", "+3430336117", 198),
    ("Marmaris", "", "+90(0)62228138", 69),
    ("Marseiles", "marseiles_port@france_ports.fr", "+3330026016", 92),
    ("Monaco", "mariana@monacoport.mc", "0037788356302", 104),
    ("Montpelier", "", "+33(0)51411947", 79),
    ("Naples", "", "+3990583686", 132),
    ("Palermo", "ggaft4@visitpalermo.co.it", "+3922746104", 57),
    ("Palma", "", "+3494955320", 74),
    ("Paphos", "paphosmariana@cyprusports.cy", "+35788301000", 47),
    ("Perpignan", "", "+3373600125", 88),
    ("St Tropez", "master@sttropezmarina.fr", "", 239),
    ("Tangier", "tan778@tangierport.com", "+21245936724", 63),
    ("Valencia", "", "+3483884002", 74);

INSERT INTO yacht_typemodels (type, model) VALUES
    ("Catamaran", "MacGregor 26X"),
    ("Monohull", "Beneteau 373"),
    ("Monohull", "Jeanneau 42 DS"),
    ("Monohull", "Catalina 350"),
    ("Powered", "Ranger 28");

INSERT INTO yachts (name, typemodel_id, homeport_id, berths, cost) VALUES
    ("Escape", get_typemodel_id("Monohull", "Beneteau 373"), get_port_id("Kusadasi"), 10, 3016.34),
    ("Mad Hatter", get_typemodel_id("Monohull", "Jeanneau 42 DS"), get_port_id("Barcelona"), 4, 869.45),
    ("Orion", get_typemodel_id("Powered", "Ranger 28"), get_port_id("Marmaris"), 9, 2309.56),
    ("Second Wind", get_typemodel_id("Catamaran", "MacGregor 26X"), get_port_id("Kusadasi"), 8, 1063.45),
    ("Serendipity", get_typemodel_id("Monohull", "Catalina 350"), get_port_id("Genoa"), 9, 2995.92),
    ("Serenity", get_typemodel_id("Powered", "Ranger 28"), get_port_id("Genoa"), 11, 2294),
    ("Wind Dancer", get_typemodel_id("Monohull", "Jeanneau 42 DS"), get_port_id("Barcelona"), 4, 892.4),
    ("Windsong", get_typemodel_id("Catamaran", "MacGregor 26X"), get_port_id("Dénia"), 7, 1352.9);

INSERT INTO charters (charter_id, customer_id, yacht_id, start_date, duration) VALUES
    ("CH-026", "D13-51", get_yacht_id("Escape"), "2018-08-25", 14),
    ("CH-027", "D13-101", get_yacht_id("Mad Hatter"), "2018-06-25", 7),
    ("CH-028", "D13-42", get_yacht_id("Mad Hatter"), "2018-07-05", 21),
    ("CH-029", "D13-R93", get_yacht_id("Mad Hatter"), "2018-08-05", 14),
    ("CH-030", "D13-R20", get_yacht_id("Orion"), "2018-07-11", 14),
    ("CH-031", "D13-101", get_yacht_id("Orion"), "2018-07-30", 10),
    ("CH-032", "D17-022", get_yacht_id("Second Wind"), "2018-06-24", 36),
    ("CH-033", "D13-R20", get_yacht_id("Serendipity"), "2018-06-17", 7),
    ("CH-034", "D13-203", get_yacht_id("Serendipity"), "2018-06-30", 18),
    ("CH-035", "D13-R20", get_yacht_id("Serendipity"), "2018-07-22", 10),
    ("CH-036", "D13-42", get_yacht_id("Serenity"), "2018-07-02", 14),
    ("CH-037", "D14-38", get_yacht_id("Serenity"), "2018-07-23", 21),
    ("CH-038", "D13-203", get_yacht_id("Serenity"), "2018-08-18", 7),
    ("CH-039", "D13-101", get_yacht_id("Wind Dancer"), "2018-07-12", 7),
    ("CH-040", "D17-022", get_yacht_id("Wind Dancer"), "2018-08-10", 10),
    ("CH-041", "D13-51", get_yacht_id("Wind Dancer"), "2018-08-23", 7),
    ("CH-042", "D14-38", get_yacht_id("Wind Dancer"), "2018-09-06", 15),
    ("CH-043", "D13-306", get_yacht_id("Windsong"), "2018-07-06", 10),
    ("CH-044", "D13-306", get_yacht_id("Windsong"), "2018-07-29", 35),
    ("CH-045", "D13-203", get_yacht_id("Windsong"), "2018-09-06", 21);

INSERT INTO visits (visit_id, charter_id, port_id, date_of_arrival, length_of_stay) VALUES
    ("V101", "CH-033", get_port_id("Genoa"), "2018-06-17", 0),
    ("V102", "CH-032", get_port_id("Kusadasi"), "2018-06-24", 0),
    ("V103", "CH-027", get_port_id("Barcelona"), "2018-06-25", 0),
    ("V104", "CH-032", get_port_id("Marmaris"), "2018-06-27", 1),
    ("V105", "CH-027", get_port_id("Perpignan"), "2018-06-29", 1),
    ("V106", "CH-034", get_port_id("Genoa"), "2018-06-30", 1),
    ("V107", "CH-036", get_port_id("Genoa"), "2018-07-02", 1),
    ("V108", "CH-032", get_port_id("Paphos"), "2018-07-04", 3),
    ("V109", "CH-034", get_port_id("Monaco"), "2018-07-04", 2),
    ("V110", "CH-028", get_port_id("Barcelona"), "2018-07-05", 1),
    ("V111", "CH-043", get_port_id("Dénia"), "2018-07-06", 0),
    ("V112", "CH-036", get_port_id("St Tropez"), "2018-07-07", 2),
    ("V113", "CH-043", get_port_id("Cartagena"), "2018-07-08", 1),
    ("V114", "CH-028", get_port_id("Palma"), "2018-07-09", 3),
    ("V115", "CH-034", get_port_id("Marseiles"), "2018-07-10", 1),
    ("V116", "CH-030", get_port_id("Marmaris"), "2018-07-11", 0),
    ("V117", "CH-043", get_port_id("Malaga"), "2018-07-11", 3),
    ("V118", "CH-039", get_port_id("Barcelona"), "2018-07-12", 1),
    ("V119", "CH-032", get_port_id("Heraklion"), "2018-07-13", 1),
    ("V120", "CH-036", get_port_id("Monaco"), "2018-07-13", 1),
    ("V121", "CH-034", get_port_id("St Tropez"), "2018-07-15", 1),
    ("V122", "CH-028", get_port_id("Cartagena"), "2018-07-16", 1),
    ("V123", "CH-030", get_port_id("Paphos"), "2018-07-16", 2),
    ("V124", "CH-032", get_port_id("Athens"), "2018-07-19", 3),
    ("V125", "CH-030", get_port_id("Heraklion"), "2018-07-21", 1),
    ("V126", "CH-028", get_port_id("Valencia"), "2018-07-22", 2),
    ("V127", "CH-035", get_port_id("Genoa"), "2018-07-22", 1),
    ("V128", "CH-032", get_port_id("Izmir"), "2018-07-23", 1),
    ("V129", "CH-037", get_port_id("Genoa"), "2018-07-23", 0),
    ("V130", "CH-035", get_port_id("Cagliari"), "2018-07-26", 1),
    ("V131", "CH-037", get_port_id("Naples"), "2018-07-26", 1),
    ("V132", "CH-044", get_port_id("Dénia"), "2018-07-29", 0),
    ("V133", "CH-031", get_port_id("Marmaris"), "2018-07-30", 0),
    ("V134", "CH-035", get_port_id("Naples"), "2018-07-30", 1),
    ("V135", "CH-037", get_port_id("Palermo"), "2018-07-31", 1),
    ("V136", "CH-044", get_port_id("Malaga"), "2018-08-02", 1),
    ("V137", "CH-031", get_port_id("Heraklion"), "2018-08-03", 1),
    ("V138", "CH-029", get_port_id("Barcelona"), "2018-08-05", 0),
    ("V139", "CH-037", get_port_id("Cagliari"), "2018-08-05", 2),
    ("V140", "CH-031", get_port_id("Bodrum"), "2018-08-06", 2),
    ("V141", "CH-044", get_port_id("Lisbon"), "2018-08-07", 4),
    ("V142", "CH-029", get_port_id("Cartagena"), "2018-08-10", 1),
    ("V143", "CH-037", get_port_id("Naples"), "2018-08-10", 1),
    ("V144", "CH-040", get_port_id("Barcelona"), "2018-08-10", 0),
    ("V145", "CH-040", get_port_id("St Tropez"), "2018-08-13", 1),
    ("V146", "CH-029", get_port_id("Magaluf"), "2018-08-15", 1),
    ("V147", "CH-044", get_port_id("Cadiz"), "2018-08-15", 1),
    ("V148", "CH-040", get_port_id("Montpelier"), "2018-08-17", 1),
    ("V149", "CH-038", get_port_id("Genoa"), "2018-08-18", 0),
    ("V150", "CH-038", get_port_id("Cannes"), "2018-08-22", 1),
    ("V151", "CH-044", get_port_id("Tangier"), "2018-08-22", 2),
    ("V152", "CH-041", get_port_id("Barcelona"), "2018-08-23", 0),
    ("V153", "CH-026", get_port_id("Kusadasi"), "2018-08-25", 0),
    ("V154", "CH-041", get_port_id("Montpelier"), "2018-08-27", 1),
    ("V155", "CH-044", get_port_id("Palma"), "2018-08-27", 1),
    ("V156", "CH-026", get_port_id("Athens"), "2018-08-29", 2),
    ("V157", "CH-026", get_port_id("Izmir"), "2018-09-05", 1),
    ("V158", "CH-042", get_port_id("Barcelona"), "2018-09-06", 0),
    ("V159", "CH-045", get_port_id("Dénia"), "2018-09-06", 1),
    ("V160", "CH-042", get_port_id("Magaluf"), "2018-09-08", 1),
    ("V161", "CH-042", get_port_id("Cartagena"), "2018-09-10", 2),
    ("V162", "CH-045", get_port_id("Barcelona"), "2018-09-12", 2),
    ("V163", "CH-042", get_port_id("Dénia"), "2018-09-15", 1),
    ("V164", "CH-045", get_port_id("Montpelier"), "2018-09-17", 2),
    ("V165", "CH-042", get_port_id("Magaluf"), "2018-09-18", 1),
    ("V166", "CH-045", get_port_id("Magaluf"), "2018-09-23", 1);