org 1000h
A dw 2
B dw 2
C dw 1
D dw ?

org 2000h
mov ax, A
add ax, B
sub ax, C
mov D, ax
hlt
end