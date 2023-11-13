#8) Escriba un programa que implemente la animación de cinco pelotitas rebotando por la pantalla. 
#Cada una con su posición, dirección y color particular.

.data
DIR_CONTROL: .word 0x10000
DIR_DATA: .word 0x10008
PELOTITA: .word 0

.code
#s0=DIR_CONTROL
#s1=DIR_DATA
#s2=pelotita1
#s3=pelotita2
#s4=pelotita3
#s5=pelotita4
#s6=pelotita5

#CONFIGURACION DATA CONTROL
ld $s0,DIR_CONTROL($0)      #s0=DIR_CONTROL
ld $s1,DIR_DATA($0)         #s1=DIR_DATA

#CONFIGURACION DE LAS PELOTITAS
#  DirX     DirY       X        Y        N        B        G       R
#xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx
daddi $t2,$0,PELOTITA       #t2=direccion pelotita
#La palabra de memoria PELOTITA solo se usara a la hora de cargar la informacion de las pelotitas a sus respectivos registros
#PELOTITA 1
daddi $t0,$0,0xFF           #R: 00-FF
sb $t0,0($t2)     
daddi $t0,$0,0x00           #G: 00-FF
sb $t0,1($t2)  
daddi $t0,$0,0x00           #B: 00-FF
sb $t0,2($t2)        
daddi $t0,$0,1              #N=1
sb $t0,3($t2)    
daddi $t0,$0,24             #Y inicial: 0-49
sb $t0,4($t2) 
daddi $t0,$0,00             #X inicial: 0-49
sb $t0,5($t2) 
daddi $t0,$0,1              #Direccion Y: -1/0/1
sb $t0,6($t2)     
daddi $t0,$0,1              #Direccion X: -1/0/1
sb $t0,7($t2)    
ld $s2,0($t2)               #s2=pelotita1

#PELOTITA 2
daddi $t0,$0,0x00           #R: 00-FF
sb $t0,0($t2)     
daddi $t0,$0,0xFF           #G: 00-FF
sb $t0,1($t2)  
daddi $t0,$0,0x00           #B: 00-FF
sb $t0,2($t2)        
daddi $t0,$0,2              #N=2
sb $t0,3($t2)    
daddi $t0,$0,24             #Y inicial: 0-49
sb $t0,4($t2) 
daddi $t0,$0,49             #X inicial: 0-49
sb $t0,5($t2) 
daddi $t0,$0,-1             #Direccion Y: -1/0/1
sb $t0,6($t2)     
daddi $t0,$0,-1             #Direccion X: -1/0/1
sb $t0,7($t2)    
ld $s3,0($t2)               #s3=pelotita2

#PELOTITA 3
daddi $t0,$0,0x00           #R: 00-FF
sb $t0,0($t2)     
daddi $t0,$0,0x00           #G: 00-FF
sb $t0,1($t2)  
daddi $t0,$0,0xFF           #B: 00-FF
sb $t0,2($t2)        
daddi $t0,$0,3              #N=3
sb $t0,3($t2)    
daddi $t0,$0,49             #Y inicial: 0-49
sb $t0,4($t2) 
daddi $t0,$0,24             #X inicial: 0-49
sb $t0,5($t2) 
daddi $t0,$0,1              #Direccion Y: -1/0/1
sb $t0,6($t2)     
daddi $t0,$0,0              #Direccion X: -1/0/1
sb $t0,7($t2)    
ld $s4,0($t2)               #s4=pelotita3

#PELOTITA 4
daddi $t0,$0,0x00           #R: 00-FF
sb $t0,0($t2)     
daddi $t0,$0,0x00           #G: 00-FF
sb $t0,1($t2)  
daddi $t0,$0,0x00           #B: 00-FF
sb $t0,2($t2)        
daddi $t0,$0,4              #N=4
sb $t0,3($t2)    
daddi $t0,$0,0              #Y inicial: 0-49
sb $t0,4($t2) 
daddi $t0,$0,0              #X inicial: 0-49
sb $t0,5($t2) 
daddi $t0,$0,1              #Direccion Y: -1/0/1
sb $t0,6($t2)     
daddi $t0,$0,1              #Direccion X: -1/0/1
sb $t0,7($t2)    
ld $s5,0($t2)               #s5=pelotita4

