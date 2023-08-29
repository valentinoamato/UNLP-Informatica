org 1000h
A dw 2
B dw 2
C dw 1
D dw ?

org 2000h
mov ax, A
mov bx, B
mov cx, C
call calculo
mov D, dx
hlt

org 3000h
calculo:
add ax, bx
sub ax, cx
mov dx, ax
ret

end