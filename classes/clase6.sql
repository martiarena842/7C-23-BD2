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

#EJ6 List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'

SELECT a.first_name, a.last_name 
FROM actor as a
WHERE EXISTS 
(SELECT * FROM film f JOIN film_actor fa on f.film_id = fa.film_id
WHERE f.film_id = fa.film_id AND a.actor_id = fa.actor_id AND 
(f.title = 'BETRAYED REAR' AND  f.title != 'CATCH AMISTAD'));

#EJ7 List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'


SELECT CONCAT(a.first_name,' ',a.last_name) as nombre_completo
FROM actor a
WHERE EXISTS (SELECT * FROM film f JOIN film_actor fa ON f.film_id = fa.film_id 
WHERE fa.actor_id = a.actor_id AND f.title = 'BETRAYED REAR')
AND EXISTS (SELECT * FROM film f JOIN film_actor fa ON f.film_id = fa.film_id 
WHERE fa.actor_id = a.actor_id AND f.title = 'CATCH AMISTAD');



#EJ8 List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'
SELECT a.first_name, a.last_name,a.actor_id
FROM actor  a
WHERE NOT EXISTS (
  SELECT *
  FROM film as f 
  JOIN film_actor fa ON f.film_id = fa.film_id
  WHERE fa.actor_id = a.actor_id 
  AND (f.title = 'BETRAYED REAR' OR f.title = 'CATCH AMISTAD')
);

