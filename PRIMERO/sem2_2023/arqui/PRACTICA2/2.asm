; 2) Escribir un programa que muestre en pantalla todos los caracteres disponibles en el simulador MSX88, comenzando con
; el caracter cuyo código es el número 01H.

org 1000h
char db 01h

ORG 2000H
MOV BX, OFFSET char
MOV AL, 1
bucle:INT 7
cmp byte ptr [bx],0ffh
js terminar
inc byte ptr [bx]
jmp bucle

terminar:INT 0
END