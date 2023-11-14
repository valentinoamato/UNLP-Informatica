#9) Escriba un programa que le permita dibujar en la pantalla gráfica de la terminal. Deberá mostrar un cursor
#(representado por un punto de un color particular) que pueda desplazarse por la pantalla usando las teclas 'a', 's', 'd'
#y 'w' para ir a la izquierda, abajo, a la derecha y arriba respectivamente. Usando la barra espaciadora se alternará
#entre modo desplazamiento (el cursor pasa por arriba de lo dibujado sin alterarlo) y modo dibujo (cada punto por el
#que el cursor pasa quedará pintado del color seleccionado). Las teclas del ‘1’ al ‘8’ se usarán para elegir uno entre los
#ocho colores disponibles para pintar.
#IMPORTANTE: Ejecutar sin BTB ni delay slot, y con un bus de direcciones de datos de 11 bits.
#CONTROLES:
#W,A,S,D = MOVIMIENTO
#1-8 = COLORES 
#SPACE = ALTERNAR MODO DEL CURSOR 
#H = TERMINAR EL PROGRAMA
.data
DIR_CONTROL: .word 0x10000 
DIR_DATA: .word 0x10008
#--  BB GG RR
#Guardo las distintas opciones de colores en memoria
COLORES: .space 8 #Etiqueta para simplificar el desplazamiento a los otros colores
COLOR1: .word 0x0000FF #ROJO
COLOR2: .word 0x00FF00 #VERDE
COLOR3: .word 0xFF0000 #AZUL
COLOR4: .word 0x00FFFF #AMARILLO
COLOR5: .word 0x009cFF #NARANJA
COLOR6: .word 0x808080 #GRIS
COLOR7: .word 0xFFFFFF #BLANCO
COLOR8: .word 0x000000 #NEGRO
CURSOR: .word 0        #Almacena la posicion y el color de el cursor
#Cuando el cursor se mueve a una nueva posicion estando en modo desplazamiento, debo primero dibujar el pixel de la posicion actual
#Luego guardar el pixel de la proxima posicion y ahora mover el cursor
PIXEL: .word 0xFFFFFF  #Guarda la informacion del pixel sobre el que se encuentra el cursor, inicia en blanco
#Cada pixel puede tener 8 colores distintos por lo que bastarian 3 bits para almacenar el color de cada pixel
#Sin embargo haciendo esto solo podria guardar la informacion de 2 pixeles por byte (3*3=9 9>8)
#Asi que usare 4 bits para definir el color de cada pixel, guardando entonces un numero decimal del 1 al 8
#La pantalla grafica tiene una dimension de 50 columnas y 50 filas, dando una cantidad de pixeles igual a 2500
#Como usare 4 bits por pixel, 2500*4=10000, necesitare guardar 10000 bits en memoria, es decir, 10000/8=1250, 1250 bytes 
IMAGEN: .space 1250

.code 
daddi $sp,$0,0x800      #Inicio la pila
ld $s0,DIR_CONTROL($0)  #s0=dir control
ld $s1,DIR_DATA($0)     #s1=dir data 
daddi $s2,$0,CURSOR     #s2=dir cursor 
#Inicia todos los pixeles en blanco
daddi $a0,$0,IMAGEN     
jal INICIAR_MEMORIA_GRAFICA
#CONDICIONES INICIALES DEL CURSOR:
daddi $t2,$0,PIXEL #t2=PIXEL
daddi $t0,$0,24         #Cordenada Y Inicial (0-49)
sb $t0,4($s2)    
sb $t0,4($t2)   #Tambien guardo Y en PIXEL
daddi $t0,$0,24         #Cordenada X Inicial (0-49)
sb $t0,5($s2) 
sb $t0,5($t2)   #Tambien guardo X en PIXEL
daddi $t0,$0,8          #Color Inicial (1-8)
dadd $s4,$t0,$0         
daddi $t1,$0,8
dmulu $t0,$t0,$t1
lw $t0,COLORES($t0)
sw $t0,CURSOR($0)        
daddi $s3,$0,0          #Modo inicial: 0=Desplazamiento/1=Dibujo

#Limpiar pantalla
daddi $t0,$0,7
sd $t0,0($s0)

