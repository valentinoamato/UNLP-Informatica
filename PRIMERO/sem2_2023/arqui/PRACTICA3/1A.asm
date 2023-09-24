;a) * Escribir un programa que encienda las luces con el patrón 11000011, o sea, solo las primeras y las
;últimas dos luces deben prenderse, y el resto deben apagarse.
PB EQU 31H
CB EQU 33H

ORG 2000H
MOV AL, 0
OUT CB, AL

MOV AL,11000011B
OUT PB,AL
HLT
END
