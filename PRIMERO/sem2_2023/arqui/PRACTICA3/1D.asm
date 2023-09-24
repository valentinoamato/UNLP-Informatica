;d) * Escribir un programa que implemente un encendido y apagado sincronizado de las luces. Un contador,
;que inicializa en cero, se incrementa en uno una vez por segundo. Por cada incremento, se muestra a
;través de las luces, prendiendo solo aquellas luces donde el valor de las llaves es 1. Entonces, primero
;se enciende solo la luz de más a la derecha, correspondiente al patrón 00000001. Luego se continúa con
;los patrones 00000010, 00000011, y así sucesivamente. El programa termina al llegar al patrón
;11111111.
PB EQU 31H
CB EQU 33H

ORG 2000H
;CONFIGURACION DE PB COMO SALIDA
MOV AL, 0
OUT CB, AL
;MAIN LOOP
LOOP:
OUT PB,AL
INC AL
JNC LOOP
HLT
END
