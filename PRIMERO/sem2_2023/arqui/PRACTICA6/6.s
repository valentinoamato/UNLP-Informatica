#6) El siguiente programa produce una salida estableciendo el color de un punto de la pantalla gráfica (en la ventana
#Terminal del simulador WinMIPS64). Modifique el programa de modo que las coordenadas y color del punto sean
#ingresados por teclado.

.data
MSJ1: .asciiz "INGRESE..."
MSJ2: .asciiz " R(0-255):"
MSJ3: .asciiz " G(0-255):"
MSJ4: .asciiz " B(0-255):"
MSJ5: .asciiz " Y(0-49):"
MSJ6: .asciiz " X(0-49):"
DIR_LF: .asciiz "\n"
PIXEL: .word 0
DIR_CONTROL: .word 0x10000
DIR_DATA: .word 0x10008

.code 
lw $s0, DIR_CONTROL($0) #$s0 = DIR_CONTROL
lw $s1, DIR_DATA($0)    #$s1 = DIR_DATA
daddi $a1,$0,PIXEL      #$a1 = PIXEL
daddi $a3,$0, DIR_LF    #$a3 = DIR_LF


daddi $t0,$0,MSJ1
sd $t0,0($s1)           #DATA=MSJ1
daddi $t0,$0,4          #t0=4
sd $t0,0($s0)           #Print MSJ

daddi $a0,$0,MSJ2       #a0=MSJ2
daddi $a2,$0,0          #a2=0
jal INGRESO             #read r

daddi $a0,$0,MSJ3       #a0=MSJ3
daddi $a2,$0,1          #a2=1
jal INGRESO             #read g

daddi $a0,$0,MSJ4       #a0=MSJ4
daddi $a2,$0,2          #a2=2
jal INGRESO             #read b

daddi $a0,$0,MSJ5       #a0=MSJ5
daddi $a2,$0,4          #a2=4
jal INGRESO             #read y

daddi $a0,$0,MSJ6       #a0=MSJ6
daddi $a2,$0,5          #a2=5
jal INGRESO             #read x

daddi $t0, $0, 7        #$t0 = 7 -> función 7: limpiar pantalla gráfica
sd $t0, 0($s0)         #DIR_CONTROL recibe 7 y limpia la pantalla gráfica

ld $t0,PIXEL($0)        #t0 = PIXEL
sd $t0,0($s1)           #DATA = PIXEL
daddi $t0,$0,5          #t0=5 
sd $t0,0($s0)           #print pixel
halt

#LEE UN DATO DE UN PIXEL Y LO GUARDA
INGRESO: #A0=DIR_MSJ #A1=DIR_PIXEL A2=NRO_DATO(0-7) A3=DIR_LF
daddi $t0,$0,4          #t0=4
sd $a3,0($s1)           #DATA=DIR_LF
sd $t0,0($s0)           #Print LF
sd $a0,0($s1)           #DATA=DIR_MSJ
sd $t0,0($s0)           #Print MSJ
daddi $t0,$0,8          #t0=8
sd $t0,0($s0)           #Read dato  
ld $t0,0($s1)           #t0=dato 
dadd $a2,$a1,$a2         #DIR_DATO = DIR_PIXEL+NRO_DATO
sb $t0,0($a2)           #PIXEL<-dato
jr $ra                  #ret