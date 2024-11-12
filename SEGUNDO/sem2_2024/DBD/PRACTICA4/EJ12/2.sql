SELECT B.DNIB, B.nombYApB, B.direccionB, B.telefonoContacto, B.mail, count(A.codEmpleado)
FROM Barbero B LEFT OUTER JOIN Atencion A ON B.codEmpleado = A.codEmpleado AND fecha >= '2023-1-1' AND fecha <= '2023-12-31'
GROUP BY B.codEmpleado, B.DNIB, B.nombYApB, B.direccionB, B.telefonoContacto, B.mail;
