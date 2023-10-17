#7) * Escribir un programa que recorra una TABLA de diez números enteros y determine cuántos elementos son mayores que X.
#El resultado debe almacenarse en una dirección etiquetada CANT. El programa debe generar además otro arreglo llamado RES
#cuyos elementos sean ceros y unos. Un ‘1’ indicará que el entero correspondiente en el arreglo TABLA es mayor que X,
#mientras que un ‘0’ indicará que es menor o igual.
.data
X: .word 5
CANT: .word 0
TABLA: .word 3,8,5,3,5,10,11,2,15,0
RES: .word 0

.code

dadd r1,r0,r0 #Desplazamiento
daddi r2,r0,10 #Cantidad de elementos
dadd r6,r0,r0  #Cantidad de elementos mayores a X

ld r3,X(r0) #r3<-X

LOOP:
ld r5,TABLA(r1)
slt r4,r3,r5 #TABLA[i]>X -> r4 = 1
beqz r4, ES_MENOR
daddi r6,r6,1 #r6++
sd r4,RES(r1)
ES_MENOR:
daddi r1,r1,8
daddi r2,r2,-1
bnez r2,LOOP # Indice != Cantidad de elementos -> LOOP

sd r6,CANT(r0)
halt