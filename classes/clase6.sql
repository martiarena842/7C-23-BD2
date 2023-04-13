-- Active: 1680704245221@@127.0.0.1@3306@sakila
use sakila;

#List all the actors that share the last name. Show them in order
SELECT a.first_name, a.last_name
FROM actor a
WHERE EXISTS (
  SELECT *
  FROM actor b 
  WHERE a.last_name=b.last_name
    AND a.actor_id <> b.actor_id
)
ORDER BY a.last_name ;

#EJERCICIO2 Actors that dont participate in any film
SELECT  a.first_name, a.last_name
FROM actor as a
WHERE NOT EXISTS (
    SELECT 1
    FROM film_actor
    WHERE a.actor_id = film_actor.actor_id
);


#EJERCICIO 3 Find customers that rented only one film
select CONCAT (c.first_name,' ',c.last_name)as nombre_completo
from customer as c
where not exists (
  select *
  from rental r
  where customer_id=r.customer_id)
;
select c.first_name,c.last_name 
from customer as c
where EXISTS
;


#EJERCICIO4  
SELECT concat(c.first_name, ' ', c.last_name) as full_name
FROM customer c
WHERE NOT EXISTS    (SELECT *
                    FROM rental r
                    WHERE c.customer_id = r.customer_id
);


