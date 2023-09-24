;e) Idem d), pero ahora utilizar el HAND-SHAKE en modo interrupciones.
EOI EQU 20H
IMR EQU 21H
INT2 EQU 26H
ID_INT2 EQU 10
DATO EQU 40H
ESTADO EQU 41H

ORG 40
DW RUT_HS

ORG 1000H
STR DB "INGRESE UN NUMERO:"
FIN DB ?
TERMINAR DB 0

ORG 1500H
STR2 DB ?

ORG 2000H
;CONFIGURACION PIC
CLI
MOV AL,11111011B
OUT IMR,AL

MOV AL,ID_INT2
OUT INT2,AL
STI
;INPUT LOOP
MOV CX,0
INPUT:
;MENSAJE A MOSTRAR
MOV BX, OFFSET STR
MOV AL, OFFSET FIN-OFFSET STR
;IMPRIMIR  MENSAJE
INT 7
;INGRESO DE NUMERO
MOV BX,OFFSET STR2
ADD BX,CX
INT 6
;AUMENTO BX REDUZCO CL
INC CX
CMP CX,5
JNZ INPUT
;CX BX
MOV CL, 0
MOV BX,OFFSET STR2
;CONFIGURACION ESTADO: HABILITO INTERRUPCIONES
IN AL,ESTADO
OR AL,10000000B; I->0
OUT ESTADO,AL
;LOOP 
LOOP: CMP TERMINAR,1
JNZ LOOP
HLT

ORG 3000H
RUT_HS:
PUSH AX
;IMPRESION DEL CARACTER
MOV AL,[BX]
OUT DATO,AL
;AUMENTO CL. SI CL<5 INC BX ELSE DEC BX
INC CL
CMP CL,5
JZ CMP10 ;SI SE IMPRIMIO EL QUINTO CARACTER, NO MODIFICO BX PARA QUE ESTE SE IMPRIMA UNA VEZ MAS
JNC RESTAR
INC BX
JMP CMP10
RESTAR:
DEC BX
;SI CL>10 TERMINO EL PROGRAMA
CMP10:CMP CL,10
JNZ RETORNAR
;DESABILITAR INTERRUPCIONES ^ TERMINAR->1
CLI
MOV AL,0FFH
OUT IMR,AL
STI
MOV TERMINAR,1
RETORNAR:
;EOI
MOV AL, EOI
OUT EOI,AL
;SALVAR AX
POP AX
IRET
END
