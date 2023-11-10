#1) El siguiente programa produce la salida de un mensaje predefinido en la ventana Terminal del simulador
#WinMIPS64. Teniendo en cuenta las condiciones de control del puerto de E/S (en el resumen anterior), modifique el
#programa de modo que el mensaje a mostrar sea ingresado por teclado en lugar de ser un mensaje fijo.

.data
CONTROL: .word 0x10000
DATA: .word 0x10008
MENSAJE: 

.text
ld $s0, DATA($zero) ; $s0 = dirección de DATA
ld $s1, CONTROL($zero) ; $s1 = dirección de CONTROL

daddi $t1,$0,0
daddi $t2,$0,9
daddi $t4,$0,0xd
INGRESO: sd $t2,0($s1)
lbu $t3,0($s0)
sb $t3,MENSAJE($t1)
daddi $t1,$t1,1
bne $t4,$t3,INGRESO

daddi $t0, $zero, MENSAJE ; $t0 = dirección del mensaje a mostrar
sd $t0, 0($s0) ; DATA recibe el puntero al comienzo del mensaje

daddi $t0, $zero, 6 ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica
sd $t0, 0($s1) ; CONTROL recibe 6 y limpia la pantalla

daddi $t0, $zero, 4 ; $t0 = 4 -> función 4: salida de una cadena ASCII
sd $t0, 0($s1) ; CONTROL recibe 4 y produce la salida del mensaje

halt