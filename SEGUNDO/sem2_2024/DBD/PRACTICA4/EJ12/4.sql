SELECT DNIB, nombYApB, direccionB, telefonoContacto, mail
FROM Barbero NATURAL JOIN Atencion
WHERE valor > 5000;
