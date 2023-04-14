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
SELECT c1.first_name, c1.last_name FROM customer c1
WHERE (SELECT count(*) FROM rental r WHERE c1.customer_id = r.customer_id)=1;


#EJERCICIO4  Find customers that rented more than one film
SELECT c.first_name, c.last_name FROM customer c
WHERE (SELECT count(*) FROM rental r WHERE c.customer_id = r.customer_id)>1;


#EJ5 List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'
SELECT a.first_name, a.last_name
FROM actor as a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor as fa
    WHERE fa.film_id IN (
        SELECT f.film_id
        FROM film as f
        WHERE f.title IN ('BETRAYED REAR', 'CATCH AMISTAD')
    )
)
;
