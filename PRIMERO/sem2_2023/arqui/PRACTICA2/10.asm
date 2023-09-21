;10) Interrupción por hardware: tecla F10.
;Escribir un programa que, mientras ejecuta un lazo infinito, cuente el número de veces que se presiona la tecla F10 y
;acumule este valor en el registro DX.
IMR EQU 21H
INT0 EQU 24H
EOI EQU 20H
N_F10 EQU 10
ORG 40
IP_F10 DW RUT_F10 ;ES IGUAL A IP_F10 DW 3000H
ORG 2000H

CLI
MOV AL, 11111110B ;TAMBIEN PODRIA SER 0FEH
OUT IMR, AL ; PIC: registro IMR
MOV AL, N_F10
OUT INT0, AL ; PIC: registro INT0
MOV DX, 0
STI

LAZO: JMP LAZO
ORG 3000H
RUT_F10: PUSH AX
INC DX
MOV AL, EOI
OUT EOI, AL ; PIC: registro EOI
POP AX
IRET
END
;Explicar detalladamente:
;a) La función de los registros del PIC: ISR, IRR, IMR, INT0-INT7, EOI. Indicar la dirección de cada uno.
;b) Cuáles de estos registros son programables y cómo trabaja la instrucción OUT.
;c) Qué hacen y para qué se usan las instrucciones CLI y STI.

;a) ISR (In Service Register): Indica si hay y cual es la interrupcion en ejecucion 
;   IRR (Interrupt Request Register): Indica las interrupciones pedidas
;   IMR (Interrupt Mask Register): Indica las interrupciones enmascaradas
;   INT0-INT7: Guardan su vector de interrupcion (0-255) respectivamente
;   EOI (End of interrupt): Sirve para indicar al pic que la ejecucion de un gestor de interrupcion finalizo

;b) Todos estos registros son de tipo lectura-escritura a excepcion del ISR y el IRR que son solo lectura.
;   Para direccionar un dispositivo periférico se utilizan las líneas del bus de control ior e iow (input-output read e input-output write).
;   Estas líneas del bus de control son activadas por la unidad de control al decodificar una instrucción IN u OUT.

;c) El flag I del procesador es el encargado de permitir o ignorar las interrupciones.
;   De esta manera la instruccion CLI (Clear Interrupt Flag) establece el flag I a 0, desabilitando las interrupciones,
;   Y la instruccion STI (Set Interrupt Flag) restablece el valor del flag a 1, habilitandolas nuevamente.
;   De esta manera nos aseguramos que no se atiendan interrupciones mientras no se terminaron de configurar.