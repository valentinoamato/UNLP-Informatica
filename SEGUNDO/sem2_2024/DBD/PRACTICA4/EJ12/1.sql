SELECT nombYAp, direccionC, celular
FROM Cliente NATURAL JOIN Atencion
EXCEPT
SELECT nombYAp, direccionC, celular
FROM Cliente NATURAL JOIN Atencion
WHERE fecha >= '2024-1-1' AND fecha <= '2024-12-31';
