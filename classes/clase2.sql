# 7C-23-BD2
Create a new database called imdb
Create tables: film (film_id, title, description, release_year); actor (actor_id, first_name, last_name) , film_actor (actor_id, film_id)
Use autoincrement id
Create PKs
Alter table add column last_update to film and actor
Alter table add foreign keys to film_actor table
Insert some actors, films and who acted in each film

use imdb;
create table film( id int AUTO_INCREMENT primary key,nombre VARCHAR(30),description varchar(100),release_year YEAR);

create table actor(id int AUTO_INCREMENT primary key,first_name varchar(30),last_name VARCHAR(40));
create table film_actor(id int AUTO_INCREMENT PRIMARY key,actor_id int,film_id int,
constraint FOREIGN key (actor_id)REFERENCES actor(id),
constraint FOREIGN key (film_id)REFERENCES film(id));

INSERT INTO actor (first_name, last_name)
VALUES
  ('Tom', 'Hanks'),
  ('Harry', 'Popotter'),
  ('ROBERTO', 'De Niro'),
  ('LEO', 'DICAPRIO');

-- Insert some films
INSERT INTO film (nombre, description, release_year)
VALUES
  ('Forrest Gump', 'mejor pelicula, un chico con poco iq es bueno en todo lo que hace', 1994),
  ('el padrino', 'Un padrino no se hace cargo del sobrino', 1972),
  ('toy stori', 'Un juguete revive y esta vivo', 2015);

-- Insert some film_actor relationships
INSERT INTO film_actor (actor_id, film_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 2)
  
