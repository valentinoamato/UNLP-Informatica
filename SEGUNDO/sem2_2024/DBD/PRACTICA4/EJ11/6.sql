SELECT nroBox, m2, ubicacion, capacidad, nombre
FROM Box NATURAL JOIN Supervision NATURAL JOIN Mascota
WHERE fechaEntra >= '2024-1-1' AND fechaEntra <= '2024-12-31';
