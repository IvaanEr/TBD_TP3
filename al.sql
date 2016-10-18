-- Ejercicio 1

CREATE DATABASE IF NOT EXISTS AL;

USE AL;

DROP TABLE escribe, autor, libro;

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

ALTER TABLE autor ADD INDEX (aApe);
ALTER TABLE libro ADD INDEX (lTitulo);	

-- Ejercicio 3
INSERT INTO autor (aNac, aNom, aApe, aRes) VALUES('Peru','Gato','Conbotas',NULL),('Argentina','Abelardo','Castillo','Chaco');
INSERT INTO libro VALUES(2,'TBD','UNR',250),(1,'Teoria de Tipos y Bananas Explosivas vol.2','LambdaChimp',200);
INSERT INTO escribe VALUES(1,1,'1998-01-11'),(2,2,'1945-09-11');

-- Ejercicio 4
UPDATE autor SET aRes = 'Buenos Aires'
						 WHERE aNom = 'Abelardo' AND aApe = 'Castillo';

-- UPDATE libro SET lPrecio = ((10*lPrecio)/100) + lPrecio
		--				 WHERE lEditorial = 'UNR';

UPDATE libro SET lPrecio = CASE WHEN lPrecio <= 200 THEN((20*lPrecio)/100) + lPrecio ELSE ((10*lPrecio)/100) + lPrecio END
						 WHERE lIsbn IN (SELECT libroID FROM autor,escribe
																						WHERE aID = autorID AND
												     										  aNac <> 'Argentina');

DELETE FROM libro WHERE lIsbn IN (SELECT libroID FROM escribe
																									WHERE YEAR(eAño) = '1998');
