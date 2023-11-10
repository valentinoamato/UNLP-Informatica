#4) Escriba un programa que solicite el ingreso por teclado de una clave (sucesión de cuatro caracteres) utilizando la
#subrutina char de ingreso de un carácter. Luego, debe comparar la secuencia ingresada con una cadena almacenada
#en la variable clave. Si las dos cadenas son iguales entre si, la subrutina llamada respuesta mostrará el texto
#“Bienvenido” en la salida estándar del simulador (ventana Terminal). En cambio, si las cadenas no son iguales, la
#subrutina deberá mostrar “ERROR” y solicitar nuevamente el ingreso de la clave.

.data
CONTROL: .word 0x10000
DATA: .word 0x10008
CLAVE: .asciiz "HOLA"
MSJ1: .asciiz "Bienvenido"
MSJ2: .asciiz "ERROR\n"

.code
daddi $sp,$0,0x400      #sp = 400
ld $s0,CONTROL($0)      #s0=control
ld $s1,DATA($0)         #s1=data
daddi $a0,$0,CLAVE      #a0=CLAVE
daddi $a1,$0,MSJ1       #a1=MSJ1
daddi $a2,$0,MSJ2       #a1=MSJ2
jal ACCESO
halt


#s0=control s1=data v0=char
CHAR: daddi $t7,$0,9    #t7=9
sd $t7,0($s0)           #read char 
ld $v0,0($s1)           #v0 = char
jr $ra 

#s0=control s1=data a0=clave a1=MSJ1 a2=MSJ2
ACCESO: daddi $sp,$sp,-8
sd $ra,0($sp)           #push ra 
INTENTO:
dadd $t0,$0,$a0         #t0=0
LOOP: lbu $t1,0($t0)    #t1 = clave[a0-t0]
dadd $t4,$0,$t1         #t4=t1
beqz $t4, CORRECTO      #t4 = 0 -> CORRECTO
jal CHAR                #v0 = CHAR 
daddi $t0,$t0,1
beq $t1,$v0,LOOP        #t1=v0 -> LOOP
#INCORRECTO
daddi $t2,$0,4          #t2=4
sd $a2,0($s1)           #data=msj2
sd $t2,0($s0)           #print
j INTENTO
CORRECTO:
daddi $t2,$0,4          #t2=4
sd $a1,0($s1)           #data=msj1
sd $t2,0($s0)           #print
ld $ra,0($sp)           #pop ra
daddi $sp,$sp,8         #pop ra
jr $ra

