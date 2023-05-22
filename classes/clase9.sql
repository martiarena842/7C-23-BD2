-- Active: 1680704245221@@127.0.0.1@3306@sakila

#1
SELECT country.country, country.country_id, COUNT(city.city_id) AS CIUDADES
FROM country
inner JOIN city ON country.country_id = city.country_id
GROUP BY country.country, country.country_id
ORDER BY country.country, country.country_id;

#2
SELECT country.country, COUNT(city.city_id) AS contador_cities
FROM country
JOIN city ON country.country_id = city.country_id
GROUP BY country.country
HAVING contador_cities > 10
ORDER BY contador_cities DESC;

#3
SELECT c.first_name, c.last_name, a.address,
       COUNT(r.rental_id) AS peliculasrentadas,
       SUM(p.amount) AS gasto_total
FROM customer AS c
INNER JOIN address AS a ON c.address_id = a.address_id
INNER JOIN rental AS r ON c.customer_id = r.customer_id
INNER JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.address
ORDER BY gasto_total DESC;

#4
SELECT category.name, AVG(film.length) AS duracion_promedio
FROM category
JOIN film_category ON category.category_id = film_category.category_id

JOIN film ON film_category.film_id = film.film_id
GROUP BY category.category_id, category.name
ORDER BY duracion_promedio DESC;

#5
SELECT film.rating, COUNT(payment.payment_id) AS ventas
FROM film
 JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
    JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY film.rating
ORDER BY sales DESC;
