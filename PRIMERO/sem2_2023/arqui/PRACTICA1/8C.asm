; c) * Escriba la subrutina ES_VOCAL, que determina si un carácter es vocal o no, ya sea mayúscula o minúscula. La
; rutina debe recibir el carácter por valor vía registro, y debe retornar, también vía registro, el valor 0FFH si el
; carácter es una vocal, o 00H en caso contrario.

ORG 1000H
CARACTER   DB  "."
VOCALES DB "aeiouAEIOU", 00h

ORG 2000H
MOV AL, CARACTER
CALL ES_VOCAL
HLT 

ORG 3000H
ES_VOCAL: 
  push bx
  MOV AH, 0
  MOV BX, OFFSET VOCALES
  
  LOOP: CMP AL, [BX]
  JZ ESVOCAL
  JNZ NOESVOCAL
  
  ESVOCAL: MOV AH, 0FFh
  JMP RETORNO

  NOESVOCAL: INC BX
  CMP BYTE PTR [BX], 00h
  JNZ LOOP

  RETORNO: 
  pop bx
  RET 
END
