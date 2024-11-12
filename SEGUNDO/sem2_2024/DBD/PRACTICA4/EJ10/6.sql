SELECT patente, modelo, marca, peso
FROM Vehiculo NATURAL JOIN Auto
WHERE es_electrico;
