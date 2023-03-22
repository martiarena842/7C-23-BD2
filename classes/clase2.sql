# 7C-23-BD2

use imdb;
create table film( id int AUTO_INCREMENT primary key,nombre VARCHAR(30),description varchar(100),release_year YEAR);

create table actor(id int AUTO_INCREMENT primary key,first_name varchar(30),last_name VARCHAR(40));
create table film_actor(id int AUTO_INCREMENT PRIMARY key);

ALTER TABLE film
ADD last_update varchar(20);

ALTER TABLE actor
ADD last_update varchar(20);

alter table film_actor add actor_id int ;
alter table film_actor ADD FOREIGN key (actor_id)REFERENCES actor(id);

alter table film_actor add film_id int;
alter table film_actor add foreign key(film_id)REFERENCES film(id);


INSERT INTO actor (first_name, last_name)
VALUES
  ('Tom', 'Hanks'),
  ('Harry', 'Popotter'),
  ('ROBERTO', 'De Niro'),
  ('LEO', 'DICAPRIO');

INSERT INTO film (nombre, description, release_year)
VALUES
  ('Forrest Gump', 'mejor pelicula, un chico con poco iq es bueno en todo lo que hace', 1994),
  ('el padrino', 'Un padrino no se hace cargo del sobrino', 1972),
  ('toy stori', 'Un juguete revive y esta vivo', 2015);

INSERT INTO film_actor (actor_id, film_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 3)
  
