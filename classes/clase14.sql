-- Active: 1686142519701@@127.0.0.1@3306@sakila
select  co.country,CONCAT(c.first_name, " ", c.last_name) as full_name,a.address,ci.city
from customer c 
inner join address a on a.address_id=c.address_id
inner join city ci on ci.city_id=a.city_id
inner join country co on co.country_id=ci.country_id
where country="Argentina"
;

/*2*/
SELECT f.title ,l.name ,f.rating,
    CASE
WHEN f.rating = 'G' THEN 'Apta para Menores de 12 años'
WHEN f.rating = 'PG' THEN 'Apta Para todas las edades'
WHEN f.rating = 'PG-13' THEN 'Apta para mayores de 12 años'
WHEN f.rating = 'R' THEN 'Apta Mayores de 16 años'
WHEN f.rating = 'NC-17' THEN 'Apta para Mayores de 18 años'
ELSE 'No se conoce el Rating'
END 
AS descripcion
from film f
Inner JOIN language l ON f.language_id = l.language_id;

/*3*/

SELECT  CONCAT(ac.first_name, ' ', ac.last_name) as 'Nombre_completo',
        f.title ,
        f.release_year      
from film f
inner JOIN film_actor using(film_id)
Inner JOIN actor ac USING(actor_id)
where CONCAT(first_name, ' ', last_name) LIKE TRIM(UPPER('BELA WALKEN'));

/*4*/
SELECT
    f.title, r.rental_date, c.first_name,
    CASE
        WHEN r.return_date IS NULL THEN 'No se devolvio ' ELSE 'Si se devolvio'
    END 'Se devolvio?'
FROM rental r
    INNER JOIN inventory i on r.inventory_id = i.inventory_id
    INNER JOIN film f on i.film_id = f.film_id
    INNER JOIN customer c on r.customer_id = c.customer_id
WHERE
    month(r.rental_date) = '05'
    or month(r.rental_date) = '06'
    order by rental_rate
    ;

/*5
CAST: La funcion CAST permite cambiar el tipo de dato de una expresión o valor a otro tipo de dato específico. 
Esto se utiliza para adaptar los datos en una consulta o expresión a un formato particular que sea necesario para realizar calculos, 
comparaciones o presentaciones específicas.
POR ejemplo:
Hagamos de cuenta que hay una columna qeu se llama number y tiene un valor de 2.79,
podemos seleccionarla como un numero entero o como se necesite, segun lo que se esta buscando: Ejeplo del codigo a utilizar
SELECT CAST (Number AS integer)


CONVERT: no altera el tipo de dato subyacente, pero cambia como se presenta el valor. Puede cambiar el formato de fechas, 
numeros o textos para que se muestren de manera diferente en los resultados de la consulta. Es una transformacion visual, pero el tipo de dato real permanece sin cambios.
En este ejemplo la funcion convert nos ayuda a hacer que se muestren los primeros 4 caracteres de la fecha mostrando asi solo el anio de nacimiento
SELECT name, CONVERT(INT, LEFT(birth_date, 4)) AS anio_nacimiento
FROM people;


En resumen, CAST cambia el tipo de dato, mientras que CONVERT cambia como se muestra. 
Ambas funciones son utiles en diferentes situaciones según tus necesidades especificas en una consulta.

*/

/* 6

NVL-Oracle databases: se utiliza para reemplazar valores NULL con un valor especificado. 
Si la primera expresion es NULL, devuelve la segunda expresion. De lo contrario, devuelve la primera expresión
ejemplo: 
SELECT title, NVL(description, 'Descripción no disponible') AS descripcion
FROM film;

ISNULL-SQL Server:Similar a NVL, la función ISNULL reemplaza valores NULL con un valor especificado. 
Si la primera expresion es NULL, devuelve la segunda expresion. De lo contrario, devuelve la primera expresion
Ejemplo
SELECT ISNULL(description, 'Descripción no disponible') AS descripcion
FROM film;

IFNULL -MySQL: La función IFNULL se utiliza en MySQL para manejar valores NULL. Si la primera expresión es NULL, devuelve la segunda expresión.
De lo contrario, devuelve la primera expresión.
Ejemplo:
SELECT IFNULL(description, 'Descripción no disponible') AS descripcion
FROM film
LIMIT 5;


COALESCE-Oracle, SQL Server y MySQL,etc..: Devuelve la primera expresión no NULL en la lista. Puedes proporcionar varias expresiones para buscar valores no NULL.
Ejemplo:
SELECT COALESCE(description, 'Descripción no disponible') AS descripcion
FROM film;
*/

