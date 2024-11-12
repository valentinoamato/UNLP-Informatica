SELECT V.matricula, V.CUIT, V.nombYAp, direccion, telefono, count(S.matricula)
FROM Veterinario V LEFT OUTER JOIN Supervision S ON V.matricula = S.matricula AND S.fechaSale >= '2024-1-1' AND S.fechaSale <= '2024-1-31'
GROUP BY V.matricula, V.CUIT, V.nombYAp, direccion, telefono;
