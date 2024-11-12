SELECT DNI, nombYAP, direccionC, fechaNacimiento, celular
FROM Cliente NATURAL JOIN Atencion NATURAL JOIN Barberia
WHERE razon_social = 'Corta barba'
INTERSECT
SELECT DNI, nombYAP, direccionC, fechaNacimiento, celular
FROM Cliente NATURAL JOIN Atencion NATURAL JOIN Barberia
WHERE razon_social = 'Barberia Barbara';
