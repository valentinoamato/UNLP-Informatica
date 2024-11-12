SELECT nombreCancha, count(IdEntrenamiento)
FROM Complejo LEFT OUTER JOIN Cancha ON Complejo.IdComplejo = Cancha.IdComplejo LEFT OUTER JOIN Entrenamiento ON Cancha.IdCancha = Entrenamiento.IdCancha
WHERE Complejo.nombreComplejo = 'Complejo 1'
GROUP BY Cancha.IdCancha, Cancha.nombreCancha;
