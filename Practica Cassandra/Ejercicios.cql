--- Q1: Devolver los datos de los clientes que tengan menos de 25 años de una zona dada.
CREATE TABLE tareacassandra.Clientes (nombre text, apellidos text, email text, edad tinyint, zona text, PRIMARY KEY((edad),email));

INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Juan','Martinez','juan@email.com',18,'Norte'); 
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Maria','Garcia','maria@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Domingo','','domingo@email.com',32,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Roberto','Lujan','roberto@email.com',21,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Mario','Garcia','mario@email.com',25,'Sur');

SELECT * FROM tareacassandra.Clientes WHERE zona = 'Norte' AND edad < 25 ALLOW FILTERING;

-- Q2: Devolver todos los datos de un cliente a partir de su e-mail. 
DROP TABLE tareacassandra.Clientes;
CREATE TABLE tareacassandra.Clientes (nombre text, apellidos text, email text, edad tinyint, zona text, PRIMARY KEY(email));

INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Juan','Martinez','juan@email.com',18,'Norte'); 
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Maria','Garcia','maria@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Domingo','','domingo@email.com',32,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Roberto','Lujan','roberto@email.com',21,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Mario','Garcia','mario@email.com',25,'Sur');

SELECT * FROM tareacassandra.Clientes WHERE email = 'maria@email.com';


-- Q3: Devolver el número de clientes que hay en una zona dada.
DROP TABLE tareacassandra.Clientes;
CREATE TABLE tareacassandra.Clientes (email text, zona text, PRIMARY KEY((zona),email));

INSERT INTO tareacassandra.Clientes (email,zona) VALUES ('juan@email.com','Norte');
INSERT INTO tareacassandra.Clientes (email,zona) VALUES ('maria@email.com','Sur');
INSERT INTO tareacassandra.Clientes (email,zona) VALUES ('domingo@email.com','Norte');
INSERT INTO tareacassandra.Clientes (email,zona) VALUES ('roberto@email.com','Norte');
INSERT INTO tareacassandra.Clientes (email,zona) VALUES ('mario@email.com','Sur');

SELECT COUNT(*) FROM tareacassandra.Clientes WHERE zona = 'Norte';


--Q4: Devolver todos los datos del cliente de mayor edad de una zona dada.
DROP TABLE tareacassandra.Clientes;
CREATE TABLE tareacassandra.Clientes (nombre text, apellidos text, email text, edad tinyint, zona text, PRIMARY KEY((zona),edad,email));

INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Juan','Martinez','juan@email.com',18,'Norte'); 
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Maria','Garcia','maria@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Domingo','','domingo@email.com',32,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Roberto','Lujan','roberto@email.com',21,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Mario','Garcia','mario@email.com',25,'Sur');

SELECT * FROM tareacassandra.Clientes WHERE zona = 'Norte' ORDER BY edad DESC LIMIT 1;


--Q5: Calcular la media de edad de los clientes de una zona dada.
DROP TABLE tareacassandra.Clientes;
CREATE TABLE tareacassandra.Clientes (email text,edad tinyint, zona text, PRIMARY KEY((zona),email));

