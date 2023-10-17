#6) Escribir un programa que lea tres números enteros A, B y C de la memoria de datos y determine cuántos de ellos son iguales
#entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D.
.data
A: .word 3
B: .word 3
C: .word 3
D: .word 0

.code
ld r1, A(r0)
ld r2, B(r0)
ld r3, C(r0)
dadd r4, r0, r0

#A!=B?
bne r1,r2,DISTINTOS1
daddi r4, r4, 1
DISTINTOS1:

#A!=C?
bne r1,r3,DISTINTOS2
daddi r4, r4, 1
DISTINTOS2:

#B!=C?
bne r2,r3,DISTINTOS3
daddi r4, r4, 1
DISTINTOS3:

#Si r4=1 hay DOS numero iguales (R4++)
daddi r5,r0,1
bne r4,r5, NO_DOS
daddi r4,r4,1
NO_DOS: 
sd r4, D(r0)
halt