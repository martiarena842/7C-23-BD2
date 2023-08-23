-- Active: 1686142519701@@127.0.0.1@3306@sakila

/*
1


*/


INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES (123, 'martiarena', 'tomi', 'x5801', NULL, '1', 1, 'VP sales');
/*
No voy a poder ingresar un email NULL ya que al crear la tabla se especifico que email no puede ser null


*/
/*
2
UPDATE employees SET employeeNumber = employeeNumber - 20

What did happen? Explain. Then run this other
Lo que paso fue que en la tabla employees a la columna de employeeNumber se le resto 20 unidades a los numeros de los empleados en la tabla

UPDATE employees SET employeeNumber = employeeNumber + 20
Lo que paso aca fue lo contrario a la query anterior ya que en vez de restar 20 unidades a employeeNUmber se le sumaron 20 unidades 
*/

--3 
alter table employees 
ADD age int,
ADD constraint CheckEdad CHECK(age >= 16 and age <= 70);

/*
4
film_actor funciona como la tabla intermedia de dos tablas que son de muhcos a muchos
La "referential integrity" asegura que la informacion en esta tabla intermedia sea precisa.
asi mantenemos toda la informacion organizada y correcta en la base de datos.
*/

/*5*/

ALTER TABLE employees
ADD COLUMN lastUpdate datetime;
ALTER TABLE employees
ADD COLUMN lastUpdateUser VARCHAR(100);	

delimiter //
CREATE TRIGGER update_lastUpdatte
before update on employees
for each row
BEGIN 
set new.lastUpdate=NOW();
set new.lastUpdateUser=CURRENT_USER;

END //
DELIMITER;

UPDATE employees SET lastName = 'marto' WHERE employeeNumber = 1002;
select * from employees;


/*6*

trigger ins_film
se activa al crear una nueva columna en "film"
CREATE DEFINER=`user`@`%` TRIGGER `ins_film` 
    AFTER INSERT ON `film`
    FOR EACH ROW
BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
END
Basicamente al crear una nueva columna en film esta inserta en film_text una nueva columna con el mismo
film_id ,titulo y descripcion que el que se agrego a film


upd_film hace que luego de actualizar una columna de "film" se actualice tambien la columna que se creo con el trigger anterior de ins_film
asi se puede mantener actualizada con los cambios
CREATE DEFINER=`user`@`%` TRIGGER `upd_film`
    AFTER UPDATE ON `film`
    FOR EACH ROW
BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
END;

del_film hace que luego de eliminar una fila en la tabla "film" tambien se borre la fila que se creo en la tabla de film_text usando el film_id que se elimino
CREATE DEFINER=`user`@`%` TRIGGER `del_film`
    AFTER DELETE ON `film`
    FOR EACH ROW
BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
END;










/

