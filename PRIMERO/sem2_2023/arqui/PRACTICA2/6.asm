;6) * Escribir un programa que solicite el ingreso de un número (de un dígito) por teclado y muestre en pantalla dicho
;número expresado en letras. Luego que solicite el ingreso de otro y así sucesivamente. Se debe finalizar la ejecución al
;ingresarse en dos vueltas consecutivas el número cero.
ORG 1000H
NUMERO DB "CERO  " ; Todos los nombres tienen 6 caracteres para
DB "UNO   " ; facilitar posicionarnos al imprimir el nombre del numero
DB "DOS   "
DB "TRES  "
DB "CUATRO"
DB "CINCO "
DB "SEIS  "
DB "SIETE "
DB "OCHO  "
DB "NUEVE "
MSJ DB " INGRESE UN NUMERO:"
ERROR DB "CARACTER INVALIDO."
FIN DB ?

ORG 1500H
NUM DB ?

ORG 2000H
MOV CX,00H
BUCLE:MOV BX, OFFSET MSJ
MOV AL, OFFSET ERROR-OFFSET MSJ
INT 7
MOV BX, OFFSET NUM
INT 6
INC CL
CMP NUM,30H ;SI EL NUMERO NO ES 0 PONGO 0 CX SINO LE SUMO 1
JZ ES_CERO
MOV CL,00H
ES_CERO:
CALL ES_NUM
CMP AL,0FFH
JZ ES_NUMERO
MOV BX, OFFSET ERROR
MOV AL, OFFSET FIN - OFFSET ERROR
JMP IMPRIMIR
ES_NUMERO:
MOV BX, OFFSET NUMERO
MOV AL, 6
BUCLE_SUMA: CMP NUM,30H
JZ IMPRIMIR
ADD BX,6
DEC NUM
JMP BUCLE_SUMA

IMPRIMIR:
INT 7
CMP CL,2
JNZ BUCLE
INT 0

ORG 3000H
ES_NUM: MOV AH,[BX]
MOV AL,00H
CMP AH,30H
JS RETORNAR
CMP AH,3AH
JNS RETORNAR
MOV AL,0FFH
RETORNAR:
MOV AH,00H
RET
END
