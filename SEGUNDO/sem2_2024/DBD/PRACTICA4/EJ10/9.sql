SELECT patente, modelo, marca, peso, km
FROM Vehiculo NATURAL JOIN Service
WHERE EXTRACT(YEAR FROM fecha) = 2024;
