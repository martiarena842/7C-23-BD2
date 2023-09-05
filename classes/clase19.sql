-- Active: 1686142519701@@127.0.0.1@3306@sakila
create user 'data_analyst'@'localhost' identified BY 'pepe1234';
#2
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';

#3
mysql -u data_analyst -p
USE sakila;
/*
Esto lo hice en la consola y con esto pude iniciar sesion como el user de data_analyst 
*/
CREATE TABLE datanalyst(
    id int PRIMARY KEY 
);  
/*
4
*/
update film
set title="Forest Gump"
where film_id=23
;
/*
5
inicio sesion con root o con otro usuario con los permisos necesarios
*/
REVOKE UPDATE ON sakila.* FROM 'bdi'@'localhost';
/*
6
primero inicio sesion con data analyst y ingreso la contrasenia q cree anteriormente
*/
mysql -u data_analyst -p
USE sakila;
update film
set title="Forest Gump"
where film_id=23
;
/*
Me devuelve un error ya que no tiene los permisos para poder usar el comando UPDATE por que se lo quitamos:
-- ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'
*/
