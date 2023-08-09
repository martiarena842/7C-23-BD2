-- Active: 1686142519701@@127.0.0.1@3306@sakila

--1
insert into customer 
(store_id, first_name, last_name, email, address_id, active, create_date, last_update)
VALUES
(1,"tomas","martiaren",'martiarenatom@gmail.com',
(select max(a.address_id) AS max_address_id
FROM address a
join city c on a.city_id = c.city_id
join country co on c.country_id = co.country_id
WHERE co.country = 'United States'),1,CURRENT_TIME(),CURRENT_TIMESTAMP
);

--2
insert into rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES
(CURRENT_DATE(),(
    SELECT i.inventory_id
    from inventory i 
    inner join film f on f.film_id=i.film_id
    where f.title="ALLEY EVOLUTION"
    LIMIT 1   ),
1,CURRENT_DATE(),
    (SELECT  staff_id
    from staff
    where store_id=2

    )
);

--3
UPDATE film
SET release_year = CASE rating
        WHEN 'PG' THEN '2004'
        WHEN 'R' THEN '2010'
        WHEN 'G' THEN '2001'
        WHEN 'PG-13' THEN '2007'
        WHEN 'NC-17' THEN '2013'
        ELSE release_year END;

--4
SELECT rental_id from rental WHERE
 return_date is null
order by rental_date desc
 limit 1
;
update rental
set return_date = CURRENT_TIMESTAMP
where rental_id = 14616;

--5
DELETE FROM film
WHERE film_id=123;
/* 
No podemos borrar la pelicula porque hay claves foraneas que estan usando la informacion de esa pelicula, 
por lo que se estan utilizando y no se pueden eliminar por eso
.*/
DELETE FROM rental
WHERE inventory_id in (SELECT inventory_id from inventory where film_id = 321);
DELETE FROM inventory
WHERE film_id = 321;
DELETE FROM payment
WHERE rental_id IN (SELECT rental_id from rental WHERE inventory_id in (
select inventory_id from inventory WHERE film_id = 321)
);
DELETE FROM film_actor
WHERE film_id = 321;
DELETE FROM film_category
WHERE film_id = 321;
/* Y ahora luego de borrar todas las relaciones que estaban usando el film_id 321 puedo finalmente borrar la film con el id=321 */
DELETE FROM film
WHERE film_id = 321;


--6


SELECT i.inventory_id, f.film_id, f.rental_rate
FROM inventory i
JOIN film f on f.film_id = i.film_id
WHERE i.inventory_id not in (
    SELECT iv.inventory_id
    FROM inventory iv
    JOIN rental r ON r.inventory_id = iv.inventory_id
    WHERE r.return_date is null
);
    --inventtory_id=72,film_id=15, amount=2.99

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
values(
    CURRENT_DATE(), 72,
    (select customer_id from customer order by customer_id DESC 
    LIMIT 1),
(select staff_id from staff where store_id = (
    select store_id from inventory where inventory_id = 72)));

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES ((select customer_id from customer LIMIT 1), 
(select staff_id from staff LIMIT 1),
 (select rental_id from rental order by rental_id DESC LIMIT 1),
  2.99, CURRENT_DATE()
  
  );

