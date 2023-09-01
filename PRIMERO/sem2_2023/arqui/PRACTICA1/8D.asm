;d) * Usando la subrutina anterior escribir la subrutina CONTAR_VOC, que recibe una cadena terminada en cero por
;referencia a través de un registro, y devuelve, en un registro, la cantidad de vocales que tiene esa cadena.
;Ejemplo: CONTAR_VOC de ‘contar1#!’ debe retornar 2

ORG 1000H
string   DB  "abnumE874III..//oa3",00H
VOCALES DB "aeiouAEIOU", 00h

ORG 2000H
MOV BX, offset string
CALL CONTAR_VOCALES
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

CONTAR_VOCALES:
  push ax
  mov cx, 0

  BUCLE:
  cmp byte ptr [bx], 00h
  jz retornar
  
  mov al, [bx]
  call ES_VOCAL
  inc bx
  cmp ah,00H
  jz NO_VOCAL
  inc cx
  NO_VOCAL:
  jmp BUCLE
  
  
  RETORNAR:
  pop ax
  ret
END
