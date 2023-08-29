-- Active: 1686142519701@@127.0.0.1@3306@sakila

SELECT * from address a
INNER JOIN city c ON a.city_id = c.city_id
inner join country co on co.country_id=c.country_id
where a.postal_code IN('4166','77459')
   
;
#Execution time: 8ms

SELECT * from address a
INNER JOIN city c ON a.city_id = c.city_id
inner join country co on co.country_id=c.country_id
where a.postal_code not IN('4166','77459')

#Execution time: 53ms

CREATE INDEX indexej1 ON address (postal_code);

/*
despues de crear el index el tiempo de respuesta de la primer query paso a ser de :
5ms y la de la segunda query:
17ms

Esto pasa por que creamos un index que funciona justo en nuestra query para asi poder optimizar el tiempo de respuesta que en este caso no es mucho pero en proyectos mas grandes 
si es necesario para bajar el tiempo de carga
*/

#2
select first_name from actor;
select last_name from actor;
/*  
En este caso la query de first_name tarda 9ms y la de last_name tarda 5ms
esto por mas que no se note la diferencia visualmente es por que last_name tiene un INDEX que se puede ver al ejecutar:
SHOW INDEX in actor;
este index funciona igual que el del ejercicio anterior, basicamnete el index permite que la base de datos 
encuentre los valores mucho mas rapido En vez de tener que revisar toda la tabla buscando last_name uno por uno,
la base de datos puede usar este index para saltar directamente a las ubicaciones donde se encuentran los last_name

*/

#3
ALTER TABLE film
    ADD FULLTEXT (description);
SELECT description						
FROM film
WHERE description like '%Epic%';

SELECT description									
FROM film
WHERE MATCH(description) AGAINST('%Epic%');

/*
La diferencia es infima ya que son querys que no necesitan muchos recursos
El indice FULLTEXT es un tipo especial de indice que esta diseñado especificamente para realizar busquedas de texto completo de manera eficiente. 
Fulltext se optimiza para buscar cierta palabras o frases en textos largos, por lo que en este caso nos serviria para optimizar la buqsueda
de las caracteristicas que estamos buscando en la descripcion y asi FULLTEXT nos da mas rapidez a la hora de filtrar datos
*/