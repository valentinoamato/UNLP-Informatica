#2) Escriba un programa que utilice sucesivamente dos subrutinas: La primera, denominada ingreso, debe solicitar el
#ingreso por teclado de un número entero (de un dígito), verificando que el valor ingresado realmente sea un dígito. La
#segunda, denominada muestra, deberá mostrar en la salida estándar del simulador (ventana Terminal) el valor del
#número ingresado expresado en letras (es decir, si se ingresa un ‘4’, deberá mostrar ‘CUATRO’). Establezca el pasaje
#de parámetros entre subrutinas respetando las convenciones para el uso de los registros y minimice las detenciones
#del cauce (ejercicio similar al ejercicio 6 de Práctica 2).

.data
NUMEROS: .asciiz "CERO"
.asciiz "UNO"
.asciiz "DOS"
.asciiz "TRES"
.asciiz "CUATRO"
.asciiz "CINCO"
.asciiz "SEIS"
.asciiz "SIETE"
.asciiz "OCHO"
.asciiz "NUEVE"
.asciiz "INVALIDO"
CONTROL: .word 0x10000
DATA: .word 0x10008

.code 
ld $a0,CONTROL($0)
ld $a1,DATA($0)
jal INGRESO

dadd $a2,$0,$v0 
daddi $a3,$0,NUMEROS
jal MUESTRA

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

#A0 = CONTROL | A1 = DATA | A2 = NUM | A3 = NUMEROS
MUESTRA: daddi $t0,$0,4 #T0 = 4
daddi $t1,$0,8          #T1 = 8
dmulu $a2,$a2,$t1       #NUM*8
dadd $a3,$a3,$a2        #NUMEROS + SHIFT
sd $a3, 0($a1)          #DATA=MENSAJE
sd $t0,0($a0)           #PRINT
jr $ra