#s0= dir control s1= dir data s2=dir cursor s3= modo cursor s4= color cursor(1-8)
LOOP:
#Imprimo el cursor
ld $t0,CURSOR($0)
sd $t0,0($s1)
daddi $t0,$0,5
sd $t0,0($s0)

#Leo el caracter de una tecla
daddi $t0,$0,9
sd $t0,0($s0)
ld $t0,0($s1)
andi $t0,$t0,0xFF

daddi $t1,$0,0x20       #t1=SPACE
bne $t0,$t1,NUMEROS     #Si el caracter no el espacio salto a la proxima comparacion
xori $s3,$s3,1          #Si el caracter es espacio cambio el modo del cursor
j LOOP

NUMEROS:
#Compruebo si el caracter leido es un numero valido
slti $t2,$t0,0x39       #CHAR<=8
beqz $t2,DIRECCION      #Si el codigo del caracter es mayor al del 8 paso a la proxima comparacion
daddi $t2,$0,0x30
slt $t2,$t2,$t0         #CHAR>=1
beqz $t2,DIRECCION      #Si el codigo del caracter es menor al del 1 paso a la proxima comparacion
daddi $t0,$t0,-0x30     #Le resto 30h al codigo del numero para obtener su valor decimal 
dadd $s4,$0,$t0         #Actualizo el numero de color en s4
dsll $t0,$t0,3          #Multiplico el numero por 8 para usarlo como desplazamiento
lw $t0,COLORES($t0)     #Guardo en t0 el codigo del color correspondiente al numero ingresado
sw $t0,0($s2)           #Actualizo el color del cursor
j LOOP


DIRECCION:
lb $s5,4($s2)           #s5= cordenada Y del cursor
lb $s6,5($s2)           #s6= cordenada X del cursor
daddi $t2,$0,49         #Cargo 49 en t2 para comprobar si el cursor esta en un borde
W:
daddi $t1,$0,0x77       #t1=w
bne $t0,$t1,A           #Si el caracter no es W paso a la proxima comparacion
beq $s5,$t2,LOOP        #Si el caracter esta en el margen superior reinicio el bucle
daddi $t3,$s5,1
sb $t3,4($s2)
j MODOS
A:
daddi $t1,$0,0x61       #t1=a
bne $t0,$t1,S           #Si el caracter no es A paso a la proxima comparacion
beqz $s6,LOOP           #Si el caracter esta en el margen izquierdo reinicio el bucle
daddi $t3,$s6,-1
sb $t3,5($s2)
j MODOS
S:
daddi $t1,$0,0x73       #t1=s
bne $t0,$t1,D           #Si el caracter no es S paso a la proxima comparacion
beqz $s5,LOOP           #Si el caracter esta en el margen inferior reinicio el bucle
daddi $t3,$s5,-1
sb $t3,4($s2)
j MODOS
D:
daddi $t1,$0,0x64       #t1=d
bne $t0,$t1,H           #Si el caracter no es D paso a la proxima comparacion
beq $s6,$t2,LOOP        #Si el caracter esta en el margen derecho reinicio el bucle
daddi $t3,$s6,1
sb $t3,5($s2)
j MODOS
H:
daddi $t1,$0,0x68       #t1=h
bne $t0,$t1,LOOP        #Si el caracter no es H reinicio el bucle
j TERMINAR              #Termino el programa

#s5 = cordenada Y del cursor desactualizada
#s6 = cordenada X del cursor desactualizada
MODOS:
#Cargo valores en los registros $a para usar posteriormente en subrutinas
dadd $a0,$0,$s5     #A0 = Y
dadd $a1,$0,$s6     #A1 = X
daddi $a2,$0,IMAGEN #$a2 = DIR IMAGEN
beqz $s3,MODO_DESPLAZAMIENTO #Si el cursor esta en modo desplazamiento
#Si el cursor esta en modo dibujo debo actualizar el color del pixel actual antes de moverme
dadd $a3,$0,$s4     #A3 = NUMERO COLOR
jal PIXEL_ACTUALIZAR
j GUARDAR_PIXEL

