SELECT nombre, edad, raza, peso, telefonoContacto
FROM Mascota NATURAL JOIN Supervision NATURAL JOIN Veterinario
WHERE nombYAp = 'Oscar Lopez'
ORDER BY nombre, raza;
