SELECT nombreEntrenador, fechaNacimiento, direccion 
FROM Entrenador NATURAL JOIN Entrenamiento e
WHERE e.fecha >= '2023-1-1' AND e.fecha <= '2023-12-1';