MODO_DESPLAZAMIENTO:
#Si el cursor esta en modo desplazamiento debo imprimir el pixel sobre el que se encuentra el cursor antes de mover este
ld $t0,PIXEL($0)    #Cargo en t0 el pixel
sd $t0,0($s1)       #Guardo en DATA el pixel
daddi $t0,$0,5      #t0=5
sd $t0,0($s0)       #Imprimo el pixel

GUARDAR_PIXEL:
#Guardo la informacion del pixel al que se va a mover el cursor para no perderlo
lbu $a0,4($s2)  #Cargo en a0 la cordenada Y que va a tomar el cursor
lbu $a1,5($s2)  #Cargo en a0 la cordenada X que va a tomar el cursor
#Obtengo la direccion de memoria del pixel que se encuentra en la proxima posicion del cursor
jal PIXEL_DIRECCION
lbu $t0,0($v0)  #Cargo el byte donde se encuentra el pixel en t0
beqz $v1,NO_DESPLAZAR #Si el pixel esta en la primera mitad del byte
#Si el pixel se encuentra en la segunda mitad del byte lo desplazo para que quede en la primera mitad
dsrl $t0,$t0,4  #Muevo el pixel a la primera mitad del byte
NO_DESPLAZAR:
andi $t0,$t0,0xF#Aplico una mascara para asegurarme de solo tener en t0 el color del pixel 
daddi $t1,$0,8  #Guardo en t1 la diferencia en la direccion de memoria de dos colores consecutivos
dmulu $t0,$t0,$t1#Multiplico el numero de color por 8 para obtener un desplazamiento
lw $t0,COLORES($t0)#Cargo en t0 el codigo del color del pixel 
ld $t1,0($s2)   #Cargo en t1 la informacion del cursor
#Como el proximo pixel al que se movera el cursor tiene la misma posicion que el cursor
#Solo tengo que guardar en PIXEL la informacion del CURSOR pero con el color correspondiente ($t0)
#Para esto primero pongo en 0 los primeros 32 bits correspondientes al color del CURSOR ($t1)
daddi $t2,$0,32 #t2 = desplazamiento = 32
dsrlv $t1,$t1,$t2#Desplazo la informacion del cursor 32 bits a la derecha
dsllv $t1,$t1,$t2#Desplazo la informacion del cursor 32 bits a la izquierda
#Ahora que puse en 0 los bits de color del CURSOR ($t1), los remplazo por los del PIXEL ($t0)
dadd $t1,$t1,$t0#Ahora tengo en t1 la informacion del pixel en el que se posicionara el CURSOR en el siguiente ciclo
sd $t1,PIXEL($0)#Guardo el PIXEL

j LOOP      #Inicio un nuevo ciclo
TERMINAR:   #Finalizar el programa
halt



#Inicia el color de todos los pixeles de la imagen en BLANCO
#Esto tiene como objetivo regularizar la condicion inicial de la memoria
INICIAR_MEMORIA_GRAFICA: #A0 = DIRECCION DE LA MEMORIA GRAFICA 
#Para acelerar el proceso guardare el numero del blanco de a palabras de 64 bits
daddi $t0,$0,7  #Inicia t0 en 7
daddi $t1,$0,16 #Como en 64 bits entran 16 pixeles debo cargar 16 veces el numero del color blanco (7)
CARGA:
dsll $t0,$t0,4  #Desplaza hacia la izquierda 4 veces para podes guardar nuevamente el 7
daddi $t0,$t0,7 #Guarda un 7 en t0
daddi $t1,$t1,-1#Resta 1 al contador
bnez $t1,CARGA  #Repite el proceso hasta que se haya cargado por completo la palabra 
#En 1250 bytes entran 156 palabras de 64 bits y sobran dos bytes
#Asi que empezare por guardar las 156 palabras
dadd $t2,$0,$a0 #Usare t2 como puntero y lo inicio en la direccion de la memoria grafica
daddi $t1,$0,156#Usare t1 como contador y lo inicio en 156
CARGA2:
sd $t0,0($t2)   #Guardo la palabra con los codigos del blanco en la memoria
daddi $t2,$t2,8 #Sumo 8 a t2, para que apunte a la proxima palabra de 64 bits 
daddi $t1,$t1,-1#Resto 1 al contador 
bnez $t1,CARGA2 #Repite el proceso hasta que se hayan cargado las 156 palabras
#Una vez terminada esta carga, solo resta cargar los ultimos dos bytes
#Para esto cargo los primeros 16 bits de t0 en la direccion t2, que apunta a la ultima palabra de la memoria grafica
sh $t0,0($t2)
jr $ra #retorno



