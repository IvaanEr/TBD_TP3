-- EJERCICIO 5

-- A_

SELECT DISTINCT nombre,apellido FROM Persona,PoseeInmueble WHERE codigo = codigo_propietario;


-- B_

SELECT codigo FROM Inmueble WHERE precio >= 600000 AND precio <= 700000;

-- C_

SELECT nombre,apellido FROM Persona,PrefiereZona WHERE nombre_poblacion = 'Santa Fe' AND nombre_zona = 'Norte' AND codigo = codigo_cliente;

-- D_

SELECT nombre, apellido FROM Persona WHERE codigo IN (SELECT vendedor FROM Cliente,PrefiereZona WHERE nombre_poblacion = 'Rosario' AND nombre_zona = 'Centro' AND codigo = codigo_cliente);

-- E_

SELECT nombre, apellido FROM Persona WHERE codigo IN (SELECT vendedor FROM Cliente WHERE codigo IN ( SELECT codigo FROM Vendedor ));

-- F_

SELECT nombre,apellido FROM Persona WHERE codigo IN (SELECT codigo_cliente FROM PrefiereZona WHERE nombre_poblacion = 'Rosario' GROUP BY codigo_cliente HAVING COUNT(DISTINCT nombre_zona) = (SELECT COUNT(DISTINCT nombre_zona) FROM Inmueble WHERE nombre_poblacion = 'Rosario'));

-- G_

CREATE OR REPLACE VIEW Ci (codigo_cliente, codigo) AS SELECT codigo_cliente, codigo FROM PrefiereZona,Inmueble WHERE PrefiereZona.nombre_poblacion = Inmueble.nombre_poblacion AND PrefiereZona.nombre_zona = Inmueble.nombre_zona;

CREATE OR REPLACE VIEW VisitAll (codigo_cliente) AS SELECT DISTINCT codigo_cliente FROM PrefiereZona WHERE NOT EXISTS (SELECT * FROM Ci WHERE PrefiereZona.codigo_cliente = Ci.codigo_cliente AND NOT EXISTS (SELECT * FROM Visitas WHERE Ci.codigo_cliente = Visitas.codigo_cliente AND Visitas.codigo_inmueble = Ci.codigo));

CREATE OR REPLACE VIEW VAPref (poblacion,zona) AS SELECT nombre_poblacion, nombre_zona from PrefiereZona, VisitAll where VisitAll.codigo_cliente = PrefiereZona.codigo_cliente;

CREATE OR REPLACE VIEW Aux (poblacion,zona,poblacion_2,zona_2) AS (SELECT Zona.nombre_poblacion,Zona.nombre_zona,Limita.nombre_poblacion_2,Limita.nombre_zona_2 FROM Zona,Limita WHERE Zona.nombre_poblacion = Limita.nombre_poblacion AND Zona.nombre_zona = Limita.nombre_zona) UNION (SELECT Zona.nombre_poblacion,Zona.nombre_zona,Limita.nombre_poblacion,Limita.nombre_zona FROM Zona,Limita WHERE Zona.nombre_poblacion = Limita.nombre_poblacion_2 AND Zona.nombre_zona = Limita.nombre_zona_2);

CREATE OR REPLACE VIEW Aux2 (cliente,poblacion,zona) AS (SELECT PrefiereZona.codigo_cliente,nombre_poblacion,nombre_zona FROM PrefiereZona,VisitAll WHERE PrefiereZona.codigo_cliente = VisitAll.codigo_cliente);

SELECT cliente,poblacion_2,zona_2 FROM Aux,Aux2 WHERE Aux.poblacion = Aux2.poblacion AND Aux.zona = Aux2.zona;