#PELOTITA 5
daddi $t0,$0,0xFF           #R: 00-FF
sb $t0,0($t2)     
daddi $t0,$0,0xFF           #G: 00-FF
sb $t0,1($t2)  
daddi $t0,$0,0x00           #B: 00-FF
sb $t0,2($t2)        
daddi $t0,$0,5              #N=5
sb $t0,3($t2)    
daddi $t0,$0,00             #Y inicial: 0-49
sb $t0,4($t2) 
daddi $t0,$0,49             #X inicial: 0-49
sb $t0,5($t2) 
daddi $t0,$0,-1             #Direccion Y: -1/0/1
sb $t0,6($t2)     
daddi $t0,$0,-1             #Direccion X: -1/0/1
sb $t0,7($t2)    
ld $s6,0($t2)               #s6=pelotita5
#Fin de configuracion de pelotitas


LOOP:
#LIMPIAR PANTALLA
daddi $t0,$0,7
sd $t0,0($s0)

#IMPRESION DE LAS PELOTITAS
dadd $a0,$0,$s2             #Cargo la informacion de la pelotita 1 en a0
jal IMPRIMIR_PELOTITA
dadd $a0,$0,$s3             #Cargo la informacion de la pelotita 2 en a0
jal IMPRIMIR_PELOTITA
dadd $a0,$0,$s4             #Cargo la informacion de la pelotita 3 en a0
jal IMPRIMIR_PELOTITA
dadd $a0,$0,$s5             #Cargo la informacion de la pelotita 4 en a0
jal IMPRIMIR_PELOTITA
dadd $a0,$0,$s6             #Cargo la informacion de la pelotita 5 en a0
jal IMPRIMIR_PELOTITA

#CALCULO DE POSICIONES
dadd $a0,$0,$s2             #Cargo la informacion de la pelotita 1 en a0
jal ACTUALIZAR_POSICION
dadd $s2,$0,$v0             #Guardo la nueva informacion de la pelotita
dadd $a0,$0,$s3             #Cargo la informacion de la pelotita 2 en a0
jal ACTUALIZAR_POSICION
dadd $s3,$0,$v0             #Guardo la nueva informacion de la pelotita
dadd $a0,$0,$s4             #Cargo la informacion de la pelotita 3 en a0
jal ACTUALIZAR_POSICION
dadd $s4,$0,$v0             #Guardo la nueva informacion de la pelotita
dadd $a0,$0,$s5             #Cargo la informacion de la pelotita 4 en a0
jal ACTUALIZAR_POSICION
dadd $s5,$0,$v0             #Guardo la nueva informacion de la pelotita
dadd $a0,$0,$s6             #Cargo la informacion de la pelotita 5 en a0
jal ACTUALIZAR_POSICION
dadd $s6,$0,$v0             #Guardo la nueva informacion de la pelotita

daddi $a0,$0,2000    #Configuracion del delay
jal DELAY

j LOOP #Salto al loop
halt


#IMPRIME UNA PELOTITA CON SU INFORMACION ACTUAL
IMPRIMIR_PELOTITA: #A0 = INFORMACION_PELOTITA
#Aplico una mascara para dejar solo los bits de color y posicion
#00 00 FF FF 00 FF FF FF
#0000 FFF F00 FFF FFF
#Tengo que cargar la mascara en t0 de a 12bits
daddi $t0,$0,0xFFF      #t0=FFF
daddi $t1,$0,12         #Desplazamiento
dsllv $t0,$t0,$t1       #t0=FFF 000
daddi $t0,$t0,0xF00     #t0=FFF F00
dsllv $t0,$t0,$t1       #t0=FFF F00 000
daddi $t0,$t0,0xFFF     #t0=FFF F00 FFF
dsllv $t0,$t0,$t1       #t0=FFF F00 FFF 000
daddi $t0,$t0,0xFFF     #t0=FFF F00 FFF FFF
#Aplico la mascara          
and $a0,$a0,$t0
#Ahora tengo en a0 tengo solo el color y la posicion de la pelotita:
#00 00 XX YY 00 BB GG RR
#Imprimo la pelotita
sd $a0,0($s1)
daddi $t0,$0,5
sd $t0,0($s0)
jr $ra

