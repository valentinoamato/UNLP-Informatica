;b) * Escribir un programa que verifique si la llave de más a la izquierda está prendida. Si es así, mostrar en
;pantalla el mensaje “Llave prendida”, y de lo contrario mostrar “Llave apagada”. Solo importa el valor
;de la llave de más a la izquierda (bit más significativo). Recordar que las llaves se manejan con las
;teclas 0-7.
PA EQU 30H
CA EQU 32H

ORG 1000H
MSJ1 DB "LLAVE PRENDIDA"
MSJ2 DB "LLAVE APAGADA"
FIN DB ?

ORG 2000H
MOV AL, 0FFH
OUT CA, AL

IN AL,PA
AND AL,10000000B
CMP AL,0
JZ APAGADO
MOV BX, OFFSET MSJ1
MOV AL, OFFSET MSJ2-OFFSET MSJ1
JMP IMPRIMIR
APAGADO:
MOV BX, OFFSET MSJ2
MOV AL, OFFSET FIN-OFFSET MSJ2
IMPRIMIR: INT 7
HLT
END
