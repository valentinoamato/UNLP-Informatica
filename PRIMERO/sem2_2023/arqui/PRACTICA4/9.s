#9) Escribir un programa que implemente el siguiente fragmento escrito en un lenguaje de alto nivel:
#   while a > 0 do
#       begin
#           x := x + y;
#           a := a - 1;
#       end;
#Ejecutar con la opción Delay Slot habilitada

#El programa planteado es muy similar al del ejercicio 8, por lo que procedo a modificar el programa de dicho ejercicio
.data
Y: .word 8
A: .word 8
X: .word 10

.code
ld r1,Y(r0)
ld r2,A(r0)
ld r3,X(r0)

beqz r1, FIN
beqz r2, FIN

LOOP:
daddi r2,r2,-1
bnez r2, LOOP
dadd r3,r3,r1

sd r3,X(r0)
FIN: HALT
