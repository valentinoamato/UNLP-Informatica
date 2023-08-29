org 1000h
STRING db "aBcDE1#!", 00h

org 2000h
mov bx, offset STRING
pushf
call CONTARMIN
hlt

org 3000h
CONTARMIN:
mov al, 0

a:
mov ah, [bx]
cmp ah, 0
jz retornar

cmp ah, 61h
pushf
pop dx
mov ch, 7ah
cmp ch, ah
pushf
pop cx
or dx, cx
push dx
popf

js saltar
inc al

saltar: 
inc bx
jmp a

retornar:
mov ah, 0
ret
end