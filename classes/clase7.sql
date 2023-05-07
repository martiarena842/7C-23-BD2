-- Active: 1680704245221@@127.0.0.1@3306@sakila
use sakila;
#EJERCICIO1
SELECT f.title, f.rating
FROM film as f
WHERE f.length <= (select min(length) from film);


#EJERCICO2

SELECT f1.title, f1.rating, f1.length
FROM film AS f1
WHERE f1.length <= (SELECT MIN(f2.length) FROM film AS f2)
  AND NOT EXISTS(
    SELECT * FROM film AS f3
    WHERE f3.film_id <> f1.film_id AND f3.length <= f1.length
);


#EJERCICIO3
SELECT c1.first_name, c1.last_name, a1.address, MIN(p.amount) AS lowest_payment
FROM customer AS c1
JOIN address AS a1 ON c1.address_id = a1.address_id
JOIN payment AS p ON c1.customer_id = p.customer_id
WHERE p.amount = ALL (
  SELECT MIN(amount)
  FROM payment
  WHERE customer_id = c1.customer_id
)
group by first_name,last_name,a1.address;


#EJERCICIO4

SELECT  c1.first_name, c1.last_name, a1.address ,
MIN(p.amount) AS lowest_payment,
MAX(p.amount) AS highest_payment
FROM customer AS c1
inner JOIN address AS a1 ON c1.address_id = a1.address_id
inner JOIN payment AS p ON c1.customer_id = p.customer_id
GROUP BY  c1.first_name, c1.last_name, a1.address, c1.customer_id;







