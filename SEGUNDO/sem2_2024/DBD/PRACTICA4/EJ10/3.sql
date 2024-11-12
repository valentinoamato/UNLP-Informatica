SELECT nombre, precio_parte
FROM Parte NATURAL JOIN Service_Parte
WHERE precio > 4000
GROUP BY cod_parte, nombre, precio_parte
HAVING count(*) > 30;
