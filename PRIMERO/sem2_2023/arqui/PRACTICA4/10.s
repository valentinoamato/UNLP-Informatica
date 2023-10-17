#10) Escribir un programa que cuente la cantidad de veces que un determinado caracter aparece en una cadena de texto. Observar
#cómo se almacenan en memoria los códigos ASCII de los caracteres (código de la letra “a” es 61H). Utilizar la instrucción lbu
#(load byte unsigned) para cargar códigos en registros. La inicialización de los datos es la siguiente:
#.data
#cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
#car: .asciiz "d" ; caracter buscado
#cant: .word 0 ; cantidad de veces que se repite el caracter car en cadena.

.data
CADENA: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
CAR: .ascii "d" ; caracter buscado
CANT: .word 0 ; cantidad de veces que se repite el caracter car en cadena

.code
dadd r1,r0,r0               #r1 = indice
lbu r2,CAR(r0)              #r2 = caracter buscado
dadd r3,r0,r0              #r3 = cantidad de caracteres encontrados

LOOP: lbu r4,CADENA(r1)     #r4 = caracter actual
beqz r4, FIN                #Si se termina el string saltar a fin
bne r2,r4,DISTINTOS
daddi r3,r3,1
DISTINTOS:
daddi r1,r1,1
j LOOP

FIN:
sd r3,CANT(r0)              #Guardar cantidad
halt


              
            
