#6) Como ya se observó anteriormente, muchas instrucciones que normalmente forman parte del repertorio de un
#procesador con arquitectura CISC no existen en el MIPS64. En particular, el soporte para la invocación a subrutinas
#es mucho más simple que el provisto en la arquitectura x86 (pero no por ello menos potente). El siguiente programa
#muestra un ejemplo de invocación a una subrutina.
.data
valor1: .word 2
valor2: .word 2
result: .word 0

.code
ld $a0, valor1($zero)
ld $a1, valor2($zero)
jal a_la_potencia
sd $v0, result($zero)
halt

a_la_potencia: daddi $v0, $zero, 1 #v0 <- 1
lazo: slt $t1, $a1, $zero          #a1<0 -> t1=0
bnez $t1, terminar                 #t1=0 -> terminar
daddi $a1, $a1, -1                 #a1-1
dmul $v0, $v0, $a0                 #v0 <- v0*a0
j lazo                             #lazo
terminar: jr $ra                   #ret

#a) ¿Qué hace el programa? ¿Cómo está estructurado el código del mismo?
#b) ¿Qué acciones produce la instrucción jal? ¿Y la instrucción jr?
#c) ¿Qué valor se almacena en el registro $ra? ¿Qué función cumplen los registros $a0 y $a1? ¿Y el registro $v0?
#d) ¿Qué sucedería si la subrutina a_la_potencia necesitara invocar a otra subrutina para realizar la multiplicación,
#por ejemplo, en lugar de usar la instrucción dmul? ¿Cómo sabría cada una de las subrutinas a que dirección de
#memoria deben retornar?

#A) El programa realiza la siguiente operacion matematica valor1^(valor2+1). 
#
#B) La instruccion jal salta a la direccion de la etiqueta y copia en r31 la direccion de retorno.
#   La instruccion jr salta a la direccion contenida en el registro especificado.
#
#C) En el registro $ra se almacecna el valor CH correspondiente a la direccion de la instruccion posterior a jal.
#   Los registros $a0 y $a1 se usan para pasarle argumentos a la subrutina y $v0 sirve para obtener el retorno de la subrutina.
#
#D) Si la subrutina a_la_potencia: llamara a otra subrutina dentro de si, deberia antes guardar su direccion de retorno en la pila.