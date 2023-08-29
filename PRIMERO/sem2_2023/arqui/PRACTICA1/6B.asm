org 1000h
A dw 5
B dw 5
RES dw 0

org 2000h
mov ax, A
mov bx, B
mov cx, 0

call MUL
mov RES, cx
hlt

org 3000h
SUM: add cx, ax
dec bx
JNZ MUL
ret

end