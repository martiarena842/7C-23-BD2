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

#EJERCICIO2




#EJERCICIO 3
select CONCAT (c.first_name,' ',c.last_name)as nombre 
from customer as c
where not exists (
  select *
  from rental r
  where customer_id=r.customer_id)
;
#EJERCICIO4  
SELECT concat(c.first_name, ' ', c.last_name) as full_name
FROM customer c
WHERE NOT EXISTS    (SELECT *
                    FROM rental r
                    WHERE c.customer_id = r.customer_id
);


