-- Active: 1686142519701@@127.0.0.1@3306@sakila

--4Find all the film titles that are not in the inventory
SELECT f.title
from film f
WHERE NOT EXISTS(SELECT i.film_id from inventory i where f.film_id=i.film_id);

--5Find all the films that are in the inventory but were never rented.
SELECT f.title,i2.inventory_id
from film f
         inner join inventory i2 on f.film_id = i2.film_id
WHERE EXISTS(select i.film_id
             from inventory as i
             where i.film_id = f.film_id
AND NOT EXISTS (select r.inventory_id from rental r where r.inventory_id=i.inventory_id))
;

--6Generate a report with:

select c.first_name, c.last_name, s.store_id, f.title
from customer as c
inner join store s on c.store_id = s.store_id
inner join inventory i on s.store_id = i.store_id
inner join film f on i.film_id = f.film_id
where exists(select r.customer_id from rental as r where c.customer_id = r.customer_id and r.return_date is not null);

--7show sales per store
SELECT s.store_id, SUM(p.amount),CONCAT(st.first_name ," , ",st.last_name)as nombres, CONCAT(co.country," , ",c.city) as ciudad
FROM store s
INNER JOIN staff st ON st.store_id=s.store_id
INNER JOIN payment p ON p.staff_id = st.staff_id
INNER JOIN address a on a.address_id=s.address_id
INNER JOIN city c on c.city_id=a.city_id
INNER JOIN country co on co.country_id=c.country_id
GROUP BY s.store_id,ciudad,nombres ;
;
--8Which actor has appeared in the most films?
SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) AS film_count
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_count DESC
LIMIT 1 ;

