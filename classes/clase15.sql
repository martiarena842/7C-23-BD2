-- Active: 1686142519701@@127.0.0.1@3306@sakila
 

/*1*/
create view list_of_customers as 
select 
c.customer_id,
CONCAT(c.first_name," ", c.last_name) as nombre_completo
,a.address,a.postal_code,a.phone,
ci.city,
co.country,
CASE
        WHEN c.active = 1 THEN 'active'
        ELSE 'inactive'
    END AS status,
    s.store_id

from customer c
Inner join address a on a.address_id=c.address_id
inner join city ci on ci.city_id=a.city_id
INNER JOIN country co on co.country_id=ci.country_id
inner join store s on s.store_id=c.store_id

;

/*2*/
create view film_details as
select f.title,f.film_id,f.description,f.`length`,f.rental_rate as price,
f.rating ,
c.name as category
,GROUP_CONCAT (a.first_name) as actors

from film_actor fa

inner join film f on f.film_id=fa.film_id
inner join actor a on a.actor_id=fa.actor_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id

group by f.film_id, f.title, f.description, c.name, f.rental_rate, f.length, f.rating;

/*3*/
create view sales_by_film_category as
select 
c.name as category,
SUM(p.amount) as total_rental

from film_category fc

INNER JOIN category c ON c.category_id = fc.category_id
INNER JOIN film f on f.film_id = fc.film_id
INNER JOIN inventory i ON i.film_id = f.film_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
INNER JOIN payment p on r.rental_id = p.rental_id
GROUP BY c.name;

/*4*/
create view actor_information as 
select a.first_name,a.last_name,a.actor_id,COUNT(f.film_id) as AmountOfFilmsActed from film_actor fa 
INNER join actor a on a.actor_id=fa.actor_id
inner join film f on f.film_id=fa.film_id
group by a.first_name,a.last_name,a.actor_id
;

/*5

Al comienzo selecciona el id del actor, luego el nombre y el apellido por separado
Luego utiliza una subquery en la que obtiene la información de las películas en las que cada actor ha actuado,
agrupadas por categoría y concatenadas en una cadena en la que luego del nombre de la categoria hay ":" y si hay mas de 1 pelicula en esa categoria que a actuado se separa 
con una "," cada categoria esta separada por ";" el resultado de la concatenación se ordena por el nombre de la categoría 
Despues de la subquery, la vista continúa con el from y los join para combinar las tablas "actor", "film_actor", "film_category" y "category"
Y por ultimo el resultado se agrupa por id de actor,nombre y apellido para asegurarse de que cada actor aparezca solo una vez en la vista.
*/
-------------------------------------------------
/*6

Una view es un subconjunto de una base de datos y se basa en una consulta que se ejecuta en una o más tablas de base de datos,
estas nos sirven para reducir el tiempo de espera para realizar consultas complejas ya que no requieren muchos recursos.Nos da un acceso mas rapido 
a los datos que se utilizan con frecuencia.

Si bien las vistas pueden ser útiles para mejorar el rendimiento de ciertas consultas, guardar todas las vistas puede generar una sobrecarga en la base de datos,
debido a que estas ocupan mucho espacio en el disco y necesitan mantenerse actualizadas para reflejar los datos lo que puede requerir recursos adicionales

algunas alternativas puden ser:
-Vistas regulares: Las vistas regulares proporcionan una representación virtual de los datos y no almacenan datos reales. Son utlies para simplificar consultas complejas y 
proporcionar un mayor nivel de abstracción, pero pueden no mejorar el rendimiento de las consultas como lo hacen las vistas materializadas.
-Caché: El uso de un mecanismo de cache en memoria también puede ayudar a mejorar el rendimiento de las consultas para datos accedidos con frecuencia.


Las vistas materializadas son compatibles con varios sistemas de gestión de bases de datos relacionales (RDBMS o DBMS):

Oracle Database: Oracle proporciona Vistas Materializadas como una característica nativa para mejorar el rendimiento de las consultas.
PostgreSQL: PostgreSQL admite Vistas Materializadas a través de la instrucción "CREATE MATERIALIZED VIEW".
Microsoft SQL Server: SQL Server ofrece Vistas Indexadas, que son similares a las vistas materializadas en otras bases de datos.
*/
