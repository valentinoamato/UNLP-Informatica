org 1000h
A dw 5
B dw 5
RES dw 0

org 2000h
mov bx, offset A
mov cx, 0

call MUL
mov RES, cx
hlt

org 3000h
MUL: add cx, [bx]
add bx, 2
dec word ptr [bx]
pushf
sub bx, 2
popf
JNZ MUL
ret

end