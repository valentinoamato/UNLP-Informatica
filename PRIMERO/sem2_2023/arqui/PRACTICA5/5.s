#5) El procesador MIPS64 posee 32 registros, de 64 bits cada uno, llamados r0 a r31 (también conocidos como $0 a $31).
#Sin embargo, resulta más conveniente para los programadores darles nombres más significativos a esos registros.
#La siguiente tabla muestra la convención empleada para nombrar a los 32 registros mencionados:


#Registros | Nombres | ¿Preservado? | ¿Para que se los utiliza? 
           |         |              | 
#r0        | $zero   |     NO       | Siempre tiene el valor 0 y no se puede cambiar
#r1        | $at     |     NO       | Assembler Temporary - Reservado para uso del ensamblador
#r2-r3     | $v0-$v1 |     NO       | Valores de retorno de subrutina
#r4-r7     | $a0-$a3 |     NO       | Argumentos pasados a subrutina
#r8-r15    | $t0-$t7 |     NO       | Registros temporales
#r16-r23   | $s0-$s7 |     SI       | Variables globales del programa
#r24-r25   | $t8-$t9 |     NO       | Registros temporales
#r26-r27   | $k0-$k1 |     NO       | Reservados para uso del kernel del SO
#R28       | $gp     |     SI       | Global Pointer
#R29       | $sp     |     SI       | Stack Pointer - Puntero al tope de la pila
#R30       | $fp     |     SI       | Frame Pointer
#R31       | $ra     |     SI       | Return Address - Direccion de retorno 

#Complete la tabla anterior explicando el uso que normalmente se le da cada uno de los registros nombrados. Marque
#en la columna “¿Preservado?” si el valor de cada grupo de registros debe ser preservado luego de realizada una
#llamada a una subrutina. Puede encontrar información útil en el apunte “Programando sobre MIPS64”.