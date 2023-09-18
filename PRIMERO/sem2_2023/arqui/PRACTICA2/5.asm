;5) Modificar el programa anterior agregando una subrutina llamada ES_NUM que verifique si el caracter ingresado es
;realmente un número. De no serlo, el programa debe mostrar el mensaje “CARACTER NO VALIDO”. La subrutina debe
;recibir el código del caracter por referencia desde el programa principal y debe devolver vía registro el valor 0FFH en caso
;de tratarse de un número o el valor 00H en caso contrario. Tener en cuenta que el código del “0” es 30H y el del “9” es
;39H
ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
ERROR DB "CARACTER NO VALIDO."
FIN DB ?

ORG 1500H
NUM DB ?

ORG 2000H
MOV BX, OFFSET MSJ
MOV AL, OFFSET ERROR-OFFSET MSJ
INT 7
MOV BX, OFFSET NUM
INT 6
CALL ES_NUM
CMP AL,0FFH
MOV AL, 1
JZ IMPRIMIR
MOV BX, OFFSET ERROR
MOV AL, OFFSET FIN - OFFSET ERROR
IMPRIMIR:
INT 7
MOV CL, NUM
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