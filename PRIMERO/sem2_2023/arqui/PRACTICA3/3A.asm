;a) * Escribir un programa que imprime “INGENIERIA E INFORMATICA” en la impresora a través del
;HAND-SHAKE. La comunicación se establece por consulta de estado (polling). ¿Qué diferencias
;encuentra con el ejercicio 2b?
DATO EQU 40H
ESTADO EQU 41H

ORG 1000H
STR DB "INGENIERIA E INFORMATICA"
FIN DB ?

ORG 2000H
;CONFIGURACION ESTADO
IN AL,ESTADO
AND AL,01111111B; I->0
OUT ESTADO,AL
;IMPRESION
MOV BX,OFFSET STR
MOV CL,OFFSET FIN-OFFSET STR
LOOP:
IN AL,ESTADO
AND AL,1;GUARDO EN AL BUSY
JNZ LOOP;SI B=1
;IMPRESION DEL CARACTER
MOV AL,[BX]
OUT DATO,AL
;CX BX
INC BX
DEC CL
JNZ LOOP

INT 0
END
