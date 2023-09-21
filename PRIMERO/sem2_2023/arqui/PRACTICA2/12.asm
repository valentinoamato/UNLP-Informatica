;12) Interrupción por hardware: TIMER.
;Implementar a través de un programa un reloj segundero que muestre en pantalla los segundos transcurridos (00-59 seg)
;desde el inicio de la ejecución.
CONT EQU 10H
COMP EQU 11H

EOI EQU 20H
IMR EQU 21H
INT1 EQU 25H

V_INT1 EQU 10
ORG 40
DW RUT_CLK

ORG 1000H
SEG DB 30H ;ASCII 0
DB 30H
FIN DB ?
ORG 2000H
CLI
MOV AL, 11111101B
OUT IMR, AL ; PIC: registro IMR

MOV AL, V_INT1
OUT INT1, AL ; PIC: registro INT1

MOV AL, 0
OUT CONT, AL ; TIMER: registro CONT

MOV AL, 1
OUT COMP, AL ; TIMER: registro COMP
;00
MOV BX, OFFSET SEG
MOV AL, OFFSET FIN-OFFSET SEG
STI
LAZO: JMP LAZO
HLT

ORG 3000H
RUT_CLK: PUSH AX
INC SEG+1
CMP SEG+1, 3AH; 39H=9 3AH= :
;SI SEG+1 TIENE UN CARACTER VALIDO (0-9) LO IMPRIME Y RESETEA EL CONTADOR
JNZ RESET
;SI SE PASO DE 9, LE PONE UN 0 (30H) Y EN CAMBIO INCREMENTA SEG, QUE CUENTA DECENAS 
MOV SEG+1, 30H
INC SEG
CMP SEG, 36H
;SI SEG TIENE UN CARACTER VALIDO (0-5) LO IMPRIME Y RESETEA EL CONTADOR
JNZ RESET
;SINO PONE UN 0 EN SEG
MOV SEG, 30H

RESET: INT 7

MOV AL, 0
OUT CONT, AL

MOV AL, EOI
OUT EOI, AL

POP AX
IRET
END
;Explicar detalladamente:
;a) Cómo funciona el TIMER y cuándo emite una interrupción a la CPU.
;b) La función que cumplen sus registros, la dirección de cada uno y cómo se programan.

;A ^ B) El TIMER permite generar interrupciones temporizadas, posee dos registros de 8 bits:
;     -CONT (10H): Se incrementa con cada pulso aplicado a la entrada el periferico (1hz)
;     -COMP (11H): Registro de comparacion
;   Cuando los dos registros tienen el mismo valor se genera una interrupcion por hardware en la linea 1
;   Para programarlo se debe poner el el registro CONT el numero del que se quiere comenzar a contar (normalmente 0)
;   Y en el registro COMP se debe poner el valor adecuado para que la interrupcion se de cuando sea necesaria
;   Para ambos casos se debe usar la instruccion OUT 