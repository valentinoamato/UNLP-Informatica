SELECT matricula, CUIT, nombYAp, direccion, telefono
FROM Veterinario NATURAL JOIN Supervision
WHERE fechaSale IS NULL;
