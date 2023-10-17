#8) * Escribir un programa que multiplique dos números enteros utilizando sumas repetidas (similar a Ejercicio 6 o 7 de la Práctica
#1). El programa debe estar optimizado para su ejecución con la opción Delay Slot habilitada


#A*B=C
.data
A: .word 8
B: .word 8
C: .word 0

.code
ld r1,A(r0)
ld r2,B(r0)
dadd r3,r0,r0

beqz r1, FIN
beqz r2, FIN

LOOP:
daddi r2,r2,-1
bnez r2, LOOP
dadd r3,r3,r1

sd r3,C(r0)
FIN: HALT