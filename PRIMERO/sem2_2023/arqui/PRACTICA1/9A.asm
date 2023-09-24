; a) Escribir una subrutina ROTARIZQ que haga una rotación hacia la izquierda de los bits de un byte almacenado en la
; memoria. Dicho byte debe pasarse por valor desde el programa principal a la subrutina a través de registros y por
; referencia. No hay valor de retorno, sino que se modifica directamente la memoria.
;11111111.
ORG 1000H
BYTE1 DB 00100011B

ORG 2000H
MOV BX,OFFSET BYTE1
CALL ROTARIZQ
HLT

ORG 3000H
ROTARIZQ:
PUSH AX
MOV AH, [BX]
ADD AH,AH
ADC AH,0
MOV BYTE PTR [BX], AH
POP AX
RET
END