INSERT INTO tareacassandra.Clientes (email,edad,zona) VALUES ('juan@email.com',18,'Norte');
INSERT INTO tareacassandra.Clientes (email,edad,zona) VALUES ('maria@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (email,edad,zona) VALUES ('domingo@email.com',32,'Norte');
INSERT INTO tareacassandra.Clientes (email,edad,zona) VALUES ('roberto@email.com',21,'Norte');
INSERT INTO tareacassandra.Clientes (email,edad,zona) VALUES ('mario@email.com',25,'Sur');

SELECT AVG(edad) AS media_de_edad FROM tareacassandra.Clientes WHERE zona = 'Norte';


-- Q6: Devolver los datos de los clientes de una zona dada cuyo nombre coincida con un determinado valor, ordenados alfabéticamente por apellidos.
DROP TABLE tareacassandra.Clientes;
CREATE TABLE tareacassandra.Clientes (nombre text, apellidos text, email text, edad tinyint, zona text, PRIMARY KEY((zona),nombre,apellidos,email));

INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Juan','Martinez','juan@email.com',18,'Norte'); 
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Maria','Garcia','maria@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Domingo','','domingo@email.com',32,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Roberto','Lujan','roberto@email.com',21,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Mario','Garcia','mario@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Juan','Gonzalez','juanzzz@email.com',18,'Norte'); 

SELECT * FROM tareacassandra.Clientes WHERE zona = 'Norte' AND nombre = 'Juan';


-- Q7: Devolver los datos de los clientes de una edad yn nombre dados.

DROP TABLE tareacassandra.Clientes;
CREATE TABLE tareacassandra.Clientes (nombre text, apellidos text, email text, edad tinyint, zona text, PRIMARY KEY((nombre),edad,email));

INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Juan','Martinez','juan@email.com',18,'Norte'); 
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Maria','Garcia','maria@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Domingo','','domingo@email.com',32,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Roberto','Lujan','roberto@email.com',21,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Mario','Garcia','mario@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Juan','Gonzalez','juanzzz@email.com',18,'Norte'); 

SELECT * FROM tareacassandra.Clientes WHERE nombre = 'Juan' AND edad = 18;

--Escribe la operación de actualización que cambie los apellidos a ‘Alarcón’ de un cliente que tenga exactamente 21 años, cuya zona sea ‘Norte’ y el email sea ‘roberto@email.com’.
DROP TABLE tareacassandra.Clientes;
CREATE TABLE tareacassandra.Clientes (apellidos text, email text, edad tinyint, zona text, PRIMARY KEY((edad),zona,email));

INSERT INTO tareacassandra.Clientes (apellidos,email,edad,zona) VALUES ('Martinez','juan@email.com',18,'Norte'); 
INSERT INTO tareacassandra.Clientes (apellidos,email,edad,zona) VALUES ('Garcia','maria@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (apellidos,email,edad,zona) VALUES ('','domingo@email.com',32,'Norte');
INSERT INTO tareacassandra.Clientes (apellidos,email,edad,zona) VALUES ('Lujan','roberto@email.com',21,'Norte');
INSERT INTO tareacassandra.Clientes (apellidos,email,edad,zona) VALUES ('Garcia','mario@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (apellidos,email,edad,zona) VALUES ('Gonzalez','juanzzz@email.com',18,'Norte'); 

UPDATE tareacassandra.Clientes SET apellidos = 'Alarcon' WHERE edad = 21 AND zona = 'Norte' AND email = 'roberto@email.com';
SELECT * FROM tareacassandra.Clientes;


--Crea una vista materializada que almacene los datos de los clientes mayores o iguales de 18 años y menores o iguales de 30 años.
DROP TABLE tareacassandra.Clientes;
CREATE TABLE tareacassandra.Clientes (nombre text, apellidos text, email text, edad tinyint, zona text, PRIMARY KEY((edad),email));

INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Juan','Martinez','juan@email.com',18,'Norte'); 
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Maria','Garcia','maria@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Domingo','','domingo@email.com',32,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Roberto','Lujan','roberto@email.com',21,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Mario','Garcia','mario@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Juan','Gonzalez','juanzzz@email.com',18,'Norte'); 

CREATE MATERIALIZED VIEW tareacassandra.Clientes18_30 AS SELECT * FROM tareacassandra.Clientes WHERE edad >= 18 AND edad <= 30  PRIMARY KEY (nombre,apellidos,email);

-- Realiza una consulta de todos los resultados de esta vista.
SELECT * FROM tareacassandra.Clientes18_30;
--SELECT * FROM tareacassandra.Clientes WHERE edad >= 18 AND edad <= 30 ALLOW FILTERING;


-- Borra los datos del cliente que se llama ‘Mario García’
DROP TABLE tareacassandra.Clientes;

CREATE TABLE tareacassandra.Clientes (nombre text, apellidos text, email text, edad tinyint, zona text, PRIMARY KEY((nombre),apellidos,email));

INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Juan','Martinez','juan@email.com',18,'Norte'); 
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Maria','Garcia','maria@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Domingo','','domingo@email.com',32,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Roberto','Lujan','roberto@email.com',21,'Norte');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Mario','Garcia','mario@email.com',25,'Sur');
INSERT INTO tareacassandra.Clientes (nombre,apellidos,email,edad,zona) VALUES ('Juan','Gonzalez','juanzzz@email.com',18,'Norte'); 

SELECT * FROM tareacassandra.Clientes;
DELETE FROM tareacassandra.Clientes WHERE nombre = 'Mario' AND apellidos = 'Garcia';
SELECT * FROM tareacassandra.Clientes;
