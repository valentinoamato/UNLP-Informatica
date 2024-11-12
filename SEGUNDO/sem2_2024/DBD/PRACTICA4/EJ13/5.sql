SELECT nombreClub, ciudad
FROM Entrenador NATURAL JOIN Entrenamiento NATURAL JOIN Cancha NATURAL JOIN Complejo NATURAL JOIN Club
WHERE nombreEntrenador = 'Marcos Perez';
