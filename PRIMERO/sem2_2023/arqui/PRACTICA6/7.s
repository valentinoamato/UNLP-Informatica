#7) Se desea realizar la demostración de la transformación de un carácter codificado en ASCII a su visualización en una
#matriz de puntos con 7 columnas y 9 filas. Escriba un programa que realice tal demostración, solicitando el ingreso
#por teclado de un carácter para luego mostrarlo en la pantalla gráfica de la terminal.
#Fila ↓
#8         1 1 1
#7       6       2
#6       6       2
#5         7 7 7    
#4       5       3
#3       5       3
#2       5       3
#1         4 4 4
#0    
#Col → 0 1 2 3 4 5 6

.data 
CONTROL: .word 0x10000
DATA: .word 0x10008
#Se guarda para cada numero los segmentos del display que se deben encender
#Si el la palabra de un numero el bit N es 1 es porque el segmento N se debe dibujar para dicho numero
#CERO = 0111 1110
CERO: .byte 0x7E
#UNO = 0000 1100
UNO: .byte 0x0C
#DOS = 1011 0110
DOS: .byte 0xB6
#TRES = 1001 1110
TRES: .byte 0x9E
#CUATRO = 1100 1100
CUATRO: .byte 0xCC
#CINCO = 1101 1010
CINCO: .byte 0xDA
#SEIS = 1111 1010
SEIS: .byte 0xFA
#SIETE = 0000 1110
SIETE: .byte 0x0E
#OCHO = 1111 1110
OCHO: .byte 0xFE
#NUEVE = 1101 1110
NUEVE: .byte 0xDE
MSJ: .asciiz "INGRESE UN NUMERO ENTERO (0-9):"

.code 
daddi $sp,$0,0x400  #SP=400H
ld $s0,CONTROL($0)  #S0=CONTROL
ld $s1,DATA($0)     #S1=DATA

daddi $t0,$t0,MSJ   #T0=MSJ
sd $t0,0($s1)       #DATA=MSJ
daddi $t0,$0,4      #T0=4
sd $t0,0($s0)       #PRINT MSJ

daddi $t0,$0,8      #T0=8
sd $t0,0($s0)       #READ NUM
ld $t0,0($s1)       #T0=NUM
daddi $t1,$0,8      #T1=8
dmulu $t0,$t0,$t1   #NUM*8
ld $s2,CERO($t0)    #S2=SEGMENTOS_NUM 

SEGMENTO1:
andi $t0,$s2,0x2    #T0=SEGMENTO1
beqz $t0,SEGMENTO2  #SI SEGMENTO1=0 -> SEGMENTO2
#PRINT SEGMENTO1
daddi $a0,$0,8      #Y
daddi $a1,$0,2      #X
daddi $a2,$0,3      #LONGITUD
daddi $a3,$0,0      #DIRECCION
jal LINEA

SEGMENTO2:
andi $t0,$s2,0x4    #T0=SEGMENTO2
beqz $t0,SEGMENTO3  #SI SEGMENTO2=0 -> SEGMENTO3
#PRINT SEGMENTO2
daddi $a0,$0,6      #Y
daddi $a1,$0,5      #X
daddi $a2,$0,2      #LONGITUD
daddi $a3,$0,1      #DIRECCION
jal LINEA

SEGMENTO3:
andi $t0,$s2,0x8    #T0=SEGMENTO3
beqz $t0,SEGMENTO4  #SI SEGMENTO3=0 -> SEGMENTO4
#PRINT SEGMENTO3
daddi $a0,$0,2      #Y
daddi $a1,$0,5      #X
daddi $a2,$0,3      #LONGITUD
daddi $a3,$0,1      #DIRECCION
jal LINEA

SEGMENTO4:
andi $t0,$s2,0x10    #T0=SEGMENTO4
beqz $t0,SEGMENTO5  #SI SEGMENTO4=0 -> SEGMENTO5
#PRINT SEGMENTO4
daddi $a0,$0,1      #Y
daddi $a1,$0,2      #X
daddi $a2,$0,3      #LONGITUD
daddi $a3,$0,0      #DIRECCION
jal LINEA

