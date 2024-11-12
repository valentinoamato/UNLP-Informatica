CREATE TEMP TABLE  Patentes_a_eliminar AS
    SELECT patente
    FROM Vehiculo NATURAL JOIN Camion
    WHERE km > 250000;

DELETE
FROM Camion
WHERE patente IN (SELECT patente FROM Patentes_a_eliminar);

DELETE
FROM Vehiculo
WHERE patente IN (SELECT patente FROM Patentes_a_eliminar);

DROP TABLE Patentes_a_eliminar;
