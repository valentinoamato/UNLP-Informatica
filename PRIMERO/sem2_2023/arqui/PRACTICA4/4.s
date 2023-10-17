#4) * Dado el siguiente programa:
.data
tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
num: .word 456
long: .word 10
.code
ld r1, long(r0)
ld r2, num(r0)
dadd r3, r0, r0
dadd r10, r0, r0
loop: ld r4, tabla(r3)
beq r4, r2, listo
daddi r1, r1, -1
daddi r3, r3, 8
bnez r1, loop
j fin
listo: daddi r10, r0, 1
fin: halt
#a) Ejecutar en simulador con Forwarding habilitado. ¿Qué tarea realiza? ¿Cuál es el resultado y dónde queda indicado?
#b) Re-Ejecutar el programa con la opción Configure/Enable Branch Target Buffer habilitada. Explicar la ventaja de usar este
#método y cómo trabaja.
#c) Confeccionar una tabla que compare número de ciclos, CPI, RAWs y Branch Taken Stalls para los dos casos anteriores.

#A) 
#El programa busca un numero en una lista, si lo encuentra, deja un 1 en r10 y sino deja un 0.
#
#B) 
#La ventaja de usar este metodo es que permite reducir los atascos de Branch Taken cuando hay un loop o mas en el programa.
#Trabaja guardando en un buffer el resultado de los salto condicionales. Siempre predice que el resultado de un salto va a ser
# el mismo de la anterior vez. De esta manera permite ahorrar atascos cuando un salto se va a dar o no varias veces consecutivas.
#
#C)
#               |Normal |BTB    |
#Ciclos         |90     |86     |
#               |       |       |
#Instrucciones  |56     |56     |
#               |       |       |
#CPI            |1.607  |1.536  |
#               |       |       |
#RAWs           |20     |20     |
#               |       |       |
#BTS            |10     |4      |
#
#
#
#
#