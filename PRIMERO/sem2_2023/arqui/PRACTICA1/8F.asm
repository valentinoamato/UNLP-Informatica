; f) Escriba la subrutina REEMPLAZAR_CAR que reciba dos caracteres (ORIGINAL y REEMPLAZO) por valor a través de
; la pila, y una cadena terminada en cero también a través de la pila. La subrutina debe reemplazar el carácter
; ORIGINAL por el carácter REEMPLAZO.


ORG 1000H
string   DB  "tatubiu",00H
ORIGINAL DB "a"
REMPLAZO DB "b"

ORG 2000H
MOV BX, offset string
push bx
mov ah, original
mov al,remplazo
push ax

CALL REMPLAZAR
HLT 

ORG 3000H
REMPLAZAR: 
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
  
  cmp ah,[bx]
  jnz NO_CHAR
  mov byte ptr [bx],al
  NO_CHAR:
  jmp LOOP
  
  
  RETORNAR:
  ret
END
