SELECT razon_social, direccion, telefono
FROM Barberia NATURAL JOIN Atencion NATURAL JOIN Cliente
WHERE DNI = '22283566'
ORDER BY razon_social, direccion;
