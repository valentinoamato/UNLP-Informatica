#d) Modificar el programa para que almacene en un arreglo en memoria de datos los contenidos parciales del registro r1 ¿Qué
#significado tienen los elementos de la tabla que se genera?
.data
NUM_INICIAL: .word 2
CICLOS: .word 4
ARREGLO: .word 0
.code
daddi r3,r0,0
ld r2, CICLOS(r0)
ld r1, NUM_INICIAL(r0)
sd r1,ARREGLO(r3)
daddi r3,r0,8
loop: 
daddi r2, r2, -1
dsll r1, r1, 1
sd r1,ARREGLO(r3)
daddi r3,r3,8
bnez r2, loop
halt