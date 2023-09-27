# Active: 1686142519701@@127.0.0.1@3306@sakila
    
/*
1
Write a function that returns the amount of copies of a film in a store in sakila-db. Pass either the film id or the film name and the store id.
*/    
DELIMITER //
CREATE FUNCTION FilmCopiesStore(filmID int, storeID int) RETURNS int
READS SQL DATA
BEGIN
    DECLARE copies INT;

    IF filmID is not null then
        SELECT COUNT(*) INTO copies
        FROM inventory inv
        JOIN rental r ON inv.inventory_id = r.inventory_id
        WHERE inv.film_id = filmID AND inv.store_id = storeID;
        RETURN copies;

    END IF;
END //
DELIMITER ;
SELECT FilmCopiesStore (1, 2);

/*
2
Write a stored procedure with an output parameter that contains a list of customer first and last names separated by ";",
that live in a certain country. You pass the country it gives you the list of people living there. USE A CURSOR, do not use any aggregation function (ike CONTCAT_WS.
*/
DELIMITER //

CREATE PROCEDURE CountryCustomers(
    IN targetCountry VARCHAR(150),
     OUT customerss VARCHAR(230))

BEGIN
    DECLARE finish INT DEFAULT 0;
    DECLARE firstName VARCHAR(30);
    DECLARE lastName VARCHAR(50);
    DECLARE coun VARCHAR(100) ;

    DECLARE CursorC1 CURSOR FOR
        SELECT first_name, last_name
        FROM customer
        WHERE country = targetCountry;

    SET customerss = '';
    
    OPEN CursorC1;
    read_loop: LOOP
        FETCH CursorC1 INTO firstName, lastName;
        IF finish THEN
            LEAVE read_loop;

        END IF;
        
        IF LENGTH(customerss) > 0 THEN
            SET customerss = CONCAT(customerss, ';', firstName, ' ', lastName);
        ELSE
            SET customerss = CONCAT(firstName, ' ', lastName);

        END IF;
    END LOOP;
    CLOSE CursorC1;
END //

DELIMITER ;

CALL CountryCustomers('USA', @customerList);
SELECT @customerList;


DELIMITER //


CREATE PROCEDURE customerScountry(IN target_country VARCHAR(250), INOUT customer_list VARCHAR(500)) 
BEGIN 
	DECLARE finished INT DEFAULT 0;
	DECLARE first_name VARCHAR(250); 
	DECLARE last_name VARCHAR(250);
	DECLARE country VARCHAR(250);

	DECLARE cursor_list CURSOR FOR
	SELECT
	    co.country,c.first_name,c.last_name
	FROM customer c
	    INNER JOIN address USING(address_id)
	    INNER JOIN city USING(city_id)
	    INNER JOIN country co USING(country_id);
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

	OPEN cursor_list;

	loop_label: LOOP
		FETCH cursor_list INTO country, first_name, last_name;

		IF country = target_country THEN
			SET customer_list = CONCAT(first_name, ' ', last_name, ' ; ', customer_list);
		END IF;

        IF finished = 1 THEN
			LEAVE loop_label;
		END IF;

	END LOOP loop_label;
	CLOSE cursor_list;
	
END //
DELIMITER ;
SET @customer_list = '';
CALL customerScountry('Spain', @customer_list);
SELECT @customer_list;

/*
3
Review the function inventory_in_stock and the procedure film_in_stock explain the code, write usage examples.

Esta funcion tiene como objetivo verificar si un articula esta en stock segun la base de datos,
puede devolver true si hay stock del articulo o false si no hay stock.

*/
DROP FUNCTION IF EXISTS inventory_in_stock;

CREATE FUNCTION inventory_in_stock(p_inventory_id INT) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
    DECLARE v_rentals INT;
    DECLARE v_out INT;

    #Comprueba cuantos registros de alquiler hay guardados con el `inventory_id` que fue enviado
    SELECT COUNT(*) INTO v_rentals
    FROM rental
    WHERE inventory_id = p_inventory_id;

    #SI no hay registros de alquiler del articulo, eso significa que si esta en stock
    IF v_rentals = 0 THEN
        RETURN TRUE;
    END IF;

    #Verifica si hay registros de alquiler sin fecha de devolucion para el `inventory_id` proporcionado.
    SELECT COUNT(rental_id) INTO v_out
    FROM inventory
    LEFT JOIN rental USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id
    AND rental.return_date IS NULL;

    #Si si hay registros de alquiler sin fecha de devolucion, eso significa que el articulo no esta en stock
    IF v_out > 0 THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END

/*
En el siguiente ejemplo de uso podemos ver como el articulo "1" si se encuentra en stock ya que al correr la funcion nos devuelve un 1
que signififca true es decir que si hay stock, pero en el ejemplo del articulo "1231" devuelve un 0 ya que este articulo no se encuentra en Stock.
Ya que el 0 representa el False
*/
SELECT inventory_in_stock(1);
SELECT inventory_in_stock(1231);
