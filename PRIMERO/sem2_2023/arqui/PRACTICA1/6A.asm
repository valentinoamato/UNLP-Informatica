org 1000h
A dw 2
B dw 3
RES dw 0

org 2000h
mov ax, A
mov bx, B
mov cx, 0

SUM: add cx, ax
dec bx
JNZ SUM

mov RES, cx
hlt

end