SEGMENTO5:
andi $t0,$s2,0x20    #T0=SEGMENTO5
beqz $t0,SEGMENTO6  #SI SEGMENTO5=0 -> SEGMENTO6
#PRINT SEGMENTO5
daddi $a0,$0,2      #Y
daddi $a1,$0,1      #X
daddi $a2,$0,3      #LONGITUD
daddi $a3,$0,1      #DIRECCION
jal LINEA

SEGMENTO6:
andi $t0,$s2,0x40    #T0=SEGMENTO6
beqz $t0,SEGMENTO7  #SI SEGMENTO6=0 -> SEGMENTO7
#PRINT SEGMENTO6
daddi $a0,$0,6      #Y
daddi $a1,$0,1      #X
daddi $a2,$0,2      #LONGITUD
daddi $a3,$0,1      #DIRECCION
jal LINEA

SEGMENTO7:
andi $t0,$s2,0x80   #T0=SEGMENTO7
beqz $t0,FIN  #SI SEGMENTO7=0 -> FIN
#PRINT SEGMENTO7
daddi $a0,$0,5      #Y
daddi $a1,$0,2      #X
daddi $a2,$0,3      #LONGITUD
daddi $a3,$0,0      #DIRECCION
jal LINEA

FIN:
halt



#Renderiza una linea horizontal o vertical
LINEA: #S0=CONTROL S1=DATA A0=Yinicial A1=Xinicial A2=LONGITUD A3=DIRECCION:horizontal(0)/vertical(1) 
daddi $sp,$sp,-8    #push ra
sd $ra,0($sp)       #push ra
daddi $sp,$sp,-8    #push s2
sd $s2,0($sp)       #push s2
daddi $sp,$sp,-8    #push s3
sd $s3,0($sp)       #push s3
daddi $sp,$sp,-8    #push s4
sd $s4,0($sp)       #push s4

dadd $s4,$0,$a2      #S4=LONGITUD

beqz $a3,HORIZONTAL
dadd $s2,$0,$a0     #S2=Yinicial
dadd $s3,$0,$a1     #S3=Xinicial
IMPRIMIR_V:           
beqz $s4,TERMINAR   #TERMINAR SI LONGITUD = 0
dadd $a0,$0,$s2     #A0=Y
dadd $a1,$0,$s3     #A1=Xinicial
jal PUNTO           #Imprime punto en (y,x)
daddi $s2,$s2,1     #Y+1
daddi $s4,$s4,-1    #LONGITUD-1
j IMPRIMIR_V

HORIZONTAL:
dadd $s2,$0,$a1     #S2=Xinicial
dadd $s3,$0,$a0     #S3=Yinicial
IMPRIMIR_H:           
beqz $s4,TERMINAR   #TERMINAR SI LONGITUD = 0
dadd $a0,$0,$s3     #A0=Yinicial
dadd $a1,$0,$s2     #A1=X
jal PUNTO           #Imprime punto en (y,x)
daddi $s2,$s2,1     #Y+1
daddi $s4,$s4,-1    #LONGITUD-1
j IMPRIMIR_H

TERMINAR:
ld $s4,0($sp)       #pop s4
daddi $sp,$sp,8     #pop s4
ld $s3,0($sp)       #pop s3
daddi $sp,$sp,8     #pop s3
ld $s2,0($sp)       #pop s2
daddi $sp,$sp,8     #pop s2
ld $ra,0($sp)       #pop ra
daddi $sp,$sp,8     #pop ra
jr $ra              #ret



#Renderiza un pixel negro en las cordenadas recibidas
PUNTO: #A0=Y A1=X S0=CONTROL S1=DATA
dadd $t0,$0,$0      #t0=0
daddi $t1,$0,32     #t1=32 (8*4) Desplazamiento de Y
dsllv $a0,$a0,$t1   #Desplazamiento de Y
daddi $t1,$0,40     #t1=40 (8*5) Desplazamiento de X
dsllv $a1,$a1,$t1   #Desplazamiento de X
dadd $t0,$t0,$a0    #t0<-Y
dadd $t0,$t0,$a1    #t0<-X 
sd $t0,0($s1)       #PIXEL->DATA
daddi $t1,$0,5      #t1=5
sd $t1,0($s0)       #PRINT PIXEL
jr $ra              #RET



