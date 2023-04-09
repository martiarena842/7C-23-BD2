-- Active: 1680704245221@@127.0.0.1@3306@sakila
use sakila;

#1
select  title,special_features,rating from film where rating="PG-13";   
#2
select  title,`length` from film ;

#3Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00
select title,rental_rate,replacement_cost from film WHERE replacement_cost >=20 and replacement_cost <=24 ;

#4Show title, category and rating of films that have 'Behind the Scenes' as special_features

select f.title,rating,special_features,c.name as category
 from film f
inner join category c on category_id
where special_features ='Behind the scenes'
;

#5Show first name and last name of actors that acted in 'ZOOLANDER FICTION'
select a.first_name, a.last_name, f.title
from actor as a
inner join film f
where title="ZOOLANDER FICTION";

#6Show the address, city and country of the store with id 1

select a.address , c.city,co.country,s.store_id
from address as a
inner join city c 
inner join country as co 
inner join store s 
where store_id=1;

#7Show pair of film titles and rating of films that have the same rating. 
SELECT  f1.title  , f2.title  ,f1.rating
FROM film f1 , film f2
WHERE f1.rating  =  f2.rating AND f1.film_id <>  f2.film_id
;
#8Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).

select s.first_name,s.last_name,f.title,st.store_id
from staff s
inner join store st on s.staff_id=st.store_id
inner join inventory i on st.store_id=i.store_id
inner join film f on i.film_id=f.film_id
where st.store_id=2;


