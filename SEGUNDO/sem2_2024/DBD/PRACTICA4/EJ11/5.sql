SELECT nombre, edad, raza, peso
FROM Mascota NATURAL JOIN Supervision
WHERE matricula = 'MP 1000'
INTERSECT
SELECT nombre, edad, raza, peso
FROM Mascota NATURAL JOIN Supervision
WHERE matricula = 'MN 4545';
