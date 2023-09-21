;11) Escribir un programa que permita seleccionar una letra del abecedario al azar. El código de la letra debe generarse en un
;registro que incremente su valor desde el código de A hasta el de Z continuamente. La letra debe quedar seleccionada al
;presionarse la tecla F10 y debe mostrarse de inmediato en la pantalla de comandos.
EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H
V_INT0 EQU 10
D_INT0 EQU G_INT0

ORG 40
DW D_INT0

ORG 1000H
MSJ DB " LETRA:"
FIN DB ?
LETRA DB ?

ORG 2000H
CLI
MOV AL, 11111110B ;CONFIGURO EL IMR
OUT IMR,AL

MOV AL, V_INT0
OUT INT0, AL
STI
REINICIAR: MOV AH, 41H
SUMAR: INC AH
CMP AH,5AH
JZ REINICIAR
JMP SUMAR
HLT

ORG 3000H
G_INT0:
PUSH BX ;SALVO BX
;IMPRIMO UN MENSAJE
MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN - OFFSET  MSJ
INT 7
;IMPRIMO LA LETRA
MOV LETRA, AH
MOV BX, OFFSET LETRA
MOV AL, 1
INT 7
;20H->EOI
MOV AL,EOI
OUT EOI,AL
;SALVO BX
POP BX
IRET
END




