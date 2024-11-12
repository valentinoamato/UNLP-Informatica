SELECT patente, modelo, marca, peso, km, es_electrico, tipo_motor
FROM Vehiculo NATURAL JOIN Auto NATURAL JOIN Service NATURAL JOIN Service_Parte NATURAL JOIN Parte
WHERE (km_service < 13000 AND descripcion = 'cambio de aceite') OR (descripcion = 'inspeccion general' AND nombre = 'filtro de combustible');
