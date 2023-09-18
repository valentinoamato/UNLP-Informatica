;3) * Escribir un programa que muestre en pantalla las letras del abecedario, sin espacios, intercalando mayúsculas y
;minúsculas (AaBb…), sin incluir texto en la memoria de datos del programa. Tener en cuenta que el código de “A” es 41H,
;el de “a” es 61H y que el resto de los códigos son correlativos según el abecedario.

org 1000h
char db 41h

ORG 2000H
MOV BX, OFFSET char
MOV AL, 1
bucle:INT 7
add char,20h
INT 7
sub char ,20h
cmp char,5Ah
jz terminar
inc char
jmp bucle

terminar:INT 0
END