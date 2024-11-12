SELECT patente, modelo, marca, peso, km, largo, max_toneladas, cant_ruedas, tiene_acoplado
FROM Vehiculo NATURAL JOIN Camion NATURAL JOIN Service
WHERE fecha >= CURRENT_DATE - INTERVAL '365 days' AND (cant_ruedas >= 4 OR cant_ruedas <= 8);
