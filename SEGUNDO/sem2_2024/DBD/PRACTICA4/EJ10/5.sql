SELECT nombre, precio_parte
FROM Parte
WHERE NOT EXISTS (

    SELECT *
    FROM Service
    WHERE EXTRACT(YEAR FROM fecha) = EXTRACT(YEAR FROM CURRENT_DATE) AND NOT EXISTS (

        SELECT *
        FROM Service_Parte
        WHERE (Parte.cod_parte = Service_Parte.cod_parte AND Service_Parte.fecha = Service.fecha AND Service_Parte.patente = Service.patente)));
