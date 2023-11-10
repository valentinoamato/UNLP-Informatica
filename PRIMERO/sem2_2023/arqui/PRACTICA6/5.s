#5) Escriba un programa que calcule el resultado de elevar un valor en punto flotante a la potencia indicada por un
#exponente que es un número entero positivo. Para ello, en el programa principal se solicitará el ingreso de la base (un
#número en punto flotante) y del exponente (un número entero sin signo) y se deberá utilizar la subrutina
#a_la_potencia para calcular el resultado pedido (que será un valor en punto flotante). Tenga en cuenta que
#cualquier base elevada a la 0 da como resultado 1. Muestre el resultado numérico de la operación en la salida estándar
#del simulador (ventana Terminal).

.data
CONTROL: .word 0x10000
DATA: .word 0x10008
MSJ1: .asciiz "INGRESE LA BASE (flotante):"
MSJ2: .asciiz "INGRESE EL EXPONENTE (entero positivo):"
MSJ3: .asciiz "RESULTADO:"
UNO: .double 1.0


.code
ld $s0,CONTROL($0)      #s0=control
ld $s1,DATA($0)         #s0=control

daddi $t0,$0,4          #t0=4
daddi $t2,$0,MSJ1       #t2=msj1
sd $t2,0($s1)           #data=msj1
sd $t0,0($s0)           #print msj1

daddi $t1,$0,8          #t1=8
sd $t1,0($s0)           #read base
l.d f0,0($s1)           #f0=base

daddi $t2,$0,MSJ2       #t2=msj2
sd $t2,0($s1)           #data=msj2
sd $t0,0($s0)           #print msj2

sd $t1,0($s0)           #read exponente
ld $a0,0($s1)           #a0=exponente

daddi $a1,$0,UNO        #a1=UNO

daddi $a2,$0,MSJ3       #a2=MSJ3

jal POTENCIA

halt


#f0=base a0=exponente a1=uno a2=MSJ3
POTENCIA: 
l.d f1,0($a1)           #f1=1
beqz $a0, IMPRIMIRUNO   #base=1 -> fp=1
daddi $t0,$0,1          #t0=1
mov.d f2,f0             #f2=f0
LOOP:   
beq $a0,$t0,IMPRIMIR    #a0=1 -> IMPRIMIR
mul.d f0,f0,f2          #f0*f2        
daddi $a0,$a0,-1         #a0-1
j LOOP
IMPRIMIRUNO:
mov.d f0,f1             #f0=1
IMPRIMIR:
daddi $t0,$0,4          #t0=4
sd $a2,0($s1)           #data=MSJ3
sd $t0,0($s0)           #print msj3 
daddi $t0,$0,3          #t0=3
s.d f0,0($s1)          #data=f0
sd $t0,0($s0)           #print f0
jr $ra                  #ret

