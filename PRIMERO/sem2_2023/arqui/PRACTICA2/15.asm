;15) Escribir un programa que implemente un conteo regresivo a partir de un valor ingresado desde el teclado. El conteo
;debe comenzar al presionarse la tecla F10. El tiempo transcurrido debe mostrarse en pantalla, actualizándose el valor cada
;segundo.
CONT EQU 10H
COMP EQU 11H

EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H
INT1 EQU 25H

V_INT0 EQU 5
V_INT1 EQU 10

ORG 20
DW RUT_F10

ORG 40
DW RUT_CLK

ORG 1000H
MSJ1 DB "INGRESE UN NUMERO: "
MSJ2 DB "CUENTA:"
CUENTA DB ?
DB " TIEMPO:"
TIEMPO DB 30H
LF DB 10;LINE FEED
FIN DB ?
TERMINAR DB 0 

ORG 2000H
;ENTRADA DEL NUMERO
MOV BX, OFFSET MSJ1
MOV AL, OFFSET MSJ2- OFFSET MSJ1
INT 7
MOV BX, OFFSET CUENTA ;101AH
INT 6
MOV BX, OFFSET LF
MOV AL, 1
INT 7

CLI
MOV AL, 11111110B
OUT IMR, AL ; PIC: registro IMR

MOV AL, V_INT0
OUT INT0, AL ; PIC: registro INT0

MOV AL, V_INT1
OUT INT1, AL ; PIC: registro INT1

MOV AL, 1
OUT COMP, AL ; TIMER: registro COMP

MOV AL, 0
OUT CONT, AL ; TIMER: registro CONT
STI

LAZO: CMP TERMINAR,0
JZ LAZO
HLT

ORG 3000H ;GESTOR DE INT0
RUT_F10:  
;SALVO AX
PUSH AX
;ENMASCARO TODAS LAS INTERRUPCIONES
CLI
MOV AL,11111101B
OUT IMR,AL 
STI

;EOI
MOV AL, EOI
OUT EOI,AL
;SALVA AX
POP AX
IRET

ORG 3200H ;GESTOR DE INT1
RUT_CLK:   
;SALVO AX
PUSH AX
;SI CUENTA LLEGA A 0 (30H) ENMASCARO TODO Y TERMINO EL PROGRAMA, SINO SIGO
CMP CUENTA, 30H
JNZ CONTINUAR
INC TERMINAR
;ENMASCARO TODAS LAS INTERRUPCIONES
CLI
MOV AL,0FFH
OUT IMR,AL 
STI
CONTINUAR:

;IMPRIME LA CUENTA Y EL TIEMPO
MOV BX, OFFSET MSJ2
MOV AL, OFFSET FIN-OFFSET MSJ2
INT 7

INC TIEMPO
DEC CUENTA

MOV AL, EOI
OUT EOI,AL

CLI;CONT->0
MOV AL,0
OUT CONT,AL
STI

POP AX
IRET
END
