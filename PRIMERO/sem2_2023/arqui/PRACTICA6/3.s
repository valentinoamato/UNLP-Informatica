#3) Escriba un programa que realice la suma de dos números enteros (de un dígito cada uno) utilizando dos subrutinas: La
#denominada ingreso del ejercicio anterior (ingreso por teclado de un dígito numérico) y otra denominada
#resultado, que muestre en la salida estándar del simulador (ventana Terminal) el resultado numérico de la suma de
#los dos números ingresados (ejercicio similar al ejercicio 7 de Práctica 2).

.data
CONTROL: .word 0x10000
DATA: .word 0x10008

.code
ld $a0,CONTROL($0)
ld $a1,DATA($0)

jal INGRESO
dadd $a2,$0,$v0

jal INGRESO
dadd $a3,$0,$v0

jal RESULTADO
halt

#A0 = CONTROL | A1 = DATA |
INGRESO: daddi $t0,$0,8 #T0 = 8
sd $t0,0($a0)           #CONTROL = 8
ld $v0,0($a1)           #V0=^DATA
daddi $t0,$0,0          #T0=0
daddi $t1,$0,9          #T1=9
slt $t2,$t1,$v0         #9<V0?
bnez $t2, INVALIDO
slt $t2,$v0,$t0         #V0<0?
bnez $t2, INVALIDO
j VALIDO
INVALIDO:
daddi $v0,$0,10         #V0=10
VALIDO:
jr $ra

#A0 = CONTROL | A1 = DATA | A2 = NUM1 | A3 = NUM2
RESULTADO: dadd $a2,$a2,$a3     #A2+A3
daddi $t0,$0,1                  #T0=1
sd $a2,0($a1)                   #DATA=SUM 
sd $t0,0($a0)                   #PRINT 
jr $ra
