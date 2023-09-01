; e) Escriba la subrutina CONTAR_CAR que cuenta la cantidad de veces que aparece un carácter dado en una cadena
; terminada en cero. El carácter a buscar se debe pasar por valor mientras que la cadena a analizar por referencia,
; ambos a través de la pila.
; Ejemplo: CONTAR_CAR de ‘abbcde!’ y ‘b’ debe retornar 2, mientras que CONTAR_CAR de ‘abbcde!’ y ‘z’ debe
; retornar 0.


ORG 1000H
string   DB  "baaabaav",00H
CHAR DB "a"

ORG 2000H
MOV BX, offset string
push bx
mov al, CHAR
push ax
CALL COUNT_CHAR
HLT 

ORG 3000H
COUNT_CHAR: 
  MOV BX, SP
  add bx,2
  mov ax,[bx]
  mov cx,0
  add bx,2
  mov bx,[bx]
  dec bx
  
  


  LOOP:
  inc bx
  cmp byte ptr [bx], 00h
  jz retornar
  
  cmp al,[bx]
  jnz NO_CHAR
  inc cx
  NO_CHAR:
  jmp LOOP
  
  
  RETORNAR:
  ret
END
