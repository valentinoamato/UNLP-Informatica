org 1000h
STRING db "abcd", 00h

org 2000h
mov bx, offset STRING
call LONGITUD
hlt

org 3000h
LONGITUD: mov cx, bx
a: cmp byte ptr [bx], 00h
pushf
inc bx
popf
jnz a

sub bx, cx
dec bx
mov cx, bx
ret
end