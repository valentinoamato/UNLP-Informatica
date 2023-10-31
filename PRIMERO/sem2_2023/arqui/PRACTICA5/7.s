#7) Escriba una subrutina que reciba como parámetros un número positivo M de 64 bits, la dirección del comienzo de una
#tabla que contenga valores numéricos de 64 bits sin signo y la cantidad de valores almacenados en dicha tabla.
#La subrutina debe retornar la cantidad de valores mayores que M contenidos en la tabla.

.data
NUMERO: .double 4.56
TABLA: .double 3.45, 8.2, 1.92, 10.5, 4.55, 4.57, 0.0
FIN: .double -1
RESULTADO: .word 0

.code
l.d f0,NUMERO($0)       #f0=NUMERO
daddi $s0,$0,0          #$s0=0
daddi $s1,$0,0          #$s1=0
l.d f2,FIN($0)          #f2=FIN=-1

LOOP: l.d f1,TABLA($s0) #f1=TABLA[$s0]

c.eq.d f1,f2            #Si TABLA[$s0] = -1
bc1t TERMINAR 

c.le.d f1,f0            #Si TABLA[i]<=NUMERO   -> FP=1
daddi $s0,$s0,8         #$s0+8
bc1f LOOP               #FP=0 -> LOOP
daddi $s1,$s1,1         #$s1+1
j LOOP

TERMINAR:
sd $s1,RESULTADO($0)
halt

