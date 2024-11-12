DELETE
FROM Entrenamiento
WHERE IdEntrenador = (
    SELECT IdEntrenador
    FROM Entrenador
    WHERE nombreEntrenador = 'Juan Perez');