#OBTIENE LA DIRECCION DE UN PIXEL A PARTIR DE SUS CORDENADAS
#NOTESE QUE COMO LA MINIMA PALABRA DIRECCIONABLE ES DE 1 BYTE  Y EL COLOR DE CADA PIXEL OCUPA 1 NIBBLE (MEDIO BYTE)
#EL BYTE AL QUE APUNTA LA DIRECCION RETORNADA POR LA SUBRUTINA CONTENDRA LOS COLORES DE DOS PIXELES
#ENTONCES TAMBIEN RETORNARA SI EL COLOR DEL PIXEL QUE SE BUSCA SE ENCUENTRA EN EL PRIMER O EN EL SEGUNDO NIBBLE DE ESE BYTE
#ESTO LO HARA DEVOLVIENDO EN V0 UN 0 SI EL VALOR BUSCADO CORRESPONDE AL PRIMER NIBBLE Y UN 1 SI CORRESPONDE AL SEGUNDO
PIXEL_DIRECCION: #A0 = Y(0-49) | A1 = X(0-49) | A2 = DIR MEMORIA GRAFICA | V0 = DIR | V1 = UBICACION DEL PIXEL (EN EL BYTE): PRIMERA MITAD(0)/SEGUNDA MITAD(1)
andi $v1,$a1,1      #Guardo en v1 el primer bit de X
#Si X es par (El pixel se encuentra en la primera mitad) v1 = 0, si X es impar (El pixel se encuentra en la segunda mitad) v1=1
daddi $t0,$0,25     #t0=numero de bytes por fila
dmulu $a0,$a0,$t0   #a0=numero de bytes por fila*cantidad de filas
daddi $t0,$0,2      #t0=cantidad de columnas por byte 
ddivu $a1,$a1,$t0   #a1=cantidad de columnas/cantidad de columnas por byte
dadd $a0,$a0,$a1    #a0 = direccion de memoria relativa (sin tener en cuenta donde inicia la memoria grafica) 
dadd $v0,$a0,$a2    #v0 = direccion de memoria absoluta (se le suma el direccion donde inicia la memoria grafica)
jr $ra              #retorno 
#NOTA: Por alguna razon la etiqueta DIRECCION_PIXEL: no funcionaba para esta subrutina :\



#RECIBE LAS CORDENADAS DE UN PIXEL Y ACTUALIZA SU NUMERO DE COLOR POR UNO RECIBIDO
PIXEL_ACTUALIZAR:   #A0=Y(0-49) A1=X(0-49) A2=DIR MEMORIA GRAFICA A3=COLOR(1-8)
daddi $sp,$sp,-8    #Push ra
sd $ra,0($sp)       #Push ra
#Primero obtengo la direccion de memoria del byte donde esta el pixel
jal PIXEL_DIRECCION
lbu $t0,0($v0)      #Cargo en t0 el byte donde se encuentra el pixel 
bnez $v1,SEGUNDA_MITAD 
#Si el color del pixel se encuentra en la primera mitad del byte 
andi $t0,$t0,0xF0   #Borro el color del pixel a actualizar y dejo el color del otro 
dadd $t0,$t0,$a3    #Cargo el nuevo color 
j ACTUALIZAR
SEGUNDA_MITAD:
#Si el color del pixel se encuentra en la segunda mitad del byte 
andi $t0,$t0,0x0F   #Borro el color del pixel a actualizar y dejo el color del otro 
dsll $a3,$a3,4      #Desplazo el nuevo color para que ocupe la segunda mitad del byte
dadd $t0,$t0,$a3    #Cargo el nuevo color 
ACTUALIZAR:
sb $t0,0($v0)       #Guardo el byte en memoria con los cambios realizados
ld $ra,0($sp)       #Pop ra
daddi $sp,$sp,8     #Pop ra
jr $ra          #retorno