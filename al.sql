-- Ejercicio 1

CREATE DATABASE IF NOT EXISTS AL;

USE AL;

DELETE FROM autor;
DELETE FROM libro; 

CREATE TABLE IF NOT EXISTS autor (
	aID	int(10) AUTO_INCREMENT,	
	aNac char(30),
	aNom char(30) NOT NULL,
	aApe char(30) NOT NULL,
	aRes char(30), 	
	PRIMARY KEY (aID)
);



CREATE TABLE IF NOT EXISTS libro (
	lIsbn bigint NOT NULL,
	lTitulo char(40) NOT NULL,
	lEditorial char(30),
	lPrecio float(15),
	PRIMARY KEY (lIsbn)
	); 



CREATE TABLE IF NOT EXISTS escribe (

  autorID int(10),	
  libroID bigint,
	eAño date ,
	PRIMARY KEY (libroID, autorID),
	FOREIGN KEY (libroID) REFERENCES libro (lIsbn)
		ON DELETE cascade ON UPDATE cascade,
	FOREIGN KEY (autorID) REFERENCES autor (aID)
		ON DELETE cascade ON UPDATE cascade
);

-- Ejercicio 2

-- ALTER TABLE autor ADD INDEX (aApe);
-- ALTER TABLE libro ADD INDEX (lTitulo);	

-- Ejercicio 3
INSERT INTO autor (aNac, aNom, aApe, aRes) VALUES('Argentina','Jorge','Borges',NULL),('Argentina','Abelardo','Castillo','Chaco');
INSERT INTO libro VALUES(1234567891,'TBD','UNR',25.50),(1,'Teoria de Tipos y Bananas Explosivas vol.2','LambdaChimp',2);
-- INSERT INTO escribe VALUES(1, 5555555555, 