#ACTUALIZA LA POSICION DE LA PELOTITA SEGUN SU UBICACION Y DIRECCION ACTUAL
ACTUALIZAR_POSICION: #A0=INFORMACION PELOTITA V0=INFORMACION ACTUALIZADA
#Separo la informacion relevante en distintos registros
#Para esto primero desplazo la informacion de la pelotita para obtener:
#00 00 00 00 DirX DirY X Y  
daddi $t5,$0,32     #N Desplazamiento
dsrlv $t4,$a0,$t5   #t4 = #00 00 00 00 DirX DirY X Y 
andi $t0,$t4,0xFF   #t0 = #00 00 00 00 00 00  00  Y
dsrl $t4,$t4,8      #t4 = #00 00 00 00 00 DirX DirY X
andi $t1,$t4,0xFF   #t1 = #00 00 00 00 00 00  00  X
dsrl $t4,$t4,8      #t4 = #00 00 00 00 00 00 DirX DirY 
andi $t2,$t4,0xFF   #t2 = #00 00 00 00 00 00  00  DirY
dsrl $t3,$t4,8      #t3 = #00 00 00 00 00 00  00  DirX  
#Ahora: t0=Y t1=X t2=DirY t3=DirX
#Si la direccion es -1 tengo que extender el signo:
#00 00 00 00 00 00 00 FF -> FF FF FF FF FF FF FF FF 
daddi $t5,$0,0xFF   #t5=FF 
bne $t2,$t5,DIR_X   #Si la direccion Y no es -1 no la modifico
daddi $t2,$0,-1     #Sino extiendo el signo (Guardo directamente -1)
DIR_X:
bne $t3,$t5,VOLVER  #Si la direccion X no es -1 no la modifico
daddi $t3,$0,-1     #Sino extiendo el signo (Guardo directamente -1)
VOLVER:
#Actualizo la posicion sumandole a cada eje su direccion correspondiente
dadd $t0,$t0,$t2    #t0=Y+DirY
dadd $t1,$t1,$t3    #t1=X+DirX
#Compruebo que las nuevas posiciones esten en el rango correspondiente (0-49)
#Si no lo estan, las corrijo y cambio de direccion
slti $t5,$t0,50     #Verifico que Y sea menor a 50
bnez $t5,Y_MENOR_A_50#Si lo es salto a la proxima comparacion 
daddi $t0,$t0,-2    #Restauro el valor anterior de Y y le resto 1 
daddi $t2,$0,0xFF   #Cambio la DirY a -1
Y_MENOR_A_50:
slt $t5,$0,$t0      #Verifico que Y sea mayor a -1
bnez $t5,VERIFICAR_X#Si lo es salto a la proxima comparacion
daddi $t0,$t0,2     #Restauro el valor anterior de Y y le sumo 1
daddi $t2,$0,1      #Cambio la DirY a 1
VERIFICAR_X:
slti $t5,$t1,50     #Verifico que X sea menor a 50
bnez $t5,X_MENOR_A_50#Si lo es salto a la proxima comparacion 
daddi $t1,$t1,-2    #Restauro el valor anterior de X y le resto 1 
daddi $t3,$0,0xFF   #Cambio la DirX a -1
X_MENOR_A_50:
slt $t5,$0,$t1      #Verifico que X sea mayor a -1
bnez $t5,FIN_COMPARACIONES#Si lo es termino las comparaciones
daddi $t1,$t1,2     #Restauro el valor anterior de X y le sumo 1
daddi $t3,$0,1      #Cambio la DirX a 1
FIN_COMPARACIONES:
#Ahora que tengo las cordenadas y direcciones de la pelotita actualizadas
#Proceso a guardar toda la informacion en v0
dadd $v0,$0,$t3     #v0 = 00 00 00 00 00 00 00 DirX
dsll $v0,$v0,8      #v0 = 00 00 00 00 00 00 DirX 00
andi $t2,$t2,0xFF   #t2 = 00 00 00 00 00 00 00 DirY #Me aseguro de poner en 0 los 56 bits mas significativos por si t2=-1
dadd $v0,$v0,$t2    #v0 = 00 00 00 00 00 00 DirX DirY
dsll $v0,$v0,8      #v0 = 00 00 00 00 00 DirX DirY 00
dadd $v0,$v0,$t1    #v0 = 00 00 00 00 00 DirX DirY X
dsll $v0,$v0,8      #v0 = 00 00 00 00 DirX DirY X  00
dadd $v0,$v0,$t0    #v0 = 00 00 00 00 DirX DirY X  Y
daddi $t5,$0,32     #t5=32
dsllv $v0,$v0,$t5   #v0 = DirX DirY X Y 00 00 00 00
#Desplazo a0 32 bits a la izquierda y luego a la derecha dejar en 0 los valores previos de posicion y direccion
dsllv $a0,$a0,$t5   #a0 = N  B  G  R 00 00 00 00
dsrlv $a0,$a0,$t5   #a0 = 00 00 00 00 N  B  G  R
dadd $v0,$v0,$a0    #v0 = DirX DirY X Y N B G R   
#La informacion de la pelotita queda actualizada en v0 
jr $ra

#GENERA UN RETRASO PROPORCIONAL AL NUMERO RECIBIDO 
DELAY: #A0=DELAY 
daddi $a0,$a0,-1    #Resta 1 a a0
bnez $a0,DELAY      #Mientras no llegue a 0 sigue restando
jr $ra


